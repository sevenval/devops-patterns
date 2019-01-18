
* `Makefile`: Controls all non-local operations, e.g. builds, deployments,
  operations-taks etc.
* `docker-compose.yaml`: Locals builds and services are controlled by this file.
* `ops/docker-compose.ops.yaml`: Any non-local environments are managed via this
  file. All necessary application are wrapped in a run-once Docker-container.
  Thus no dependencies must be installed.
* `services/`: This folder contains the services. Every service has it's own
  folder. A folder's name should correspond to the service's name, e.g. "mysql"
  or "db" for a MySQL-database. The service folders contain the Dockerfile to
  build the image. It may also contain application code or data.
* `environments/`: Contains environment-specific data necessary running, staring
  or deploying the application. For the names of the folders the same names
  as in `services/` should be used.
* `ops/`: Configuration files and templates which control the managemnt
  containers called by `ops/docker-compose.ops.yaml`.

# Structure

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
