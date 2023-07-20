remote_state {
    backend = "s3"
    generate = {
        path = "state.tf"
        if_exists = "overwrite_terragrunt"
    }
    config = {
        profile = "your-aws-profile"
        role_arn = "arn:aws:iam::1234567:role/yourcompany@gmail.com"
        bucket = "name of the S3 bucket"

        key = "${path_relative_to_include()}/terraform.tfstate"
        region = "region"
        encrypt = true 
        dynamodb_table = "name of the DynamoDB table"
    }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
  region  = "us-east-1"
  profile = "local profile name with which you communicate with AWS"
  
  assume_role {
    session_name = "optional"
    role_arn = "arn:aws:iam::123456789:role/yourcompany@gmail.com"
  }
}
EOF
}