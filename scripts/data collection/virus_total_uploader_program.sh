#!/bin/bash 
# Install boto3 and python3 if not installed already
#sudo apt-get install python3
#python -m pip install boto3

cd /home/student 

#clone virus total uploader repository
git clone https://github.com/gitgiant/VT_Uploader.git 
cd VT_Uploader

#insert the VirusTotal API Key
echo "key = \"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\"" > tokens.py

#insert the region.
sed -i "s|raise NoRegionError()|region_name = 'us-east-2'|g" /home/student/.local/lib/python3.8/site-packages/botocore/regions.py

# sub out the is with == so it doesn't throw an error.
sed -i "s|if (platform.system()) is 'Windows':|if (platform.system()) == 'Windows':|g" /home/student/VT_Uploader/main.py


