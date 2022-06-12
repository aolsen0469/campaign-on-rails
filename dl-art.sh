#!/bin/bash
DIRECTORY='/foundry-data/Data/dm-assets/art/tokens'
KEYWORDS="$1"
for i in {1..3};
  do python3.9 CCwKCHv6.py -k $KEYWORDS -d $DIRECTORY -n $KEYWORDS-$i.jpg;
done
