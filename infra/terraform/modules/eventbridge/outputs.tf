output "bus_name" {
  value = aws_cloudwatch_event_bus.this.name
}

output "document_validated_rule_name" {
  value = aws_cloudwatch_event_rule.document_validated.name
}
