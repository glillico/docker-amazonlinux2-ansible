FROM amazonlinux:2
LABEL maintainer="Graham Lillico"

ENV container docker

# Update packages to the latest version
RUN yum -y update \
&& yum clean all \
&& yum -y autoremove

# Install required packages.
# Remove packages that are nolonger requried.
# Clean the yum cache.
RUN yum makecache fast \
&& yum -y install \
https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
initscripts \
&& yum -y update \
&& yum -y install \
python \
python-pip \
sudo \
&& yum -y autoremove \
&& yum clean all \
&& rm -rf /var/cache/yum/*

# Configure systemd.
# See https://hub.docker.com/_/centos/ for details.
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install ansible.
RUN pip install ansible

# Create ansible directory and copy ansible inventory file.
RUN mkdir /etc/ansible
COPY hosts /etc/ansible/hosts

# Stop systemd from spawning agettys on tty[1-6].
RUN rm -f /lib/systemd/system/multi-user.target.wants/getty.target

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/lib/systemd/systemd"]
