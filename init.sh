#!/bin/bash
/usr/sbin/sshd
exec gunicorn --bind 0.0.0.0:8000 hello.hello:app