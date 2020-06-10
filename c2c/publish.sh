#!/bin/bash -e

NAME="camptocamp/graphhopper"

function publish {
    local version=$1
    docker_version=`echo "${version}" | sed -e 's/^release\///' | sed -e 's/\//_/g'`

    echo "Deploying image to docker hub for tag ${docker_version}"
    docker tag "${NAME}:latest" "${NAME}:${docker_version}"
    docker push "${NAME}:${docker_version}"
}

if [ ! -z "${CIRCLE_PULL_REQUEST}" ]
then
    echo "Not deploying image for pull requests"
    exit 0
fi

if [ "${CIRCLE_BRANCH}" == "c2c" ]
then
  publish latest
elif [ ! -z "${CIRCLE_TAG}" ]
then
  publish "${CIRCLE_TAG}"
elif [ ! -z "${CIRCLE_BRANCH}" ]
then
  publish "${CIRCLE_BRANCH}"
else
  echo "Not deploying image"
fi
