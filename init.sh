#!/bin/bash
service ssh start
exec gunicorn --timeout 120 --bind 0.0.0.0:8000 hello.hello:app