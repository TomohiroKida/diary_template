#!/bin/bash
#
# check day: diff diary file L.4 and count up number to now.
# L.4 is num of days to come lab.

#year_list=$(seq -f "$HOME/diary/%.0f" 2017 2019)
now_day=$HOME/diary/.now
echo $year_list
diff <(find ${year_list} -type f | sort |\
    while read day ; do awk 'NR==4{print}' $day; done) \
     <(seq $(awk 'NR==4{print}' $now_day))
