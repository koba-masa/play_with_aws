FROM ruby:3.2

ENV LAMBDA_TASK_ROOT=/var/task

RUN mkdir -p ${LAMBDA_TASK_ROOT}

WORKDIR ${LAMBDA_TASK_ROOT}

COPY lambda_via_api_gateway.rb ${LAMBDA_TASK_ROOT}/

ENTRYPOINT [ "aws_lambda_ric" ]

CMD [ "lambda_via_api_gateway.Lambda::LambdaViaApiGateway.call" ]
