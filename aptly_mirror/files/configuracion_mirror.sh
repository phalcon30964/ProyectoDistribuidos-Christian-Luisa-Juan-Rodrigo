#!/bin/bash

#Se recuperan las variables del entorno y se hace un split separando por ",". Se crea un string que configurara el mirror.
IFS=', ' read -r -a array <<< "${deps}"
separador=" | "
configuracion="Priority (required) | Priority (important) | Priority (standard) "
for paquete in "${array[@]}"
do
 configuracion=$configuracion$separador$paquete
done

#Se aplica la configuracion al mirror aplty y se actualiza la base de datos.
aptly mirror edit -filter="$configuracion" mirror-xenial
aptly mirror update mirror-xenial
aptly snapshot create mirror-snap-xenial from mirror mirror-xenial
#Se crea el snapshot y se publica el mirror
./aptly_expect.sh
aptly serve
