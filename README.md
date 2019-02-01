# Deployment patterns for Docker

A template pattern to build, deploy and manage applications in Docker
environments in a light and transparent way.

It uses Make, Docker and Docker-compose to abstract the specific commands for
managing the application. Except for the above mentioned programs no other
programs must be installed since they are provided via Docker images.


## Structure

```
Makefile
docker-compose.yaml
services/
  1/
    Dockerfile
    code/
    data/
  2/
    [...]
environments/
  1/
    devel/
    prod/
    local/
  2/
    [...]
ops/
  docker-compose.ops.yaml
  1/
    devel/
    prod/
  2/
    [...]
```

* `Makefile`: Controls all non-local operations, e.g. builds, deployments,
  operations-tasks etc.
* `docker-compose.yaml`: Only local builds and services are controlled by this file.
* `ops/docker-compose.ops.yaml`: Any non-local environments are managed via this
  file. All necessary applications are wrapped in a run-once Docker-container.
  Thus no dependencies must be installed. Under
  https://github.com/sevenval/dockerfiles there are some images which can be
  utilized, e.g. sloppy-/rancher-deployment.
* `services/`: This folder contains the services. Every service has it's own
  folder. A folder's name should correspond to the service's name, e.g. "mysql"
  or "db" for a MySQL-database. The service folders contain the Dockerfile to
  build the image. It may also contain application code or data.
* `environments/`: Contains environment-specific data necessary for running,
   starting or deploying the application. For the names of the folders the same
   names as in `services/` should be used.
* `ops/`: Configuration files and templates which control the management
  containers called by `ops/docker-compose.ops.yaml`.

## Setup

Run the script `setup` in the directory which should be prepared and the
necessary files are copied from the directory `skel/`.

