#!/bin/sh
set -e
service ssh start
FLASK_APP=/app/server.py flask run --host=0.0.0.0 --port=80
#exec gunicorn -w 4 -b 0.0.0.0:8000 app:app
