#!/bin/bash
set -e

cd /srv/gamemooch

rm /srv/gamemooch/tmp/pids/server.pid
rails db:migrate
rails server -b 0.0.0.0
