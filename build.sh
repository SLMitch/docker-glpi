#!/bin/bash
image=docker.inf.tvvideoms.com/docker/slmitch/glpi:10.0.11
docker build -t $image .
echo "docker push  $image"
