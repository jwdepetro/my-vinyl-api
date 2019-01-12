FROM ruby:2.6-alpine

RUN apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    apk add curl wget bash && \
    apk add build-base nodejs postgresql-dev

RUN mkdir /app

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem update --system
RUN gem install bundler
RUN bundle update --bundler

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["/bin/bash", "entrypoint.sh"]