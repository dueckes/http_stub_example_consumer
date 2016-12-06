FROM ruby:2.3.1-alpine

# Update Bundler
RUN gem install bundler

# Cache dependencies
COPY ["Gemfile", "Gemfile.lock", "/tmp/cache/"]
WORKDIR /tmp/cache
RUN bundle install && rm -rf /tmp/cache

# Copy code
COPY . /root/app/
WORKDIR /root/app

# Registers bundle in working directory
RUN bundle install --without development

# Expose server port
EXPOSE 3000

# Start the consumer & tail logs in order to sustain a foreground process
CMD trap exit TERM; bundle exec rake consumer:start && tail -f tmp/logs/server_console.log
