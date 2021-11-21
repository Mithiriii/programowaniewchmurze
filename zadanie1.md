#OPIS
Wszystkie screeny zostały umieszczone w folderze https://github.com/Mithiriii/programowaniewchmurze/tree/main/images
Wszystkie pliki zostały umieszczone w folderze https://github.com/Mithiriii/programowaniewchmurze/tree/main/files

# ZADANIE 1

Został stworzony skrypt w bashu który posłużył do stworzenia pliku file.log zawierający logi.

```bash
#!/bin/bash

DATA=$(date +"Data uruchomienia: %A, %d of %B, %r")
IMIE=$"Imie: Tomasz Nagrodzki"
NETSTATS=$(netstat -an --tcp --program)
echo $DATA >> file.log
echo $IMIE >> file.log
echo $NETSTATS >> file.log
chmod 777 file.log
```
Użyte zostały podstawowe funkcje linuxa.
W pliku html użyłem javascript by nie używać niczego dodatkowego po stronie serwera. Skrypt wykonuje się po stronie klienta.
Plik html wygląda następująco:
```html
<html>
<head>
<script src=
"https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">
    </script>

    <script>

        $.getJSON("https://api.ipify.org?format=json",
                                          function(data) {

            // Setting text of element P with id gfg
            $("#gfg").html(data.ip);
        })
</script>
</head>
<body>

<p id="gfg"></p>
<p id="output"></p>

<script>
var today = new Date();
	var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
	var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
	var dateTime = date+' '+time;
	document.getElementById('output').innerHTML = dateTime;
</script>

</body>
</html>
```

# ZADANIE 2

```Dockerfile
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
```
Podczas budowania pliku dodałem etykiete author wskazującą moje imię i nazwisko. Bazowym obrazem jest httpd:2.4, doinstalowałem net-tools które były potrzebne do użycia w skrypcie. Kopiuję skrypt do folderu projekt a plik index do htdocs które służy za publiczny folder do indexu. Ustawiam port na 433, konfiguruje nazwę serwera i koniec końców uruchamiam skrypt. Ważne jest żeby skrypt.sh oraz Dockerfile znajdowały się w tym samym folderze.

# ZADANIE 3

a) W folderze z Dockerfile należy użyć polecenia: docker build -t <nazwa_obrazu> . <br>
b) Używamy polecenia w konsoli: docker run -dit --name <nazwa_kontenera> -p 443:80 <nazwa_obrazu> <br>
c) W konsoli używamy polecenia: docker exec -it <nazwa_obrazu> /bin/bash <br>
W kolejnym kroku używamy: cat file.log <br>
d) Używamy polecenia: docker inspect <nazwa_obrazu> | jq '.[] .RootFS' <br>
![alt text](https://github.com/Mithiriii/programowaniewchmurze/blob/main/images/screen1.PNG "title")
