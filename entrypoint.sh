#!/bin/sh -l

export PROJECT_NAME=$(echo $GITHUB_REPOSITORY|cut -d '/' -f2)
export TAG=$GITHUB_JOB
echo "Creating $PROJECT_NAME ECR repo"

mkdir -p deploy/terraform

cat << EOF > deploy/terraform/main.tf
variable "account" {
  default = "$AWS_ACCOUNT"
}

variable "region" {
  default = "AWS_REGION"
}
EOF

cat << EOF > deploy/terraform/main.tf
provider "aws" {
    region = var.region
}

resource "aws_ecr_repository" "$PROJECT_NAME" {
  name                 = "$PROJECT_NAME"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
EOF

cd deploy/terraform/
terraform init
terraform plan -out=plan.tfplan