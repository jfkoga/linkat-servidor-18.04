#!/bin/bash

grep --quiet "ntlm" /etc/samba/smb.conf
if [ $? != 0 ]; then
	sed -i '/security.*/a \\tntlm auth = yes' smb.conf
fi
