resource "aws_iam_user" "student" {
  count = 2
  name = "eks_student${count.index+1}"
}

