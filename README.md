## Requirements
You will need a AWS account, IAM user, or equivalent to follow this quickstart...

**Don't have an account?** [Learn how to create one](https://docs.aws.amazon.com/polly/latest/dg/setting-up.html)

Create a file named '.env' inside the '.devcontainer'.

The file should have the following content.

Replace the values in the example with your own credentials.

Notice you need to paste your credentials twice with different variable names.

```
SECRET_MESSAGE=Your secret message here

AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
AWS_DEFAULT_REGION=us-west-2

CONCOURSE_AWS_SECRETSMANAGER_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE
CONCOURSE_AWS_SECRETSMANAGER_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
CONCOURSE_AWS_SECRETSMANAGER_REGION=us-west-2
```


## Running example

```bash
git clone https://github.com/fejnartal/concourse-with-credmanager.git
cd concourse-with-credmanager/.devcontainer
docker-compose up -d --build
```

Wait some seconds for Concourse to start.
Navigate to http://localhost:8080/teams/main/pipelines/hello/jobs/hello

You are ready to run your secret command!

