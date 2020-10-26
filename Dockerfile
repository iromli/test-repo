FROM adoptopenjdk/openjdk11:jre-11.0.8_10-alpine

# ===============
# Alpine packages
# ===============

RUN apk update \
    && apk add --no-cache openssl py3-pip curl tini \
    && apk add --no-cache --virtual build-deps wget git

# JAR files required to generate OpenID Connect keys
ENV JANS_VERSION=5.0.0-SNAPSHOT
ENV JANS_BUILD_DATE="2020-09-28 18:22"
ENV JANS_SOURCE_URL=https://ox.gluu.org/maven/org/janssen/janssen-client/${JANS_VERSION}/janssen-client-${JANS_VERSION}-jar-with-dependencies.jar

RUN mkdir -p /app/javalibs \
    && wget -q ${JANS_SOURCE_URL} -O /app/javalibs/janssen-client.jar