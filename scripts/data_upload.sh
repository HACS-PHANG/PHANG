#!/bin/bash -e
name=$1

# Move into the honeypot_files directory and create dir for this honeypot
cd honeypot_files/
mkdir $name
cd $name/

# Make directory for all downloads
mkdir ./containerdownloads/

# Copy all files in secret folder (all files that are downloaded by attacker
# and stored in this folder by command poisoning script) into git repo
# to be analyzed by virustotal
cp -r /var/lib/lxc/$name/rootfs/var/log/.downloads ./containerdownloads/

# Copy mitm and auth logs into current directory
cp /home/student/MITM/$name.log ./
cp /var/lib/lxc/$name/var/log/auth.log ./


# Add, commit, and push all changes to github
git add .
git commit -m “Uploading downloaded files for $name”
git push