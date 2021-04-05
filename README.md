# Instal and configure AWS CLI

https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html

```shell
$ aws configure
AWS Access Key ID [None]: YOUR_AWS_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_AWS_SECRET_ACCESS_KEY
Default region name [None]: YOUR_AWS_REGION
Default output format [None]: json
```

# Install IAM authenticator

https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html


# Install Terraform

https://releases.hashicorp.com/terraform/0.14.9/terraform_0.14.9_windows_amd64.zip


# Run Terraform

```shell
$ terraform init
$ terraform plan
$ terraform appy
```

# Cluster Autoscaler (Manual Install) - Deactivate module eks-cluster-autoscaler

Documentation - https://github.com/terraform-aws-modules/terraform-aws-eks/tree/master/examples/irsa
Issue - https://github.com/terraform-aws-modules/terraform-aws-eks/issues/965

Replace `<ACCOUNT ID>` with your AWS account ID in `cluster-autoscaler-chart-values.yaml`. There is output from terraform for this.

Install the chart using the provided values file (Change eks.amazonaws.com/role-arn in ./helm/cluster-autoscaler-values.yaml):

```shell
$ helm repo add autoscaler https://kubernetes.github.io/autoscaler
$ helm repo update
$ helm upgrade --install cluster-autoscaler --namespace kube-system autoscaler/cluster-autoscaler-chart --values=./helm/cluster-autoscaler-values.yaml
$ kubectl --namespace=kube-system get pods -l "app.kubernetes.io/name=aws-cluster-autoscaler-chart,app.kubernetes.io/instance=cluster-autoscaler" # validate the deployment
```
 
OPTIONAL - Test if autoscaler works

```shell
$ kubectl apply -f k8s-manifest/mempod.yaml
```

Unistall Helm chart

```shell
$ helm uninstall cluster-autoscaler -n kube-system
```

# ALBv2 Ingress Controller

Documentation: https://kubernetes-sigs.github.io/aws-load-balancer-controller/latest/deploy/installation/

Install CRDs and ALB ingress manifest (Change eks.amazonaws.com/role-arn in alb-serviceaccount.yaml):

```shell
$ helm repo add eks https://aws.github.io/eks-charts
$ kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"
$ kubectl apply -f ./k8s-manifest/alb-serviceaccount.yaml
$ helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=<k8s-cluster-name> --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
```

Unistall Helm chart

```shell
$ helm uninstall aws-load-balancer-controller -n kube-system
```

# Deploy 2048 Game and Create ALB - Optional

```shell
$ kubectl apply -f k8s-manifest/2048.yaml
```