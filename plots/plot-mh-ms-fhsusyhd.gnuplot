set terminal pdfcairo
set output "PlotScale-in-FH_new_low-fhsusyhd.pdf"
set xlabel "M_S / GeV"
set ylabel "M_h / GeV"
set grid
set key box bottom right
set style fill transparent solid 0.1

set style line 1 lt 1 dt 1 lw 2 lc rgb "#FF0000"
set style line 2 lt 1 dt 2 lw 2 lc rgb "#0000FF"
set style line 3 lt 1 dt 4 lw 2 lc rgb "#45AD53"
set style line 4 lt 1 dt 3 lw 2 lc rgb "#FFA500"
set style line 5 lt 1 dt 5 lw 2 lc rgb "#F702E7"
set style line 6 lt 1 dt 6 lw 2 lc rgb "#00D1D1"
set style line 7 lt 1 dt 7 lw 2 lc rgb "#84D100"

datafile = "PlotScale.in.FH_new_low"

plot [93:] [70:] \
     datafile u 1:6               w lines ls 5 t 'FeynHiggs 2.11.3', \
     datafile u 1:4               w lines ls 4 t 'SUSYHD', \

     # datafile u 1:($6-$7):($6+$7) w filledcurves ls 5 t '', \
     # datafile u 1:($4-$5):($4+$5) w filledcurves ls 4 t ''
     # datafile u 1:6:7             w yerrorbars ls 5 dt 1 lw 1 t '', \
     # datafile u 1:4:5             w yerrorbars ls 4 dt 1 lw 1 t ''
