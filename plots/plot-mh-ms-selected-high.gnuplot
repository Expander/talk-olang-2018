set terminal pdfcairo
set output "PlotScale-in-FH_new_low-selected-high.pdf"
set xlabel "M_S / TeV"
set ylabel "M_h / GeV"
set grid
set key box bottom right
set style fill transparent solid 0.1

set style line 1 lt 1 dt 1 lw 2 lc rgb "#FF0000"
set style line 2 lt 1 dt 2 lw 2 lc rgb "#0000FF"
set style line 3 lt 1 dt 4 lw 2 lc rgb "#45AD53"

set logscale x

datafile = "scale_high_TB5.dat"

plot [0.091:] [70:] \
     datafile u ($1/1000):2 w lines ls 1 t 'automatic EFT 1L', \
     "< awk '{ if ($3 > 0) print }' ".datafile u ($1/1000):3 w lines ls 3 t 'full model 2L', \
     datafile u ($1/1000):4 w lines ls 2 t 'EFT 2L'

set output "PlotScale-in-FH_new_low-selected-high-TB20.pdf"
datafile = "scale_high_TB20.dat"

plot [0.091:] [70:] \
     datafile u ($1/1000):2 w lines ls 1 t 'automatic EFT 1L', \
     "< awk '{ if ($3 > 0) print }' ".datafile u ($1/1000):3 w lines ls 3 t 'full model 2L', \
     datafile u ($1/1000):4 w lines ls 2 t 'EFT 2L'

set output "PlotScale-in-FH_new_low-selected-high-TB5-Xtsqrt6.pdf"
datafile = "scale_high_TB5_Xtsqrt6.dat"

plot [0.091:] [70:] \
     datafile u ($1/1000):2 w lines ls 1 t 'automatic EFT 1L', \
     "< awk '{ if ($3 > 0) print }' ".datafile u ($1/1000):3 w lines ls 3 t 'full model 2L', \
     datafile u ($1/1000):4 w lines ls 2 t 'EFT 2L'

set output "PlotScale-in-FH_new_low-selected-high-TB20-Xtsqrt6.pdf"
datafile = "scale_high_TB20_Xtsqrt6.dat"

plot [0.091:] [70:] \
     datafile u ($1/1000):2 w lines ls 1 t 'automatic EFT 1L', \
     "< awk '{ if ($3 > 0) print }' ".datafile u ($1/1000):3 w lines ls 3 t 'full model 2L', \
     datafile u ($1/1000):4 w lines ls 2 t 'EFT 2L'
