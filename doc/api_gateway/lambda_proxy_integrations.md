# Lambdaプロキシ統合

## プロキシ統合と非プロキシ統合の違い

### プロキシ統合

リクエストに渡されたURLやパラメータの処理をLambda側にて処理をする必要がある

→ API Gateway側で指定された書式のレスポンスを返す必要がある

### 非プロキシ統合

リクエストに渡されたURLやパラメータの処理をAPI Gateway側にて処理をする必要がある<br>
処理しない場合、リクエストに含まれる情報はLambda側には伝わらない

→ アプリ側で自由にパラメータの増減を行うことができない

## 参考

- [API Gateway で Lambda プロキシ統合を設定する](https://docs.aws.amazon.com/ja_jp/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html)
- [マッピングテンプレートについて](https://docs.aws.amazon.com/ja_jp/apigateway/latest/developerguide/models-mappings.html)
- [API Gateway マッピングテンプレートとアクセスのログ記録の変数リファレンス](https://docs.aws.amazon.com/ja_jp/apigateway/latest/developerguide/api-gateway-mapping-template-reference.html)
