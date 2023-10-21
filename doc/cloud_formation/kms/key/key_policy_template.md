# KMSのキーポリシーのテンプレート

## 共通部分

```yaml
Sid: "Enable IAM User Permissions"
Effect: Allow
Principal:
  AWS: !Sub arn:aws:iam::${AWS::AccountId}:root
Action:
  - "kms:*"
Resource: "*"
```

## キーの管理権限

```yaml
Sid: "Allow access for Key Administrators"
Effect: Allow
Principal:
  AWS: []
Action:
  - kms:Create*
  - kms:Describe*
  - kms:Enable*
  - kms:List*
  - kms:Put*
  - kms:Update*
  - kms:Revoke*
  - kms:Disable*
  - kms:Get*
  - kms:Delete*
  - kms:TagResource
  - kms:UntagResource
Resource: "*"
```

### キーの削除権限

`Action`に以下の操作権限を追加する

- `kms:ScheduleKeyDeletion`
- `kms:CancelKeyDeletion`

## キーの使用権限

以下の2つの設定を行う

```yaml
Sid: "Allow use of the key"
Effect: Allow
Principal:
  AWS: []
Action:
  - kms:Encrypt
  - kms:Decrypt
  - kms:ReEncrypt*
  - kms:GenerateDataKey*
  - kms:DescribeKey
Resource: "*"
```

```yaml
Sid: "Allow attachment of persistent resources"
Effect: Allow
Principal:
  AWS: []
Action:
  - kms:CreateGrant
  - kms:ListGrants
  - kms:RevokeGrant
Resource: "*"
Condition:
  Bool:
    kms:GrantIsForAWSResource: "true"
```

## 別のAWSアカウントとの連携

- TODO
