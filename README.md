# Amazon Linux 2 Docker Image for Ansible Testing

[![latest](https://github.com/glillico/docker-amazonlinux2-ansible/workflows/latest/badge.svg)](https://github.com/glillico/docker-amazonlinux2-ansible/actions?query=workflow%3Alatest)

A docker container using Amazon Linux 2 with Ansible installed for playbook and role testing.

## Tags

  - 'latest'  : Python 2.7.x and the latest stable version of Ansible.

## How To Build

To build this docker container you can do the following.

  - Install Docker Engine, see [here](https://docs.docker.com/engine/install/) for details.
  - Clone this repository.
    - `$ git clone https://github.com/glillico/docker-amazonlinux2-ansible.git`
  - Change to the repositories directory.
    - `$ cd docker-amazonlinux2-ansible`
  - Run the command
    - `$ docker build -t amazonlinux2-ansible .`

## How To Use

  - Install Docker Engine, see [here](https://docs.docker.com/engine/install/) for details.
  - To create a containter from the image you created in the `How To Build` section run the command.
    - `$ docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns=host amazonlinux2-ansible:latest`
  - To confirm Ansible is working within the container run the command.
    - `$ docker exec --tty <CONTAINER ID> env TERM=xterm ansible --version`

## Notes

This image is used for testing purposes only and is not intended to be used to provide live services of any sort.

## License

MIT

## Author Information

Created in 2020 by Graham Lillico.
