# put_object時におけるメタデータの扱い

## 検証
### 検証コード
- `src/scripts/s3/put_object_with_metadata.rb`
```sh
docker-compose run --rm app bundle exec ruby src/scripts/s3/put_object_with_metadata.rb
```

### 検証結果

| metadata | Key | メタデータ |
| :-- | :-- | :-- |
| なし | put_object_with_metadata/without_metadata.json | {} |
| あり→なし(初期状態) | put_object_with_metadata/without_metadata_after_with.json | {"x-amz-metadata-other"=>"without_metadata_after_with"} |
| あり→なし | put_object_with_metadata/without_metadata_after_with.json | {} |
| あり | put_object_with_metadata/with_metadata.json | {"x-amz-metadata-other"=>"with_metadata"} |
| なし→あり(初期状態) | put_object_with_metadata/with_metadata_after_without.json | {} |
| なし→あり | put_object_with_metadata/with_metadata_after_without.json | {"x-amz-metadata-other"=>"with_metadata_after_without"} |
