#!/bin/bash

read -p "Enter username to check SSH access attempts: " username

accept=$(grep -E "Accepted" /var/log/secure | awk '{ if ($0 ~ "'"$username"'") { print $1, $2, $3, $9, $11 }}' | wc -l)

fail=$(grep -E "Failed password" /var/log/secure | awk '{ if ($0 ~ "'"$username"'") { print $1, $2, $3, $9, $11 }}' | wc -l)

echo "Number of accepted attempt for user "$username" is "$accept""
echo "Number of failed attempt for user "$username" is "$fail""

if [ "$fail" -gt 5 ]
then
   echo "Warning user "$username" do more 5 attempt and i will lock his username now"
   sudo usermod -L "$username"
fi
