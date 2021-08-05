# Build ECR repo

This action will build an ECR repo with the name of the repository where it is running.

## Env var needs

- AWS_REGION

- AWS_ACCOUNT


## Example usage

```
on: [push]

jobs:
  build:
    runs-on: self-hosted
    name: Build
    env:
      AWS_ACCOUNT: <AWS ACCOUNT ID>
      AWS_REGION: <AWS REGION>
    steps:
      - name: ECR repo
        uses: nicolasdonoso/build-ecr-repo@v1.0
      
```