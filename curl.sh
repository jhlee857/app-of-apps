#!/bin/bash
#while :
SET=$(seq 0 999)
success_cnt=0
failed_cnt=0
for i in $SET
do
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "nginx.localhost:9080")

if [ $STATUS -eq 200 ]; then
  echo $STATUS
  success_cnt=$((success_cnt+1))
else
  echo "!!!!! Failed !!!!!!" - $STATUS
  failed_cnt=$((failed_cnt+1))
fi
done

echo success : $success_cnt
echo failed : $failed_cnt
