# Terraform templates
**Deployment templates to enable easy deployment to aws environments**

## Setting up the lambda and associated assets in a new AWS account

**Add the new account to config.tf**
- Add the new supported account to the comment above the aws-env variable
- Add the new region to the default region mapping.

**Create a new AWS user to deploy this infrastructure from TeamCity with**
- The new user should have the following policy document
```json
{

}
```

**Change the TC build configuration to know about the environment**


**Setup the event source through the console**