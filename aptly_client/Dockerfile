FROM httpd:2.2 

#Se agrega la llave publica correspondiente al mirror creado en el contenedor aptly 
ADD files/llave_publica.asc /tmp
RUN apt-key add /tmp/llave_publica.asc
RUN rm -f /tmp/llave_publica.asc

#Se instalan los paquetes. Install_packages es un escript que comprueba que el contenedor mirror este disponible antes de descargar los paquetes.
RUN apt-get update
RUN apt-get install curl -y
ADD files/install_packages.sh /install_packages.sh
RUN chmod +x /install_packages.sh

#Se corre la instalacion de los paquetes.
WORKDIR /
CMD ["./install_packages.sh"]
