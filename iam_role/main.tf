variable "varDevs" {
  description = "Nombre del IAM Role"
  type        = string
}

resource "aws_iam_role" "devs" {
  name = var.varDevs

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "change_name_policy" {
  name = "${var.varDevs}_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:List*",
          "s3:Get*",
          "s3:ReplicateTags",
          "s3:CreateBucket",
          "s3:DeleteBucket"
        ],
        Resource = "*"
      },
      {
        Effect = "Deny",
        Action = "s3:GetObject",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "change_name_attachment" {
  role       = aws_iam_role.devs.name
  policy_arn = aws_iam_policy.change_name_policy.arn
}
