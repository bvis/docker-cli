# Docker CLI
This image provides a quick way of test client versions of Docker.

It allows you to use specific versions that are tagged in Docker Hub, but you can use it to build in an easy way
any docker client version you want to test.

# Build specific versions

    git clone ...
    cd ...
    docker build -t basi/docker-cli --build-arg CHANNEL=test --build-arg VERSION=1.13.0-rc1 .
    docker run --name some-docker --rm basi/docker-cli docker version

It would give you the output:

```
Client:
 Version:      1.13.0-rc1
 API version:  1.25
 Go version:   go1.7.3
 Git commit:   75fd88b
 Built:        Fri Nov 11 22:32:34 2016
 OS/Arch:      linux/amd64
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

If you want to connect this client to a daemon just use the typical options you would use on any case.

## Usage
You can use this image to interact with local or demote docker daemons.

### Connect to a local daemon
Usually you'd need just to mount the daemon socket:

```
docker run \
  --name some-docker \
  --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  basi/docker-cli version
```
Produces the output:
```
Client:
 Version:      1.13.0-rc1
 API version:  1.24 (downgraded from 1.25)
 Go version:   go1.7.3
 Git commit:   75fd88b
 Built:        Fri Nov 11 22:32:34 2016
 OS/Arch:      linux/amd64

Server:
 Version:             1.12.3
 API version:         1.24
 Minimum API version:
 Go version:          go1.6.3
 Git commit:          6b644ec
 Built:               Thu Oct 27 00:09:21 2016
 OS/Arch:             linux/amd64
 Experimental:        true
 ```

### Connect to a remote daemon
In case you want to connect to another daemon that is not in your host machine you'll need to pass to the client your environment variables:

```
export DOCKER_MACHINE_NAME=default
export DOCKER_REMOTE_HOST=tcp://DOCKER-SERVER-IP:2376
docker run \
  --name some-docker \
  --rm \
  -v ${HOME}/.docker/machine/:/machine-certs \
  -e DOCKER_TLS_VERIFY=1 \
  -e DOCKER_HOST=${DOCKER_REMOTE_HOST} \
  -e DOCKER_CERT_PATH=/machine-certs/machines/${DOCKER_MACHINE_NAME} \
  basi/docker-cli version
```
It produces the output:
```
Client:
 Version:      1.13.0-rc1
 API version:  1.25
 Go version:   go1.7.3
 Git commit:   75fd88b
 Built:        Fri Nov 11 22:32:34 2016
 OS/Arch:      linux/amd64

Server:
 Version:             1.13.0-rc1
 API version:         1.25
 Minimum API version: 1.12
 Go version:          go1.7.3
 Git commit:          75fd88b
 Built:               Fri Nov 11 19:47:07 2016
 OS/Arch:             linux/amd64
 Experimental:        false
```
