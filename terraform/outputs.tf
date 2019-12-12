# outputs.tf

output "alb_hostname" {
  value = aws_alb.main.dns_name
}

output "autoscaling_policy_down" {
  value = aws_appautoscaling_policy.down
}

output "autoscaling_policy_up" {
  value = aws_appautoscaling_policy.up
}