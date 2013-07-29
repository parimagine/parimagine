#!/bin/sh
# find . -regex ".*\.\(jpg\|gif\|png\|jpeg\)" | grep -v 'thumb' | tr "[:upper:]" "[:lower:]" | sed 's/^\.\///' | xargs -n1 upload.sh
find . -regex ".*\.jpg" | grep -v 'thumb' | tr "[:upper:]" "[:lower:]" | sed 's/^\.\///' | xargs -n1 upload.sh


find . -regex ".*-1170x.*\.jpg" | xargs -n1 ./copy.sh
find . -regex ".*x800\.jpg" | xargs -n1 ./copy.sh
find . -regextype sed -regex "\d*.jpg" | xargs -n1 ./copy2.sh


find -E . -regex "\d\d\d\.jpg"

find . -regex "[^x]*.jpg" | xargs -n1 ./copy2.sh
