# resource "aws_iam_role" "jenkins_instance_role" {
#   name = "jenkins_instance_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
#   tags = {
#     Name        = "aws assume role"
#     Environment = var.environment
#   }
# }

# resource "aws_iam_policy" "policy" {
#   name        = "jenkins_instance_policy"
#   description = "jenkins policy"
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:Describe*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]

#   })

#   tags = {
#     Name        = "aws assume policy"
#     Environment = var.environment
#   }
# }

# resource "aws_iam_role_policy_attachment" "jenkins-attach" {
#   role       = aws_iam_role.jenkins_instance_role.name
#   policy_arn = aws_iam_policy.policy.arn
# }

# resource "aws_iam_instance_profile" "ip" {
#   name = "aws_instance_profile_jenkins"
#   role = aws_iam_role.jenkins_instance_role.name
# }


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