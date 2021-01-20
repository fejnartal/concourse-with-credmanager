FROM concourse/concourse:latest

# Mandatory settings
# ------------------
ENV CONCOURSE_AWS_SECRETSMANAGER_ACCESS_KEY=
ENV CONCOURSE_AWS_SECRETSMANAGER_SECRET_KEY=
ENV CONCOURSE_AWS_SECRETSMANAGER_REGION=

# Customization, nice-to-have settings. Not mandatory, it fallbacks to sensible defaults
# --------------------------------------------------------------------------------------
# https://concourse-ci.org/aws-asm-credential-manager.html#aws-secretsmanager-pipeline-secret-template

# ENV CONCOURSE_AWS_SECRETSMANAGER_PIPELINE_SECRET_TEMPLATE=/concourse/{{.Team}}/{{.Pipeline}}/{{.Secret}}
# ENV CONCOURSE_AWS_SECRETSMANAGER_TEAM_SECRET_TEMPLATE=/concourse/{{.Team}}/{{.Secret}}
