FROM balenalib/raspberrypi3-debian:latest
MAINTAINER github@abstruse.systems

ENV DATA_DIR=/data \
	BIND_USER=bind

RUN echo exit 0 > /usr/sbin/policy-rc.d

RUN sudo su \
	&& rm -rf /etc/apt/apt.conf.d/docker-gzip-indexes \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y wget bind9 dnsutils \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 53/tcp

VOLUME ["${DATA_DIR}"]

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/named"]
