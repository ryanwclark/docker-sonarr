# docker-sonarr

[![Build Status](https://img.shields.io/github/workflow/status/ryanwclark/docker-sonarr/build?style=flat-square)](https://github.com/ryanwclark/docker-sonarr/actions?query=workflow%3Abuild)
[![Docker Stars](https://img.shields.io/docker/stars/ryanwclark/sonarr.svg?style=flat-square&logo=docker)](https://hub.docker.com/ryanwclark/sonarr/)
[![Docker Pulls](https://img.shields.io/docker/pulls/ryanwclark/sonarr.svg?style=flat-square&logo=docker)](https://hub.docker.com/ryanwclark/sonarr/)


## About

This will build a Docker image for [sonarr](https://www.sonarr.org)

## Table of Contents

- [docker-sonarr](#docker-sonarr)
  - [About](#about)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites and Assumptions](#prerequisites-and-assumptions)
  - [Prerequisites and Assumptions](#prerequisites-and-assumptions-1)
  - [Installation](#installation)
    - [Build from Source](#build-from-source)
    - [Prebuilt Images](#prebuilt-images)
      - [Multi Archictecture](#multi-archictecture)
  - [Configuration](#configuration)
    - [Quick Start](#quick-start)
    - [Persistent Storage](#persistent-storage)
    - [Environment Variables](#environment-variables)
      - [Base Images used](#base-images-used)
    - [Networking](#networking)
  - [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
  - [Support](#support)
    - [Usage](#usage)
    - [Bugfixes](#bugfixes)
    - [Feature Requests](#feature-requests)
    - [Updates](#updates)
  - [License](#license)
  - [References](#references)

## Prerequisites and Assumptions

No prerequisites

## Prerequisites and Assumptions

- This image doesn't do much on it's own, you must use a complemenary service to pass messages or data to it via port 783.

## Installation
### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/ryanwclark/sonarr) and is the recommended method of installation.

```bash
docker pull ryanwclark/sonarr:(imagetag)
```
The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Version | Container OS | Tag       |
| ------- | ------------ | --------- |
| latest  | Alpine       | `:latest` |
| 6       | Alpine       | `:6`      |
| 5       | Alpine       | `:5`      |

#### Multi Archictecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v6`, `arm/v7`, `arm64` and others. These variants are all unsupported. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Make [networking ports](#networking) available for public access if necessary
### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Parameter    | Description           |
| ------------ | --------------------- |
| `/data/db`   | Application Directory |
| `/data/logs` | Logfiles              |


* * *
### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/ryanwclark/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/ryanwclark/docker-alpine/) | Customized Image based on Alpine Linux |

| Parameter     | Description                            | Default  |
| ------------- | -------------------------------------- | -------- |
| `ENABLE_LOGS` | Enable Logfiles `TRUE` or `FALSE`      | `FALSE`  |
| `LOG_LEVEL`   | Log level                              | `notice` |
| `sonarr_PORT`  | Listening Port                         | `6379`   |
| `sonarr_PASS`  | (optional) Require password to connect |          |

### Networking

The following ports are exposed.

| Port   | Description |
| ------ | ----------- |
| `6379` | sonarr Port  |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is) bash
```

## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.

### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.


### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.


## License
MIT. See [LICENSE](LICENSE) for more details.

## References



