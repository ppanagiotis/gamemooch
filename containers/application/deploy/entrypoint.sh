#!/bin/bash
set -e

cd /srv/gamemooch

rm -f /srv/gamemooch/tmp/pids/server.pid
bundle install
rails db:migrate
rails server -b 0.0.0.0
