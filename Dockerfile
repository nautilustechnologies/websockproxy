# FROM ubuntu:18.04 AS dev-box
FROM nvidia/cuda:11.8.0-base-ubuntu18.04  AS dev-box

ENV DEBIAN_FRONTEND=noninteractive 
LABEL org.opencontainers.image.authors="nautilustechnologies"

COPY . /opt/websockproxy/
WORKDIR /opt/websockproxy/

RUN \
  echo "--[update system settings]--" ;\
    cp -f /opt/websockproxy/docker-image-config/docker-startup.sh /opt/websockproxy/ ;\
    cp -rf /opt/websockproxy/docker-image-config/dnsmasq/* /etc/dnsmasq.d/ ;\
  echo "--[done update system settings]--" &&\
  echo "--[installing system packages]--" ;\
    apt-get update ;\
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --install-recommends \
        python python-dev python3-pip python3-venv iptables dnsmasq uml-utilities \
        postgresql postgresql-contrib zstd zpaq xz-utils zutils bison nfs-server nfs-common \
        iputils-ping telnet net-tools build-essential curl wget vim s3fs bison &&\
    apt-get upgrade -yq &&\
    apt-get clean ;\
  echo "--[done installing system packages]--" &&\
  echo "--[installing pip 2.7 packages]--" ;\
      [ -f /opt/websockproxy/get-pip.py ] && python /opt/websockproxy/get-pip.py ;\
  echo "--[done installing pip 2.7 packages]--" &&\
  echo "--[installing websockproxy requirements]--" ;\
  [ -f /opt/websockproxy/requirements.txt ] && pip install -r /opt/websockproxy/requirements.txt ;\
  echo "--[done installing websockproxy requirements]--"


EXPOSE 80 8080
CMD ["/opt/websockproxy/docker-startup.sh"]
#############################
