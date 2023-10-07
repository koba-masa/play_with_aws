# AWS ECSを使用したWebアプリケーション環境の構築

## 構成図

## 手順

### 作成コマンド
```sh
aws cloudformation create-stack \
   --stack-name play-with-aws-web-service-with-ecs \
   --template-body file://main.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=web_service_with_ecs
```

### 更新コマンド
```sh
aws cloudformation update-stack \
   --stack-name play-with-aws-web-service-with-ecs \
   --template-body file://main.yaml \
```

### 削除コマンド
```sh
aws cloudformation delete-stack --stack-name play-with-aws-web-service-with-ecs
```

### イベント確認コマンド
```sh
aws cloudformation describe-stack-events --stack-name play-with-aws-web-service-with-ecs
```
