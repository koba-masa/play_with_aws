# frozen_string_literal: true

require './src/scripts/s3/base'

module S3
  class PutObjectWithMetadata < Base
    HEADER = %w[metadata Key メタデータ].freeze

    def initialize
      super
      @output.append(HEADER)
    end

    def execute
      without_metadata
      without_metadata_after_with
      with_metadata
      with_metadata_after_without
      output
    end

    def without_metadata
      metadata = 'なし'
      key = "#{prefix}/without_metadata.json"
      additional_options = nil

      delete_object(key)
      put_object(options(key, additional_options))
      result(metadata, key)
    end

    def without_metadata_after_with
      metadata = 'あり→なし'
      key = "#{prefix}/without_metadata_after_with.json"
      additional_options = { metadata: { 'x-amz-metadata-other' => 'without_metadata_after_with' } }

      delete_object(key)
      put_object(options(key, additional_options))
      result(metadata, key)
      put_object(options(key, nil))
      result(metadata, key)
    end

    def with_metadata
      metadata = 'あり'
      key = "#{prefix}/with_metadata.json"
      additional_options = { metadata: { 'x-amz-metadata-other' => 'with_metadata' } }

      delete_object(key)
      put_object(options(key, additional_options))
      result(metadata, key)
    end

    def with_metadata_after_without
      metadata = 'なし→あり'
      key = "#{prefix}/with_metadata_after_without.json"
      additional_options = { metadata: { 'x-amz-metadata-other' => 'with_metadata_after_without' } }

      delete_object(key)
      put_object(options(key, nil))
      result(metadata, key)
      put_object(options(key, additional_options))
      result(metadata, key)
    end

    def settings
      Settings.put_object_with_metadata
    end

    def body
      settings.upload_file
    end

    def options(destination_key, additional_options)
      options = {
        bucket:,
        key: destination_key,
        body:,
      }
      options = options.merge(additional_options) unless additional_options.nil?
      options
    end

    def prefix
      'put_object_with_metadata'
    end

    def result(metadata, key)
      response = get_object(key)
      @output.append(
        [
          metadata,
          key,
          response.metadata,
        ],
      )
    end
  end
end

S3::PutObjectWithMetadata.new.execute if __FILE__ == $PROGRAM_NAME
