#############################
# FROM ubuntu:18.04 AS production
FROM ubuntu:18.04 AS production

ENV DEBIAN_FRONTEND=noninteractive 
LABEL org.opencontainers.image.authors="nautilustechnologies"

COPY . /opt/websockproxy/
COPY docker-image-config/docker-startup.sh switchedrelay.py limiter.py requirements.txt /opt/websockproxy/
COPY docker-image-config/dnsmasq/interface docker-image-config/dnsmasq/dhcp /etc/dnsmasq.d/

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y python python-dev iptables dnsmasq uml-utilities \
    iputils-ping telnet net-tools build-essential curl wget vim git socat tahoe-lafs \
    && DEBIAN_FRONTEND=noninteractiv apt-get clean

# RUN \
#   echo "--[installing system packages]--" ;\
#   apt-get update ;\
#   DEBIAN_FRONTEND=noninteractive apt-get install --yes --install-recommends \
#       python python-dev python3-pip python3-venv iptables dnsmasq uml-utilities \
#       postgresql postgresql-contrib zstd zpaq xz-utils zutils bison nfs-server nfs-common \
#       iputils-ping telnet net-tools build-essential curl wget vim s3fs bison sudo git socat &&\
#   apt-get upgrade -yq &&\
#   apt-get clean &&\
#   echo "--[done installing system packages]--"

RUN \
  echo "--[installing pip 2.7 packages]--" ;\
      [ -f /opt/websockproxy/get-pip.py ] && python /opt/websockproxy/get-pip.py ;\
  echo "--[done installing pip 2.7 packages]--" ;\
  echo "--[installing websockproxy requirements]--" ;\
    [ -f /opt/websockproxy/requirements.txt ] && pip2 install -r /opt/websockproxy/requirements.txt ;\
  echo "--[done installing websockproxy requirements]--" ;\
  echo "--[installing nodejs modules]--" ;\
    [ ! -d /root/.nvm ] && ( \rm -rf /root/.nvm && git clone https://github.com/creationix/nvm.git /root/.nvm ) ;\
    [ -f /opt/websockproxy/nodejs/installPackages.sh ] && ( bash /opt/websockproxy/nodejs/installPackages.sh) ;\
  echo "--[done installing nodejs modules]--"

WORKDIR /opt/websockproxy/

EXPOSE 80 8080 5432 1883

CMD /opt/websockproxy/docker-startup.sh


