#!/bin/sh

gnuplotFiles=`find -name *.gpl`
epsFiles=`find -name *.eps`

if [ -z $gnuplotFiles ]
then
    echo "no gnuplot files found"
else
    for f in *.gpl; do gnuplot $f; done
fi

if [ -z $epsFiles ]
then
    echo "no eps files found"
else
    for f in *.eps ; do epstopdf $f; done
fi
