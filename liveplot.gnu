set multiplot layout 2,3
#set yrange [0:100]
set xdata time
set timefmt "%H:%M:%S" 
set format x "%H:%M"
set xtics 1*60 rotate by -90
set yrange [0:100]
set title "CPU temperatures" 
plot "temp" u 1:2 w l lw 4 notitle
set yrange [0:16]
set title "Memory Usage"
plot "ram" u 1:2 w l lw 4 notitle
set yrange [0:100]
set title "CPU Usage"
plot "cpu" u 1:2 w l lw 4 notitle
set yrange [0:100]
set title "Disks Usage"
plot "disks" u 1:2 w l lw 4 notitle, "disks" u 1:3 w l lw 4 notitle, "disks" u 1:4 w l lw 4 notitle
set yrange[0:400]
set title "Running Processes"
plot "processes" u 1:2 w l lw 4 notitle
pause 10
reread
unset multiplot

