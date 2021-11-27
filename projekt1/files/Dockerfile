FROM httpd:2.4 AS ProjektApp

LABEL author="Tomasz Nagrodzki"

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    net-tools \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
COPY skrypt.sh projekt/skrypt.sh
COPY index.html /usr/local/apache2/htdocs/
EXPOSE 443
RUN echo "ServerName localhost" >> /usr/local/apache2/conf/httpd.conf
RUN ["projekt/skrypt.sh"]
