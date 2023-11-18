# スイッチロールをするためのAWS Profile設定

## 設定内容

### `~/.aws/config`

```sh
[profile play_with_aws_user_for_switch_role]
region = us-east-2
output = table

[profile play_with_aws_switch_role]
source_profile = play_with_aws_user_for_switch_role
role_arn = arn:aws:iam::222222222222:role/play_with_aws_switch_role
mfa_serial = arn:aws:iam::222222222222:mfa/play_with_aws_switch_role
role_session_name = play_with_aws_switch_role
```

### `~/.aws/credential`

```sh
[play_with_aws_user_for_switch_role]
aws_access_key_id=ABCDEFGHIJK1234567
aws_secret_access_key=ABCDEFGHIJK1234567
```
