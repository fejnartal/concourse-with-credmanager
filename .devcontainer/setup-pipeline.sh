#!/bin/bash

echo "Waiting for Concourse to launch on 8080..."

while ! nc -z concourse 8080; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done

echo "Concourse is ready!"

# This script automatically sets up the self-updating demo pipeline so you can begin experimenting
fly --target=concourse login --concourse-url=http://concourse:8080 --username=test --password=test
fly --target=concourse sync

cd /workspace/
for filename in *.pipeline;
do
# https://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash
  splitDot=(${filename//./ })
  teamName="${splitDot[0]}"
  pipeName="${splitDot[1]}"

  fly --target=concourse set-team --team-name="${teamName}" --local-user=test --non-interactive
  fly --target=concourse login --team-name="${teamName}" --concourse-url=http://concourse:8080 --username=test --password=test
  fly --target=concourse set-pipeline --pipeline="${pipeName}" --config=/workspace/"${filename}" --non-interactive
  fly --target=concourse unpause-pipeline --pipeline="${pipeName}"
done

echo 'jojo!'
{ # try
    aws secretsmanager update-secret --secret-id /concourse/team1/test-secrets/pipeline-secret --secret-string "$PIPELINE_SECRET"
    aws secretsmanager update-secret --secret-id /concourse/team2/team-secret --secret-string "$TEAM_SECRET"
    aws secretsmanager update-secret --secret-id /concourse/concourse-secret --secret-string "$CONCOURSE_SECRET"
} || { # catch
    aws secretsmanager create-secret --name /concourse/team1/test-secrets/pipeline-secret --secret-string "$PIPELINE_SECRET"
    aws secretsmanager create-secret --name /concourse/team2/team-secret --secret-string "$TEAM_SECRET"
    aws secretsmanager create-secret --name /concourse/concourse-secret --secret-string "$CONCOURSE_SECRET"
}

exec "$@"
