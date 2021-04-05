############################################################################
# Setup desired region
############################################################################
variable "region" {
  default     = "eu-west-1"
  description = "AWS region"
}

############################################################################
# Cluster Name
############################################################################
variable "cluster_name" {
   type = string
   default = "training"
}

############################################################################
# Number of users/namespaces to create
############################################################################
variable "number_users" {
   type = number
   default = 2
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
      userarn  = "arn:aws:iam::<ACCOUNT_ID>:user/eks_student1"
      username = "eks_student1"
      groups   = ["operations1"]
    },
    {
      userarn  = "arn:aws:iam::<ACCOUNT_ID>:user/eks_student2"
      username = "eks_student2"
      groups   = ["operations2"]
    },
  ]
}