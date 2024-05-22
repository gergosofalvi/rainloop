#!/bin/bash
docker buildx build \
-t geriapp/rainloop \
--file Dockerfile \
--platform linux/arm64,linux/amd64 \
.
