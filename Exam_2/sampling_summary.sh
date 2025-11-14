#!/bin/bash


#count the number of unique lines from the second column of the CSV file, excluding the header.
NumOfSites=$(awk -F',' 'NR>1 {print $2}' Exam2_Levine_et_al_body_size.csv | sort -u | wc -l)

#echo the number of unique lines to a txt file
echo "$NumOfSites" > NumberOfUniqueSites.txt

#input file for awk is comma seperated
awk -F',' '
#begin block
BEGIN {
#output file will be tab separated
    OFS = "\t"
#define headers
    print "Site_Code", "N_Samples", "N_Males", "N_Females"
}
#main block, skip the header
NR > 1 {
#site is column 2 and sex is column 3
    site = $2
    sex  = $3
#add to num of bugs at site for each indvidual at site
    total[site]++
#add to males at side if sex is M, add to females if sex is F
    if (sex == "M") males[site]++
    else if (sex == "F") females[site]++
}
#end block
END {
#use a for loop to print the values for each site
    for (s in total) {
        print s, total[s], males[s] + 0, females[s] + 0
    }
}
#do all this to the csv provided and put it on the output file
' Exam2_Levine_et_al_body_size.csv > Site_Summary.txt
