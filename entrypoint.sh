#!/bin/sh -l

export PROJECT_NAME=$(echo $GITHUB_REPOSITORY|cut -d '/' -f2)
export TAG=$GITHUB_JOB
echo "Creating $PROJECT_NAME ECR repo"

mkdir -p deploy/terraform

cat << EOF > variables.tf
variable "account" {
  default = "$AWS_ACCOUNT"
}

variable "region" {
  default = "$AWS_REGION"
}
EOF

cat << EOF > main.tf
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

envsubst < variables.tf > deploy/terraform/variables.tf
envsubst < main.tf > deploy/terraform/main.tf
cd deploy/terraform/
terraform init
terraform plan -out=plan.tfplan
sleep 30
echo "holding for 30s before running apply"
terraform apply -input=false plan.tfplan