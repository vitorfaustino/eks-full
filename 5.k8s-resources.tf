resource "kubernetes_namespace" "namespaces" {
  count = var.number_users
  metadata {
    annotations = {
      name = "annotation-${count.index+1}"
    }

    labels = {
      mylabel = "label-${count.index+1}"
    }

    name = "student${count.index+1}"
  }
}

# Change APII resources
resource "kubernetes_role" "role_operations" {
  count = var.number_users
  metadata {
    name = "operation"
    namespace = "student${count.index+1}"
    labels = {
      test = "MyRole"
    }
  }

  rule {
    api_groups     = ["extensions", "apps", ""]
    resources      = ["pods"]
    verbs          = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments"]
    verbs      = ["get", "list"]
  }
}

resource "kubernetes_role_binding" "rb1" {
  count = var.number_users
  metadata {
    name      = "rb_operation"
    namespace = "student${count.index+1}"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "operation"
  }
  subject {
    kind      = "User"
    name      = "eks_student${count.index+1}"
    api_group = "rbac.authorization.k8s.io"
  }
  /*subject {
    kind      = "Group"
    name      = "operations1"
    api_group = "rbac.authorization.k8s.io"
  }*/
}

