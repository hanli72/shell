#!/bin/bash
# ************************************************************************/
#	> File Name: ssd_perfo_temp.sh
#	> Author: Tony Yang 
#	> Mail: hanli712@163.com 
#	> Created Time: 2021年01月23日 星期六 23时01分42秒
# ************************************************************************/

#$1 is for interval time setting
#$2 is for DUT name setting
#$3 is for saving file name

intervaltime=$1
devicename=$2
logfilename=$3

if [[ -z $1 ]];then
    echo please set interval time [1-10]s
    read intervaltime
    intervaltime=$intervaltime
fi
if [[ -z $2  ]];then
    echo please set device Name like /dev/nvme0n1
    read devicename
    devicename=${devicename}
fi
if [[ -z $3  ]];then
    echo please set log File Name
    read logname
    logfilename=${logname}.txt
fi

source ./time.sh
start_time

while(true)
do
#interleave time setting
#	sleep $intervaltime
	temp=`nvme smart-log ${devicename} |grep temperature |sed -n '1p' |awk -F: '{print $2}'`
#do not record IOPS, since test condition is not engouth. Tony Yang 20210130	
	Bandwith=`fio ./perf_short_depth32_1MW.job | grep WRITE: |awk '{print $3}' |awk -F")" '{print $1}' |awk -F"(" '{print $2}'`
	echo "${temp} ${Bandwith}" | tee -a ${logfilename}
	#break
    runningtime
done
