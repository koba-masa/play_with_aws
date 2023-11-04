require 'json'

module Lambda
  class LambdaViaApiGateway
    def initialize(event, context)
      @event = event
      @context = context
    end

    def self.call(event:, context:)
      instance = LambdaViaApiGateway.new(event, context)
      instance.execute
    end

    def execute
      { response: { statusCode: 200, body: { message: 'Hello, world!' } } }
    end
  end
end
