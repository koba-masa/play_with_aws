# AWSの初期ユーザーグループの作成(初期パスワードの変更権限・MFA認証の必須化)

## 環境構築

### 新規作成

```sh
aws cloudformation create-stack --stack-name play-with-aws-setup-default-user-group \
   --capabilities CAPABILITY_NAMED_IAM \
   --template-body file://main.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=default_user_group Key=CmBillingGroup,Value=play_with_aws_default_user_group
```

### 更新

```sh
aws cloudformation update-stack --stack-name play-with-aws-setup-default-user-group \
   --capabilities CAPABILITY_NAMED_IAM \
   --template-body file://main.yaml
```

### 削除

```sh
aws cloudformation delete-stack --stack-name play-with-aws-setup-default-user-group
```
