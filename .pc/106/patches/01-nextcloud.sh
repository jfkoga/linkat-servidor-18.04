#!/bin/bash

NAME="$(grep NEW_NAME /etc/linkat/linkat-servidor/linkat-servidor.conf | cut -d "=" -f2)"
DOMAIN="$(grep DOMAIN /etc/linkat/linkat-servidor/linkat-servidor.conf | cut -d "=" -f2)"
IP="$(grep IP /etc/linkat/linkat-servidor/linkat-servidor.conf | cut -d "=" -f2)"

# Comprova que Nextcloud restart té els paràmetres del Servidor de Centre
        if [ -f /usr/local/bin/nextcloud-restart.sh ]; then
                        sed -i "s/__NAME__/$NAME/g" /usr/local/bin/nextcloud-restart.sh
			sed -i "s/__DOMAIN__/$DOMAIN/g" /usr/local/bin/nextcloud-restart.sh
			sed -i "s/__IP__/$IP/g" /usr/local/bin/nextcloud-restart.sh
                fi
