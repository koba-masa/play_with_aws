# frozen_string_literal: true

require './src/scripts/s3/base'

module S3
  class CopyObjectWithMetadata < Base
    HEADER = %w[metadata metadata_directive Key ContentType CacheControl メタデータ].freeze

    def initialize
      super
      @output.append(HEADER)
    end

    def execute
      setup
      copy_without_metadata_by_none
      copy_without_metadata_by_copy
      copy_without_metadata_by_replace
      copy_with_metadata_by_none
      copy_with_metadata_by_copy
      copy_with_metadata_by_replace
      output
    end

    def copy_without_metadata_by_none
      key = "#{prefix}/copy_without_metadata_by_none.json"
      additional_options = nil
      delete_object(key)
      copy_object(options(key, additional_options))
      result('なし', 'なし', key)
    end

    def copy_without_metadata_by_copy
      key = "#{prefix}/copy_without_metadata_by_copy.json"
      additional_options = {
        metadata_directive: 'COPY',
      }
      delete_object(key)
      copy_object(options(key, additional_options))
      result('なし', 'COPY', key)
    end

    def copy_without_metadata_by_replace
      key = "#{prefix}/copy_without_metadata_by_replace.json"
      additional_options = {
        metadata_directive: 'REPLACE',
      }
      delete_object(key)
      copy_object(options(key, additional_options))
      result('なし', 'REPLACE', key)
    end

    def copy_with_metadata_by_none
      key = "#{prefix}/copy_with_metadata_by_none.json"
      additional_options = {
        content_type: 'text/html',
        cache_control: 'max-age=2',
        metadata: {
          'x-amz-metadata-other' => 'copy_with_metadata_by_none',
        },
      }
      delete_object(key)
      copy_object(options(key, additional_options))
      result('指定', 'なし', key)
    end

    def copy_with_metadata_by_copy
      key = "#{prefix}/copy_with_metadata_by_copy.json"
      additional_options = {
        metadata_directive: 'COPY',
        content_type: 'text/html',
        cache_control: 'max-age=2',
        metadata: {
          'x-amz-metadata-other' => 'copy_with_metadata_by_copy',
        },
      }
      delete_object(key)
      copy_object(options(key, additional_options))
      result('指定', 'COPY', key)
    end

    def copy_with_metadata_by_replace
      key = "#{prefix}/copy_with_metadata_by_replace.json"
      additional_options = {
        metadata_directive: 'REPLACE',
        content_type: 'text/html',
        cache_control: 'max-age=2',
        metadata: {
          'x-amz-metadata-other' => 'copy_with_metadata_by_replace',
        },
      }
      delete_object(key)
      copy_object(options(key, additional_options))
      result('指定', 'REPLACE', key)
    end

    def setup
      delete_object(original_key)
      put_object(
        {
          bucket:,
          key: original_key,
          body:,
          content_type: 'application/json',
          cache_control: 'max-age=1',
          metadata: {
            'x-amz-metadata' => 'setup',
          },
        },
      )
      result('初期データ', '', original_key)
    end

    def settings
      Settings.copy_object_with_metadata
    end

    def body
      settings.upload_file
    end

    def options(destination_key, additional_options)
      options = {
        bucket:,
        copy_source: "#{bucket}/#{original_key}",
        key: destination_key,
      }
      options = options.merge(additional_options) unless additional_options.nil?
      options
    end

    def prefix
      'copy_object_with_metadata'
    end

    def original_key
      "#{prefix}/original.json"
    end

    def result(metadata, metadata_directive, key)
      response = get_object(key)
      @output.append(
        [
          metadata,
          metadata_directive,
          key,
          response.content_type,
          response.cache_control,
          response.metadata,
        ],
      )
    end
  end
end

S3::CopyObjectWithMetadata.new.execute if __FILE__ == $PROGRAM_NAME
