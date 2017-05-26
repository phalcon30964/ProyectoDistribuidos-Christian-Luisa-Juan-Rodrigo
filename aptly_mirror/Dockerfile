#Base image used
FROM ubuntu:16.04 

#Importar la llave privada al repositorio local.
ADD /files/llave_privada.asc /llave_privada.asc
RUN gpg --import /llave_privada.asc
RUN rm -f /llave_privada.asc
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/ubuntu-archive-keyring.gpg --export | gpg --no-default-keyring --keyring trustedkeys.gpg --import

#Se modifica la configuracion de aplty
ADD /files/aptly.conf /etc/aptly.conf

#Se adicionan repositorios necesarios para cargar las dependencias de aptly
RUN echo deb http://repo.aptly.info/ squeeze main > /etc/apt/sources.list
RUN echo deb http://co.archive.ubuntu.com/ubuntu/ xenial main restricted >> /etc/apt/sources.list
RUN echo deb http://co.archive.ubuntu.com/ubuntu/ xenial universe >> /etc/apt/sources.list
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 9E3E53F19C7DE460
RUN apt-get update

#Se instala aptly y sus dependencias
RUN apt-get install aptly -y && \
    apt-get install xz-utils -y && \
    apt-get install bzip2 -y && \
    apt-get install expect -y 

#Se configura aplty
RUN aptly mirror create -architectures=amd64 -filter='Priority (required) | Priority (important) | Priority (standard) ' -filter-with-deps mirror-xenial http://mirror.upb.edu.co/ubuntu/ xenial main
RUN aptly mirror update mirror-xenial

#Se utiliza expect para crear los snapshots. Se crea un script para recibir el array de variables y configurar el mirror con ellas.
ADD /files/aptly_expect.sh /aptly_expect.sh
ADD /files/configuracion_mirror.sh /configuracion_mirror.sh

#Se otorgan permisos de ejecucion.
RUN chmod +x /aptly_expect.sh
RUN chmod +x /configuracion_mirror.sh

#El siguiente script edita la configuracion del mirror , luego llama a aptly_expect y crea los snapshots y publica el servidor aplty.
CMD ["./configuracion_mirror.sh"]
