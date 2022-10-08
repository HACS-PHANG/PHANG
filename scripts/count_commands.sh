#!/bin/bash 
echo "Pure Information Gathering:" >> /home/student/container_reports/$name
echo "number of ls commands: $("grep -c ls /home/mitm/session_logs/$name") >> /home/student/container_reports/$name
echo "number of cd commands: $("grep -c cd /home/mitm/session_logs/$name") >> /home/student/container_reports/$name
echo "Surface Level Modification:" >> /home/student/container_reports/$name
echo "number of vim commands: $("grep -c vim /home/mitm/session_logs/$name") >> /home/student/container_reports/$name
echo "number of touch commands: $("grep -c touch /home/mitm/session_logs/$name") >> /home/student/container_reports/$name
echo "number of curl commands: $("grep -c curl /home/mitm/session_logs/$name") >> /home/student/container_reports/$name
echo "number of wget commands: $("grep -c wget /home/mitm/session_logs/$name") >> /home/student/container_reports/$name
echo "Critical Level Modification:" >> /.containerlogoccurrences/$name
echo "number of chmod commands: $("grep -c chmod /home/mitm/session_logs/$name") >> /home/student/container_reports/$name
