#!/bin/bash

rm temp
rm ram
rm cpu
rm disks
rm processes

writedata() {
while true; do
 echo -e $(date +"%H:%M:%S")"\t"$(sensors | grep "Package id" | tail -2 | awk '{ print $4 }' | sed 's/+//g'| sed 's/°C//g'| awk '{ print $ 1 }' | head -1 | sed 's/.0//g') >> temp
 echo -e $(date +"%H:%M:%S")"\t"$(free -mh | sed -n 2p | awk '{ print $3 }' | sed 's/Gi//g' | sed 's/,/./g') >> ram
 echo -e $(date +"%H:%M:%S")"\t"$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat) | sed 's/%//g' | sed 's/,/./g') >> cpu
 echo -e $(date +"%H:%M:%S")"\t"$(df -H | grep -vE '^Filesystem|tmpfs|cdrom|loop|udev' | awk '{ print $5 " " $1 }' | awk '{ print $1 }' | sed 's/%/ /g' | tr -d '\n') >> disks
 echo -e $(date +"%H:%M:%S")"\t"$(ps -e | wc -l) >> processes
 sleep 3 
done 
}

writedata &
sleep 1
gnuplot liveplot.gnu
