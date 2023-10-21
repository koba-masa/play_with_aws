# AWS ECSを使用したWebアプリケーション環境の構築

## 構成図

## 手順

#### スタックの作成

```sh
aws cloudformation create-stack \
   --stack-name play-with-aws-web-service-with-ecs-ecr \
   --template-body file://ecr.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=web_service_with_ecs Key=CmBillingGroup,Value=play_with_aws_web_service_with_ecs
```

#### スタックの更新

```sh
aws cloudformation update-stack --stack-name play-with-aws-web-service-with-ecs-ecr \
  --template-body file://ecr.yaml
```

#### スタックの削除

```sh
aws cloudformation delete-stack --stack-name play-with-aws-web-service-with-ecs-ecr
```

#### イベントの確認

```sh
aws cloudformation describe-stack-events --stack-name play-with-aws-web-service-with-ecs-ecr --output text
```

### Webアプリケーション環境の構築

#### スタックの作成

```sh
aws cloudformation create-stack \
   --stack-name play-with-aws-web-service-with-ecs \
   --capabilities CAPABILITY_NAMED_IAM \
   --template-body file://main.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=web_service_with_ecs Key=CmBillingGroup,Value=play_with_aws_web_service_with_ecs
```

#### スタックの更新

```sh
aws cloudformation update-stack --stack-name play-with-aws-web-service-with-ecs \
  --capabilities CAPABILITY_NAMED_IAM \
  --template-body file://main.yaml
```

#### スタックの削除

```sh
aws cloudformation delete-stack --stack-name play-with-aws-web-service-with-ecs
```

### イベントの確認

```sh
aws cloudformation describe-stack-events --stack-name play-with-aws-web-service-with-ecs --output text
```
