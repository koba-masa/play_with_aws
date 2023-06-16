# frozen_string_literal: true

require 'bundler/setup'

class Base
  CONFIG = 'config/development.yml'

  def initialize
    Bundler.require(:default, :development)

    file_path = File.expand_path(CONFIG, Dir.pwd)
    raise StandardError, "File is not found. : #{file_path}" unless File.exist?(file_path) || File.file?(file_path)

    Dotenv.load
    Config.load_and_set_settings(file_path)
  end
end
