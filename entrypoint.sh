#!/bin/bash -ex
if [[ ! -z "${LOCAL_NET}" ]]; then
    sed -i -r "s,^(local_net=).*,\1$LOCAL_NET," /etc/asterisk/pjsip.conf
fi

if [[ ! -z "${EXTERNEL_ADDRESS}" ]]; then
    sed -i -r "s/^(external_media_address=).*/\1$EXTERNEL_ADDRESS/" /etc/asterisk/pjsip.conf
    sed -i -r "s/^(external_signaling_address=).*/\1$EXTERNEL_ADDRESS/" /etc/asterisk/pjsip.conf
fi

if [[ ! -z "${ARI_PASSWORD}" ]]; then
    sed -i -r "s/^(password =).*/\1 $ARI_PASSWORD/" /etc/asterisk/ari.conf
fi

/usr/sbin/asterisk -fp
