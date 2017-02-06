FROM ruby:2.3

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        build-essential libpq-dev nodejs postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /myapp
WORKDIR /myapp

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
