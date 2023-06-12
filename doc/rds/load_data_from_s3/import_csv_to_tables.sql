LOAD DATA FROM S3
    FILE
    's3://verification.wyrd-kobayashi.com/sample.csv'
    REPLACE
    INTO TABLE samples
;
