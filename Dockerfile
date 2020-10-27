FROM adoptopenjdk/openjdk11:jre-11.0.8_10-alpine

# ===============
# Alpine packages
# ===============

RUN apk update \
    && apk add --no-cache openssl py3-pip curl tini bash \
    && apk add --no-cache --virtual build-deps wget git

# JAR files required to generate OpenID Connect keys
ENV JANS_VERSION=5.0.0-SNAPSHOT
ENV JANS_BUILD_DATE='2020-10-02 11:56'
ENV JANS_SOURCE_URL=https://ox.gluu.org/maven/org/janssen/janssen-client/${JANS_VERSION}/janssen-client-${JANS_VERSION}-jar-with-dependencies.jar

RUN mkdir -p /app/javalibs \
    && wget -q ${JANS_SOURCE_URL} -O /app/javalibs/janssen-client.jar

RUN pip3 install -U pip --no-cache \
    && pip3 install --no-cache click

RUN apk del build-deps
