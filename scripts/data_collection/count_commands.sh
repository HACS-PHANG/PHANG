#!/bin/bash 
name=$1
bannertype=$2
filepathtosearch = "/home/student/$bannertype/$name/$name.log"
filepathtooutput = "/home/student/$bannertype/$name/count_commands"
echo "Pure Information Gathering:" >> /home/student/container_reports/$name
echo "number of ls commands: $("grep -c ls $filepathtosearch") >> $filepathtooutput
echo "number of cd commands: $("grep -c cd $filepathtosearch") >> $filepathtooutput
echo "Surface Level Modification:" >> $filepathtooutput
echo "number of vim commands: $("grep -c vim $filepathtosearch") >> $filepathtooutput
echo "number of touch commands: $("grep -c touch $filepathtosearch") >> $filepathtooutput
echo "number of curl commands: $("grep -c curl $filepathtosearch") >> $filepathtooutput
echo "number of wget commands: $("grep -c wget $filepathtosearch") >> $filepathtooutput
echo "Critical Level Modification:" >> $filepathtooutput
echo "number of chmod commands: $("grep -c chmod $filepathtosearch") >> $filepathtooutput
