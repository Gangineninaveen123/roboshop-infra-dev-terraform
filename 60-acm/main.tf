#Certificate creation.
resource "aws_acm_certificate" "karthikeya" {
  domain_name       = "dev.${var.zone_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-certificate"
    }
  )
}

# 2. Create the DNS CNAME validation records
resource "aws_route53_record" "karthikeya" {
  for_each = {
    for dvo in aws_acm_certificate.karthikeya.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

# 3. Complete the validation button clicking (Waits until AWS issues the certificate)
resource "aws_acm_certificate_validation" "karthikeya" {
  certificate_arn         = aws_acm_certificate.karthikeya.arn
  validation_record_fqdns = [for record in aws_route53_record.karthikeya : record.fqdn]
}