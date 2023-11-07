FROM ruby:3.2

COPY lambda_via_api_gateway.rb ${LAMBDA_TASK_ROOT}/

CMD [ "lambda_via_api_gateway.Lambda::LambdaViaApiGateway.call" ]
