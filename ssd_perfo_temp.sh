#!/bin/bash
# ************************************************************************/
#	> File Name: ssd_perfo_temp.sh
#	> Author: Tony Yang 
#	> Mail: hanli712@163.com 
#	> Created Time: 2021年01月23日 星期六 23时01分42秒
# ************************************************************************/

intervaltime=$1
devicename=$2
logfilename=$3

if [[ -z $1 ]];then
    echo please set interval time [1-10]s
    read intervaltime
    intervaltime=$intervaltime
fi
if [[ -z $2  ]];then
    echo please set device Name
    read devicename
    devicename=${devicename}
fi
if [[ -z $3  ]];then
    echo please set log File Name
    read logname
    logfilename=${logname}.txt
fi

source ./shell_function/time.sh
start_time

while(true)
do
#interleave time setting
	sleep $intervaltime
    runningtime
done
