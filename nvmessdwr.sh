#!/bin/bash
# ************************************************************************/
#	> File Name: nvmessdwr.sh
#	> Author: Tony Yang 
#	> Mail: hanli712@163.com 
#	> Created Time: 2021年02月10日 星期三 21时04分59秒
# ************************************************************************/

ddwritefile=ddwrite.txt
readssdfile=readssd.txt
source ./time.sh
start_time

if [ -z $1 ];then
    echo "please input the device for testing"
    read devicessd
    echo "the device will be tested is $devicessd"
else
    devicessd=$1
    echo "the device will be tested is $devicessd"
fi 
if [ -z $2 ];then
    #echo "please input the LBA count for testing"
    #read lbacount
    avlba=`nvme id-ns $devicessd |grep ncap |awk -F: '{print $2}'`
    echo "The availabe LBA is $avlba"
    lbacount=$((avlba-0xff))
    echo "$lbacount LBA will be tested"
#    exit 1
else
    lbacount=$2
    echo "$lbacount LBA will be tested"
fi 

dd if=/dev/urandom of=$ddwritefile bs=128k count=1

for ((i=0; i<${lbacount}; i+=255))
do
nvme write $devicessd -s $i -c 255 -z 128k -d ./$ddwritefile
nvme read $devicessd -s $i -c 255 -z 128k -d ./$readssdfile
diff $ddwritefile $readssdfile
if [ $? -ne 0 ];then
    echo -e "\033[41;37mData verify error at LBA $i to $((i+255)): \033[0m"
    exit 1
else
    echo -e "\033[42;37mData verify pass at LBA $i to $((i+255)) \033[0m"
fi
let i+=1
#echo "i is $i"
done
runningtime
