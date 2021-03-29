# Instal AWS CLI

https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html

$ aws configure
AWS Access Key ID [None]: YOUR_AWS_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_AWS_SECRET_ACCESS_KEY
Default region name [None]: YOUR_AWS_REGION
Default output format [None]: json


# Install IAM authenticator

https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html


# Install Terraform

https://releases.hashicorp.com/terraform/0.14.9/terraform_0.14.9_windows_amd64.zip


# Configure AWS cli

```shell
$ aws configure
AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>
AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>
Default region name [None]: <YOUR_AWS_REGION>
Default output format [None]: json
```

# Run Terraform

```shell
$ terraform init
$ terraform plan
$ terraform appy
```

# Cluster Autoscaler

Documentation - https://github.com/terraform-aws-modules/terraform-aws-eks/tree/master/examples/irsa

Replace `<ACCOUNT ID>` with your AWS account ID in `cluster-autoscaler-chart-values.yaml`. There is output from terraform for this.

Install the chart using the provided values file:

```shell
$ helm repo add autoscaler https://kubernetes.github.io/autoscaler
$ helm repo update
$ helm upgrade --install cluster-autoscaler --namespace kube-system autoscaler/cluster-autoscaler-chart --values=./helm/cluster-autoscaler-values.yaml
$ helm install cluster-autoscaler --namespace kube-system autoscaler/cluster-autoscaler-chart --values=cluster-autoscaler-chart-values.yaml
$ kubectl --namespace=kube-system get pods -l "app.kubernetes.io/name=aws-cluster-autoscaler-chart,app.kubernetes.io/instance=cluster-autoscaler"
```
 
Unistall Helm chart

```shell
$ helm uninstall cluster-autoscaler -n kube-system
```