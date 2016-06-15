# Terraform templates
Deployment templates to enable easy deployment to aws environments

## Setting up the lambda and associated assets in a new AWS account

**Add the new account to config.tf**
- Add the new supported account to the comment above the aws-env variable
- Add the new region to the default region mapping.

**Create a new AWS user to deploy this infrastructure from TeamCity with**
- The new user should have the following policy document. Ensure you swap out the Account ID correctly
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1457302495999",
            "Effect": "Allow",
            "Action": [
                "lambda:CreateFunction"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "Stmt1457302496000",
            "Effect": "Allow",
            "Action": [
                "lambda:UpdateFunctionCode",
                "lambda:PublishVersion",
                "lambda:GetFunction"
            ],
            "Resource": [
                "arn:aws:lambda:<Region>:<AccountId>:function:dynamodb-lambda-autoscale"
            ]
        },
        {
           "Sid": "Stmt1465954135559",
           "Action": [
               "s3:CreateBucket",
               "s3:GetObject",
               "s3:PutObject"
           ],
           "Effect": "Allow",
           "Resource": "*"
        },
        {
            "Sid": "Stmt1457302496002",
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole",
                "iam:GetRole",
                "iam:PassRole",
                "iam:PutRolePolicy",
                "iam:GetRolePolicy"
            ],
            "Resource": [
                "arn:aws:iam::<AccountId>:role/dynamodb-lambda-autoscale"
            ]
        },
        {
            "Sid": "Stmt1457302496003",
            "Effect": "Allow",
            "Action": [
                "dynamodb:CreateTable",
                "dynamodb:DescribeTable"
            ],
            "Resource": [
                "arn:aws:dynamodb:<Region>:<AccountId>:table/dynamodb-lambda-autoscale"
            ]
        }
    ]
}
```

**Change the TC build configuration to know about the environment**
- Go to the [build configuration](https://teamcity.dev.xero.com/admin/editBuildParams.html?id=buildType:DynamodbLambdaAutoscale_CreateInfrastructure) and update the awsAccessKey, awsAccount and awsSecretKey to have values for the new account. 
- Run the build and select plan as the terraformAction and the appropriate keys & account.
- Review the build log, it should say that it will create 3 new resources. If it looks good, then run the plan again. This time select apply as the terraformAction. 

**Add the table names that you would like to scale to the new table**
- Find the DynamoDB table called `dynamodb-lambda-autoscale` in the AWS console.
- Go to the `Items tab` and click the `Create item` button. Add the name of your table to the value of the `TableName` attribute and click save.
- Repeat for all of the tables you would like to scale.

**Setup the event source through the console**
- Find the Lambda called `dynamodb-lambda-autoscale` in the AWS console, select the `Event Sources` tab and click the `Add event source` link.
- use the following settings for your source:
  - Event source type: `CouldWatch Events - Schedule`.
  - Rule name: `1-minute`.
  - Rule description: `triggers every 1 minute`.
  - Schedule expression: `rate(1 minute)`.
  - Optionally enable the `Enable event source` checkbox. **If this is enabled then the lambda is going to start scaling your tables**. 

fin.