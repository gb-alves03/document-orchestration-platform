resource "aws_cloudwatch_event_bus" "this" {
  name = var.bus_name
}

# Example rule for DocumentValidated events (filtering by detail-type)
resource "aws_cloudwatch_event_rule" "document_validated" {
  name           = "${var.bus_name}-document-validated"
  event_bus_name = aws_cloudwatch_event_bus.this.name

  event_pattern = jsonencode({
    "source"      = ["document.orchestrator"],
    "detail-type" = ["DocumentValidated"]
  })
  depends_on = [aws_cloudwatch_event_bus.this]
}

# consumer target (optional): if user supplies target_arn, attach it
resource "aws_cloudwatch_event_target" "validated_target" {
  count = var.validated_target_arn == "" ? 0 : 1
  rule  = aws_cloudwatch_event_rule.document_validated.name
  arn   = var.validated_target_arn
}
