#!/bin/sh
find . -regex ".*\.\(jpg\|gif\|png\|jpeg\)" | grep -v 'thumb' | tr "[:upper:]" "[:lower:]" | sed 's/^\.\///' | xargs -n1 upload.sh
