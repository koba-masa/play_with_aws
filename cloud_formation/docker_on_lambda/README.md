# AWS Lambda上にてDockerを動かす

## 実行環境構築

### 新規作成

```sh
aws cloudformation create-stack \
   --stack-name play-with-aws-docker-on-lambda-ecr \
   --template-body file://ecr.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=docker_on_lambda Key=CmBillingGroup,Value=play_with_aws_docker_on_lambda
```

```sh
aws cloudformation create-stack \
   --stack-name play-with-aws-docker-on-lambda \
   --capabilities CAPABILITY_NAMED_IAM \
   --template-body file://main.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=docker_on_lambda Key=CmBillingGroup,Value=play_with_aws_docker_on_lambda
```

### 更新

```sh
aws cloudformation update-stack --stack-name play-with-aws-docker-on-lambda-ecr \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file://s3.yaml
```

```sh
aws cloudformation update-stack --stack-name play-with-aws-docker-on-lambda \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file://main.yaml
```

### 削除

```sh
aws cloudformation delete-stack --stack-name play-with-aws-docker-on-lambda
```

```sh
aws cloudformation delete-stack --stack-name play-with-aws-docker-on-lambda-ecr
```

## Dockerfileのビルド

### シンボリックリンクの作成

```sh
cd docker_files
cp ../../../src/scripts/lambda/lambda_via_api_gateway.rb .
docker build -t play_with_aws_docker_on_lambda .
```
