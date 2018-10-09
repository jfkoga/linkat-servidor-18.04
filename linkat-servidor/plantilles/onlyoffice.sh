#!/bin/bash

sudo mkdir -p /srv/app/onlyoffice/DocumentServer/data/certs

sudo openssl req -x509 -nodes -days 36500 -newkey rsa:2048 -keyout /srv/app/onlyoffice/DocumentServer/data/certs/onlyoffice.key -out /srv/app/onlyoffice/DocumentServer/data/certs/onlyoffice.crt -subj "/C=ES/ST=Catalunya/L=Barcelona/O=Generalitat de Catalunya/OU=Departament Ensenyament/CN=xtec.cat"

sudo docker pull onlyoffice/documentserver

sudo docker run -itd -p 0.0.0.0:8443:443 --restart=always \
    -v /srv/app/onlyoffice/DocumentServer/cache:/var/lib/onlyoffice/documentserver/App_Data/cache/files  \
    -v /srv/app/onlyoffice/DocumentServer/logs:/var/log/onlyoffice  \
#    -v /srv/app/onlyoffice/DocumentServer/config:/etc/onlyoffice/documentserver
    -v /srv/app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data onlyoffice/documentserver

sudo nextcloud.occ app:install onlyoffice
sudo nextcloud.occ app:enable onlyoffice
sudo nextcloud.occ config:app:set onlyoffice DocumentServerUrl --value="https://__IP__:8443/"
sudo nextcloud.occ config:system:set onlyoffice verify_peer_off --value="true"
sudo snap restart nextcloud

