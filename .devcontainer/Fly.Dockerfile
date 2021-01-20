FROM curlimages/curl as getaws
USER root
RUN curl -o awscliv2.zip -L "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
RUN unzip awscliv2.zip

FROM curlimages/curl as getfly
USER root
RUN curl -o fly.tgz -L "https://github.com/concourse/concourse/releases/download/v6.7.3/fly-6.7.3-linux-amd64.tgz"
RUN tar -xvf fly.tgz

FROM ubuntu:bionic
COPY --from=getaws aws aws
COPY --from=getfly fly /usr/local/bin/fly
COPY setup-pipeline.sh /usr/local/bin/setup-pipeline.sh

RUN chmod +x /usr/local/bin/fly \
 && chmod +x /usr/local/bin/setup-pipeline.sh
RUN aws/install

ENV AWS_ACCESS_KEY_ID=
ENV AWS_SECRET_ACCESS_KEY=
ENV AWS_DEFAULT_REGION=
ENV SECRET_MESSAGE=

RUN apt-get update \
 && apt install -y --no-install-recommends \
      less netcat \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["setup-pipeline.sh"]
