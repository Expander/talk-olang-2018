set terminal pdfcairo
set output "PlotXt.pdf"
set xlabel "X_t / M_S"
set ylabel "M_h / GeV"
set grid
set key box top left
set style fill transparent solid 0.1

set style line 1 lt 1 dt 1 lw 1 lc rgb "#FF0000"
set style line 2 lt 1 dt 2 lw 1 lc rgb "#0000FF"
set style line 3 lt 1 dt 4 lw 1 lc rgb "#45AD53"
set style line 4 lt 1 dt 3 lw 2 lc rgb "#FAA20A"
set style line 5 lt 1 dt 5 lw 1 lc rgb "#F702E7"

datafile = "PlotXt.in"

plot [:] [:] \
     datafile u 1:2               w lines ls 1 t 'FlexibleSUSY matching M_h', \
     datafile u 1:3               w lines ls 2 t 'FlexibleSUSY matching {/Symbol l}', \
     datafile u 1:6               w lines ls 3 t 'FeynHiggs 2.11.3', \
     datafile u 1:($6-$7):($6+$7) w filledcurves ls 3 t '', \
     datafile u 1:4               w lines ls 4 t 'SUSYHD', \
     datafile u 1:($4-$5):($4+$5) w filledcurves ls 4 t '', \
     "< awk '{ if ($9 > 0) print }' ".datafile u 1:9 w lines ls 5 t 'FlexibleSUSY/MSSM'

#      datafile u 1:8               w lines ls 5 t 'SPheno', \
#      datafile u 1:10              w lines ls 7 t 'SoftSUSY'
