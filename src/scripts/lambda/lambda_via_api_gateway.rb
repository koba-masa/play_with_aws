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
      puts event
      puts context
      { statusCode: 200, headers: {}, body: { message: 'Hello, world!' }.to_json }
    end

  private
    def event
      @event
    end

    def context
      @context
    end
  end
end
