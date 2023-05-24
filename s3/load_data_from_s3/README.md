# S3にあるCSVファイルからAuroraRDS(MySQL)にデータをインポートする

## 前提条件
### RDS-S3間のアクセスを行うためのロールの作成
- ユースケース
  - `RDS - Add Role to Database`
    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "",
                "Effect": "Allow",
                "Principal": {
                    "Service": "rds.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    ```

- ポリシー
  - `AmazonS3ReadOnlyAccess`

### インポート対象となるファイルの準備
|||
|:--|:--|
|バケット|`sample.bucket`|
|キー|`sample.csv`|
|S3 URI|`s3://sample.bucket/sample.csv`|

[s3/load_data_from_s3/sample.csv](/s3/load_data_from_s3/sample.csv)

## 事前作業
### ユーザの作成
```sql
mysql> CREATE DATABASE verification CHARACTER SET UTF8;
mysql> CREATE USER 'testuser'@'%' IDENTIFIED BY 'test123';
mysql> GRANT SELECT, INSERT, UPDATE, DELETE ON verification.* TO 'testuser'@'%';
mysql> SHOW GRANTS FOR 'testuser'@'%';
+----------------------------------------------------------------------------+
| Grants for testuser@%                                                      |
+----------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `testuser`@`%`                                       |
| GRANT SELECT, INSERT, UPDATE, DELETE ON `verification`.* TO `testuser`@`%` |
+----------------------------------------------------------------------------+
2 rows in set (0.20 sec)
```

### テーブルの作成
[s3/load_data_from_s3/create_samples.sql](/s3/load_data_from_s3/create_samples.sql)

## 本題
### インポート用の権限を付与
```sql
mysql> GRANT AWS_LOAD_S3_ACCESS TO 'testuser'@'%';
mysql> SHOW GRANTS FOR 'testuser'@'%';
+----------------------------------------------------------------------------+
| Grants for testuser@%                                                      |
+----------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `testuser`@`%`                                       |
| GRANT SELECT, INSERT, UPDATE, DELETE ON `verification`.* TO `testuser`@`%` |
| GRANT `AWS_LOAD_S3_ACCESS`@`%` TO `testuser`@`%`                           |
+----------------------------------------------------------------------------+
3 rows in set (0.13 sec)
```

### クラスターパラメータの変更
- クラスターパラメータの変更
  |概要|Variable_name|Value|
  |:--|:--|:--|
  |ロールの自動有効化|`activate_all_roles_on_login`|`1`|
  |`LOAD DATA FROM S3`ステートメント実行用ロール|`aws_default_s3_role`|`arn:aws:iam::<account_id>:role/<role_id>`|


### LOAD DATA FROM S3の実行
```sql
mysql> LOAD DATA FROM S3
    ->     FILE
    ->     's3://sample.bucket/sample.csv'
    ->     REPLACE
    ->     INTO TABLE samples
    -> ;
uery OK, 4 rows affected, 16 warnings (0.20 sec)
Records: 4  Deleted: 0  Skipped: 0  Warnings: 16

```

## はまりポイント
### クラスターパラメータの設定不足
```sql
mysql> LOAD DATA FROM S3
    ->     FILE
    ->     's3://sample.bucket/sample.csv'
    ->     REPLACE
    ->     INTO TABLE samples
    -> ;
ERROR 63985 (HY000): S3 API returned error: Both aurora_load_from_s3_role and aws_default_s3_role are not specified, please see documentation for more details

mysql> SHOW VARIABLES LIKE '%aws_default_s3_role%';
+---------------------+-------+
| Variable_name       | Value |
+---------------------+-------+
| aws_default_s3_role |       |
+---------------------+-------+
1 row in set (0.14 sec)
```

> `ERROR 63985 (HY000): S3 API returned error: Both aurora_load_from_s3_role and aws_default_s3_role are not specified, please see documentation for more details`

https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Integrating.Authorizing.IAM.AddRoleToDBCluster.html


```sql
mysql> SHOW VARIABLES LIKE '%aws_default_s3_role%';
+---------------------+------------------------------------------------------------------+
| Variable_name       | Value                                                            |
+---------------------+------------------------------------------------------------------+
| aws_default_s3_role | arn:aws:iam::<account_id>:role/<role_id>　                       |
+---------------------+------------------------------------------------------------------+
1 row in set (0.13 sec)

mysql>
```

## 参考
- [Amazon S3 バケットのテキストファイルから Amazon Aurora MySQL DB クラスターへのデータのロード](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Integrating.LoadFromS3.html)
  - [IAM ロールと Amazon Aurora MySQL DB クラスターの関連付け](https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Integrating.Authorizing.IAM.AddRoleToDBCluster.html)
