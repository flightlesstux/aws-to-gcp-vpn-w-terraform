You can create a secure VPN connection (ipsec) between Amazon Web Services (AWS) and Google Cloud Platform (GCP) with this project.

## What can this do?

Creating a Customer Gateway on AWS.
Creating a Virtual Private Gateway on AWS.
Creating a Site-to-Site VPN Connection on AWS.
Creating a Security Group for VPN connection access on AWS.
Creating a External IP address for VPN connection on GCP.
Creating a Managing the firewall rule for VPN connection on GCP.
Creating a Route rule on GCP.


## Requirements

- [Enable Compute Engine API](https://console.cloud.google.com/marketplace/product/google/compute.googleapis.com) if doesn't enable.
- [Create Service account](https://console.cloud.google.com/iam-admin/serviceaccounts) with `Editor` role (or whatever you want) and export the key file.
- [Create Cloud Google Storage Bucket](https://console.cloud.google.com/storage/create-bucket) for keep the terraform state. If you want, you can add your service account as a member to bucket OR [Create S3 Bucket](https://s3.console.aws.amazon.com/s3/bucket/create?region=eu-central-1) for keep the terraform state.
- Check your [IAM Permissions](https://console.aws.amazon.com/iam/home) on AWS side.

## Usage

- Step 1:\
Clone this repository.

- Step 2:\
`export GOOGLE_APPLICATION_CREDENTIALS="service-account-key.json"`\
Authenticate to Google Platform if even google-sdk is not installed. It's really useful for CI/CD pipelines! If you already logged in to your Google Cloud Platform project like `gcloud auth login`, you can skip this step.

- Step 3:\
`export GOOGLE_PROJECT="0123456789012"`\
Project ID is also declared via terraform but if you don't export the value, you will probable get an error like below.

```
│ Error: project: required field is not set
│
│   with google_compute_instance_group_manager.this,
│   on group_manager.tf line 1, in resource "google_compute_instance_group_manager" "this":
│    1: resource "google_compute_instance_group_manager" "this" {
```

- Step 5:\
`AWS_ACCESS_KEY_ID=AKIA1SFAESADASFASR5D`\
`AWS_SECRET_ACCESS_KEY=Aasdfiajfar1O9DFASDAA3rasdas02304adsq9re`\
Export your AWS Access Key ID and Secret Access Key for create a resource in your AWS Region.

- Step 6:\
Edit values for `variables.tf` 

- Step 7:\
Set your terraform state bucket via `state.tf` file. You can use AWS S3 or Google Cloud Storage.

- Step 8:\
`terraform init`

- Step 9:\
`terraform apply` or `terraform apply -auto-approve`

## Terraform Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 3.38.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 3.66.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.38.0 |
| <a name="provider_google"></a> [google](#provider\_google) | 3.66.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_customer_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/3.38.0/docs/resources/customer_gateway) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/3.38.0/docs/resources/security_group) | resource |
| [aws_vpn_connection.this](https://registry.terraform.io/providers/hashicorp/aws/3.38.0/docs/resources/vpn_connection) | resource |
| [aws_vpn_connection_route.this](https://registry.terraform.io/providers/hashicorp/aws/3.38.0/docs/resources/vpn_connection_route) | resource |
| [aws_vpn_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/3.38.0/docs/resources/vpn_gateway) | resource |
| [aws_vpn_gateway_route_propagation.this](https://registry.terraform.io/providers/hashicorp/aws/3.38.0/docs/resources/vpn_gateway_route_propagation) | resource |
| [google_compute_address.this](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/resources/compute_address) | resource |
| [google_compute_firewall.this](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/resources/compute_firewall) | resource |
| [google_compute_forwarding_rule.esp](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_forwarding_rule.udp4500](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_forwarding_rule.udp500](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/resources/compute_forwarding_rule) | resource |
| [google_compute_route.this](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/resources/compute_route) | resource |
| [google_compute_vpn_gateway.this](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/resources/compute_vpn_gateway) | resource |
| [google_compute_vpn_tunnel.tunnel1](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/resources/compute_vpn_tunnel) | resource |
| [google_compute_vpn_tunnel.tunnel2](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/resources/compute_vpn_tunnel) | resource |
| [aws_customer_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/3.38.0/docs/data-sources/customer_gateway) | data source |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/3.38.0/docs/data-sources/route_table) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/3.38.0/docs/data-sources/vpc) | data source |
| [google_compute_address.this](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/data-sources/compute_address) | data source |
| [google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/data-sources/compute_network) | data source |
| [google_compute_subnetwork.cidr](https://registry.terraform.io/providers/hashicorp/google/3.66.1/docs/data-sources/compute_subnetwork) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | AWS to GCP Connection Name | `string` | `"aws-to-gcp-vpn"` | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region | `string` | `"eu-central-1"` | yes |
| <a name="input_aws_vpc_id"></a> [aws\_vpc\_id](#input\_aws\_vpc\_id) | AWS VPC ID | `string` | `"vpc-123a5b57"` | yes |
| <a name="input_gcp_network"></a> [gcp\_network](#input\_gcp\_network) | GCP Network Name | `string` | `"my-network"` | yes |
| <a name="input_gcp_subnet"></a> [gcp\_subnet](#input\_gcp\_subnet) | GCP Network Subnet Name | `string` | `"private-network"` | yes |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | GCP Project ID | `string` | `"0123456789012"` | yes |
| <a name="input_gcp_project_name"></a> [gcp\_project\_name](#input\_gcp\_project\_name) | GCP Project Name | `string` | `"hello-baby"` | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | GCP Region | `string` | `"europe-west1"` | yes |
| <a name="input_gcp_zone"></a> [gcp\_zone](#input\_gcp\_zone) | GCP Zone | `string` | `"europe-west1-b"` | yes |

## Outputs

No outputs.
