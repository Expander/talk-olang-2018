set terminal pdfcairo
set output "PlotScale-in-FH_new_low-notower.pdf"
set xlabel "M_S / GeV"
set ylabel "M_h / GeV"
set grid
set key box bottom right width -1
set style fill transparent solid 0.1

set style line 1 lt 1 dt 1 lw 2 lc rgb "#FF0000"
set style line 2 lt 1 dt 2 lw 2 lc rgb "#0000FF"
set style line 3 lt 1 dt 4 lw 2 lc rgb "#45AD53"
set style line 4 lt 1 dt 1 lw 2 lc rgb "#0000FF"
set style line 5 lt 1 dt 5 lw 2 lc rgb "#F702E7"
set style line 6 lt 1 dt 6 lw 2 lc rgb "#00D1D1"
set style line 7 lt 1 dt 1 lw 2 lc rgb "#45AD53"

datafile = "scale_low_TB5.dat"

plot [91:] [70:] \
     datafile u 1:3 w lines ls 3 t 'full model 2L', \
     datafile u 1:4 w lines ls 2 t 'EFT 2L'

set output "PlotScale-in-FH_new_low-notower-ss-susyhd.pdf"

datafile2 = "PlotScale.in.FH_new_low"
datafileSUSYHD = "susyhd_high_TB5.dat"
#set logscale x

plot [91:1000] [70:] \
     datafile u 1:3 w lines ls 3 t 'full model 2L', \
     datafile u 1:4 w lines ls 2 t 'EFT 2L', \
     datafile2 u 1:10 w lines ls 7 t 'SoftSUSY 3.6.2', \
     datafileSUSYHD u 1:2  w lines ls 4 t 'SUSYHD 1.0.2'

     # datafile2 u 1:4  w lines ls 4 t 'SUSYHD 1.0.2'
     # datafileSUSYHD u 1:2  w lines ls 4 t 'SUSYHD 1.0.2'
     # datafile2 u 1:($4-$5):($4+$5) w filledcurves ls 4 t '', \
