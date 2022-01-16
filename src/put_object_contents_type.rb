require 'config'
require './src/aws/s3_client'

class PutObjectContetnsType
  def initialize(config)
    file_path = File.expand_path(config, Dir.pwd)
    unless File.exist?(file_path) || File.file?(file_path)
      raise StandardError("File is not found. : #{file_path}")
    end
    Config.load_and_set_settings(file_path)
  end

  def execute
    upload_without_mime
    upload_with_mime_after_without_mime
    upload_with_mime
    upload_without_mime_after_with_mime
  end

  # mimeを指定しないでアップロード場合
  def upload_without_mime
    puts "mimeを指定せずにアップロードした場合"
    file_name = "without_mime.json"
    key = "#{prefix}/#{file_name}"
    s3_client.delete(key)
    upload(key, src_file, nil)
    output(key, s3_client.download(key))
  end

  # mime未指定後、指定してアップロード場合
  def upload_with_mime_after_without_mime
    puts "mime未指定後、指定してアップロード場合"
    file_name = "with_mime_after_without_mime.json"
    key = "#{prefix}/#{file_name}"
    s3_client.delete(key)
    upload(key, src_file, nil)
    output(key, s3_client.download(key))
    upload(key, src_file, mime)
    output(key, s3_client.download(key))
  end

  # mimeを指定してアップロード場合
  def upload_with_mime
    puts "mimeを指定してアップロード場合"
    file_name = "with_mime.json"
    key = "#{prefix}/#{file_name}"
    s3_client.delete(key)
    upload(key, src_file, mime)
    output(key, s3_client.download(key))
  end

  # mime指定後、指定せずにアップロード場合
  def upload_without_mime_after_with_mime
    puts "mime指定後、指定せずにアップロード場合"
    file_name = "without_mime_after_with_mime.json"
    key = "#{prefix}/#{file_name}"
    s3_client.delete(key)
    upload(key, src_file, mime)
    output(key, s3_client.download(key))
    upload(key, src_file, nil)
    output(key, s3_client.download(key))
  end

  def s3_client
    @s3_cleint = Aws::S3Client.new(
      bucket,
      Settings.put_object_contents_type.s3.region,
    )
  end

  def upload(key, body, content_type=nil)
    options = {
      bucket: Settings.put_object_contents_type.s3.bucket,
      key: key,
      body: body,
    }
    options = options.merge({content_type: content_type}) unless content_type.nil?

    s3_client.upload_put_object(options)
  end

  def bucket
    Settings.put_object_contents_type.s3.bucket
  end

  def src_file
    Settings.put_object_contents_type.s3.object.file
  end

  def mime
    mime = Settings.put_object_contents_type.s3.object.mime
  end

  def prefix
    Settings.put_object_contents_type.s3.object.prefix
  end

  def output(key, result)
    puts "  key: #{key}"
    puts "    content_type: #{result.content_type}"
  end
end

PutObjectContetnsType.new('config/put_objects_contents_type/development.yml').execute
