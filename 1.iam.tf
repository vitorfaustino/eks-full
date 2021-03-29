############################################################################
# Users need to access with kubectl
############################################################################
resource "aws_iam_user" "student" {
  count = 2
  name = "eks_student${count.index+1}"
}

############################################################################
# Role/Policy needed for cluster Autoscaler
############################################################################
/*resource "aws_iam_role" "role_ec2_autoscaler" {
  name = "role_ec2_autoscaler"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "policy_ec2_autoscaler" {
  name = "policy_ec2_autoscaler"
  role = aws_iam_role.role_ec2_autoscaler.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}*/