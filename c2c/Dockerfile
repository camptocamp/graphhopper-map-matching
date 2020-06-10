FROM debian:buster-slim

RUN apt-get update \
  && mkdir /usr/share/man/man1 \
  && apt-get install -y --no-install-recommends unzip wget curl maven openjdk-11-jdk-headless openjdk-11-jre-headless \
  && apt-get clean \
  && rm -rf /usr/share/man/man1 \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data && mkdir -p /graphhopper

COPY ./graphhopper /graphhopper/

WORKDIR /graphhopper

# Disable maven progress bar
ENV MAVEN_OPTS=-Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn 

RUN mvn package install -DskipTests

RUN mkdir -p /graphhopper-map-matching

COPY . /graphhopper-map-matching/
RUN cd /graphhopper-map-matching && mvn package -DskipTests

EXPOSE 8989

CMD /bin/bash
