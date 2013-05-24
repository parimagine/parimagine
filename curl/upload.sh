#!/bin/sh
# https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/documents/
# --noproxy http://localhost:1212/geppaequo-fileupload/documents/
curl --proxy http://proxy:8080 --verbose -i -F "file=@$1" "https://parimaginep1894179457trial.hanatrial.ondemand.com/parimagine/documents/"`dirname $1`
