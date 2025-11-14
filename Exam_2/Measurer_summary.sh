#!/bin/bash

#input file for awk is comma seperated
awk -F',' '
#begin block
BEGIN {
#output file will be tab separated
    OFS = "\t"
#define headers
    print "Measurer", "Samples", "Rural", "Suburban", "Urban"
}
#main block, skip the header
NR > 1 {
#site code is column 2 and urban metric is column 5
    measurer = $1
    ip = $5 + 0
#add to measurer total   
    total[measurer]++
#using if/else to define the urban stats for each measurer based on the metric provided
    if (ip <= 20)
        rural[measurer]++
    else if (ip <= 50)
        suburban[measurer]++
    else
        urban[measurer]++
}
#end block
END {
#print the results   
 for (m in total) {
        r = (rural[m] ? rural[m] : 0)
        s = (suburban[m] ? suburban[m] : 0)
        u = (urban[m] ? urban[m] : 0)
        print m, total[m], r, s, u
    }
}
#do all this to the csv provided and put it on the output file
' Exam2_Levine_et_al_body_size.csv > Measurer_Summary.txt
