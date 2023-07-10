# frozen_string_literal: true

require './src/scripts/s3/base'

module S3
  class GetObjectResponse < Base
    def initialize
      super
    end

    def execute
      setup
    end

    def setup
      settings.s3.upload_files.each do |file|
        file_path = file.path
        content_type = file.content_type
        put_object(
          {
            bucket:,
            key: "#{prefix}/#{File.basename(file_path)}",
            body: File.open(file_path),
            content_type:,
          }
        )
      end
    end

    def settings
      Settings.get_object_response
    end

    def prefix
      "get_object_response"
    end
  end
end

S3::GetObjectResponse.new.execute if __FILE__ == $PROGRAM_NAME
