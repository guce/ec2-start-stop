# EC2 Start Stop

Implement EC2 scheduled start and stop with **Lambda golang** & **CloudWatch**.



# Step

## IAM

### New Policy

```shell
IAM -> Policies -> Create policy

Visual editor
Service -> EC2
Actions -> Access level -> Write -> StartInstances,StopInstances
Resources -> All resources

PolicyName -> StartStopEC2Instances
```



### New Role

```shell
IAM -> Roles -> Create role

AWS service -> Lambda
Policy -> StartStopEC2Instances

Role name -> StartStopEC2Instances
```



## Lambda Function

```shell
AWS Lambda -> Functions -> Create function

Name -> StartEC2Instances
Runtime -> Go 1.x
Role -> Existing role -> StartStopEC2Instances

clone the repo
./build.sh

Function code
Function package -> start-ec2-instances.zip
Handler -> start-ec2-instances

Test -> Create new test event
{
  "InstanceRegion": "cn-northwest-1",
  "InstanceIdList":[
    "i-xxxxxxxxxxxxxxxxx",
    "i-xxxxxxxxxxxxxxxxx"
  ]
}
```



## CloudWatch

```shell
Rules -> Create role -> Schedule

Cron expression -> xxxxx
#e.g.
08 00 ? * MON-FRI *		#8 am every working day, start ec2 instances
22 00 * * ? *			#10 pm every day, stop ec2 instances

Targets -> Lambda function -> StartEC2Instances
Constant(JSON text)
{
  "InstanceRegion": "cn-northwest-1",
  "InstanceIdList":[
    "i-xxxxxxxxxxxxxxxxx",
    "i-xxxxxxxxxxxxxxxxx"
  ]
}
```



# Reference

AWS lambda go  https://github.com/aws/aws-lambda-go

AWS sdk go https://github.com/aws/aws-sdk-go

CloudWatch https://docs.amazonaws.cn/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions