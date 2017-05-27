#!/bin/bash

#Se recuperan las variables del entorno y se hace un split separando por ",". Se crea un string que configurara el mirror.
IFS=', ' read -r -a array <<< "${deps}"
configuracion="Priority (required) | Priority (important) | Priority (standard) "
for paquete in "${array[@]}"
do
 configuracion=$configuracion" | "$paquete
done

#Se aplica la configuracion al mirror aplty y se actualiza la base de datos.
aptly mirror edit -filter="$configuracion" mirror-xenial
aptly mirror update mirror-xenial
aptly snapshot create mirror-snap-xenial from mirror mirror-xenial

#Se crea el snapshot 
expect -f <(cat <<'EOD'
spawn aptly publish snapshot mirror-snap-xenial
expect "Enter passphrase:"
send -- "password\r"
expect "Enter passphrase:"
send -- "password\r"
expect eof
EOD
)

#Se publica el mirror
aptly serve
