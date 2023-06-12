FROM ruby:3.1.2

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      vim && \
    apt-get clean -y

RUN gem install bundler solargraph ruby-debug-ide

WORKDIR /app_root

COPY . .
RUN bundle install
