if (!exists("dir")) dir='.'

set terminal pdfcairo enhanced
set key box bottom right width -2
set logscale x
set grid

set style line 1 lt 1 dt 1 lw 2 lc rgb '#FF0000'
set style line 2 lt 1 dt 2 lw 2 lc rgb '#0000FF'
set style line 3 lt 1 dt 4 lw 2 lc rgb '#45AD53'
set style line 4 lt 1 dt 3 lw 2 lc rgb '#000000'
set style line 5 lt 1 dt 5 lw 2 lc rgb '#FF00FF'
set style line 6 lt 1 dt 6 lw 2 lc rgb '#00FFFF'
set style line 7 lt 1 dt 7 lw 2 lc rgb '#000000'
set style line 8 lt 1 dt 4 lw 2 lc rgb '#00FF00'
set style line 9 lt 1 dt 2 lw 2 lc rgb '#9C4C17'

set xlabel 'M_{SUSY} / TeV'
set ylabel 'M_h / GeV'

set output dir.'/scale_MSSM.pdf'

plot [0.09:] [60:140] \
     dir.'/scale_MSSM.dat' u ($1/1000):4 t 'FlexibleSUSY/MSSM' w lines ls 3, \
     dir.'/scale_MSSM.dat' u ($1/1000):12 t 'SPheno 3.3.8' w lines ls 6, \
     dir.'/scale_MSSM.dat' u ($1/1000):8 t 'FeynHiggs 2.11.3' w lines ls 8, \
     dir.'/scale_MSSM.dat' u ($1/1000):($8-$9):($8+$9) t 'FeynHiggs uncertainty' w filledcurves ls 8 dt 1 lw 0 fs transparent solid 0.3, \
     dir.'/scale_MSSM.dat' u ($1/1000):10 t 'SUSYHD 1.0.2' w lines ls 9, \
     dir.'/scale_MSSM.dat' u ($1/1000):($10-$11):($10+$11) t 'SUSYHD uncertainty' w filledcurves ls 9 dt 1 lw 0 fs transparent solid 0.3

set output dir.'/scale_MSSM_tower.pdf'

plot [0.09:] [60:140] \
     dir.'/scale_MSSM.dat' u ($1/1000):2 t 'FlexibleSUSY/MSSM-tower' w lines ls 1, \
     dir.'/scale_MSSM.dat' u ($1/1000):4 t 'FlexibleSUSY/MSSM' w lines ls 3, \
     dir.'/scale_MSSM.dat' u ($1/1000):12 t 'SPheno 3.3.8' w lines ls 6, \
     dir.'/scale_MSSM.dat' u ($1/1000):8 t 'FeynHiggs 2.11.3' w lines ls 8, \
     dir.'/scale_MSSM.dat' u ($1/1000):($8-$9):($8+$9) t 'FeynHiggs uncertainty' w filledcurves ls 8 dt 1 lw 0 fs transparent solid 0.3, \
     dir.'/scale_MSSM.dat' u ($1/1000):10 t 'SUSYHD 1.0.2' w lines ls 9, \
     dir.'/scale_MSSM.dat' u ($1/1000):($10-$11):($10+$11) t 'SUSYHD uncertainty' w filledcurves ls 9 dt 1 lw 0 fs transparent solid 0.3

min(x,y) = x < y ? x : y
max(x,y) = x < y ? y : x

# set output dir.'/scale_MSSM_TB-5_Xt-2.pdf'

# plot [0.09:] [80:140] \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):2 t 'FlexibleSUSY/MSSM-tower' w lines ls 1, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):4 t 'FlexibleSUSY/MSSM' w lines ls 3, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):5 t 'FlexibleSUSY/HSSUSY' w lines ls 2, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):6 t 'SOFTSUSY 3.6.2' w lines ls 5, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):12 t 'SPheno 3.3.8' w lines ls 6, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):8 t 'FeynHiggs 2.11.3' w lines ls 8, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):($8-$9):($8+$9) t 'FeynHiggs uncertainty' w filledcurves ls 8 dt 1 lw 0 fs transparent solid 0.3, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):10 t 'SUSYHD 1.0.2' w lines ls 9, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):($10-$11):($10+$11) t 'SUSYHD uncertainty' w filledcurves ls 9 dt 1 lw 0 fs transparent solid 0.3

# plot [0.09:] [80:140] \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):2 t 'FlexibleSUSY/MSSM-tower' w lines ls 1, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):4 t 'FlexibleSUSY/MSSM' w lines ls 3, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):5 t 'FlexibleSUSY/HSSUSY' w lines ls 2, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):6 t 'SOFTSUSY 3.6.2' w lines ls 5, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):12 t 'SPheno 3.3.8' w lines ls 6, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):8 t 'FeynHiggs 2.11.3' w lines ls 8, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):10 t 'SUSYHD 1.0.2' w lines ls 9, \
#      '< paste '.dir.'/scale_MSSMtower_TB-5_Xt-2_DeltaLambda.dat' \
#      u ($1/1000):(min($4,$6)):(max($4,$6)) t 'uncertainty from varying C_1 and C_2' \
#      w filledcurves ls 2 dt 1 lw 0 fs transparent solid 0.3, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):($2-abs($2-$16)):($2+abs($2-$16)) t '{\261}|M_h(y_t^{(1)}) - M_h(y_t^{(0)})|' \
#      w filledcurves ls 3 dt 1 lw 0 fs transparent solid 0.3, \

# plot [0.09:] [80:140] \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):2 t 'FlexibleSUSY/MSSM-tower' w lines ls 1, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):4 t 'FlexibleSUSY/MSSM' w lines ls 3, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):5 t 'FlexibleSUSY/HSSUSY' w lines ls 2, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):6 t 'SOFTSUSY 3.6.2' w lines ls 5, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):12 t 'SPheno 3.3.8' w lines ls 6, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):8 t 'FeynHiggs 2.11.3' w lines ls 8, \
#      dir.'/scale_MSSM_TB-5_Xt-2.dat' u ($1/1000):10 t 'SUSYHD 1.0.2' w lines ls 9, \
#      '< paste '.dir.'/scale_MSSMtower_TB-5_Xt-2_Qmatch_uncertainty.dat '.dir.'/scale_MSSM_TB-5_Xt-2.dat' \
#      u ($1/1000):($4-$2/2):($4+$2/2) t 'Q_{match} uncertainty' \
#      w filledcurves ls 1 dt 1 lw 0 fs transparent solid 0.3, \

# set output dir.'/scale_MSSM_TB-5_Xt--2.pdf'

# plot [0.09:] [80:140] \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):2 t 'FlexibleSUSY/MSSM-tower' w lines ls 1, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):4 t 'FlexibleSUSY/MSSM' w lines ls 3, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):5 t 'FlexibleSUSY/HSSUSY' w lines ls 2, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):6 t 'SOFTSUSY 3.6.2' w lines ls 5, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):12 t 'SPheno 3.3.8' w lines ls 6, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):8 t 'FeynHiggs 2.11.3' w lines ls 8, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):($8-$9):($8+$9) t 'FeynHiggs uncertainty' w filledcurves ls 8 dt 1 lw 0 fs transparent solid 0.3, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):10 t 'SUSYHD 1.0.2' w lines ls 9, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):($10-$11):($10+$11) t 'SUSYHD uncertainty' w filledcurves ls 9 dt 1 lw 0 fs transparent solid 0.3

# plot [0.09:] [80:140] \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):2 t 'FlexibleSUSY/MSSM-tower' w lines ls 1, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):4 t 'FlexibleSUSY/MSSM' w lines ls 3, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):5 t 'FlexibleSUSY/HSSUSY' w lines ls 2, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):6 t 'SOFTSUSY 3.6.2' w lines ls 5, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):12 t 'SPheno 3.3.8' w lines ls 6, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):8 t 'FeynHiggs 2.11.3' w lines ls 8, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):10 t 'SUSYHD 1.0.2' w lines ls 9, \
#      '< paste '.dir.'/scale_MSSMtower_TB-5_Xt--2_DeltaLambda.dat' \
#      u ($1/1000):(min($4,$6)):(max($4,$6)) t 'uncertainty from varying C_1 and C_2' \
#      w filledcurves ls 2 dt 1 lw 0 fs transparent solid 0.3, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):($2-abs($2-$16)):($2+abs($2-$16)) t '{\261}|M_h(y_t^{(1)}) - M_h(y_t^{(0)})|' \
#      w filledcurves ls 3 dt 1 lw 0 fs transparent solid 0.3, \

# plot [0.09:] [80:140] \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):2 t 'FlexibleSUSY/MSSM-tower' w lines ls 1, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):4 t 'FlexibleSUSY/MSSM' w lines ls 3, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):5 t 'FlexibleSUSY/HSSUSY' w lines ls 2, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):6 t 'SOFTSUSY 3.6.2' w lines ls 5, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):12 t 'SPheno 3.3.8' w lines ls 6, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):8 t 'FeynHiggs 2.11.3' w lines ls 8, \
#      dir.'/scale_MSSM_TB-5_Xt--2.dat' u ($1/1000):10 t 'SUSYHD 1.0.2' w lines ls 9, \
#      '< paste '.dir.'/scale_MSSMtower_TB-5_Xt--2_Qmatch_uncertainty.dat '.dir.'/scale_MSSM_TB-5_Xt--2.dat' \
#      u ($1/1000):($4-$2/2):($4+$2/2) t 'Q_{match} uncertainty' \
#      w filledcurves ls 1 dt 1 lw 0 fs transparent solid 0.3, \
