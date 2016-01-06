#!/bin/bash

#for f in *.mp; do mpost $f; done

mpfiles=`find . -type f -name '*.mp' -not -name 'feynmp.mp' -printf "%f\n"`
echo "Compile files with MetaPost:"
echo $mpfiles
for f in $mpfiles; do mpost $f; done
