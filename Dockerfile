# FROM ubuntu:18.04 AS ubuntu-base
# # FROM debian:12 AS ubuntu-base

# ENV DEBIAN_FRONTEND=noninteractive 
# LABEL org.opencontainers.image.authors="nautilustechnologies"

# RUN apt-get update \
#     && DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq \
#     && DEBIAN_FRONTEND=noninteractive apt-get install -y python python-dev iptables dnsmasq uml-utilities \
#     iputils-ping telnet net-tools build-essential curl wget vim \
#     && DEBIAN_FRONTEND=noninteractiv apt-get clean
# RUN \
#   echo "--[installing pip 2.7 packages]--" ;\
#       curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && python get-pip.py ;\
#   echo "--[done installing pip 2.7 packages]--" ;\
#############################
FROM dev-box AS production

ENV DEBIAN_FRONTEND=noninteractive 
LABEL org.opencontainers.image.authors="nautilustechnologies"

COPY . /opt/websockproxy/
COPY docker-image-config/docker-startup.sh switchedrelay.py limiter.py requirements.txt /opt/websockproxy/
COPY docker-image-config/dnsmasq/interface docker-image-config/dnsmasq/dhcp /etc/dnsmasq.d/

WORKDIR /opt/websockproxy/

RUN \
  echo "--[installing pip 2.7 packages]--" ;\
      [ -f /opt/websockproxy/get-pip.py ] && python /opt/websockproxy/get-pip.py ;\
  echo "--[done installing pip 2.7 packages]--" ;\
  echo "--[installing websockproxy requirements]--" ;\
  [ -f /opt/websockproxy/requirements.txt ] && pip2 install -r /opt/websockproxy/requirements.txt ;\
  echo "--[done installing websockproxy requirements]--"

EXPOSE 80

CMD /opt/websockproxy/docker-startup.sh


