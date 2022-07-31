# lambda-inception
## HOW TO USE THIS CODE
First of all you have to clone this repository and create e new Lambda function url on aws web console. Make sure to select "Node.js 18.x" from the "Runtime" dropdown menu.  
Then install aws-cli tool (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and configure your account with this command:  
```shell
aws configure
```
**NOTE:** you need to use a user with `AWSLambda_FullAccess` permission policy.

Then:
- Open package.json and change the `'name'` field with your Lambda function's name.  
- Open deploy.sh and make sure the `AWS_REGION` variable is correct for your setup.  
- Open env.js and change the aws region and the arn for your lambdaInceptionWorkerRole.     
- Go in `worker` folder and launch `npm install` to install worker's dependencies (essentially just got.js) 

All done!  
If everything is correctly setup, you can run `./deploy.sh` to upload the code to yout Lambda Function.
Access your AWS console to take note of your Lambda url.

### A note on security
You can leave your Lambda function URL open to the world (using `Auth type: none` while creating your Function URL, or later in the "Function URL" tab of your Lambda).  
A better option is to create a user with the `lambda:InvokeFunctionUrl` permission policy. For instance you can use this user's credentials to call your function URL with cURL options:
```shell
--user XXXXXXXXXXXXXXXXXXXX:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \
--aws-sigv4 "aws:amz:YOUR_AWS_REGION:lambda"
```