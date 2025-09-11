# FROM ubuntu:18.04 AS dev-box
FROM nvidia/cuda:11.8.0-base-ubuntu18.04  AS dev-box

ENV DEBIAN_FRONTEND=noninteractive 
LABEL org.opencontainers.image.authors="nautilustechnologies"

RUN \
    echo "--[installing system packages]--" ;\
    apt-get update ;\
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --install-recommends \
        python python-dev python3-pip python3-venv iptables dnsmasq uml-utilities \
        iputils-ping telnet net-tools build-essential curl wget vim s3fs &&\
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq &&\
    apt-get clean ;\
  echo "--[done installing system packages]--"

RUN \
  echo "--[installing pip 2.7 packages]--" ;\
      curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && python get-pip.py ;\
  echo "--[done installing pip 2.7 packages]--"

CMD ["/bin/bash"]