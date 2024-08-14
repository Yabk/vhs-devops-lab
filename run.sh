#!/usr/bin/env bash
set -euo pipefail

podman run --name=nexus -dt -v /tn_devops/nexus:/opt/nexus/sonatype-work -p 18081:8081/tcp --restart=always nexus

