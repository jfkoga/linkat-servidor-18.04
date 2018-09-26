#!/bin/bash

###SAMBA###
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f samba.ldif
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f samba_indices.ldif

sudo smbpasswd -w __PASSROOT__

/usr/share/linkat/linkat-servidor/configurador/files/smbldap-populate.sh

sudo auth-client-config -t nss -p lac_ldap

#LOCALSID=$(sudo net getlocalsid | awk ' {print $6} ')
#sed -i s/__GETLOCALSID__/"$LOCALSID"/g /etc/smbldap-tools/smbldap.conf

