#+TITLE:     documentation.sh
#+AUTHOR:    samba
#+EMAIL:     psaisambasiva@gmail.com
#+DATE:      2015-07-09 Thu
#+DESCRIPTION:AUTOMATION OF SOFTWARE INSTALLATION ON LINUX MACHINE 
#+KEYWORDS: BASICALLY INSTALLS SOFTWARES specified in 'basic.txt' file
#+LANGUAGE:  en
#+OPTIONS:   H:3 num:t toc:t \n:nil @:t ::t |:t ^:t -:t f:t *:t <:t
#+OPTIONS:   TeX:t LaTeX:t skip:nil d:nil todo:t pri:nil tags:not-in-toc
#+INFOJS_OPT: view:nil toc:nil ltoc:t mouse:underline buttons:0 path:http://orgmode.org/org-info.js
#+EXPORT_SELECT_TAGS: export
#+EXPORT_EXCLUDE_TAGS: noexport
#+LINK_UP:   
#+LINK_HOME: 
#+XSLT:
#+PROPERTY: session *scratch*
#+PROPERTY: results output
#+PROPERTY: tangle <documentation.sh>
#+PROPERTY: exports code

Initializing variables

#+BEGIN_SRC sh 
#!/bin/bash
bit=32
bitv="x86_64"
source=".rpm"
model="Ubuntu"
extra="jre"
java3d="java3d"
#+END_SRC 

Setting Proxy so that it can download any updates

#+BEGIN_SRC sh
export http_proxy="proxy.iiit.ac.in:8080"
export https_proxy="proxy.iiit.ac.in:8080"
#+END_SRC 

Checking if 32-bit or 64-bit version so that it downloads required package from container hosted

#+BEGIN_SRC sh
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
#+END_SRC

checking if it is ubuntu/centos,updating,checking if wget is installed as it is requird for further commands

#+BEGIN_SRC sh
cat /etc/issue > vers.txt
while read -r li; do
if echo "$li" | grep -q "$model";then
echo "Updating this Ubuntu Machine";
sudo apt-get update
sudo apt-get install wget
break;
else 
echo "Updating this CentOs Machine";
model="Centos"
sudo yum update
sudo yum install wget
break;
fi
done < vers.txt
#+END_SRC

reading given text file for just length so that we can run while loops further

#+BEGIN_SRC sh
lineno=0
while read -r line; do
lineno=`expr $lineno + 1`
done < basic.txt
#+END_SRC

reading given text file with ith line

#+BEGIN_SRC sh
i=0 
while [ $i -lt $lineno ]; do
i=`expr $i + 1`
head -$i basic.txt | tail -1 > vers.txt
read -r line < vers.txt
#+END_SRC

checking if another version of java is previously installed?, this information is stored in java_result variable

#+BEGIN_SRC sh
java -version
java_result=`echo $?`
#+END_SRC

Decoding the required package name from given requirement software name

#+BEGIN_SRC sh
name="$line"
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
#+END_SRC

Downloading and Installing Required softwares along with their dependencies

#+BEGIN_SRC sh
if [ $model = "Ubuntu" ]
then
#Setting Proxy 
export http_proxy=""
sudo wget -r --no-parent 10.4.15.172/$line/
cd 10.4.15.172/$line/
sudo dpkg -i *.deb
success=`echo $?`
cd -
else
#Setting Proxy
export http_proxy=""
sudo wget -r --no-parent 10.4.15.172/$line/
cd 10.4.15.172/$line/
sudo yum install *.rpm
success=`echo $?`
cd -
fi 
#+END_SRC

After completion of download and install process of software, checking if the package is not properly installed due to lack of updates
and if package is Jre, setting path for java as well as java3dso that it could run applets after its reboot

#+BEGIN_SRC sh
if [ $success = 0 ]                                    
then 
 echo "INSTALLATION PROCESS OF '$name' IS DONE"
 if echo "$line" | grep -q "$java3d"
 then
 #set the path for java-3d
  if [ $model = "Ubuntu" ];then
  export CLASSPATH=".:/usr/share/java/j3dcore-1.5.2+dfsg.jar:/usr/share/java/j3dutils-1.5.2+dfsg.jar:/usr/share/java/vecmath-1.5.2.jar"
  export LD_LIBRARY_PATH="/usr/lib/jni"
  fi
 fi
 if echo "$line" | grep -q "$extra"
 then                     
  if test $java_result -eq 0                                  
  then
#+END_SRC

 Asking User to select Required Java Version if multiple java versions are detected in system and 
also setting path for successful installation of java

#+BEGIN_SRC sh
 echo " Please select $lback version "
   if [ $model = "Centos" ];then sudo alternatives --config java;else sudo update-alternatives --config java;fi
  fi                                                         
  if [ $model = "Centos" ]                                    
  then
  echo ""
  ##---------FOR_CENTOS-----------
  #now to set path...
   if echo "$line" | grep -q "jre-7"
   then
    if test $bit -eq 64;then echo "JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64" >> "/etc/profile";else echo "JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk" >> "/etc/profile";fi
   fi
   if echo "$line" | grep -q "jre-6"
   then
    if test $bit -eq 64;then echo "JAVA_HOME=/usr/lib/jvm/jre-1.6.0-openjdk.x86_64" >> "/etc/profile" else echo "JAVA_HOME=/usr/lib/jvm/jre-1.6.0-openjdk" >> "/etc/profile";fi
   fi
   echo "PATH=$PATH:$HOME/bin:$JAVA_HOME/bin" >> "/etc/profile"
   echo "export JAVA_HOME" >> "/etc/profile" 
   echo "export JRE_HOME" >> "/etc/profile"
   echo "export PATH" >> "/etc/profile"
   #-------------------------------- 
  fi
  if [ $model = "Ubuntu" ]
  then
  echo ""
  ##--------FOR_UBUNTU-------------
  #now to set path...
   if echo "$line" | grep -q "jre-6";then
    if test $bit -eq 64;then echo "JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64" >> "/etc/profile" else echo "JAVA_HOME=/usr/lib/jvm/java-6-openjdk-i386" >> "/etc/profile"; fi
   fi
   if echo "$line" | grep -q "jre-6";then
    if test $bit -eq 64;then echo "JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64" >> "/etc/profile" else echo "JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386" >> "/etc/profile"; fi
   fi
  echo "PATH=$PATH:$HOME/bin:$JAVA_HOME/jre/bin" >> "/etc/profile"
  echo "export JAVA_HOME" >> "/etc/profile" 
  echo "export JRE_HOME" >> "/etc/profile"
  echo "export PATH" >> "/etc/profile"
  #--------------------------------
  fi
 fi
else
#+END_SRC

If Software is not properly installed, removing it/installing its dependencies and updating the system

#+BEGIN_SRC sh
 echo "INSTALLING DEPENDENCIES"
 if [ $model = "Ubuntu" ]
 then
 export http_proxy="http://proxy.iiit.ac.in:8080"
 sudo apt-get -f install
 else
 export http_proxy="http://proxy.iiit.ac.in:8080"
 sudo yum update
 #sudo yum localinstall $line
 fi
 echo "INSTALLED DEPENDENCIES"
fi
done
#+END_SRC

Setting up old proxy and removing temporary files created by the script

#+BEGIN_SRC sh
export http_proxy="http://proxy.iiit.ac.in:8080"

pwd > vers.txt
read -r li < vers.txt
rm $li/vers.txt
#rm -R $line
#+END_SRC

