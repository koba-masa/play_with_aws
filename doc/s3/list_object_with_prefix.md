# list_objects_v2におけるプレフィックの扱い

## 事象
- `list_objects_v2`を使用して、先頭一致するオブジェクトの取得を行なった際に、delimiterの有無で結果が変わった

## 検証
### 検証コード
- [`src/scripts/s3/list_objects_v2_with_prefix.rb`](/src/scripts/s3/list_objects_v2_with_prefix.rb)
```sh
docker-compose run --rm app bundle exec ruby src/scripts/s3/list_objects_v2_with_prefix.rb
```

### 検証結果
| prefix | 結果 |
| :-- | :-- |
| list_object_with_prefix/ | list_object_with_prefix/sample1.json<br>list_object_with_prefix/sample2.json |
| list_object_with_prefix | list_object_with_prefix/sample1.json<br>list_object_with_prefix/sample2.json |
| list_object_with_prefix/ | list_object_with_prefix/sample1.json<br>list_object_with_prefix/sample2.json |
| list_object_with_prefix/sample | list_object_with_prefix/sample1.json<br>list_object_with_prefix/sample2.json |
| list_object_with_prefix/sample1.json | list_object_with_prefix/sample1.json |

## 結論
- 結果に差分が見られず。
   - 仕様が変わった？

### AWS CLIを使用して検証
- CLIで検証した結果、以下の差分が発生した。

```
% aws s3 ls s3://sample.bucket/list_objects_v2_with_prefix/
2023-06-17 15:08:55         26 sample1.json
2023-06-17 15:08:55         26 sample2.json
% aws s3 ls s3://sample.bucket/list_objects_v2_with_prefix
                           PRE list_objects_v2_with_prefix/
%
```

## 参考
