FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client
RUN mkdir /pgsync
WORKDIR /pgsync
COPY Gemfile /pgsync/Gemfile
COPY Gemfile.lock /pgsync/Gemfile.lock
COPY pgsync.yml /pgsync/.pgsync.yml
RUN bundle install
COPY update_db.sh /pgsync/update_db.sh
RUN chmod +x /pgsync/update_db.sh
