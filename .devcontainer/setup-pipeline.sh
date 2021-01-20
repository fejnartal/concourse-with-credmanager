#!/bin/bash

echo "Waiting for Concourse to launch on 8080..."

while ! nc -z concourse 8080; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done

echo "Concourse is ready!"

# This script automatically sets up the self-updating demo pipeline so you can begin experimenting
fly --target=concourse login --concourse-url=http://concourse:8080 --username=test --password=test
fly --target=concourse sync
fly --target=concourse set-pipeline --pipeline=hello --config=/workspace/pipeline.yml --non-interactive
fly --target=concourse unpause-pipeline --pipeline=hello

echo 'jojo!'
{ # try
    aws secretsmanager update-secret --secret-id /concourse/main/hello/secret --secret-string "$SECRET_MESSAGE"
} || { # catch
    aws secretsmanager create-secret --secret-id /concourse/main/hello/secret --secret-string "$SECRET_MESSAGE"
}

exec "$@"
