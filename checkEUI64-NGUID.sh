#!/bin/bash
while read line
do
RowNum=`ls ${line}* |wc -l`
#check if the test log based on giving  MB 's SN is exist
# = 0, means no log 
if [ ${RowNum} -eq 0 ];then
	NLSN=null
	MPN=null
	Nguid=null
	Eui64=null
	MBSN=$line
	FW=null
	echo "${MBSN} ${NLSN} ${MPN} ${FW} ${Eui64} ${Nguid}"
elif [ $RowNum -eq 1 ];then
	NLSN=`cat ${line}*.txt |grep "The NETLIST SN" |awk -F: '{print $2}'|wc -l`
	if [ $NLSN -eq 0 ];then
	NLSN=null
	else
	NLSN=`cat ${line}*.txt |grep "The NETLIST SN" |awk -F: '{print $2}'`
	fi
	MPN=`cat ${line}*.txt |grep "Model Number: " |awk -F: '{print $2}'|sed 's/ //g'|wc -l`
	if [ $MPN -eq 0 ];then
	MPN=null
	else
	MPN=`cat ${line}*.txt |grep "Model Number: " |awk -F: '{print $2}'|sed 's/ //g'`
	fi
    Nguid=`cat ${line}*.txt| grep "nguid" |awk -F: '{print $2}'|wc -l`
	if [ $Nguid -eq 0 ];then
	Nguid=null
	else
    Nguid=`cat ${line}*.txt| grep "nguid" |awk -F: '{print $2}'`
	fi	
	Eui64=`cat ${line}*.txt| grep "eui64" |awk -F: '{print $2}'|wc -l`
	if [ $Eui64 -eq 0 ];then
	Eui64=null
	else
	Eui64=`cat ${line}*.txt| grep "eui64" |awk -F: '{print $2}'`
	fi	
    MBSN=`cat ${line}*.txt| grep "Serial Number:" |awk -F: '{print $2}'|sed 's/ //g'|wc -l`
	if [ $MBSN -eq 0 ];then
	MBSN=null
	else
    MBSN=`cat ${line}*.txt| grep "Serial Number:" |awk -F: '{print $2}'|sed 's/ //g'`
	fi	
    FW=`cat ${line}*.txt| grep "Firmware Version: " |awk -F: '{print $2}'|sed 's/ //g'|wc -l`
	if [ $FW -eq 0 ];then
	FW=null
	else
    FW=`cat ${line}*.txt| grep "Firmware Version: " |awk -F: '{print $2}'|sed 's/ //g'`
	fi	
	echo "${MBSN} ${NLSN} ${MPN} ${FW} ${Eui64} ${Nguid}"
elif [ $RowNum -gt 20 ];then
	break
else 
	DupNum=0
	for file in `ls ${line}*`
	do
	#echo "the DupNum is $DupNum "
	file[${DupNum}]=$file
	#display latest file name.
	#echo "the DupNum is $DupNum "
	#echo "the file name is ${file[${DupNum}]} \n"
	#echo "the file name is ${file[0]} \n"
	#ehco and break at here can't use 2 table, otherwise, error happend, don't know the reason.
	#echo "the file name is ${file[${DupNum}]} \n"
#adding done at here to echo last duplicated SN log
	done
	NLSN=`cat ${file[${DupNum}]} |grep "The NETLIST SN" |awk -F: '{print $2}'|wc -l`
	if [ $NLSN -eq 0 ];then
	NLSN=null
	else
	NLSN=`cat ${file[${DupNum}]} |grep "The NETLIST SN" |awk -F: '{print $2}'`
	fi
	MPN=`cat ${file[${DupNum}]} |grep "Model Number: " |awk -F: '{print $2}'|sed 's/ //g'|wc -l`
	if [ $MPN -eq 0 ];then
	MPN=null
	else
	MPN=`cat ${file[${DupNum}]} |grep "Model Number: " |awk -F: '{print $2}'|sed 's/ //g'`
	fi
    Nguid=`cat ${file[${DupNum}]}| grep "nguid" |awk -F: '{print $2}'|wc -l`
	if [ $Nguid -eq 0 ];then
	Nguid=null
	else
    Nguid=`cat ${file[${DupNum}]}| grep "nguid" |awk -F: '{print $2}'`
	fi	
	Eui64=`cat ${file[${DupNum}]}| grep "eui64" |awk -F: '{print $2}'|wc -l`
	if [ $Eui64 -eq 0 ];then
	Eui64=null
	else
	Eui64=`cat ${file[${DupNum}]}| grep "eui64" |awk -F: '{print $2}'`
	fi	
    MBSN=`cat ${file[${DupNum}]}| grep "Serial Number:" |awk -F: '{print $2}'|sed 's/ //g'|wc -l`
	if [ $MBSN -eq 0 ];then
	MBSN=null
	else
    MBSN=`cat ${file[${DupNum}]}| grep "Serial Number:" |awk -F: '{print $2}'|sed 's/ //g'`
	fi	
    FW=`cat ${file[${DupNum}]}| grep "Firmware Version: " |awk -F: '{print $2}'|sed 's/ //g'|wc -l`
	if [ $FW -eq 0 ];then
	FW=null
	else
    FW=`cat ${file[${DupNum}]}| grep "Firmware Version: " |awk -F: '{print $2}'|sed 's/ //g'`
	fi	
	DupNum=$((${DupNum} + 1))
	echo "${MBSN} ${NLSN} ${MPN} ${FW} ${Eui64} ${Nguid}"
	#add ing done at here to echo each duplicated SN log
	#done
fi

done <./log.txt
