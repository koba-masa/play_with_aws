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
      { statusCode: 200, headers: {}, body: { message: 'Hello, world!' }.to_json }
    end
  end
end
