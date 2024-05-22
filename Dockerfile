FROM alpine:3.19

LABEL description "Rainloop is a simple, modern & fast web-based client" \
      maintainer="Hardware <contact@meshup.net>"

ARG GPG_FINGERPRINT="3B79 7ECE 694F 3B7B 70F3  11A4 ED7C 49D9 87DA 4591"

ENV UID=991 GID=991 UPLOAD_MAX_SIZE=25M LOG_TO_STDOUT=false MEMORY_LIMIT=128M

RUN echo "@community https://nl.alpinelinux.org/alpine/v3.19/community" >> /etc/apk/repositories \
 && apk -U upgrade \
 && apk add -t build-dependencies \
    gnupg \
    openssl \
    wget \
 && apk add \
    ca-certificates \
    nginx \
    s6 \
    su-exec \
    php83-fpm@community \
    php83-curl@community \
    php83-iconv@community \
    php83-xml@community \
    php83-dom@community \
    php83-openssl@community \
    php83-json@community \
    php83-zlib@community \
    php83-pdo_pgsql@community \
    php83-pdo_mysql@community \
    php83-pdo_sqlite@community \
    php83-sqlite3@community \
    php83-ldap@community \
    php83-simplexml@community
 RUN cd /tmp \
   && wget -q https://github.com/RainLoop/rainloop-webmail/releases/download/v1.17.0/rainloop-legacy-1.17.0.zip \
   && wget -q https://github.com/RainLoop/rainloop-webmail/releases/download/v1.17.0/rainloop-legacy-1.17.0.zip.asc \
   && wget -q https://www.rainloop.net/repository/RainLoop.asc \
   && gpg --import RainLoop.asc \
   && FINGERPRINT="$(LANG=C gpg --verify rainloop-legacy-1.17.0.zip.asc rainloop-legacy-1.17.0.zip 2>&1 \
   | sed -n "s#Primary key fingerprint: \(.*\)#\1#p")" \
   && if [ -z "${FINGERPRINT}" ]; then echo "ERROR: Invalid GPG signature!" && exit 1; fi \
   && if [ "${FINGERPRINT}" != "${GPG_FINGERPRINT}" ]; then echo "ERROR: Wrong GPG fingerprint!" && exit 1; fi \
   && mkdir /rainloop && unzip -q /tmp/rainloop-legacy-1.17.0.zip -d /rainloop \
   && find /rainloop -type d -exec chmod 755 {} \; \
   && find /rainloop -type f -exec chmod 644 {} \;
 RUN apk del build-dependencies
 RUN rm -rf /tmp/* /var/cache/apk/* /root/.gnupg

COPY rootfs /
RUN chmod +x /usr/local/bin/run.sh /services/*/run /services/.s6-svscan/*
VOLUME /rainloop/data
EXPOSE 8888
CMD ["run.sh"]
