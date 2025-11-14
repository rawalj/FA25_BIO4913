#!/bin/bash

#input file for awk is comma seperated
awk -F',' '
#begin block
BEGIN {
#output file will be tab separated
    OFS = "\t"
#define headers
    print "Site_Code", "Class"
}
#main block, skip the header
NR > 1 {
#site code is column 2 and urban metric is column 5
    site = $2
    ip = $5 + 0
#using if/else if/else to define the urban stats of each site based on the metric provided
    if (ip < 15)
        class[site] = "Rural"
    else if (ip >= 15 && ip <= 49)
        class[site] = "Suburban"
    else if (ip > 50)
        class[site] = "Urban"
}
#end block
END {
#use a for loop to print the values for each site
    for (s in class) {
        print s, class[s]
    }
}
#do all this to the csv provided and put it on the output file
' Exam2_Levine_et_al_body_size.csv > Site_Urban.txt
