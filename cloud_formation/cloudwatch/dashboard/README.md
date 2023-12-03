# CloudWatchのダッシュボードを作成する

## 環境構築

### 新規作成

```sh
aws cloudformation create-stack --stack-name play-with-aws-cloudwatch-dashboard \
   --template-body file://main.yaml \
   --capabilities CAPABILITY_AUTO_EXPAND \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=cloudwatch_dashboard Key=CmBillingGroup,Value=play_with_aws_cloudwatch_dashboard
```

### 更新

```sh
aws cloudformation update-stack --stack-name play-with-aws-cloudwatch-dashboard \
   --capabilities CAPABILITY_AUTO_EXPAND \
   --template-body file://main.yaml
```

### 削除

```sh
aws cloudformation delete-stack --stack-name play-with-aws-cloudwatch-dashboard
```
