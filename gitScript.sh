#!/bin/bash

echo "more stuff"

echo -e "This covers file creation and then updating and maintaining that file" \n

git clone https://github.com/slipknotts/NTI300 \n

cd NTI300 \n

echo -e "create file 'newFile.sh'" \n

git add newFile.sh \n

git commit -m \"added example file\" \n

git push \n

echo -e "employ website functionality" \n

git fetch \n

git pull \n

echo -e "create newFile2.sh" \n

git add newFile2.sh \n

git commit -m \"added new file 'newFile2.sh'\" \n

git push \n 
