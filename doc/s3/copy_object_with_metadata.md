| metadata | metadata_directive | Key | ContentType | CacheControl | メタデータ |
| :-- | :-- | :-- | :-- | :-- | :-- |
| 初期データ |  | copy_object_with_metadata/original.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| なし | なし | copy_object_with_metadata/copy_without_metadata_none.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| なし | COPY | copy_object_with_metadata/copy_without_metadata_copy.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| なし | REPLACE | copy_object_with_metadata/copy_without_metadata_replace.json | binary/octet-stream |  | {} |
| 指定 | なし | copy_object_with_metadata/copy_with_metadata_none.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| 指定 | COPY | copy_object_with_metadata/copy_without_metadata_copy.json | application/json | max-age=1 | {"x-amz-metadata"=>"setup"} |
| 指定 | REPLACE | copy_object_with_metadata/copy_without_metadata_replace.json | text/html | max-age=2 | {"x-amz-metadata-other"=>"copy_without_metadata_replace"} |