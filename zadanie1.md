# ZADANIE 1

Został stworzony skrypt w bashu który posłużył temu zadaniu.


#!/bin/bash

TODAY=$(date +"Data uruchomienia: %A, %d of %B, %r")
FORCLIENT=$(date +"%A, %d of %B, %r")
IMIE=$"Imie: Tomasz Nagrodzki"

echo $TODAY >> file.log
echo $IMIE >> file.log
netstat -tulpn | grep LISTEN >> file.log
ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(.\d+){3}' >> index.html
chmod 777 file.log
chmod 777 index.html
echo $FORCLIENT >> index.html



FROM php:7.0-apache AS ProjektApp

LABEL author="Tomasz Nagrodzki"
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    net-tools \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY skrypt.sh project/skrypt.sh
RUN ["project/skrypt.sh"]
EXPOSE 80
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
