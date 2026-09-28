
# exporting Listener arn to ssm parameteer store
resource "aws_ssm_parameter" "acm_certificate_arn" {
  name  = "/${var.project}/${var.environment}/acm_certificate_arn"
  type  = "String"
  value = aws_acm_certificate.karthikeya.arn  # exporting backed_alb listener arn to parameter store ssm
}