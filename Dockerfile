# Use the Ruby 3.1.2 image from Docker Hub
# as the base image (https://hub.docker.com/_/ruby)
FROM ruby:3.1.2
RUN mkdir /app
WORKDIR /app 
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
# so we map to elasticsearch:9200
ADD elasticsearch.rb /app/config/initializers/elasticsearch.rb
ADD . /app

# Add a script to be executed every time the container starts.
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
COPY wait-for-it.sh /usr/bin/
RUN chmod +x /usr/bin/wait-for-it.sh
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]