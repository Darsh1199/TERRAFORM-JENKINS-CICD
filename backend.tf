terraform {
  backend "s3" {
    bucket = "mrcloudbook-cicd-bucket"
    key    = "my-terraform-environment/main"
    region = "us-east-1"

    endpoints = {
      s3 = "http://localhost:9000"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}
