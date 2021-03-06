FROM adoptopenjdk/openjdk11:jre-11.0.8_10-alpine

# ===============
# Alpine packages
# ===============

RUN apk update \
    && apk add --no-cache openssl py3-pip curl tini \
    && apk add --no-cache --virtual build-deps wget git

# JAR files required to generate OpenID Connect keys
ENV CN_VERSION=5.0.0-SNAPSHOT
ENV CN_BUILD_DATE='2020-11-10 15:47'
ENV CN_SOURCE_URL=https://maven.jans.io/maven/io/jans/jans-auth-client/${CN_VERSION}/jans-auth-client-${CN_VERSION}-jar-with-dependencies.jar

RUN mkdir -p /app/javalibs \
    && wget -q ${CN_SOURCE_URL} -O /app/javalibs/auth-client.jar

RUN pip3 install -U pip --no-cache \
    && pip3 install --no-cache click

RUN apk del build-deps
