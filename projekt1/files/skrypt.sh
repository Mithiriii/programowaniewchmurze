#!/bin/bash

DATA=$(date +"Data uruchomienia: %A, %d of %B, %r")
DATA2=$(date +"%A, %d of %B, %r")
IMIE=$"Imie: Tomasz Nagrodzki"
NETSTATS=$(netstat -an --tcp --program)
echo $DATA >> file.log
echo $IMIE >> file.log
echo $NETSTATS >> file.log
chmod 777 file.log
