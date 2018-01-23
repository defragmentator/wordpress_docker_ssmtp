#!/bin/bash
#set -euo pipefail

if [ -n "$SSMTP_ROOT" ]; then
    sed -i "s/root=yourmail@mail.com/root=$SSMTP_ROOT/g" /etc/ssmtp/ssmtp.conf
fi
if [ -n "$SSMTP_MAILHUB" ]; then
    sed -i "s/mailhub=smtp.yourmail.com/mailhub=$SSMTP_MAILHUB/g" /etc/ssmtp/ssmtp.conf
fi
if [ -n "$SSMTP_USETLS" ]; then
    sed -i "s/UseTLS=NO/UseTLS=$SSMTP_USETLS/g" /etc/ssmtp/ssmtp.conf
fi
if [ -n "$SSMTP_STARTTLS" ]; then
    sed -i "s/UseSTARTTLS=NO/UseSTARTTLS=$SSMTP_STARTTLS/g" /etc/ssmtp/ssmtp.conf
fi
if [ -n "$SSMTP_REWRITEDOMAIN" ]; then
    sed -i "s/rewriteDomain=/rewriteDomain=$SSMTP_REWRITEDOMAIN/g" /etc/ssmtp/ssmtp.conf
fi
if [ -n "$SSMTP_HOSTNAME" ]; then
    sed -i "s/hostname=yourserver.example.com/hostname=$SSMTP_HOSTNAME/g" /etc/ssmtp/ssmtp.conf
fi
if [ -n "$SSMTP_FROMLINEOVERRIDE" ]; then
    sed -i "s/FromLineOverride=YES/FromLineOverride=$SSMTP_FROMLINEOVERRIDE/g" /etc/ssmtp/ssmtp.conf
fi
if [ -n "$SSMTP_AUTHUSER" ]; then
    sed -i "s/AuthUser=/AuthUser=$SSMTP_AUTHUSER/g" /etc/ssmtp/ssmtp.conf
fi
if [ -n "$SSMTP_AUTHPASS" ]; then
    sed -i "s/AuthPass=/AuthPass=$SSMTP_AUTHPASS/g" /etc/ssmtp/ssmtp.conf
fi

exec /usr/local/bin/docker-entrypoint.sh $@
