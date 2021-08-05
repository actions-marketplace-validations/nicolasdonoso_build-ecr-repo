# Build ECR repo

This action will build an ECR repo with the name of the repository where it is running.

## Env var needs

- AWS_REGION

- AWS_ACCOUNT

- environment.name


## Example usage

```
on: [push]

jobs:
  build:
    runs-on: self-hosted
    name: Build
    environment:
      name: <ENV NAME>
    env:
      AWS_ACCOUNT: <AWS ACCOUNT ID>
      AWS_REGION: <AWS REGION>
    steps:
      - name: Cache TF state
        uses: actions/cache@v2
        with:
          key: ${{ environment.name  }}
          path: |
            deploy/terraform/plan.tfplan
            deploy/terraform/.terraform
            deploy/terraform/terraform.tfstate
      - name: ECR repo
        uses: nicolasdonoso/build-ecr-repo@v1.0
      
```