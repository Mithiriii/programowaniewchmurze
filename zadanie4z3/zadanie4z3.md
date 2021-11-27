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
![alt text](https://github.com/Mithiriii/programowaniewchmurze/blob/main/zadanie4z3/images/scr1.PNG "title")

# Zadanie 3
Utworzyłem volumen lokalnie komendą: docker volume create RemoteVol

# Zadanie 4
Uruchamienie kontrolera z potrzebnymi opcjami: docker run -it --name alpine4 --memory=512m --mount source=RemoteVol,target=/logi lab4docker

# Zadanie 5
Używam komendy: docker volume inspect RemoteVol <br>
Dzięki niej mogę zobaczyć ścieżkę montowania
![alt text](https://github.com/Mithiriii/programowaniewchmurze/blob/main/zadanie4z3/images/scr2.PNG "title")
I użyć komendy: cat /var/lib/docker/volumes/RemoteVol/_data/info.log  <br>
By zobaczyć zawartość pliku info.log na kosoli.
![alt text](https://github.com/Mithiriii/programowaniewchmurze/blob/main/zadanie4z3/images/scr3.PNG "title")
Żeby zobaczyć ile konener alpine4 ma pamięci ram należy użyć polecenia: docker inspect alpine4 | grep Memory <br>
Po podzieleniu liczby 536870912 na 1024^2(przechodzimy z bajtów przez kilobajty na megabajty) wychodzi nam 512MB co zgadza się z założeniem zadania.
![alt text](https://github.com/Mithiriii/programowaniewchmurze/blob/main/zadanie4z3/images/scr4.PNG "title")
Możemy jeszcze sprawdzić czy kontener na pewno zawiera plik info.log poprzez urzycie następujących komend:  <br>
docker cp alpine4:/ ./test - kopiuje filesystem z alpine4 do katalogu test <br>
ls -all test/logi/ - sprawdzam pliki w katalogu test/logi
 ![alt text](https://github.com/Mithiriii/programowaniewchmurze/blob/main/zadanie4z3/images/scr5.PNG "title")
