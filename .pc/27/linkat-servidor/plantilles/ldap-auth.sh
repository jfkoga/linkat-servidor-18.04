#!/bin/bash
## LDAP Authentication

# debconf-set-selections ldap-auth-config
# check /etc/ldap.secret
sudo auth-client-config -t nss -p lac_ldap
sudo pam-auth-update

