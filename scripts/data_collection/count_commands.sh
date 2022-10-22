#!/bin/bash 
name=$1
bannertype=$2
filepathtosearch="/home/student/$bannertype/$name/$name.log"
filepathtooutput="/home/student/$bannertype/$name/count_commands"
echo "Pure Information Gathering:" >> $filepathtooutput
sleep 5
lsgrep=$(grep -w -o ls "${filepathtosearch}" | wc -l)
cdgrep=$(grep -w -o cd "${filepathtosearch}" | wc -l)

vimgrep=$(grep -w -o vim "${filepathtosearch}" | wc -l)
touchgrep=$(grep -w -o touch "${filepathtosearch}" | wc -l)
curlgrep=$(grep -w -o curl "${filepathtosearch}" | wc -l)
wgetgrep=$(grep -w -o wget "${filepathtosearch}" | wc -l)

chmodgrep=$(grep -w -o chmod "${filepathtosearch}" | wc -l)

echo "number of ls commands: ${lsgrep}" >> "$filepathtooutput"
echo "number of cd commands: ${cdgrep}" >> "$filepathtooutput"
echo "Surface Level Modification:" >> "$filepathtooutput"
echo "number of vim commands: ${vimgrep}" >> "$filepathtooutput"
echo "number of touch commands: ${touchgrep}" >> "$filepathtooutput"
echo "number of curl commands: ${curlgrep}"  >> "$filepathtooutput"
echo "number of wget commands: ${wgetgrep}" >> "$filepathtooutput"
echo "Critical Level Modification:" >> "$filepathtooutput"
echo "number of chmod commands: ${chmodgrep}" >> "$filepathtooutput"
