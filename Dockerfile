FROM ruby:2.7.3-alpine

WORKDIR /app
COPY Gemfile* index.rb /app/

RUN bundle install
EXPOSE 4567
ENTRYPOINT ["./index.rb"]
