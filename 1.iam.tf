############################################################################
# Users need to access with kubectl
############################################################################
resource "aws_iam_user" "student" {
  count = var.number_users
  name = "eks_student${count.index+1}"
}