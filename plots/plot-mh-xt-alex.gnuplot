set terminal pdfcairo
set xlabel "X_t / M_S"
set ylabel "M_h / GeV"
set grid
set key box top left
set style fill transparent solid 0.1

set style line 1 lt 1 dt 1 lw 2 lc rgb "#FF0000"
set style line 2 lt 1 dt 2 lw 2 lc rgb "#0000FF"
set style line 3 lt 1 dt 4 lw 2 lc rgb "#45AD53"
set style line 4 lt 1 dt 3 lw 2 lc rgb "#FAA20A"
set style line 5 lt 1 dt 5 lw 2 lc rgb "#F702E7"

set output "Xt_TB5_MS1000.pdf"
datafile = "Xt_TB5_MS1000.dat"

plot [:] [:] \
     datafile u 1:2 w lines ls 1 t 'automatic EFT 1L', \
     datafile u 1:4 w lines ls 2 t 'EFT 2L', \
     datafile u 1:3 w lines ls 3 t 'full model 2L'

set output "Xt_TB5_MS10000.pdf"
datafile = "Xt_TB5_MS10000.dat"

plot [:] [:] \
     datafile u 1:2 w lines ls 1 t 'automatic EFT 1L', \
     datafile u 1:4 w lines ls 2 t 'EFT 2L', \
     datafile u 1:3 w lines ls 3 t 'full model 2L'

set output "Xt_TB20_MS2000.pdf"
datafile = "Xt_TB20_MS2000.dat"

plot [:] [:] \
     datafile u 1:2 w lines ls 1 t 'automatic EFT 1L', \
     datafile u 1:4 w lines ls 2 t 'EFT 2L', \
     datafile u 1:3 w lines ls 3 t 'full model 2L'

# plots w/ tree-level matching

set output "Xt_TB5_MS100_Matching0L.pdf"
datafile = "Xt_TB5_MS100_Matching0L.dat"
datafile2= "Xt_TB5_MS100_Matching0L_SE1L.dat"

plot [:] [70:132] \
     datafile  u 1:2 w lines ls 1 t 'automatic EFT 1L (0L MSSM parameter matching)', \
     datafile2 u 1:4 w lines ls 2 t 'EFT 1L', \
     datafile  u 1:3 w lines ls 3 t 'full model 2L'

set output "Xt_TB5_MS200_Matching0L.pdf"
datafile = "Xt_TB5_MS200_Matching0L.dat"
datafile2= "Xt_TB5_MS200_Matching0L_SE1L.dat"

replot

set output "Xt_TB5_MS300_Matching0L.pdf"
datafile = "Xt_TB5_MS300_Matching0L.dat"
datafile2= "Xt_TB5_MS300_Matching0L_SE1L.dat"

replot

set output "Xt_TB5_MS400_Matching0L.pdf"
datafile = "Xt_TB5_MS400_Matching0L.dat"
datafile2= "Xt_TB5_MS400_Matching0L_SE1L.dat"

replot

set output "Xt_TB5_MS500_Matching0L.pdf"
datafile = "Xt_TB5_MS500_Matching0L.dat"
datafile2= "Xt_TB5_MS500_Matching0L_SE1L.dat"

replot

set output "Xt_TB5_MS1000_Matching0L.pdf"
datafile = "Xt_TB5_MS1000_Matching0L.dat"
datafile2= "Xt_TB5_MS1000_Matching0L_SE1L.dat"

set key bottom

replot

set output "Xt_TB5_MS10000_Matching0L.pdf"
datafile = "Xt_TB5_MS10000_Matching0L.dat"
datafile2= "Xt_TB5_MS10000_Matching0L_SE1L.dat"

replot
