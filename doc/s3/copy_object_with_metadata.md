# copy_object時におけるメタデータの扱い

## 事象
- ローカルからS3にアップロード(`s3 sync`)したオブジェクトをコピー(`copy_object`)した際にメタデータの情報を追加しようとしたら、既存の設定が消えてしまった

## 検証
### 検証コード
- [`src/scripts/s3/copy_object_with_metadata.rb`](/src/scripts/s3/copy_object_with_metadata.rb)
```sh
docker-compose run --rm app bundle exec ruby src/scripts/s3/copy_object_with_metadata.rb
```

### 検証結果
| metadata | metadata_directive | Key | ContentType | CacheControl | メタデータ |
| :-- | :-- | :-- | :-- | :-- | :-- |
| 初期データ |  | copy_object_with_metadata/original.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| なし | なし | copy_object_with_metadata/copy_without_metadata_none.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| なし | COPY | copy_object_with_metadata/copy_without_metadata_copy.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| なし | REPLACE | copy_object_with_metadata/copy_without_metadata_replace.json | binary/octet-stream |  | {} |
| 指定 | なし | copy_object_with_metadata/copy_with_metadata_none.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| 指定 | COPY | copy_object_with_metadata/copy_without_metadata_copy.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| 指定 | REPLACE | copy_object_with_metadata/copy_without_metadata_replace.json | text/html | max-age=2 | {"x-amz-metadata-other"=>"copy_without_metadata_replace"} |

## 結論
- `metadata_directive`に`COPY`を指定した際には、元のメタデータがコピーされる
   - `metadata`に新しいメタデータを指定しても、`COPY`が指定されている場合は反映されない
- `metadata_directive`に`REPLACE`を指定した際には、新しく指定したメタデータが反映される
   - 既存のメタデータに新しく追加する場合でも、既存のものを含めて指定する必要がある→指定したものしか反映されない

## 参考
- https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/userguide/UsingMetadata.html
- https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html
