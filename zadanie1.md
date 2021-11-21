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
