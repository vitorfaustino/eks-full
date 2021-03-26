############################################################################
# Setup desired region
############################################################################
variable "region" {
  default     = "eu-west-1"
  description = "AWS region"
}

variable "cluster_name" {
   type = string
   default = "training"
}


############################################################################
# Map Users to groups. Rolebinding by group
############################################################################
variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::425239951089:user/eks_student1"
      username = "eks_student1"
      groups   = ["operations1"]
    },
    {
      userarn  = "arn:aws:iam::425239951089:user/eks_student2"
      username = "eks_student2"
      groups   = ["operations2"]
    },
  ]
}