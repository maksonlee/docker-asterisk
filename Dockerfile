FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-c"]

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y ca-certificates curl wget build-essential git autoconf subversion pkg-config libtool \
    && cd /tmp \
    && curl -OL http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20.3.0.tar.gz \
    && tar xzvf asterisk-20.3.0.tar.gz \
    && cd asterisk-20.3.0 \
    && contrib/scripts/install_prereq install \
    && ./configure \
    && make -j12 \
    && make install \
    && make samples \
    && ldconfig \
    && mkdir /var/lib/asterisk/astdb \
    && rm -rf /tmp/* \
    && apt-get purge --no-install-recommends --no-install-suggests -y ca-certificates curl wget build-essential git autoconf subversion pkg-config libtool \
    && apt-get autoremove --no-install-recommends --no-install-suggests -y

COPY conf/ari.conf conf/http.conf conf/pjsip.conf conf/sorcery.conf /etc/asterisk/

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
