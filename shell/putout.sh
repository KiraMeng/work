#!/bin/sh
#Use to copyfile to you computer 
#
#History:
#	2017.09.23 Kira.Meng first release
#

#data
SERVER='cvdip02.adayoge.com'
server_path='\pc_public'
user_name=''
password=''

if [ 1 -gt $# ]; then
	echo "ERROR 1.1:PLEASE INPUT FILE"
	exit 0
fi
#exclude source file
for i in $*
do
	if [ "${i##*.}" == "c" ]||\
		[ "${i##*.}" == "h" ]||\
		[ "${i##*.}" == "java" ]||\
		[ "${i##*.}" == "mk" ]||\
		[ "${i##*.}" == "Makefile" ]||\
		[ "${i##*.}" == "sh" ]||\
		[ "${i##*.}" == "hpp" ]||\
		[ "${i##*.}" == "s" ]||\
		[ "${i##*.}" == "cpp" ]; then
		echo "error 1.2:Cant put source file"
		exit 0
	fi
done
#get IP
ip=$(ping $SERVER -s 1 -c 1|grep $SERVER|head -n 1|cut -d'(' -f 2|cut -d')' -f 1)
#delete file
smbclient -c "cd android_BSP;rm $USER\\*" //$ip$server_path -U $user_name%$password
#copy file
smbclient -c "cd android_BSP;mkdir $USER;cd $USER;prompt;mput $*" //$ip$server_path -U $user_name%$password

