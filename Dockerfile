ARG BUILD_ALPINE_VERSION

FROM alpine:${BUILD_ALPINE_VERSION}

ENV DNSMASQ_CONFIG_DIR="/etc/dnsmasq.d" \
    DNSMASQ_DEFAULT_DOMAIN=localhost \
    DNSMASQ_DNS_SERVER_1=1.1.1.1 \
    DNSMASQ_DNS_SERVER_2=1.0.0.1

RUN set -ex; \
    # Install Dnsmasq
    apk --no-cache add dnsmasq; \
    # Install envsubst
    apk add --update libintl; \
    apk add --no-cache --virtual .gettext gettext; \
    cp /usr/bin/envsubst /usr/local/bin/envsubst; \
    apk del .gettext; \
    # Prepare base folders
    mkdir -p ${DNSMASQ_CONFIG_DIR}; \
    # Execute dnsmasq as any user
    chgrp -R 0 ${DNSMASQ_CONFIG_DIR}; \
    chmod -R g+rwX ${DNSMASQ_CONFIG_DIR}

USER 1001

COPY conf/dnsmasq.conf /etc/dnsmasq.conf
COPY conf/dnsmasq.d/*.tmpl /etc/dnsmasq.d/
COPY scripts/*.sh /scripts/

WORKDIR $DNSMASQ_CONFIG_DIR
EXPOSE 5353/tcp 5353/udp

STOPSIGNAL SIGTERM

ENTRYPOINT ["/scripts/docker-entrypoint.sh"]
CMD ["dnsmasq"]
