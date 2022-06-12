#!/bin/bash
FILE='/foundry-data/Data/worlds/test/data/tables.db'

cat $FILE | jq '.name,._id' | grep $1 -A1
