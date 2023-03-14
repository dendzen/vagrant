#!/bin/bash
# Variables
GRAFANA_USER=admin
GRAFANA_PASSWORD=admin
GRAFANA_URL=http://localhost:3000
DASHBOARD_JSON_FILE=/home/vagrant/configs/node-exporter-full.json
# Get auth token
CURRENTTIME=$(date +%S)
echo $CURRENTTIME
#AUTH_TOKEN=`curl -s -H 'Content-Type: application/json' --data-binary '{"user":"'"$GRAFANA_USER"'","email":"","password":"'"$GRAFANA_PASSWORD"'"}' "$GRAFANA_URL/api/auth/login" | jq -r '.user.authToken'`
DATE=`date`
AUTH_TOKEN=`curl --location 'http://localhost:3000/api/auth/keys' --header 'Content-Type: application/json; charset=utf-8' --header 'Authorization: Basic YWRtaW46YWRtaW4=' --data '{"name": "Key'$CURRENTTIME'","role": "Admin","secondsToLive": 60}' | jq -r '.key'`
echo token
echo $AUTH_TOKEN
# Import dashboard
#curl -s -H "Authorization: Bearer $AUTH_TOKEN" -H 'Content-Type: application/json' --data-binary "@$DASHBOARD_JSON_FILE" "$GRAFANA_URL/api/dashboards/db"
curl --location 'http://localhost:3000/api/datasources' \
--header 'Content-Type: application/json; charset=utf-8' \
--header 'Authorization: Basic YWRtaW46YWRtaW4=' \
--data '{
  "name":"prometheus",
  "type":"prometheus",
  "url":"http://localhost:3000",
  "access":"proxy",
  "basicAuth":false

