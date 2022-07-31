#!/bin/bash

AWS_REGION=eu-south-1
FUNCTION_NAME=$(< package.json grep \"name\": | awk '{print $2}' | tr -d '",')

# Create zip archive for Workers
rm -f worker.zip
cd worker && zip -r ../worker.zip package.json package-lock.json worker.js node_modules && cd ..

# Create zip archive for Manager
rm -f deploy.zip
zip -r deploy.zip ./* -x deploy.sh -x deploy.zip -x worker/\*

# Deploy
aws lambda --region $AWS_REGION update-function-code --function-name $FUNCTION_NAME --zip-file fileb://deploy.zip