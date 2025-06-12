#!/bin/bash
gunicorn --timeout 120 --bind 0.0.0.0:$PORT hello.hello:app & exec /usr/sbin/sshd -D -f /etc/ssh/sshd_config