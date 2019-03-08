# Docker Debug

This Docker image is intended to make debugging containers and making general
container development easier.

It contains typical debugging tools that you may not find in your application
containers (i.e. nslookup, curl, vim, dive, etc). That can be extremely useful
when trying to resolve an issue with your running app or it's network setup.
For example: testing DNS resolution against a service in your cluster.

As covered in the [usage](#usage) you can also point these tools at a running
container and effiectly utilise them without the need to change your application
container itself. For example: if you want to test a file-based config change
quickly in your target container but it doesn't have vim or any other editor.


## Usage
As per [How-to Debug a Running Docker Container from a Separate Container], you
can use this container and it's tools to debug other running containers like so:
```bash
docker run -it --privileged         \
  --pid=container:$DEBUG_CONTAINER  \
  --net=container:$DEBUG_CONTAINER  \
  ahstn/debug
```

Now you have access to the target containers processes, filesystem
(at: /proc/1/root) and it's network (on: localhost).

For debugging Kubernetes networking you can run the following to access a ZSH
prompt inside the network:
```bash
kubectl run debug --image=ahstn/debug -i --tty --rm
```

## Contents
The image contains everything a standard alpine container with the following:

* Standard Linux Utils
  * curl
  * wget
  * fping
  * bind-tools (nslookup)
  * ZSH
  * tmux
* Development Tools
  * Vim
  * Git
* DevOps Tools
  * Docker
  * Dive
  * Kustomize
  * Kubernetes CLI (kubectl)


[How-to Debug a Running Docker Container from a Separate Container]: https://medium.com/@rothgar/how-to-debug-a-running-docker-container-from-a-separate-container-983f11740dc6
