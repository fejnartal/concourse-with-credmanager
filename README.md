[![Remote-Containers-Ready](https://img.shields.io/badge/Remote%20Container-Ready-blue?logo=visual-studio-code)](https://code.visualstudio.com/docs/remote/containers)


## Requirements
To follow this quickstart you will need:
- Docker Compose installed on your machine. [Learn how to do it.](https://docs.docker.com/compose/install/)
- An AWS account, IAM user, or equivalent. [Learn how to do it.](https://docs.aws.amazon.com/polly/latest/dg/setting-up.html)

## Quickstart

Clone the repo:
```bash
git clone https://github.com/fejnartal/concourse-with-credmanager.git
```
Navigate to .devcontainer folder insider the repo:
```bash
cd concourse-with-credmanager/.devcontainer
```
Create a file named '.env':
```bash
touch .env
```
Use your preferred editor to paste the following content inside the file:
```
SECRET_MESSAGE=Your secret message here

AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
AWS_DEFAULT_REGION=us-west-2

CONCOURSE_AWS_SECRETSMANAGER_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE
CONCOURSE_AWS_SECRETSMANAGER_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
CONCOURSE_AWS_SECRETSMANAGER_REGION=us-west-2
```
Replace the example AWS credentials with your own ones.<br/>
Notice you need to paste your credentials twice with different variable names.

You can also change the value of SECRET_MESSAGE to be whatever message you want.<br/>
We will be retrieving that value securely from Concourse.

Let's run everything and wait some seconds for Concourse to start.<br/>
```bash
docker-compose up -d --build
```
Navigate to http://localhost:8080/teams/main/pipelines/hello/jobs/hello

Login:
```
username: test
password: test
```
Manually run the job to see your secret appear! 

<img src="https://user-images.githubusercontent.com/51800873/105198646-28783a80-5b3e-11eb-91cb-fd9351c2b601.png" width="40%">

## Modify secret message
Open .env file in your preferred editor and modify the value of the SECRET_MESSAGE variable

Tell docker compose to update the services.
```bash
docker-compose up -d --build
```
Open and manually run the job again. The task now prints the new message: http://localhost:8080/teams/main/pipelines/hello/jobs/hello

## To stop Concourse and cleanup

```bash
docker-compose down --rmi all -v --remove-orphans
```
