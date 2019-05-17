FROM balenalib/raspberrypi3-alpine:latest
MAINTAINER github -at- abstruse -dot- systems

ENV DATA_DIR=/data \
	BIND_USER=bind

RUN echo exit 0 > /usr/sbin/policy-rc.d

RUN apk add --no-cache bind

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 53/udp 53/tcp

VOLUME ["${DATA_DIR}"]

ENTRYPOINT ["/sbin/entrypoint.sh"]

CMD ["/usr/sbin/named"]
