FROM ruby:2.4.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /test_cr_api
WORKDIR /test_cr_api
COPY Gemfile /test_cr_api/Gemfile
COPY Gemfile.lock /test_cr_api/Gemfile.lock
RUN bundle install
COPY . /test_cr_api

EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
