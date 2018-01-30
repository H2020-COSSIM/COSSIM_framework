#!/bin/bash

# The remote_mount.sh script is used to mount a directory or file inside the GEM5 image which is placed on a remote machine.

# Copyright (c) 2018, H2020 COSSIM.
# Copyright (c) 2018, Telecommunications Systems Institute.
# Author: Tampouratzis Nikolaos, ntampouratzis@isc.tuc.gr

# It takes 6 exactly parameters (e.g.: ./remore_mount.sh ARCH fullpath/filename FILE_or_DIR IP Username Password) #
echo "Upload file or folder and mount it in appropriate GEM5 image!"
echo "Architecture : $1"
echo "Path of file : $2"
echo "FILE_or_DIR : $3"
echo "IP : $4"
echo "Username : $5"
echo "Password : $6"

ip=$4
username=$5
password=$6

export SSHPASS=$password

if [ "$3" == "FILE" ]; then
sshpass -e sftp -oBatchMode=no -b - $username@$ip << !
   mkdir incoming
   cd incoming
   put $2
!
elif [ "$3" == "DIR" ]; then
sshpass -e sftp -oBatchMode=no -b - $username@$ip << !
   mkdir incoming
   cd incoming
   mkdir ${2##*/}
   put -r $2
!
else
  echo "It takes 6 exactly parameters (e.g.: ./remore_mount.sh ARCH fullpath/filename FILE_or_DIR IP Username Password)"
fi


#mound X86 command #
a='echo '
b=$password
c=' | sudo -S mount -o loop,offset=32256 $HOME/COSSIM/kernels/disks/x86_64root.img /mnt && '
mountx86_cmd=$a$b$c

#mound X86-Ubuntu command #
a='echo '
b=$password
c=' | sudo -S mount -o loop,offset=32256 $HOME/COSSIM/kernels/disks/ubuntu-12.04.img /mnt && '
mountx86_Ubuntu_cmd=$a$b$c

#mound ARM32 command #
a='echo '
b=$password
c=' | sudo -S mount -o loop,offset=32256 $HOME/COSSIM/kernels/disks/linux-aarch32-ael.img /mnt && '
mountarm32_cmd=$a$b$c

#mound ARM32-Ubuntu command #
a='echo '
b=$password
c=' | sudo -S mount -o loop,offset=32256 $HOME/COSSIM/kernels/disks/aarch32-ubuntu-natty-headless.img /mnt && '
mountarm32_Ubuntu_cmd=$a$b$c

#mound ARM64 command #
a='echo '
b=$password
c=' | sudo -S mount -o loop,offset=32256 $HOME/COSSIM/kernels/disks/linaro-minimal-aarch64.img /mnt && '
mountarm64_cmd=$a$b$c

#mound ARM64-Ubuntu command #
a='echo '
b=$password
c=' | sudo -S mount -o loop,offset=32256 $HOME/COSSIM/kernels/disks/aarch64-ubuntu-trusty-headless.img /mnt && '
mountarm64_Ubuntu_cmd=$a$b$c

#copy command from folder incomning inside to image #
a='echo '
b=$password
c=' | sudo -S cp -R '
d='$HOME/incoming/'
e=' /mnt && '
cp_cmd=$a$b$c$d${2##*/}$e

#unmound command #
a='echo '
b=$password
c=' | sudo -S umount /mnt && rm -rf incoming'
umount_cmd=$a$b$c

if [ "$1" == "X86" ]; then
  sshpass -e ssh -t $username@$ip $mountx86_cmd$cp_cmd$umount_cmd
elif [ "$1" == "X86-Ubuntu" ]; then
  sshpass -e ssh -t $username@$ip $mountx86_Ubuntu_cmd$cp_cmd$umount_cmd
elif [ "$1" == "ARM32" ]; then
  sshpass -e  ssh -t $username@$ip $mountarm32_cmd$cp_cmd$umount_cmd
elif [ "$1" == "ARM32-Ubuntu" ]; then
  sshpass -e  ssh -t $username@$ip $mountarm32_Ubuntu_cmd$cp_cmd$umount_cmd
elif [ "$1" == "ARM64" ]; then
  sshpass -e  ssh -t $username@$ip $mountarm64_cmd$cp_cmd$umount_cmd
elif [ "$1" == "ARM64-Ubuntu" ]; then
  sshpass -e  ssh -t $username@$ip $mountarm64_Ubuntu_cmd$cp_cmd$umount_cmd
else
  echo "It takes 6 exactly parameters (e.g.: ./remore_mount.sh ARCH fullpath/filename FILE_or_DIR)"
fi

sshpass -e ssh -t $username@$ip 'rm -rf incoming'