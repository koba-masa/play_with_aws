# Infrastructure As Code〜AWS CDK編〜

## 概要
- AWS CDKを使用して、AWS CloudFormationのスタックを作成する
   - [TypeScriptを使用する](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/work-with-cdk-typescript.html)


## ポリシー
- 以下のポリシーを実行するユーザーまたはロールに付与する<br>※`<アカウントID>`を対象のアカウントIDに変換する
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "cloudformation:CreateStack",
           "cloudformation:DeleteStack",
           "cloudformation:UpdateStack"
         ],
         "Resource": [
           "arn:aws:s3:::*",
           "arn:aws:cloudformation:*:<アカウントID>:stack/*/*"
         ]
       }
     ]
   }
   ```

## 手順
1. バケット名を指定する
   ```sh
   bucket_name=<適当なバケット名を指定>
   ```
1. 以下のコマンドのいずれかを実行する

```sh
yarn cdk --version
```

### 作成コマンド
```sh
aws cloudformation create-stack \
   --stack-name play-with-aws-iac-cf \
   --template-body file://cloudformation/main.yaml \
   --parameters ParameterKey=BucketName,ParameterValue=${bucket_name} \
   --tags Key=Project,Value=play_with_aws Key=Tag,Value=infrastructure_as_code
```

### 更新コマンド
```sh
aws cloudformation update-stack \
   --stack-name play-with-aws-iac-cf \
   --template-body file://cloudformation/main.yaml \
   --parameters ParameterKey=BucketName,ParameterValue=${bucket_name}
```

### 削除コマンド
```sh
aws cloudformation delete-stack --stack-name play-with-aws-iac-cf
```
