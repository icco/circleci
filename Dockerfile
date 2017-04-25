# https://github.com/docker-library/buildpack-deps/blob/master/jessie/Dockerfile
FROM buildpack-deps:jessie

# Install Jessie NodeJS repo
RUN set -ex; \
      curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN set -ex; \
      apt-get update; \
      apt-get install -y --no-install-recommends \
      unzip python python-pip python-dev jq gettext nodejs openjdk-7-jdk

RUN npm i -g https://github.com/firstlookmedia/deployables

ENV DOCKER_VER "17.04.0-ce"
RUN set -ex; \
      curl -L -o /tmp/docker-$DOCKER_VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VER.tgz; \
      tar -xz -C /tmp -f /tmp/docker-$DOCKER_VER.tgz; \
      mv /tmp/docker/* /usr/bin

RUN mkdir -p ~/.aws
RUN set -ex; \
      curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"; \
      unzip awscli-bundle.zip; \
      ./awscli-bundle/install -b /usr/bin/aws

RUN set -ex; \
      curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein; \
      chmod a+x lein; \
      mv lein /usr/local/bin
