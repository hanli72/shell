#!/bin/bash
# ************************************************************************/
#	> File Name: ssd_perfo_temp.sh
#	> Author: Tony Yang 
#	> Mail: hanli712@163.com 
#	> Created Time: 2021年01月23日 星期六 23时01分42秒
# ************************************************************************/


# $1 is for interval time setting.
# $2 is for SSD device name /dev/xxx
# $3 is for file name setting
filename=$2
source ./shell_function/time.sh
start_time

while(true)
do
#interleave time setting
	sleep $1
    runningtime
done
