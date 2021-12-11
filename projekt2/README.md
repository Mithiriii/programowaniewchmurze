# OPIS
Każdy Dockerfile znajduje się w katalogu do niego stworzony <br>
Strona znajduje się w katalogu www <br>

# DOCKERFILE

Kolejne dockerfile:

```Dockerfile
FROM mysql:5.7.36
```

```Dockerfile
FROM nginx:latest
```

```Dockerfile
FROM php:7.4-fpm
```

```Dockerfile
FROM phpmyadmin/phpmyadmin:latest
```

# DOCKER-COMPOSE.YML

```yml
version : "3"                 

services:
  nginx:                      
    build: "./nginx" #budowanie z Dockerfile folderu nginx
    restart: always #sposób resetowania w wypadku awarii
    ports:                    
      - "6666:80" #wystawienie portu 6666
    networks: #przyłączenie sieci
      - frontend
      - backend
    volumes: #ustawienie wolumenów
      - ./www:/www
      - ./konfiguracja_strony.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - mysql
      - php

  php: 
    build: "./php"
    restart: always  
    networks:
      - backend
    volumes:
      - ./www:/www

  phpmyadmin:
    build: "./phpmyadmin"
    restart: always
    environment: #zmienna środowiskowa odpowiedzialna za bazę danych
      - PMA_HOST=mysql
    depends_on:
      - mysql
    networks:
      - backend
    ports:
      - "6001:80"

  mysql:
    build: "./mysql"
    restart: always
    environment: #zmienna środowiskowoa odpowiedzialna za chasło i nazwę hosta
      - MYSQL_ROOT_PASSWORD=root 
      - MYSQL_HOST=localhost
    networks:
      - backend
    volumes:
      - ./database:/var/lib/mysql 

networks: #tworzenie sieci
  backend:
  frontend:
  ```

Kod posiada niezbędne komentarze

# STRONA WWW

```php
<?php
echo ("Dziala?");
?>
```

Kod strony www

# PLIK KONFIGURACYJNY

```conf
server {
    index index.php; #strona startowa
    server_name localhost; #nazwa hosta    
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /www; #folder głowny

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}
```

# WYGENEROWANIE GRAFICZNEJ REPREZENTACJI PLIKU DOCKER-COMPOSE
Komenda:
```
Docker run --rm -it --name dcv -v ${PWD}:/input pmsipilot/docker-compose-viz render -m image docker-compose.yml --output-file=achmea.techday.png --force
```
Screen:
