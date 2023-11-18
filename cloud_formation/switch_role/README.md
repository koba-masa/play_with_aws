# ロールの切り替え

## 環境構築

### 新規作成

```sh
aws cloudformation create-stack --stack-name play-with-aws-switch-role \
   --capabilities CAPABILITY_NAMED_IAM \
   --template-body file://main.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=switch_role Key=CmBillingGroup,Value=play_with_aws_switch_role
```

### 更新

```sh
aws cloudformation update-stack --stack-name play-with-aws-switch-role \
   --capabilities CAPABILITY_NAMED_IAM \
   --template-body file://main.yaml
```

### 削除

```sh
aws cloudformation delete-stack --stack-name play-with-aws-switch-role
```
