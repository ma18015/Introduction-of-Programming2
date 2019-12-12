#!/bin/sh
GROUP_NUMBER=${gnum}
STUDENT_ID=${id}
PASSWORD=${pass}

rm -rf src
wget --http-user=$STUDENT_ID --http-passwd=$PASSWORD --no-check-certificate https://www.cs.ise.shibaura-it.ac.jp/pn2/19/TA/download_kakunin_all.cgi\?han\=$GROUP_NUMBER
unzip download_kakunin_all.cgi\?han=$GROUP_NUMBER -d src
rm download_kakunin_all.cgi\?han=$GROUP_NUMBER

