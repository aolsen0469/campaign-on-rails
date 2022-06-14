#!/bin/bash
FILE='/foundry-data/Data/worlds/test/data/chat.db'
TEST='blah'
DATA=$(cat -v $FILE  | jq '.content' | grep -v null | tr -d '"' |sed 's/\"//g' | sed 's/\\n/<br> /g' | sed 's/\n/<br> /g' | tr -d '\n' | sed 's/^/"/' | sed 's/$/"/' | sed -e 's/<[^>]*>//g' | tr -s ' ' | tr -d "\t" | tr -d "\r" | sed 's/M-BM-//g' | sed 's/;/  \\n/g')

curl -k --data "{\"title\":\"$TEST\",\"text\":$DATA}" -H "Content-Type: application/json" -X POST https://homebrewery.naturalcrit.com/api/ | jq '.' >> .$$

URL=`cat .$$ | jq '.editId' | tr -d '"'`
echo "" > $FILE

echo "https://homebrewery.naturalcrit.com/edit/$URL"
rm .$$
