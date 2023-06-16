# frozen_string_literal: true

module Aws
  class Credential
    def self.credentials
      @credentials ||= Aws::Credentials.new(
        Settings.common.credentials.access_key_id,
        Settings.common.credentials.secret_access_key
      )
    end
  end
end
