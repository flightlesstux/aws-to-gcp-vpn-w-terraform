# You can keep your terraform state in GCP Cloud Storage or AWS S3. Chose your side.

terraform {
  backend "gcs" {
    bucket      = "tf-deployment-state"
    prefix      = "aws-to-gcp-vpn"
  }
}

terraform {
  backend "s3" {
    bucket = "tf-deployment-state-bucket"
    key    = "aws-to-gcp-vpn"
    region = "eu-central-1"
  }
}
