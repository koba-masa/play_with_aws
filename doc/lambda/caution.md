# 注意事項
## ディスク
- `/tmp`
	- `512MB`まで
	- 一時的な領域
		- キャッシュすることも可能
- 複数コンテナにて起動した場合、共有できない
	- 同一コンテナにて起動した場合、共有**してしまう**

## メモリ
- 128MB〜10,240MB

## タイムアウト
- 15分
	- 15分で終了しない処理は分割し、LambdaからLambdaを呼び出すことで対応する

## デプロイ
- zipファイル化してアップロードする必要がある
- ファイルサイズ
	- 圧縮時：`50MB`
		- 超過する場合はS3経由でアップロードする必要がある
	- 展開時：`250MB`

## ログ
- CloudWatchのログに出力する場合は、`標準出力`を指定する

### ログ出力用ポリシー
- `基本的なLambdaアクセス権限で新しいロールを作成`を指定した場合に設定されるポリシー
```
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": "logs:CreateLogGroup",
          "Resource": "arn:aws:logs:<region>:<account_id>:*"
      },
      {
          "Effect": "Allow",
          "Action": [
              "logs:CreateLogStream",
              "logs:PutLogEvents"
          ],
          "Resource": [
              "arn:aws:logs:<region>:<account_id>:log-group:/aws/lambda/<lambda_function_name>:*"
          ]
      }
  ]
}
```

## 実行
- 最初に実行されるメソッドを以下にて設定する
	- `コード` > `ランタイム設定` > `ハンドラ`
		- デフォルト：`lambda_function.lambda_handler`
			- `ファイル名(拡張子抜き).メソッド名`
### 引数
- `event`
	- イベントオブジェクト
- `context`
	- 実行環境に関するデータ

### 戻り値
- 呼び出しの種類と呼び出し元のサービスによって形式変化する

## 参考
- https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/lambda-foundation.html
- https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/runtimes-context.html
- https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/gettingstarted-limits.html
- https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/python-handler.html
	- https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/ruby-handler.html
- https://qiita.com/attakei/items/e4c2b885da77faed01db
