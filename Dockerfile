FROM ubuntu:16.10

# Current allowed channels are "get" for stable releases and "test" for testing releases
ARG CHANNEL=get
# Here you need to follow the semantic version name, for example: "1.12.3" or "1.13.1-rc1"
# keep in mind that "rc" releases are only available in the "test" channel
ARG VERSION=latest

RUN apt-get update \
 && apt-get install -y curl

RUN curl -fsSLO https://${CHANNEL}.docker.com/builds/Linux/x86_64/docker-${VERSION}.tgz \
  && tar --strip-components=1 -xvzf docker-${VERSION}.tgz -C /usr/local/bin

ENTRYPOINT ["docker"]

