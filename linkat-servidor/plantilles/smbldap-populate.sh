#!/usr/bin/expect -f

spawn smbldap-populate -g 10000 -u 10000 -r 10000 
expect "New password:"
send -- "$NEW_PASSROOT\r"

expect "Retype new password:"
send -- "$NEW_PASSROOT\r"

expect eof
