# CodePipelineの

[変数の操作](https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/actions-variables.html)

## 環境構築

### 新規作成

```sh
aws cloudformation create-stack --stack-name play-with-aws-codepipeline-variables \
   --capabilities CAPABILITY_NAMED_IAM \
   --template-body file://main.yaml \
   --tags Key=Project,Value=play_with_aws Key=Identifier,Value=codepipeline_variables Key=CmBillingGroup,Value=play_with_aws_codepipeline_variables \
   --parameters ParameterKey=CodePipelineArtifactStore,ParameterValue=${CODE_PIPELINE_ARTIFACT_STORE} \
     ParameterKey=CodeStarConnectionArn,ParameterValue=${CODE_STAR_CONNECTION_ARN}
```

### 更新

```sh
aws cloudformation update-stack --stack-name play-with-aws-codepipeline-variables \
   --capabilities CAPABILITY_NAMED_IAM \
   --template-body file://main.yaml \
   --parameters ParameterKey=CodePipelineArtifactStore,ParameterValue=${CODE_PIPELINE_ARTIFACT_STORE} \
     ParameterKey=CodeStarConnectionArn,ParameterValue=${CODE_STAR_CONNECTION_ARN}
```

### 削除

```sh
aws cloudformation delete-stack --stack-name play-with-aws-codepipeline-variables
```
