# LambdaからLambdaを呼び出す

- Lambda.Client.invokeにて別のLambdaを呼び出す

## パラメータ
| 項目 | 概要 | 備考 |
|:--|:--|:--|
|function_name|呼び出す関数名|関数名・関数ARN・関数ARNの一部※1|
|invocation_type|呼び出し方法|参照：[呼び出し方法](#呼び出し方法)|
|log_type|ログ出力方法|`Tail`を設定するとレスポンスにログが含まれる|
|client_context|呼び出し側に渡すコンテキストオブジェクト||
|payload|呼び出し側に渡すイベントオブジェクト||
|qualifier|呼び出す関数のバージョン、エイリアス||
||||

- ※1・・・ARNを`arn:aws:lambda:us-west-2:123456789012:function:my-function`とすると`123456789012:function:my-function`

### 呼び出し方法

|項目|概要|備考|
|:--|:--|:--|
|RequestResponse|同期呼び出し||
|Event|非同期呼び出し|レスポンスには呼び出しに成功したかどうかのステータスコードが返却される|
|DryRun|テスト実行||
||||

## 戻り値
|項目|概要|備考|
|:--|:--|:--|
|status_code|ステータスコード|非同期で呼び出した場合、呼び出しに成功したかどうかを返却する|
|function_error|エラーメッセージ。詳細は`payload`に格納|エラーが発生した場合に設定される|
|log_result|実行ログ||
|payload|レスポンスorエラーオブジェクト||
|executed_version|実行された関数のバージョン||
||||
## 参考
- APIリファレンス
  - https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/API_Invoke.html
    - [リクエストの構文](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/API_Invoke.html#API_Invoke_RequestSyntax)
    - [レスポンス要素](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/API_Invoke.html#API_Invoke_ResponseElements)

### Ruby
- APIリファレンス(SDK For Ruby)
  - [Aws::Lambda::Client#invoke](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Lambda/Client.html#invoke-instance_method)
    - [Aws::Lambda::Client#invoke_async](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Lambda/Client.html#invoke_async-instance_method)

### Python
- APIリファレンス(SDK For Python)
  - [boto3.Lambda.Client.invoke](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/lambda.html#Lambda.Client.invoke)
    - [boto3.Lambda.Client.invoke_async](https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/lambda.html#Lambda.Client.invoke_async)
