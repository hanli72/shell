#!/bin/bash

# remove ^M in txt, ^M issue is only within log file created by DOS
#ls | while read line
#do 
#sed -i 's/\r//g' ./$line
#done

#collect smart info for MB NVMe SSD
cd ./logsmart/
ls | while read line
do 
sn=`echo $line |awk -F_ '{print $1}'`
mpn=` cat $line |grep "Model Number:" |awk -F: '{print $2}'`
fw=` cat $line |grep "Firmware Version:" |awk -F: '{print $2}'`
VID=` cat $line |grep "PCI Vendor/Subsystem ID:" |awk -F: '{print $2}'`
SVID=` cat $line |grep "PCI Vendor/Subsystem ID:" |awk -F: '{print $2}'`
Totalcap=` cat $line |grep "Total NVM Capacity:" |awk -F[ '{print $2}' |awk -F] '{print $1}' |sed 's/ //g'`
usercap=` cat $line |grep "Namespace 1 Size/Capacity:" |awk -F[ '{print $2}'|awk -F] '{print $1}' |sed 's/ //g'`
MNSQTY=` cat $line |grep "Number of Namespaces:" |awk -F: '{print $2}'`
LBASIZE=` cat $line |grep "LBA Size:" |awk -F: '{print $2}'`
EUI64=` cat $line |grep "IEEE EUI-64:" |awk -F: '{print $2}' |sed 's/ //g'`
Criticalwar=` cat $line |grep "Critical Warning:" |awk -F: '{print $2}'`
datewritten=` cat $line |grep "Data Units Written:" |awk -F[ '{print $2}' |awk -F] '{print $1}' |sed 's/ //g'`
mediaerror=` cat $line |grep "Media and Data Integrity Errors:" |awk -F: '{print $2}'`
errorlogenter=` cat $line |grep "No Errors Logged" |wc -l`
errorlogenter1=$((${errorlogenter} -1))
echo $sn $mpn $fw $VID $SVID $Totalcap $usercap $MNSQTY $LBASIZE ${EUI64} ${Criticalwar} $datewritten $mediaerror $errorlogenter1
done
