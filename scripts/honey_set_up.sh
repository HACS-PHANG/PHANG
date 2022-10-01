#Set up honey
sudo lxc-attach -n $1 -- bash -c "echo 'example text' > employee_records.csv"
# can we do cp of file from vm to container? if we do curl we need it up somewhere
