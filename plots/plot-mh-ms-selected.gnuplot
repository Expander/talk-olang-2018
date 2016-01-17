set terminal pdfcairo
set output "PlotScale-in-FH_new_low-selected.pdf"
set xlabel "M_S / GeV"
set ylabel "M_h / GeV"
set grid
set key box bottom right
set style fill transparent solid 0.1

set style line 1 lt 1 dt 1 lw 2 lc rgb "#FF0000"
set style line 2 lt 1 dt 2 lw 2 lc rgb "#0000FF"
set style line 3 lt 1 dt 4 lw 2 lc rgb "#45AD53"

datafile = "scale_low.dat"

plot [91:] [70:] \
     datafile u 1:2 w lines ls 1 t 'mixed', \
     datafile u 1:3 w lines ls 3 t 'diagrammatic', \
     datafile u 1:4 w lines ls 2 t 'EFT'

set output "PlotScale-in-FH_new_low-selected-TB20.pdf"
datafile = "scale_low_TB20.dat"

plot [93:] [70:] \
     datafile u 1:2 w lines ls 1 t 'mixed', \
     "< awk '{ if ($3 > 0) print }' ".datafile u 1:3 w lines ls 3 t 'diagrammatic', \
     datafile u 1:4 w lines ls 2 t 'EFT'
