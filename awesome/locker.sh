#!/bin/sh

exec xautolock \
  -detectsleep \
  -time 5 \
  -locker "i3lock -c 000000 --show-failed-attempts --nofork & sleep 5 && xset dpms force off"
