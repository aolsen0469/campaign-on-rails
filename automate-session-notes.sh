#!/bin/bash
# set -x
CHATDB='/foundry-data/Data/worlds/test/data/chat.db'
#IMGURL='https://i.pinimg.com/originals/1e/47/d3/1e47d3bcf017db9900cc70437f50d375.jpg'

NAME=$(cat $CHATDB | jq '.content' | grep -v null | tr -d '"' |sed 's/\"//g' | sed 's/\\n/<br> /g' | sed 's/\n/<br> /g' | tr -d '\n' | sed 's/^/"/' | sed 's/$/"/' | sed -e 's/<[^>]*>//g' | tr -s ' ' | tr -d "\t" | tr -d "\r" | sed 's/M-BM-//g' | sed 's/;/  \\n/g' | cut -d: -f1 | tr -d '"' | tr -d "#" | sed 's/^ //g')

SHORT_NAME=$(echo ${NAME} | cut -d' ' -f2- | sed 's/[[:alnum:]]*$//')

IMGURL=$(python3.9 scrape-url.py -k "${SHORT_NAME} fantasy art landscape" | grep "http" | awk '{ print $NF }' | sort -r | head -n 1)

RAW_DATA=$(cat -v $CHATDB  | jq '.content' | grep -v null | tr -d '"' |sed 's/\"//g' | sed 's/\\n/<br> /g' | sed 's/\n/<br> /g' | tr -d '\n' | sed 's/^/"/' | sed 's/$/"/' | sed -e 's/<[^>]*>//g' | tr -s ' ' | tr -d "\t" | tr -d "\r" | sed 's/M-BM-//g' | sed 's/;/  \\n/g' | sed -e '1s@^"@"<img src=QUOTEIMGURLQUOTE style=QUOTEposition:absolute;width:100%;height:100%;top:0px;left:0pxQUOTE/>\\n@' | sed -e 's/QUOTE/'\''/g' | sed -E "s@IMGURL@${IMGURL}@g" | sed '1s/^"/"<div class='descriptive'>\\n/' | sed '$ s/"$/<\/div>"/')

curl -k \
  --data "{\"title\":\"$NAME\",\"text\":$RAW_DATA}" \
  -H "Content-Type: application/json" \
  -X POST https://homebrewery.naturalcrit.com/api/ | jq '.' >> .$$



URL=`cat .$$ | jq '.editId' | tr -d '"'`
echo "" > $CHATDB
echo "https://homebrewery.naturalcrit.com/edit/$URL"
rm .$$
