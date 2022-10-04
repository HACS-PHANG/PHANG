#!/bin/bash -e
name=$1

# Move into the honeypot_files directory
cd honeypot_files

# Copy all files in secret folder (all files that are downloaded by attacker
# and stored in this folder by command poisoning script) into git repo
# to be analyzed by virustotal
cp /var/lib/lxc/$name/rootfs/var/log/.downloads ./$name/containerdownloads/
cp /home/student/MITM/$name.log ./$name/mitmlogs/
cp /var/lib/lxc/$name/var/log/auth.log ./$name/authlogs/


# Add, commit, and push all changes to github
git add ./$name
git commit -m “Uploading downloaded files for $name”
git push