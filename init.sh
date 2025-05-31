#!/bin/bash

# SSH start
/usr/sbin/sshd

# Flask start (with gunicorn)
exec gunicorn --bind 0.0.0.0:8000 hello.hello:app