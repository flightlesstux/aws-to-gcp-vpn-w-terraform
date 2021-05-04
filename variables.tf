variable "name" {
    type = string
    description = "AWS to GCP Connection Name"
    default = "aws-to-gcp-vpn"
}

variable "gcp_project" {
    type = string
    description = "GCP Project ID"
    default = "0123456789012"
}

variable "gcp_region" {
    type = string
    description = "GCP Region"
    default = "europe-west1"
}

variable "gcp_project_name" {
    type = string
    description = "GCP Project Name"
    default = "hello-baby"
}

variable "gcp_zone" {
    type = string
    description = "GCP Zone"
    default = "europe-west1-b"
}

variable "gcp_network" {
    type = string
    description = "GCP Network Name"
    default = "my-network"
}

variable "gcp_subnet" {
    type = string
    description = "GCP Network Subnet Name"
    default = "private-network"
}

variable "aws_region" {
    type = string
    description = "AWS Region"
    default = "eu-central-1"
}

variable "aws_vpc_id" {
    type = string
    description = "AWS VPC ID"
    default = "vpc-123a5b57"
}
