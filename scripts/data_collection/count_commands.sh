#!/bin/bash 
name=$1
bannertype=$2
filepathtosearch="/home/student/$bannertype/$name/$name.log"
filepathtooutput="/home/student/$bannertype/$name/count_commands"
echo "Pure Information Gathering:" >> $filepathtooutput
sleep 5
lsgrep=$(grep -c ls "${filepathtosearch}")
cdgrep=$(grep -c cd "${filepathtosearch}")

vimgrep=$(grep -c vim "${filepathtosearch}")
touchgrep=$(grep -c touch "${filepathtosearch}")
curlgrep=$(grep -c curl "${filepathtosearch}")
wgetgrep=$(grep -c wget "${filepathtosearch}")

chmodgrep=$(grep -c chmod "${filepathtosearch}")

echo "number of ls commands: ${lsgrep}" >> "$filepathtooutput"
echo "number of cd commands: ${cdgrep}" >> "$filepathtooutput"
echo "Surface Level Modification:" >> "$filepathtooutput"
echo "number of vim commands: ${vimgrep}" >> "$filepathtooutput"
echo "number of touch commands: ${touchgrep}" >> "$filepathtooutput"
echo "number of curl commands: ${curlgrep}"  >> "$filepathtooutput"
echo "number of wget commands: ${wgetgrep}" >> "$filepathtooutput"
echo "Critical Level Modification:" >> "$filepathtooutput"
echo "number of chmod commands: ${chmodgrep}" >> "$filepathtooutput"
