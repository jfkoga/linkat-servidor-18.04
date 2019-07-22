#!/bin/bash

CONF_FILE="/etc/linkat/linkat-servidor/linkat-servidor.conf"
NCTEMPLATE="/usr/share/linkat/linkat-servidor/plantilles/nextcloud-restart.sh"
NCRESTART="/usr/local/bin/nextcloud-restart.sh"

# Include de fitxer de configuració del Servidor de Centre
. $CONF_FILE

# Restaura plantilla 'nextcloud-restart' per defecte
cp $NCTEMPLATE $NCRESTART

# Assigna a la plantilla restaurada els paràmetres existents del Servidor de Centre
        if [ -f /usr/local/bin/nextcloud-restart.sh ]; then
                        sed -i "s/__NAME__/$NEW_NAME/g" /usr/local/bin/nextcloud-restart.sh
                        sed -i "s/__DOMAIN__/$NEW_DOMAIN/g" /usr/local/bin/nextcloud-restart.sh
                        sed -i "s/__IP__/$NEW_IP/g" /usr/local/bin/nextcloud-restart.sh
                fi
# Assignem permisos a nextcloud-restart
chmod 570 $NCRESTART
