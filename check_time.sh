#!/bin/bash

# get minit data that you stay until 1 day 
function getMin(){
    day=$1
    from=$(awk -F":" 'NR==2{print $1*60+$2}' $day)
    tooo=$(awk -F":" 'NR==3{print $1*60+$2}' $day)
    echo $(($tooo - $from))
}

# for percents state
cnt=0
cntJob=`find 20[1-2][0-9] -maxdepth 2 -type f |wc -l`  # 2010-2029
mins=0
for day in `find 20[1-2][0-9] -maxdepth 2 -type f`; do # 2010-2029
    mins=$(($mins + `getMin $day`)) # add min data
    cnt=$((cnt+1))
    if [ $((cnt%10)) -eq 1 ]; then
        clear
        printf "%2d[%%]\n" $((cnt*100/cntJob))
    fi
done

printf "%d days\n" `awk 'NR==4' .now `
printf "%d day %d hour %d min\n" $(($mins/60/24)) $(($mins/60%24)) $(($mins%60))
printf "%d hour %d min\n" $(($mins/60)) $(($mins%60))

