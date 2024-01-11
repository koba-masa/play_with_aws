# Infrastructure As Code
## 概要
- 以下を使用して、インフラ構成図にある環境を構築する
   - AWS CloudFormation
   - AWS CDK
   - Terraform

### インフラ構成図
![インフラ構成図](/doc/infrastructure_as_code/images/infrastructure.svg)

## 事前準備
- 実行するユーザー、またはロールに対して、以下のポリシーを付与する<br>※`<アカウントID>`を対象のアカウントIDに変換する
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "s3:PutBucketPublicAccessBlock",
           "cloudfront:DeleteOriginAccessControl",
           "cloudfront:GetOriginAccessControlConfig",
           "cloudfront:TagResource",
           "cloudfront:UpdateOriginAccessControl",
           "s3:CreateBucket",
           "cloudfront:CreateDistribution",
           "s3:DeleteBucketPolicy",
           "cloudfront:GetDistribution",
           "s3:PutBucketTagging",
           "cloudfront:GetOriginAccessControl",
           "s3:PutLifecycleConfiguration",
           "s3:PutBucketPolicy",
           "cloudfront:UpdateDistribution",
           "cloudfront:GetDistributionConfig",
           "cloudfront:DeleteDistribution",
           "s3:DeleteBucket",
           "s3:PutBucketVersioning"
         ],
         "Resource": [
           "arn:aws:s3:::*",
           "arn:aws:cloudfront::<アカウントID>:streaming-distribution/*",
           "arn:aws:cloudfront::<アカウントID>:origin-access-control/*",
           "arn:aws:cloudfront::<アカウントID>:distribution/*"
         ]
       },
       {
         "Sid": "VisualEditor1",
         "Effect": "Allow",
         "Action": [
           "cloudfront:CreateOriginAccessControl",
           "s3:PutAccountPublicAccessBlock",
           "s3:PutAccessPointPublicAccessBlock"
         ],
         "Resource": "*"
       }
     ]
   }
```

## 実行手順
1. ディレクトリを移動する
    ```sh
    cd doc/infrastructure_as_code
    ```
1. 各ツールの詳細な手順は各ページを参照する
    - [AWS CloudFormation](/doc/infrastructure_as_code/cloudformation/README.md)
    - [AWS CDK](/doc/infrastructure_as_code/cdk/README.md)
    - [Terraform]()

## 参考
- AWS CloudFormation
    - S3
    - CloudFront
      - [オリジンアクセスコントロール](https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-originaccesscontrol.html)
- AWS CDK
- [S3 バケットへのアクセス許可をオリジンアクセスコントロールに付与する](https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html#oac-permission-to-access-s3)
