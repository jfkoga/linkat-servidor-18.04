## Nextcloud

sudo snap install nextcloud
if [ -f /etc/modalitat_linkat ]; then
	sudo /usr/share/linkat/linkat-servidor/configurador/files/nextcloud-resetpass.sh
else
	sudo nextcloud.manual-install lnadmin __PASSLNADMIN__
fi
sudo nextcloud.enable-https self-signed
sudo snap set nextcloud ports.http=81
sudo snap set nextcloud ports.https=10443
sudo nextcloud.occ config:system:set trusted_domains 1 --value="__IP__"
sudo nextcloud.occ config:system:set trusted_domains 2 --value="__NAME__.__DOMAIN__"
sudo snap run nextcloud.occ app:install user_ldap
sudo snap run nextcloud.occ app:enable user_ldap
sudo nextcloud.occ config:app:set user_ldap ldapAgentName --value="cn=admin,dc=__DOMAIN__"
sudo nextcloud.occ config:app:set user_ldap ldapBase --value="dc=__DOMAIN__"
sudo nextcloud.occ config:app:set user_ldap ldapAgentPassword --value="__PASSROOT__"
sudo nextcloud.occ config:app:set user_ldap ldap_base --value="dc=__DOMAIN__"
sudo nextcloud.occ config:app:set user_ldap ldap_base_groups --value="dc=__DOMAIN__"
sudo nextcloud.occ config:app:set user_ldap ldap_base_users --value="dc=__DOMAIN__"
sudo nextcloud.occ config:app:set user_ldap ldap_configuration_active --value="1"
sudo nextcloud.occ config:app:set user_ldap ldap_display_name --value="cn"
sudo nextcloud.occ config:app:set user_ldap ldap_dn --value="cn=admin,dc=__DOMAIN__"
sudo nextcloud.occ config:app:set user_ldap ldapUserFilter --value="(&(|(objectclass=inetOrgPerson)))"
sudo nextcloud.occ config:app:set user_ldap ldap_group_filter --value="(&(|(objectclass=posixGroup)))"
sudo nextcloud.occ config:app:set user_ldap ldap_group_member_assoc_attribute --value="gidNumber"
sudo nextcloud.occ config:app:set user_ldap ldap_groupfilter_objectclass --value="posixGroup"
sudo nextcloud.occ config:app:set user_ldap ldap_host --value="localhost"
sudo nextcloud.occ config:app:set user_ldap ldap_login_filter --value="(&(|(objectclass=inetOrgPerson)(objectclass=organizationalPerson)(objectclass=person))(|(cn=%uid)(gidNumber=%uid)(homeDirectory=%uid)(loginShell=%uid)))"
sudo nextcloud.occ config:app:set user_ldap ldap_loginfilter_attributes --value="cn\ngidNumber\nhomeDirectory\nloginShell"
sudo nextcloud.occ config:app:set user_ldap ldap_port --value="389"
sudo nextcloud.occ config:app:set user_ldap ldap_tls --value="0"
sudo nextcloud.occ config:app:set user_ldap ldap_userlist_filter --value="(|(objectclass=inetOrgPerson))"
sudo nextcloud.occ config:app:set user_ldap types --value="authentication"
sudo snap restart nextcloud
sudo nextcloud.occ app:install onlyoffice
sudo nextcloud.occ app:enable onlyoffice
sudo nextcloud.occ config:app:set onlyoffice DocumentServerUrl --value="https://__IP__:10445/"
#sudo nextcloud.occ config:app:set --value https:\/\/__IP__:10445\/ onlyoffice DocumentServerUrl
sudo nextcloud.occ config:system:set onlyoffice verify_peer_off --value="true"
sudo snap restart nextcloud

