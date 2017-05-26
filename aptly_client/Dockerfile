FROM httpd:2.2 

ADD files/llave_publica.asc /tmp
RUN apt-key add /tmp/llave_publica.asc
RUN rm -f /tmp/llave_publica.asc

ADD files/install_packages.sh /install_packages.sh
RUN chmod +x /install_packages.sh

RUN apt-get update
RUN apt-get install curl -y

WORKDIR /
CMD ["./install_packages.sh"]
