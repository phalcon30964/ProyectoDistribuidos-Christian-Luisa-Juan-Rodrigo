#!/usr/bin/expect -f

#Se usa expect para iniciar el proceso de interaccion para la creacion del mirror.

spawn aptly publish snapshot mirror-snap-xenial
expect "Enter passphrase:"
send -- "password\r"
expect "Enter passphrase:"
send -- "password\r"
expect eof
