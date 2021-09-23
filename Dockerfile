FROM ryanwclark/debian-slim:bullseye

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SONARR_VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Ryan Clark <ryanwclark@yahoo.com>"

# set environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_CONFIG_HOME="/config/xdg"
ENV SONARR_BRANCH="main"

RUN \
#  echo "**** install apt-transport-https ****" && \
#  apt-get update && \
#  apt-get install -y apt-transport-https && \
#  echo "**** add mono repository ****" && \
#  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
#  echo "deb http://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official.list && \
 echo "**** install packages ****" && \
 apt-get update && \
 apt-get install -y \
	--no-install-recommends \
	--no-install-suggests \
	ca-certificates-mono \
	libcurl4-openssl-dev \
	mono-devel && \
  # mono-mcs && \
	# mono-vbnc && \
 echo "**** clean up ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

RUN echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    jq && \
  echo "**** install sonarr ****" && \
  mkdir -p /app/sonarr/bin && \
  if [ -z ${SONARR_VERSION+x} ]; then \
    SONARR_VERSION=$(curl -sX GET http://services.sonarr.tv/v1/releases \
    | jq -r ".[] | select(.branch==\"$SONARR_BRANCH\") | .version"); \
  fi && \
  curl -o \
    /tmp/sonarr.tar.gz -L \
    "https://download.sonarr.tv/v3/${SONARR_BRANCH}/${SONARR_VERSION}/Sonarr.${SONARR_BRANCH}.${SONARR_VERSION}.linux.tar.gz" && \
  tar xf \
    /tmp/sonarr.tar.gz -C \
    /app/sonarr/bin --strip-components=1 && \
  echo "UpdateMethod=docker\nBranch=${SONARR_BRANCH}\nPackageVersion=${VERSION}\nPackageAuthor=[linuxserver.io](https://linuxserver.io)" > /app/sonarr/package_info && \
  rm -rf /app/sonarr/bin/Sonarr.Update && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8989
VOLUME /config