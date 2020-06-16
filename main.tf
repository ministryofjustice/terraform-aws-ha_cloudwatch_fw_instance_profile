resource "aws_iam_instance_profile" "fw_profile" {
  name = "${var.name}_profile"
  role = aws_iam_role.fw-role.name
}

resource "aws_iam_role_policy_attachment" "cw-attach" {
  count      = var.enable_cw ? 1 : 0
  role       = aws_iam_role.fw-role.name
  policy_arn = aws_iam_policy.cw-policy[0].arn
}

resource "aws_iam_role_policy_attachment" "ha-attach" {
  count      = var.enable_ha ? 1 : 0
  role       = aws_iam_role.fw-role.name
  policy_arn = aws_iam_policy.ha-policy[0].arn
}

resource "aws_iam_role_policy_attachment" "bs-attach" {
  count      = var.enable_bs ? 1 : 0
  role       = aws_iam_role.fw-role.name
  policy_arn = aws_iam_policy.bs-policy[0].arn
}

resource "aws_iam_role" "fw-role" {
  name = "${var.name}-fw-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
         "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "cw-policy" {
  count       = var.enable_cw ? 1 : 0
  name        = "${var.name}-cw-policy"
  description = "Policy for putting metrics to cloud watch"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "ha-policy" {
  count       = var.enable_ha ? 1 : 0
  name        = "${var.name}-ha-policy"
  description = "Policy for putting enabling HA"

  policy = <<EOF
{
"Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action":
        [
          "ec2:AttachNetworkInterface",
          "ec2:DetachNetworkInterface",
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces"
        ],
      "Resource": "*"}
  ]
}
EOF
}

resource "aws_iam_policy" "bs-policy" {
  count = var.enable_bs ? 1 : 0
  name  = "${var.name}-BootstrapRolePolicy"

  policy = <<EOF
{
  "Version" : "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::${var.bs_bucket}"
    },
    {
    "Effect": "Allow",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::${var.bs_bucket}/*"
    }
  ]
}
EOF
}
