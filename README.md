# triply/mongodb:3.2.0

## Introduction

Dockerfile to build a [MongoDB](https://www.mongodb.org/) container image, based on the [official](https://hub.docker.com/_/mongo/) MongoDB docker image.
This image however does not properly map the user and group ID of the mongodb user, to the user and group ID on the host. As a result, files in shared volumes will be inaccessible by the host user.

## Quick start
The quickest way to get started is using docker-compose.
```bash
wget https://raw.githubusercontent.com/OpenTriply/docker-mongodb/3.2.0/docker-compose.yml
```
Start MongoDB using
```bash
docker-compose up
```
## Available Configuration Parameters

In addition to the [official](https://hub.docker.com/_/mongo/) image, this image provides these environment variables


- **DEBUG**: Set this to `true` to enable entrypoint debugging.
- **USERMAP_UID**: Sets the user ID for user `mongodb` to the specified user ID. Defaults to `1000`.
- **USERMAP_GID**: Sets the group ID for user `mongodb` to the specified group ID. Defaults to `1000`.
