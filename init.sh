#!/bin/bash

# SSH start
/usr/sbin/sshd

# Flask start (with gunicorn)
exec gunicorn --bind 0.0.0.0:$PORT hello.hello:app
