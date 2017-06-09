if (!exists("dir")) dir='.'

min(x,y) = x < y ? x : y
max(x,y) = x < y ? y : x

dQ(Mhmean,Mhmax,Mhmin) = max(abs(Mhmean-Mhmax), abs(Mhmean-Mhmin))

load dir.'/definitions.gnuplot'
load dir.'/style5.gnuplot'
set output dir.'/scale_MSSM_yt_variants.pdf'
set key box bottom right width -3 height 0.5
set logscale x
set grid

set xrange [Mt:]
set yrange [80:140]
set xlabel 'M_{SUSY} / TeV'
set ylabel 'M_h / GeV'
set title 'X_t = 0, tan {/Symbol b} = 5'

scale_data = '< paste '.\
dir.'/scale_MSSM_TB-5_Xt-0.dat '.\
dir.'/scale_MSSMMuBMu_TB-5_Xt-0_scale_uncertainty_max.dat '.\
dir.'/scale_MSSMMuBMu_TB-5_Xt-0_scale_uncertainty_min.dat'

#  1: MS
#  2: Mh tower
#  4: Mh MSSMMuBMu
# 17: Suspect
# 18: MS
# 19: Mh_max from varying Q
# 20: MS
# 21: Mh_min from varying Q

plot \
     dir.'/scale_MSSM_TB-5_Xt-0.dat' u ($1/1000):4  t 'FlexibleSUSY' w lines ls 1, \
     dir.'/scale_MSSM_TB-5_Xt-0.dat' u ($1/1000):7  t 'SPheno'       w lines ls 2, \
     scale_data u ($1/1000):($4-dQ($4,$19,$21)):($4+dQ($4,$19,$21)) t 'scale variation' w filledcurves ls 14 fs transparent solid 0.4
