require 'config'
require './src/aws/ses_client'

class SESTextEmailSender
  def initialize(config)
    file_path = File.expand_path(config, Dir.pwd)
    unless File.exist?(file_path) || File.file?(file_path)
      raise StandardError("File is not found. : #{file_path}")
    end
    Config.load_and_set_settings(file_path)
  end

  def execute
    ses_client = Aws::SESClient.new(ses_settings.region)
    created_message = ses_client.create_text_message(
      charset,
      subject,
      text_message,
    )

    ses_client.send(
      ses_settings.to_addresses,
      ses_settings.from_address,
      created_message,
    )
  end

  def charset
    'UTF-8'
  end

  def subject
    'This email is test.'
  end

  def text_message
    'This email is test. Test is test.'
  end

  def ses_settings
    Settings.ses_text_email_sender.ses
  end

end

SESTextEmailSender.new('config/ses_text_email_sender/development.yml').execute
