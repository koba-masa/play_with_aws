# CloudFront + S3で構築された静的Webサイト

## 実行環境構築

### 新規作成

```sh
aws cloudformation create-stack \
   --stack-name play-with-aws-website-be-composed-of-cf-and-s3 \
   --template-body file://main.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=website_be_composed_of_cf_and_s3 Key=CmBillingGroup,Value=play_with_aws_website_be_composed_of_cf_and_s3
```

### 更新

```sh
aws cloudformation update-stack --stack-name play-with-aws-website-be-composed-of-cf-and-s3 \
  --template-body file://main.yaml
```

### 削除

```sh
aws cloudformation delete-stack --stack-name play-with-aws-lambda-via-api-gateway
```

## Webサイトのデプロイ

```sh
aws s3 sync src s3://play-with-aws-website-be-composed-of-cf-and-s3 --delete
```
