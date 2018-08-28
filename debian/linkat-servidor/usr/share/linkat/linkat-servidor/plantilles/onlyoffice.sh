#!/bin/bash

# Create onlyoffice database
sudo -i -u postgres psql -c "CREATE DATABASE onlyoffice;"
sudo -i -u postgres psql -c "CREATE USER onlyoffice WITH password '__PASSLNADMIN__';"
sudo -i -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;"

sudo mkdir -p /srv/app/onlyoffice/DocumentServer/data/certs/

openssl req -x509 -nodes -days 36500 -newkey rsa:2048 -keyout /etc/ssl/onlyoffice/onlyoffice.key -out /etc/ssl/onlyoffice/onlyoffice.crt -subj "/C=ES/ST=Catalunya/L=Barcelona/O=Generalitat de Catalunya/OU=Departament Ensenyament/CN=xtec.cat"

docker pull onlyoffice/documentserver

sudo docker run -i -t -d -p 10445:443 --restart=always -v /srv/app/onlyoffice/DocumentServer/data:/var/www/onlyoffice/Data onlyoffice/documentserver

#sudo nextcloud.occ app:install onlyoffice
#sudo nextcloud.occ app:enable onlyoffice
#sudo nextcloud.occ config:app:set onlyoffice DocumentServerUrl --value="https://__IP__:10445/"
###sudo nextcloud.occ config:app:set --value https:\/\/__IP__:10445\/ onlyoffice DocumentServerUrl
#sudo nextcloud.occ config:system:set onlyoffice verify_peer_off --value="true"
