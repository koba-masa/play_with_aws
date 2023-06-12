# frozen_string_literal: true

require './src/scripts/s3/base'

module S3
  class PutObjectWithContentType < Base
    HEADER = ['file_type', 'content_type', 'Key', 'ContentType'].freeze

    def initialize
      super
      @output.append(HEADER)
    end

    def execute
      put_object_json_without_content_type
      put_object_json_with_content_type
      put_object_json_with_content_type_html
      put_object_html_without_content_type
      put_object_html_with_content_type
      put_object_html_with_content_type_json
      put_object_text_without_content_type
      put_object_text_with_content_type
      put_object_text_with_content_type_json
      output
    end

    def put_object_json_without_content_type
      file_type = 'json'
      content_type = 'なし'
      key = "#{prefix}/put_object_json_without_content_type.json"
      body = settings.upload_files.json
      options = options(key, body, nil)

      delete_object(key)
      put_object(options)
      result(file_type, content_type, key)
    end

    def put_object_json_with_content_type
      file_type = 'json'
      content_type = 'text/json'
      key = "#{prefix}/put_object_json_with_content_type.json"
      body = settings.upload_files.json
      options = options(key, body, {content_type: content_type})

      delete_object(key)
      put_object(options)
      result(file_type, content_type, key)
    end

    def put_object_json_with_content_type_html
      file_type = 'json'
      content_type = 'text/html'
      key = "#{prefix}/put_object_json_with_content_type_html.json"
      body = settings.upload_files.json
      options = options(key, body, {content_type: content_type})

      delete_object(key)
      put_object(options)
      result(file_type, content_type, key)
    end

    def put_object_html_without_content_type
      file_type = 'html'
      content_type = 'なし'
      key = "#{prefix}/put_object_html_without_content_type.html"
      body = settings.upload_files.html
      options = options(key, body, nil)

      delete_object(key)
      put_object(options)
      result(file_type, content_type, key)
    end

    def put_object_html_with_content_type
      file_type = 'html'
      content_type = 'text/html'
      key = "#{prefix}/put_object_html_with_content_type.html"
      body = settings.upload_files.html
      options = options(key, body, {content_type: content_type})

      delete_object(key)
      put_object(options)
      result(file_type, content_type, key)
    end

    def put_object_html_with_content_type_json
      file_type = 'html'
      content_type = 'text/json'
      key = "#{prefix}/put_object_html_with_content_type_json.json"
      body = settings.upload_files.json
      options = options(key, body, {content_type: content_type})

      delete_object(key)
      put_object(options)
      result(file_type, content_type, key)
    end

    def put_object_text_without_content_type
      file_type = 'text'
      content_type = 'なし'
      key = "#{prefix}/put_object_text_without_content_type.txt"
      body = settings.upload_files.text
      options = options(key, body, nil)

      delete_object(key)
      put_object(options)
      result(file_type, content_type, key)
    end

    def put_object_text_with_content_type
      file_type = 'text'
      content_type = 'text/plain'
      key = "#{prefix}/put_object_text_with_content_type.txt"
      body = settings.upload_files.text
      options = options(key, body, {content_type: content_type})

      delete_object(key)
      put_object(options)
      result(file_type, content_type, key)
    end

    def put_object_text_with_content_type_json
      file_type = 'text'
      content_type = 'text/json'
      key = "#{prefix}/put_object_text_with_content_type_json.json"
      body = settings.upload_files.text
      options = options(key, body, {content_type: content_type})

      delete_object(key)
      put_object(options)
      result(file_type, content_type, key)
    end

    def settings
      Settings.put_object_with_content_type
    end

    def options(destination_key, body, additional_options)
      options = {
        bucket: bucket,
        key: destination_key,
        body: body
      }
      options = options.merge(additional_options) unless additional_options.nil?
      options
    end

    def prefix
      'put_object_with_content_type'
    end

    def result(file_type, content_type, key)
      response = get_object(key)
      @output.append(
        [
          file_type,
          content_type,
          key,
          response.content_type,
        ]
      )
    end
  end
end

S3::PutObjectWithContentType.new.execute if __FILE__ == $PROGRAM_NAME
