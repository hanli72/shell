#!/bin/bash
#************************************************************************
#	> File Name: time.sh
#	> Author: Tony Yang 
#	> Mail: hanli712@163.com 
#	> Created Time: 2021年01月24日 星期日 10时23分56秒
# ************************************************************************

testtime_S="00"
testtime_M="00"
testtime_H="00"
#start time
function start_time(){
    echo "Program start at `date`"
    starttimes=`date +%s`
}

function runningtime(){
    runningtimes=`date +%s`
    testtime_S=$((runningtimes - starttimes))
   # testtime_S=3501
    if ((60 <= testtime_S && testtime_S < 3600));then
    #    echo run to here
        testtime_M=$((testtime_S / 60))
        testtime_S=$((testtime_S % 60))
    elif ((3600<=testtime_S));then
     #   echo run to here 1
        testtime_H=$((testtime_S / 3600))
        testtime_M=$((testtime_S % 3600 / 60))
        testtime_S=$((testtime_S %3600 % 60))
    fi
    echo -e "\033[47;30mIt taks about ${testtime_H}h:${testtime_M}m:${testtime_S}s \033[0m"
}
#runningtime
