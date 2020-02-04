#!/bin/bash
# 

dir=$1
day_cnt_start=$2
day_cnt_stop=$(( $day_cnt_start+$(find $dir -type f | wc -l) ))
echo $dir" year"
echo "update day count from "$day_cnt_start" to "$day_cnt_stop

function updateDayCount () {

    # initial 
    day_count=$day_cnt_start

    # loop for each existing files into directory 
    for file in $(find $dir -type f | sort) ; do

        # update day count 
        #   remove l.4 of file 
        #   add day_count to l.3 of file 
        sed -i -e '4d' -e '3a'$day_count $file

        # compare day_count and l.4 of file
        diff <(echo $day_count) <(sed -n 4P $file)
        if [ $? -ne 0 ] ; then
            echo "FAILED "$day_count $file
            exit 1
        else
            echo "update "$day_count $file
        fi

        # increment
        day_count=$((day_count+=1))
    done
    echo "Fin from "$day_cnt_start" to "$day_cnt_stop
}

read -p "ok? or ^C"
updateDayCount
