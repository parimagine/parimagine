#!/bin/sh
# https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/documents/


while read p; do
  curl --proxy http://proxy:8080 -X DELETE https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/documents/$p
done < photoURLs.txt

# 