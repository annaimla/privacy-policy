#!/bin/bash

# Deploys the packaged tar ball (see compile_md.sh and .circleci/config.yml) somewhere.
# Usage: ./deploy_tar.sh -f TARFILE -h HOST -d DIRECTORY

while getopts f:h:d option
do
 case "${option}"
 in
 f) FILE=${OPTARG};;
 h) HOST=${OPTARG};;
 d) DIR=${OPTARG};;
 esac
done

echo "Uploading..."
scp $FILE $HOST:$DIR

echo "Cleaning old files..."
ssh $HOST "cd $DIR && rm -r *.html"
echo "Unpacking $FILE..."
ssh $HOST "cd $DIR && tar -xf $(basename $FILE)"

echo "Deploy completed!"