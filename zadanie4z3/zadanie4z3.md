#Zadanie 1

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
