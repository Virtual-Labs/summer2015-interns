#!/bin/bash
#initializing variables
bit=32
bitv="x86_64"
source=".rpm"
model="Ubuntu"
extra="jdk"

#checking for system version
uname -m > vers.txt
while read -r li; do
if [ $bitv = $li ]
then 
bit=64
break;
else
break;
fi
done < vers.txt

#checking if it is ubuntu/centos
cat /etc/issue > vers.txt
while read -r li; do
if echo "$li" | grep -q "$model";then
echo "It is ubuntu machine";
break;
else 
echo "It is CentOs machine";
model="Centos"
break;
fi
done < vers.txt

#reading given text file
while read -r line; do
#printf "%s\n" "$line"

line="$line-linux"
if test $bit -eq 32
then 
line="$line-x86"
else
line="$line-x64"
fi 

if [ $model = "Ubuntu" ]
then
lback=$line
line="$line.deb"
else
lback=$line
line="$line.rpm"
fi

#Downloading and
#Installing
if [ $model = "Ubuntu" ]
then
#checking for wget installation and proxy settings
sudo apt-get install wget
export http_proxy=""
wget 10.4.15.172/$line
dpkg -i $line
success=`echo $?`

else
#checking for wget installation and proxy settings
sudo yum install wget
export http_proxy=""
wget 10.4.15.172/$line
rpm -ivh $line
success=`echo $?`
fi 
#DISPLAYING SUCCESS MSG
echo "\nSuccess = $success"

if test $success -eq 0 
then
#now to set path...
if echo "$line" | grep -q "$extra";then
echo "JAVA_HOME=/usr/lib/jvm/$lback" >> "/etc/profile"
echo "PATH=$PATH:$HOME/bin:$JAVA_HOME/bin" >> "/etc/profile"
echo "export JAVA_HOME" >> "/etc/profile" 
echo "export JRE_HOME" >> "/etc/profile"
echo "export PATH" >> "/etc/profile" 
fi
fi

done < modtxt.txt
#having old proxy
export http_proxy="http://proxy.iiit.ac.in.8080"
