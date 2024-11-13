#!/bin/bash

cat /etc/hosts | while read -r line
do
   ip=$(echo $line | awk '{print $1}')
   domain=$(echo $line | awk '{print $2}')
   nslookup_ip=$(nslookup "$domain" 2>/dev/null | grep 'Address' | tail -n 1 | awk '{print $2}')
   if [[ "$ip" == *.*  && "$domain" != "localhost" ]]
     then
       if [[ "$ip" != "$nslookup_ip" ]]
           then
              echo "Bogus IP for $domain in /etc/hosts !"
       fi
   fi
done

