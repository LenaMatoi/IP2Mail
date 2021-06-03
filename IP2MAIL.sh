#!/bin/bash
#lenamatoi.net
#se crea el archivo donde almacena la ip publica actual
EXT_IP_FILE="/home/lena/work/iphoy"
timestamp=$( date +%T )
curDate=$( date +"%d-%m-%y" )
#dime cual es la IP publica
CURRENT_IP=`wget -q -O - checkip.dyndns.org|sed -e 's/.*IP ACTUAL: //' -e 's/<.*$//'`

#comprobamos si el archivo existe y se saca la IP que hay guardada
if [ -f $EXT_IP_FILE ]; then
   KNOWN_IP=$(cat $EXT_IP_FILE)
else
   #si no hay tal archivo se hace uno nuevo y se guarda la IP actual
   KNOWN_IP= touch iphoy
   KNOWN_IP=$(cat $EXT_IP_FILE)
fi

#comprobamos si la IP ha cambiado de la que esta guardada
if [ "$CURRENT_IP" != "$KNOWN_IP" ]; then
   echo $CURRENT_IP > $EXT_IP_FILE
   #si la IP cambia se manda un correo con la nueva IP
   mail -s "RPI" tucorreo@dominio.net < $EXT_IP_FILE
   #aqui se va guardar el archivo log
   echo $curDate $timestamp "* TU NUEVA IP: " $(< $EXT_IP_FILE) >> log.txt  
fi
