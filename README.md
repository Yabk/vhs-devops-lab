# Description

This repository contains `Containerfile` for Nexus server as well as accompanying `build.sh` and `run.sh` scripts. 

# Build

To build the image simply use `podman build -t nexus .` command (or run the `build.sh` script containing the same command).

The `Containerfile` uses multi-stage build to save on final image  size (this way we don't keep >200MB nexus binary archive in the image layers).

# Run

Provided `run.sh` script will:
- start the container in background
- name it `nexus`
- mount the host directory `/tn_devops/nexus` to container directory `/opt/nexus/sonatype-work`
- bind host port `18081` to the port `8081` in container
- set the restart policy to `always`

# Accessing the User Interface

To access the user interface open the following url: <http://localhost:18081> (if deploying remotely, change the hostname and port accordingly).  
To login use `admin` username and password stored in the `/tn_devops/nexus/nexus3/admin.password` file.

# Troubleshooting

## Container doesn't automatically start on system boot

If your container doesn't automatically start on system boot make sure you have `podman-restart.service` enabled.

