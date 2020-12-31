
##Cygwin Terminal doesn't support running shell script, only shell command is ok
#!/bin/bash



ls | while read line; do cat $line |grep "1MiB (Q=  1, T= 1):" |awk -F: '{print $2}' |awk -F "MB/s" '{print $1}' | awk '{if(NR%3!=0)ORS=" ";else ORS="\n"}1' ; done


ls | while read line; do cat $line |grep "4KiB (Q=  1, T= 1):" |awk -F[ '{print $2}' |awk -F "IOPS" '{print $1}' | awk '{if(NR%3!=0)ORS=" ";else ORS="\n"}1' ; done



ls | while read line; do aa=` cat $line |grep "1MiB (Q=  1, T= 1):" |awk -F: '{print $2}' |awk -F "MB/s" '{print $1}'`; bb=` cat $line |grep "4KiB (Q=  1, T= 1):" |awk -F[ '{print $2}' |awk -F "IOPS" '{print $1}'`; echo $aa$bb; done


cd ./crystalmark
ls | while read line
do 
	aa=` cat $line |grep "1MiB (Q=  1, T= 1):" |awk -F: '{print $2}' |awk -F "MB/s" '{print $1}'`
	bb=` cat $line |grep "4KiB (Q=  1, T= 1):" |awk -F[ '{print $2}' |awk -F "IOPS" '{print $1}'`
	echo $aa$bb
done