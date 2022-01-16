require 'aws-sdk-core'
require 'config'

module Aws
  class Credential
    def self.credentials
      @credentials ||= Aws::Credentials.new(
        Settings.credentials.access_key_id,
        Settings.credentials.secret_access_key
      )
    end
  end
end
