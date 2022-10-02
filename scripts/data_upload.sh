#!/bin/bash -e
name=$1

# Checkout branch meant for all data collected (so that we don't clutter main)
git checkout data_collection

# Move into the log_files directory
cd log_files

# Copy all files in secret folder (all files that are downloaded by attacker
#and stored in this folder by command poisoning script) into local folder
#to be analyzed by virustotal
cp /var/lib/lxc/$containername/rootfs/var/log/.downloads ~/containerdownloads/$containername

# Copy all the files from the lxc container into current location in git repo
cp /var/lib/lxc/$name .

# Add, commit, and push all changes to github
git add .
git commit -m “Uploading log files for $name”
git push