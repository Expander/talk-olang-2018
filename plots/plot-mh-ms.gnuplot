set terminal pdfcairo
set output "PlotScale-in-FH_new_low.pdf"
set xlabel "M_S / GeV"
set ylabel "M_h / GeV"
set grid
set key box bottom right
set style fill transparent solid 0.1

datafile = "PlotScale.in.FH_new_low"

plot [93:] [70:] \
     datafile u 1:2               w lines ls 1 t 'FlexibleSUSY matching M_h', \
     datafile u 1:3               w lines ls 2 t 'FlexibleSUSY matching {/Symbol l}', \
     datafile u 1:4               w lines ls 3 t 'SUSYHD', \
     datafile u 1:($4-$5):($4+$5) w filledcurves ls 3 t '', \
     datafile u 1:6               w lines ls 4 t 'FeynHiggs 2.11.3', \
     datafile u 1:($6-$7):($6+$7) w filledcurves ls 4 t '', \
     datafile u 1:8               w lines ls 5 t 'SPheno', \
     datafile u 1:9               w lines ls 6 t 'FlexibleSUSY MSSM', \
     datafile u 1:10              w lines ls 7 t 'SoftSUSY'
