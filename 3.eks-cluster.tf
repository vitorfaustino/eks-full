module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.19"
  subnets         = module.vpc.private_subnets
  cluster_endpoint_private_access = false

  wait_for_cluster_interpreter = ["C:/Program Files/Git/bin/sh.exe", "-c"]
  wait_for_cluster_cmd          = "until curl -k -s $ENDPOINT/healthz >/dev/null; do sleep 4; done"
  
  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = module.vpc.vpc_id

  ############################################################################
  # Node Groups
  ############################################################################
  /*node_groups = {
    example = {
      desired_capacity = 1
      max_capacity     = 4
      min_capacity     = 1

      instance_types = ["t3a.nano"]
      capacity_type  = "SPOT"
      k8s_labels = {
        Environment = "dev"
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }
      additional_tags = {
        ExtraTag = "training"
      }
    }
  }*/

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  ############################################################################
  # Normal Worker Groups
  ############################################################################
  /*worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
    },
  ]*/

  ############################################################################
  # Mixed Worker Groups
  ############################################################################
    worker_groups = [
    {
      name                = "on-demand-1"
      instance_type       = "t3a.medium"
      asg_max_size        = 2
      kubelet_extra_args  = "--node-labels=spot=false"
      suspended_processes = ["AZRebalance"]
    }
  ]


  worker_groups_launch_template = [
    {
      name                    = "spot-1"
      override_instance_types = ["t3a.medium", "t3a.large"]
      spot_instance_pools     = 4
      asg_max_size            = 5
      asg_desired_capacity    = 1
      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot"
      //public_ip               = true
      public_ip               = false
    },
  ]

  map_users = var.map_users

}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
