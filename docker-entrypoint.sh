#!/bin/bash


# Wait for services
/usr/bin/wait-for-it.sh mysql:3306 -t 0
/usr/bin/wait-for-it.sh redis:6379 -t 0
/usr/bin/wait-for-it.sh elasticsearch:9200 -t 0
/usr/bin/wait-for-it.sh rabbitmq:5672 -t 0


cd app

# Run migrations
rails db:create db:migrate db:seed

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"