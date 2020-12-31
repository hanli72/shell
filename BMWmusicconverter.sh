#!/bin/bash

Dir1="Ripped"
for ((i=47; i<=47; i++))
do
Dir2=$Dir1$i
cd /home/Music/$Dir2
for f in *
do
bmwconv "$f"
done
mv /home/Music/$Dir2/*.mp3 /home/Music1/$Dir2/
done
echo "converting is completed now."