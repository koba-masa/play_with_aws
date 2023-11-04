# API Gateway経由にてLambdaを実行する

## 実行環境構築

### 新規作成

```sh
aws cloudformation create-stack \
   --stack-name play-with-aws-lambda-via-api-gateway-s3 \
   --template-body file://s3.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=common Key=CmBillingGroup,Value=play_with_aws_common
```

```sh
aws cloudformation create-stack \
   --stack-name play-with-aws-lambda-via-api-gateway \
   --capabilities CAPABILITY_NAMED_IAM \
   --template-body file://main.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=lambda_via_api_gateway Key=CmBillingGroup,Value=play_with_aws_lambda_via_api_gateway
```

### 更新

```sh
aws cloudformation update-stack --stack-name play-with-aws-lambda-via-api-gateway-s3 \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file://s3.yaml
```

```sh
aws cloudformation update-stack --stack-name play-with-aws-lambda-via-api-gateway \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file://main.yaml
```

### 削除

```sh
aws cloudformation delete-stack --stack-name play-with-aws-lambda-via-api-gateway
```

```sh
aws cloudformation delete-stack --stack-name play-with-aws-lambda-via-api-gateway-s3
```

### ソースコードのデプロイ

```sh
zip -r lambda_via_api_gateway.zip ../../src
aws s3 cp lambda_via_api_gateway.zip s3://play-with-aws-lambda-deployment/production/
```
