#!/bin/bash
while :
do
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "nginx.localhost:9080")

if [ $STATUS -eq 200 ]; then
  echo "OKOK"
else
  echo "Failed"
fi
done
