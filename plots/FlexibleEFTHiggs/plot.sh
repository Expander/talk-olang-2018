#!/bin/sh

plot() {
    local s=$1
    local x1=$2
    local y1=$3
    local x2=$4
    local y2=$5

    [ -z "$scaling" ] && scaling=1

cat <<EOF | gnuplot
if (!exists("dir")) dir='.'

set terminal pdfcairo enhanced
load dir.'/style5.gnuplot'
Mt = 0.17334
${setlabel}
${logscale}
set grid
set xlabel "${xlabel}"

min(x,y) = x < y ? x : y
max(x,y) = x < y ? y : x
ran(left,right,data) = (data < left || data > right ? 1/0 : data)
dQ(Mhmean,Mhmax,Mhmin) = max(abs(Mhmean-Mhmax), abs(Mhmean-Mhmin))

# MSSMtower
# 1: MS
# 2: Mh
# 3: combined
# 4: Delta Mh yt
# 5: Mh min Q_match
# 6: Mh max Q_match
# 7: Mh min Q_pole
# 8: Mh max Q_pole
# 9: yt^MSSM(MS)
#10: yt^SM(MS)
#11: yt^SM(Mt)
#12: lambda^SM(MS)
#13: lambda^SM(Mt)
#14: g3^MSSM(MS)
#15: g3^SM(MS)
#16: g3^SM(Mt)

set key box bottom right width -1 height 0.5 opaque font ",9"
set ylabel 'M_h / GeV'
set output dir.'/Mh_${s}.pdf'
dataTower1L = dir.'/MSSMtower1L_${s}.dat'
dataTower2L = dir.'/MSSMtower2L_${s}.dat'
dataSGs     = dir.'/all_MSSM_${s}.dat'
dataEFT1L   = dir."/HSSUSY1L_${s}.dat"
dataEFT2L   = dir."/HSSUSY2L_${s}.dat"
dataFH      = dir."/FH-2.12.2_${s}.dat"
dataTower1LNoLogs = dir.'/MSSMtower-1L-nologs/MSSMtower1L_${s}.dat'

plot [${x1}] [${y1}] \
     dataTower2L u (\$1/${scaling}):2 t 'FlexibleEFTHiggs/MSSM 2L' w lines ls 1, \
     dataTower1L u (\$1/${scaling}):2 t 'FlexibleEFTHiggs/MSSM 1L' w lines ls 7, \
     dataTower1LNoLogs u (\$1/${scaling}):2 t 'FlexibleEFTHiggs/MSSM 1L*' w lines ls 10, \
     dataSGs   u (\$1/${scaling}):4 t 'FlexibleSUSY/MSSM 2L' w lines ls 3, \
     dataSGs   u (\$1/${scaling}):5 t 'FlexibleSUSY/HSSUSY 2L' w lines ls 2, \
     dataEFT1L u (\$1/${scaling}):2 t 'FlexibleSUSY/HSSUSY 1L' w lines ls 4, \
     dataSGs   u (\$1/${scaling}):6 t 'SOFTSUSY 3.6.2' w lines ls 5, \
     dataSGs   u (\$1/${scaling}):12 t 'SARAH/SPheno' w lines ls 6, \
     dataFH    u (\$1/${scaling}):2 t 'FeynHiggs 2.12.2' w lines ls 8, \
     dataSGs   u (\$1/${scaling}):10 t 'SUSYHD 1.0.2' w lines ls 9

set output dir.'/Mh_uncertainties_${s}.pdf'

plot [${x1}] [${y1}] \
     dataTower2L u (\$1/${scaling}):(\$2-\$3):(\$2+\$3) t '' w filledcurves ls 11 fs pattern 6, \
     dataTower2L u (\$1/${scaling}):2 t 'FlexibleEFTHiggs/MSSM 2L' w lines ls 1, \
     dataTower1L u (\$1/${scaling}):2 t 'FlexibleEFTHiggs/MSSM 1L' w lines ls 7, \
     dataTower1LNoLogs u (\$1/${scaling}):2 t 'FlexibleEFTHiggs/MSSM 1L*' w lines ls 10, \
     dataSGs   u (\$1/${scaling}):4 t 'FlexibleSUSY/MSSM 2L' w lines ls 3, \
     dataSGs   u (\$1/${scaling}):5 t 'FlexibleSUSY/HSSUSY 2L' w lines ls 2, \
     dataEFT1L u (\$1/${scaling}):2 t 'FlexibleSUSY/HSSUSY 1L' w lines ls 4, \
     dataSGs   u (\$1/${scaling}):6 t 'SOFTSUSY 3.6.2' w lines ls 5, \
     dataSGs   u (\$1/${scaling}):12 t 'SARAH/SPheno' w lines ls 6, \
     dataFH    u (\$1/${scaling}):2 t 'FeynHiggs 2.12.2' w lines ls 8, \
     dataFH    u (\$1/${scaling}):(\$2-\$3):(\$2+\$3) t '' w filledcurves ls 18 fs transparent solid 0.3, \
     dataSGs   u (\$1/${scaling}):10 t 'SUSYHD 1.0.2' w lines ls 9, \
     dataSGs   u (\$1/${scaling}):(\$10-\$11):(\$10+\$11) t '' w filledcurves ls 19 fs transparent solid 0.3

set output dir.'/Mh_relative_${s}.pdf'
set ylabel '(M_h - M_h^{FlexibleEFTHiggs/MSSM 2L}) / GeV'
set key top left

# 1L tower: fields 1 - 16
# 2L tower: fields 17 - 32
# all SGs : fields 33 - 49
# 1L tower w/o logs: fields 50 - 65
data = '< paste '.dataTower1L.' '.dataTower2L.' '.dataSGs.' '.dataTower1LNoLogs
dataFh = '< paste '.dataFH.' '.dataTower2L

plot [${x2}] [${y2}] \
     data u (\$1/${scaling}):(\$18-\$18) t 'FlexibleEFTHiggs/MSSM 2L' w lines ls 1, \
     data u (\$1/${scaling}):(\$2-\$18) t 'FlexibleEFTHiggs/MSSM 1L' w lines ls 7, \
     data u (\$33/${scaling}):(\$36-\$18) t 'FlexibleSUSY/MSSM 2L' w lines ls 3, \
     data u (\$33/${scaling}):(\$37-\$18) t 'FlexibleSUSY/HSSUSY 2L' w lines ls 2, \
     '< paste '.dataTower2L.' '.dataEFT1L \
     u (\$1/${scaling}):(\$18-\$2) t 'FlexibleSUSY/HSSUSY 1L' w lines ls 4, \
     data u (\$33/${scaling}):(\$38-\$18) t 'SOFTSUSY 3.6.2' w lines ls 5, \
     data u (\$33/${scaling}):(\$44-\$18) t 'SARAH/SPheno' w lines ls 6, \
     dataFh u (\$1/${scaling}):(\$2-\$5) t 'FeynHiggs 2.12.2' w lines ls 8, \
     data u (\$33/${scaling}):(\$42-\$18) t 'SUSYHD 1.0.3' w lines ls 9, \
     data u (\$1/${scaling}):(\$51-\$18) t 'FlexibleEFTHiggs/MSSM 1L*' w lines ls 10

set output dir.'/Mh_uncertainties_relative_${s}.pdf'

plot [${x2}] [${y2}] \
     data u (\$1/${scaling}):(\$18-\$18-\$19):(\$18-\$18+\$19) t '' w filledcurves ls 11 fs pattern 6, \
     data u (\$1/${scaling}):(\$18-\$18) t 'FlexibleEFTHiggs/MSSM 2L' w lines ls 1, \
     data u (\$1/${scaling}):(\$2-\$18) t 'FlexibleEFTHiggs/MSSM 1L' w lines ls 7, \
     data u (\$33/${scaling}):(\$36-\$18) t 'FlexibleSUSY/MSSM 2L' w lines ls 3, \
     data u (\$33/${scaling}):(\$37-\$18) t 'FlexibleSUSY/HSSUSY 2L' w lines ls 2, \
     '< paste '.dataTower2L.' '.dataEFT1L \
     u (\$1/${scaling}):(\$18-\$2) t 'FlexibleSUSY/HSSUSY 1L' w lines ls 4, \
     data u (\$33/${scaling}):(\$38-\$18) t 'SOFTSUSY 3.6.2' w lines ls 5, \
     data u (\$33/${scaling}):(\$44-\$18) t 'SARAH/SPheno' w lines ls 6, \
     dataFh u (\$1/${scaling}):(\$2-\$5) t 'FeynHiggs 2.12.2' w lines ls 8, \
     dataFh u (\$1/${scaling}):(\$2-\$3-\$5):(\$2+\$3-\$5) t '' w filledcurves ls 18 fs transparent solid 0.3, \
     data u (\$33/${scaling}):(\$42-\$18) t 'SUSYHD 1.0.2' w lines ls 9, \
     data u (\$33/${scaling}):(\$42-\$43-\$18):(\$42+\$43-\$18) t '' w filledcurves ls 19 fs transparent solid 0.3, \
     data u (\$1/${scaling}):(\$51-\$18) t 'FlexibleEFTHiggs/MSSM 1L*' w lines ls 10

######### lambda #########

set ylabel "{/Symbol l}(M_S)"
set output "lambda_${s}.pdf"
set key bottom left

plot [${x1}] [:] \
     dataTower1L u (\$1/${scaling}):12 t "FlexibleEFTHiggs-1L" w lines ls 7, \
     dataTower1LNoLogs u (\$1/${scaling}):12 t "FlexibleEFTHiggs-1L*" w lines ls 10, \
     dataTower2L u (\$1/${scaling}):12 t "FlexibleEFTHiggs-2L" w lines ls 1, \
     dataEFT1L   u (\$1/${scaling}):7  t "HSSUSY-1L" w lines ls 3, \
     dataEFT2L   u (\$1/${scaling}):7  t "HSSUSY-2L" w lines ls 2

###### DMh ######

set style line 1 lt 4 lw 0 dt 1 lc rgb '#00FFFF'
set style line 2 lt 4 lw 0 dt 1 lc rgb '#FF00FF'
set style line 3 lt 4 lw 0 dt 1 lc rgb '#FFFF00'
set key bottom right width 0 height 0.5 font ",12"

set output dir.'/DMh_tower-1L_${s}.pdf'
set ylabel "{/Symbol D} M_h / GeV"
data = dataTower1L

plot [${x1}] [-6:6] \
     data u (\$1/${scaling}):(-\$4):(\$4) t "{/Symbol D}M_h^{(y_t 0L vs. 1L)}" \
     w filledcurves ls 1 fs transparent solid 0.5, \
     data u (\$1/${scaling}):(-dQ(\$2,\$5,\$6)):(dQ(\$2,\$5,\$6)) t "{/Symbol D}M_h^{(Q_{match})}" \
     w filledcurves ls 2 fs transparent solid 0.5, \
     data u (\$1/${scaling}):(-dQ(\$2,\$7,\$8)):(dQ(\$2,\$7,\$8)) t "{/Symbol D}M_h^{(Q_{pole})}" \
     w filledcurves ls 3 fs transparent solid 0.5

set output dir.'/DMh_tower-1L_no-logs_${s}.pdf'
set ylabel "{/Symbol D} M_h / GeV"
data = dataTower1LNoLogs

plot [${x1}] [-6:6] \
     data u (\$1/${scaling}):(-dQ(\$2,\$5,\$6)):(dQ(\$2,\$5,\$6)) t "{/Symbol D}M_h^{(Q_{match})}" \
     w filledcurves ls 2 fs transparent solid 0.5, \
     data u (\$1/${scaling}):(-dQ(\$2,\$7,\$8)):(dQ(\$2,\$7,\$8)) t "{/Symbol D}M_h^{(Q_{pole})}" \
     w filledcurves ls 3 fs transparent solid 0.5

set output dir.'/DMh_tower-2L_${s}.pdf'
set ylabel "{/Symbol D} M_h / GeV"
data = dataTower2L

plot [${x1}] [-6:6] \
     data u (\$1/${scaling}):(-\$4):(\$4) t "{/Symbol D}M_h^{(y_t 1L vs. 2L)}" \
     w filledcurves ls 1 fs transparent solid 0.5, \
     data u (\$1/${scaling}):(-dQ(\$2,\$5,\$6)):(dQ(\$2,\$5,\$6)) t "{/Symbol D}M_h^{(Q_{match})}" \
     w filledcurves ls 2 fs transparent solid 0.5, \
     data u (\$1/${scaling}):(-dQ(\$2,\$7,\$8)):(dQ(\$2,\$7,\$8)) t "{/Symbol D}M_h^{(Q_{pole})}" \
     w filledcurves ls 3 fs transparent solid 0.5
EOF
}

scenario="
 MS_TB-5_Xt-0,Mt:,80:140,Mt:,-4:10,0.2
 MS_TB-5_Xt--2,0.3:,95:140,0.3:,-4:10,0.3
"

for s in $scenario ; do
    scen=$(echo "$s" | cut -d',' -f 1)
    x1=$(echo "$s" | cut -d',' -f 2)
    y1=$(echo "$s" | cut -d',' -f 3)
    x2=$(echo "$s" | cut -d',' -f 4)
    y2=$(echo "$s" | cut -d',' -f 5)
    label=$(echo "$s" | cut -d',' -f 6)
    setlabel=
    [ -n "$label" ] && setlabel="set label 100 \"${label}\" at first ${label}, graph -0.055 center"
    logscale="set logscale x"
    scaling=1000
    xlabel="M_S / TeV"
    plot "$scen" "$x1" "$y1" "$x2" "$y2" "$label"
done

scenario="
 Xt_TB-5_MS-2000,-3.5:3.5,95:,-3.5:3.5,-4:10
"

for s in $scenario ; do
    scen=$(echo "$s" | cut -d',' -f 1)
    x1=$(echo "$s" | cut -d',' -f 2)
    y1=$(echo "$s" | cut -d',' -f 3)
    x2=$(echo "$s" | cut -d',' -f 4)
    y2=$(echo "$s" | cut -d',' -f 5)
    label=$(echo "$s" | cut -d',' -f 6)
    setlabel=
    [ -n "$label" ] && setlabel="set label 100 \"${label}\" at first ${label}, graph -0.055 center"
    logscale=
    scaling=
    xlabel="X_t / M_S"
    plot "$scen" "$x1" "$y1" "$x2" "$y2"
done
