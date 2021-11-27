# Zadanie 1

plik pluto.sh

```bash
#!/bin/bash

DATA=$(date +"Data utworzenia: %A, %d of %B, %r")
echo $DATA > /logi/info.log
cat /sys/fs/cgroup/memory/memory.usage_in_bytes  | awk '{ byte =$1 /1024/1024; print "Zuzycie pamieci: " byte " MB" }' >> /logi/info.log
```

plik Dockerfile

```Dockerfile
FROM alpine
LABEL autor="Tomasz Nagrodzki"
WORKDIR /usr/src/app
VOLUME [ "/logi" ]
COPY pluto.sh pluto.sh
ENTRYPOINT [ "sh","./pluto.sh" ]
```

W pliku pluto.sh kolejno ustawiamy zmienną DATA po czym ją drukujemy na konsoli i efekt tego wysyłamy do pliku /logi/info.log. Później sprawdzamy zużytej pamięci. <br>
W pliku Dockerfile kolejno wskazujemy z jakiego obrazu korzystamy, ustawiłem labela autor z moim imieniem i nazwisko. Trzecia linijka to utworzenie katalogu roboczego, wskazujemy który folder będzie volumenem. Kopiujemy skrypt pluto.sh i ustawiamy uruchomienie skryptu gdy kontener ruszy.

# Zadanie 2
Do zbudowania obrazu używamy komendy: docker build -t lab4docker .
