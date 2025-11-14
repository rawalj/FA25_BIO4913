#!/bin/bash

#Use awk to find largest male. input file for awk is a csv
read MAX_MALE_LENGTH MAX_MALE_SITE <<< $(awk -F',' '
#do not include header. determine if each male is larger than max and then set that individual to be max
NR>1 && $3=="Male" {
    if($4>max){
        max=$4 
        site=$2
}
}

END {print max, site}' "Exam2_Levine_et_al_body_size.csv")

#Use awk to find largest female. input file for awk is comma seperated
read MAX_FEMALE_LENGTH MAX_FEMALE_SITE <<< $(awk -F',' '
#do not include header. determine if each female is larger than max and then set that individual to be max
NR>1 && $3=="Female" {
    if($4>max){
        max=$4
        site=$2
    }
}
END {print max, site}' "Exam2_Levine_et_al_body_size.csv")

#use if/else/fi to determine if the largest male and female are from the same site
if [ "$MAX_MALE_SITE" == "$MAX_FEMALE_SITE" ]; then
    SAME_SITE="Yes"
else
    SAME_SITE="No"
fi
#report results in file
{
    echo "Longest Male:"
    echo "  Nose-to-Wing-Tip (mm): $MAX_MALE_LENGTH"
    echo "  Site Code: $MAX_MALE_SITE"
    echo
    echo "Longest Female:"
    echo "  Nose-to-Wing-Tip (mm): $MAX_FEMALE_LENGTH"
    echo "  Site Code: $MAX_FEMALE_SITE"
    echo
    echo "Were longest male and female collected from the same site? $SAME_SITE"
} > "Largest_SLF.txt"
