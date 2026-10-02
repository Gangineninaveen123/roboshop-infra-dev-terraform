#) 1 -> public cdn url id https://cdn.karthikeya.site -> where this will have arn, value , which we will not give to public as its dificult, we will store in route 53 records.
# 2-> CloudFront is like caching, in edge locations.[cache behavior[/media/*]]
#3 -> origin -> where original content will be there[dev.karthikeya.site]
# CloudFront CDN
resource "aws_cloudfront_distribution" "roboshop" {

  # Origin = where CloudFront gets the actual content from
  # CDN URL is still cdn.karthikeya.site
  origin {
    domain_name = "dev.${var.zone_name}" #dev.karthikeya.site becomes origin[The original place from where CloudFront gets the content]
    origin_id   = "dev.${var.zone_name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled = true

  # CDN URL, where user will hit on the browser with https://cdn.karthikeya.site
  aliases = ["cdn.${var.zone_name}"]

  # Default cache behavior
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "dev.${var.zone_name}"

    # AWS Managed CachingDisabled policy
    cache_policy_id = data.aws_cloudfront_cache_policy.cacheDisable.id

    viewer_protocol_policy = "https-only"
  }

  # Cache /media/* content
  ordered_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "dev.${var.zone_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id        = data.aws_cloudfront_cache_policy.cacheEnable.id
  }

  price_class = "PriceClass_200"

  # Allow CDN access from these countries
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "IN"]
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}"
    }
  )

  # CDN SSL certificate
  viewer_certificate {
    acm_certificate_arn = local.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}


# Route53 record for CDN
resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name    = "cdn.${var.zone_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.roboshop.domain_name
    zone_id                = aws_cloudfront_distribution.roboshop.hosted_zone_id
    evaluate_target_health = true
  }
}

