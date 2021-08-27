require 'dotenv'
require 'aws-sdk-s3'

def main()
  threshold_date = create_threshold_date()
  credentials = Aws::Credentials.new(ENV["access_key_id"], ENV["secret_access_key"])
  s3_client = Aws::S3::Client.new(
    region: ENV["regions"],
    credentials: credentials
  )

  next_continuation_token = nil
  loop do
    response = s3_client.list_objects_v2(
      {
        bucket: ENV["bucket"],
        delimiter: "/",
        prefix: "",
        max_keys: 1,
        continuation_token: next_continuation_token
      }
    )

    next_continuation_token = response.next_continuation_token

    response.contents.each do | content |
      if can_delete?(threshold_date, content)
        s3_client.delete_object(
          {
            bucket: ENV["bucket"],
            key: content.key
          }
        )
      end
    end

    break unless response.is_truncated
  end
end

def create_threshold_date()
  today = Date.today
  Date.new(today.year, today.month - 3, 1)
end

def can_delete?(threshold_date, s3_object)
  threshold_date > s3_object.last_modified.localtime.to_date
end

if __FILE__ == $0
  Dotenv.load "config/.env"
  main()
end
