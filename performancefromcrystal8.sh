#!/bin/bash

# remove ^M in txt, ^M issue is only within log file created by DOS
#ls | while read line
#do 
#sed -i 's/\r//g' ./$line
#done

##Cygwin Terminal doesn't support running shell script, only shell command is ok
#ls | while read line; do cat $line |grep "1MiB (Q=  1, T= 1):" |awk -F: '{print $2}' |awk -F "MB/s" '{print $1}' | awk '{if(NR%3!=0)ORS=" ";else ORS="\n"}1' ; done

#ls | while read line; do cat $line |grep "4KiB (Q=  1, T= 1):" |awk -F[ '{print $2}' |awk -F "IOPS" '{print $1}' | awk '{if(NR%3!=0)ORS=" ";else ORS="\n"}1' ; done

#ls | while read line; do aa=` cat $line |grep "1MiB (Q=  1, T= 1):" |awk -F: '{print $2}' |awk -F "MB/s" '{print $1}'`; bb=` cat $line |grep "4KiB (Q=  1, T= 1):" |awk -F[ '{print $2}' |awk -F "IOPS" '{print $1}'`; echo $AA$BB; done

#collect SN MB/S IOPS from log of Crystalmark8.0 
#$1 is for block size of MB/s setting.
#S2 is for queue number of MB/s setting.
#S3 is for Thread number of MB/s setting.
#$4 is for block size of IOPS setting.
#S5 is for queue number of IOPS setting.
#S6 is for Thread number of IOPs setting.

if [ -z $blocksizieMB ];then
    echo Please input block size of MB/s like [128K, 1M ]
    read blocksizieMB
fi
if [ -z $2 ];then
    echo Please input queue number of MB/s like [1~128]
    read queueMB
fi
if [ -z $3 ];then
    echo Please input thread number of MB/s like [1~64 ]
    read threadMB
fi
if [ -z $4 ];then
    echo Please input block size of IOPS like [4K, 8K ]
    read blocksizieIOPs
fi
if [ -z $5 ];then
    echo Please input queue number of IOPs like [1~128]
    read queueIOPs
fi
if [ -z $6 ];then
    echo Please input thread number of IOPs like [1~64 ]
    read threadIOPs
fi
cd ./logcrystalmark/
echo "SN SeqR_${blocksizieMB}iB_Q${queueMB}_T${threadMB} SeqW_${blocksizieMB}iB_Q${queueMB}_T${threadMB} SeqMix_${blocksizieMB}iB_Q${queueMB}_T${threadMB} IOPsR_${blocksizieIOPs}iB_Q${queueMB}_T${threadMB} IOPsW_${blocksizieIOPs}iB_Q${queueMB}_T${threadMB} IOPsMix_${blocksizieIOPs}iB_Q${queueMB}_T${threadMB} "
ls | while read line
do 
    sn=`echo $line |awk -F. '{print $1}'`
    aa=`cat $line |grep "${blocksizieMB}iB (Q=  ${queueMB}, T= ${threadMB}): " |awk -F: '{print $2}' |awk -F "MB/s" '{print $1}'`
    bb=`cat $line |grep "${blocksizieIOPs}iB (Q=  ${queueIOPs}, T= ${threadIOPs}):" |awk -F[ '{print $2}' |awk -F "IOPS" '{print $1}'`
    echo $sn $aa $bb
done
