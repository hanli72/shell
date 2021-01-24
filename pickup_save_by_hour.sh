#!/bin/bash
#************************************************************************
#	> File Name: pickup_save_by_hour.sh
#	> Author: Tony Yang 
#	> Mail: hanli712@163.com 
#	> Created Time: 2021年01月24日 星期日 20时16分44秒
# ************************************************************************

#$1 is for filename definition which will be parsing and saving by hour
filename=""
if [ -z $1 ];then
    echo Please input file name which need parsing and save by hour
    read filename
fi
while read line
do
    monthis=`echo $line |awk '{print $1}' `
    dayis=`echo $line |awk '{print $2}' `
    houris=`echo $line |awk '{print $3}' |awk -F: '{print $1}'`
   # echo "the houris $houris"
   # echo the hournew is ${houris:0:1} 
    if(( ${houris:0:1} == 0 )) ;then
        hournew=${houris:1:1}
        #echo the hournew is $hournew
    else
        hournew=$houris
    fi
    hourold=$hournew
    #echo "the old is $hourold and the new is $hournew"
    if(($hournew > $hourold));then
        echo "$line " >> ./log/${monthis}_${dayis}_${hournew}.txt
    else
        echo "$line" >> ./log/${monthis}_${dayis}_${hourold}.txt
    fi
done < ./$filename

