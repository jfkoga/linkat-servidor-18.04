#!/bin/bash

. /etc/linkat/linkat-servidor/linkat-servidor.conf

LOG=/var/log/linkat-onlyoffice.log

# Check Internet connection. Necessary for the installation.
wget -q --tries=10 --timeout=20 --spider http://google.com
if [[ $? -eq 0 ]]; then
        echo "Online" >> $LOG
else
        $ZENITY --error --title="Instal·lació Onlyoffice" --text="Error: No hi ha connexió a Internet.\n\nEl programa d'instal·lació s'aturarà."
                                exit 1
fi

# Create onlyoffice database
sudo -i -u postgres psql -c "CREATE DATABASE onlyoffice;"
sudo -i -u postgres psql -c "CREATE USER onlyoffice WITH password '__PASSLNADMIN__';"
sudo -i -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;"

# Kill update programs and update repository info.
killall update-manager update-notifier  > /dev/null 2>&1
sudo apt-get update
if [ ! $? -eq 0 ]; then
        $ZENITY --error --text="Error a l'actualitzar els repositoris.\nComproveu la vostra connexió a Internet.\n"
        echo -en "Error a l'actualitzar els repositoris.\nComproveu la vostra connexió a Internet.\n" >> $LOG
        exit 1
fi

sudo debconf-set-selections /usr/share/linkat/linkat-servidor/configurador/files/debconf.onlyoffice-documentserver

killall update-manager update-notifier  > /dev/null 2>&1
sudo apt-get install -y onlyoffice-documentserver --force-yes
if [ ! $? -eq 0 ]; then
        $ZENITY --error --text="Error a l'instal·lar el programa.\n"
        echo -en "Error a l'instal·lar el programa.\n" >> $LOG
        exit 1
fi
echo -en "Configurant el servei nginx..."
# Stop nginx service
sudo service nginx stop

# Generar certificat
mkdir -p /etc/ssl/onlyoffice/
openssl req -x509 -nodes -days 36500 -newkey rsa:2048 -keyout /etc/ssl/onlyoffice/onlyoffice.key -out /etc/ssl/onlyoffice/onlyoffice.crt -subj "/C=ES/ST=Catalunya/L=Barcelona/O=Generalitat de Catalunya/OU=Departament Ensenyament/CN=xtec.cat"

chattr -i /etc/nginx/conf.d/onlyoffice-documentserver.conf

# Copy nginx config file for onlyoffice
sudo cp -f /usr/share/linkat/linkat-onlyoffice/onlyoffice-documentserver.conf /etc/nginx/conf.d/onlyoffice-documentserver.conf

# Start nginx service.
sudo service nginx start
if [ ! $? -eq 0 ]; then
        $ZENITY --error --text="Error a l'iniciar el servei nginx.\n"
        echo -en "Error a l'iniciar el servei nginx.\n" >> $LOG
        exit 1
else
        echo -en "Servei nginx en funcionament."\n
fi

$ZENITY --info --title="Instal·lació OnlyOffice" --text="OnlyOffice s'ha instal·lat en aquest servidor.\n\nEls clients han d'acceptar el certificat des d'aquesta URL\n\nhttps://$NEW_IP:10445"

chattr +i /etc/nginx/conf.d/onlyoffice-documentserver.conf

touch /etc/Linkat/linkat-onlyoffice/config
