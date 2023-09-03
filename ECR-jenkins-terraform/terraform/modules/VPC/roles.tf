resource "aws_iam_role" "jenkins-server" {
  name = "Jenkins-server-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ecr_access_policy" {
  name        = "ECRAccessPolicy"
  description = "Policy to access ECR repositories"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins-server-ecr-attachment" {
  policy_arn = aws_iam_policy.ecr_access_policy.arn
  role       = aws_iam_role.jenkins-server.name
}


resource "aws_iam_instance_profile" "jenkins-ecr-profile" {
  name = "jenkins-ecr-Profile"
  role = aws_iam_role.jenkins-server.name
}
