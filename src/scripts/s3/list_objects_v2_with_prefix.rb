# frozen_string_literal: true

require './src/scripts/s3/base'

module S3
  class ListObjectsV2WithPrefix < Base
    HEADER = ['prefix', '結果'].freeze

    def initialize
      super
      @output.append(HEADER)
    end

    def execute
      setup
      prefix_without_delimiter
      prefix_with_delimiter
      prefix_with_part_of_file
      prefix_with_key
      output
    end

    def prefix_without_delimiter
      target_prefix = "#{prefix}"
      result(target_prefix)
    end

    def prefix_with_delimiter
      target_prefix = "#{prefix}/"
      result(target_prefix)
    end

    def prefix_with_part_of_file
      target_prefix = "#{prefix}/sample"
      result(target_prefix)
    end

    def prefix_with_key
      target_prefix = "#{prefix}/sample1.json"
      result(target_prefix)
    end

    def setup
      target_prefix = "#{prefix}/"
      files = ["sample1.json", "sample2.json"]
      files.each do |file|
        key = "#{target_prefix}#{file}"
        delete_object(key)
        put_object({bucket: bucket, key: key, body: body,})
      end
      result(target_prefix)
    end

    def body
      settings.upload_file
    end

    def settings
      Settings.copy_object_with_metadata
    end

    def prefix
      'list_objects_v2_with_prefix'
    end

    def result(prefix)
      response = list_objects_v2(prefix)
      keys = response.contents.map { |content| content[:key] }
      @output.append(
        [
          prefix,
          keys.join('<br>'),
        ]
      )
    end
  end
end

S3::ListObjectsV2WithPrefix.new.execute if __FILE__ == $PROGRAM_NAME
