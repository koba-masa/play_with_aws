# S3オブジェクトにおけるContentTypeの扱いについて

## 事象
- JSONファイルをアップロード(`put_object`)した際に、`ContentType`に`binary/octet-stream`が設定されていた

## 検証

### 検証コード
- [`src/scripts/s3/put_object_with_content_type.rb`](/src/scripts/s3/put_object_with_content_type.rb)
```sh
docker-compose run --rm app bundle exec ruby src/scripts/s3/put_object_with_content_type.rb
```

### 検証結果

| file_type | content_type | Key | ContentType |
| :-- | :-- | :-- | :-- |
| json | なし | put_object_with_content_type/put_object_json_without_content_type.json | binary/octet-stream |
| json | text/json | put_object_with_content_type/put_object_json_with_content_type.json | text/json |
| json | text/html | put_object_with_content_type/put_object_json_with_content_type_html.json | text/html |
| html | なし | put_object_with_content_type/put_object_html_without_content_type.html | binary/octet-stream |
| html | text/html | put_object_with_content_type/put_object_html_with_content_type.html | text/html |
| html | text/json | put_object_with_content_type/put_object_html_with_content_type_json.json | text/json |
| text | なし | put_object_with_content_type/put_object_text_without_content_type.text | binary/octet-stream |
| text | text/plain | put_object_with_content_type/put_object_text_with_content_type.text | text/plain |
| text | text/json | put_object_with_content_type/put_object_text_with_content_type_json.json | text/json |

## 結論
- `content_type`が未指定の場合、推測による設定が行われる
  - S3コンソールに表示されている`タイプ`はコンテンツタイプではなく、拡張子を表示しているだけである

## 参考
- https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/userguide/UsingMetadata.html
- https://github.com/aws/aws-cli/blob/develop/awscli/customizations/s3/utils.py#L334
