 #!/bin/bash
#initializing variables
bit=32
bitv="x86_64"
source=".rpm"
model="Ubuntu"
extra="jdk"

#setting proxy details
export http_proxy="http://proxy.iiit.ac.in:8080"
export https_proxy="http://proxy.iiit.ac.in:8080"

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
echo "It is Ubuntu Machine"
#checking for updates and wget installation
sudo apt-get update
sudo apt-get install wget
break;
else
echo "It is CentOs Machine"
#checking for updates and wget installation
sudo yum update
sudo yum install wget
model="Centos"
break;
fi
done < vers.txt

#reading given text file for just length
lineno=0
while read -r line; do
lineno=`expr $lineno + 1`
done < basic.txt

#reading given text file with nth line /////////////////////////////////WHILE LOOP BEGINS//////////////////////////////////////////////////////
i=0
while [ $i -lt $lineno ]; do
i=`expr $i + 1`
head -$i basic.txt | tail -1 > vers.txt
read -r line < vers.txt
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
line="$line-u"
else
lback=$line
line="$line-c"
fi

#Downloading and
#Installing
if [ $model = "Ubuntu" ]
then
#checking for proxy settings
export http_proxy=""
wget -r --no-parent 10.4.15.172/$line/
cd 10.4.15.172/$line/
dpkg -i *.deb
success=`echo $?`
cd -
else
#checking for proxy settings
export http_proxy=""
wget -r --no-parent 10.4.15.172/$line/
cd 10.4.15.172/$line/
rpm -ivh *.rpm
success=`echo $?`
cd -
fi
#DISPLAYING SUCCESS MSG
#echo "\nSuccess = $success"

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
else
echo "------------------------------------------INSTALLING DEPENDENCIES---------------------------------"

if [ $model = "Ubuntu" ]
then
export http_proxy="http://proxy.iiit.ac.in:8080"
sudo apt-get -f install
export http_proxy=""
else
export http_proxy="http://proxy.iiit.ac.in:8080"
#sudo yum localinstall $line
sudo yum update
export http_proxy=""
fi

echo "------------------------------------------INSTALLED DEPENDENCIES-----------------------------------"

fi

done

#////////////////////////////////////////////////////WHILE LOOP ENDS///////////////////////////////////////////////

#having old proxy
export http_proxy="http://proxy.iiit.ac.in:8080"



pwd > vers.txt
read -r li < vers.txt
rm $li/vers.txt
#rm -R $line                                                                                                                   1,1           Top
