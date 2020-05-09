output "iam_instance_profile_name" {
  description = "IAM instance profile name"
  value = aws_iam_instance_profile.fw_profile.name
}

