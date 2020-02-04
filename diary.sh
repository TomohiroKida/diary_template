#!/bin/bash

## echo today or yesterday from argument
## today:     y
## yesterday: n
function todayOrYesterday () { answer=$1 
    if [ "A$answer" = 'An' ] ; then
        echo $(LANG=en_US.UTF-8 date +%F-%a --date "1 day ago")
    else
        echo $(LANG=en_US.UTF-8 date +%F-%a) 
    fi
}

## for change date and reset in line 1 of .now file
# FORMAT
# 1 year-month-day-week
# 2 hour:min (start time)
# 3 hour:min (fin   time)
# 4 day count
# 5 -- 
# 6 --
function changeNowFile () {
    edit_day=$1
    sed -i \
        -e '1s/.*/'$edit_day'/' \
        -e '2s/.*/:/'  \
        -e '3s/.*/:/'  \
        -e '5,$d'      \
        -e '4a --\n--' \
        .now
}

# you edit .now file and copy .now to ./year/month/day by read command
function editTodayDiaryByRead() {
    editor=$1;
    echo $(LANG=en_US.UTF-8 date +%F-%a) ?
    read -p "y/n " answer
    edit_day=`todayOrYesterday $answer`
    year=$(echo $edit_day | cut -f 1 -d "-")
    month=$(echo $edit_day | cut -f 2 -d "-")
    day=$(echo $edit_day | cut -f 3 -d "-")
    dir=$year/$month
    file=$dir/$day

    echo "dir  "$dir
    echo "file "$file
    read -p "ok? or ^C "
    # first init diary create .now
    if [ ! -f .now ] ; then
        cp template .now
        sed -i -e '4d' -e '3a'0 .now; 
    fi
    # change now file 
    changeNowFile $edit_day

    # create new year or month
    if [ ! -d $dir ] ; then
        read -p "mkdir -p $dir ? " 
        mkdir -p $dir
    fi

    # create today's file
    if [ ! -f $file ] ; then
        cp .now $file;
    fi

    # update day count ----------
    day_count=$(( 1+$(sed -n 4P $file) ));  
    echo $day_count;                        
    sed -i -e '4d' -e '3a'$day_count $file; 

    # edit
    $editor $file        
    # today's file is lnk of now
    rm .now
    ln -s $file .now 
}

# ------------------------------------------------------------------------------
# start scripts from here
editor=$1
if [ $# -le 1 ]; then
    if [ "$editor" = "emacs" ]; then
        echo emacs
        editTodayDiaryByRead emacs
    else 
        echo vim
        editTodayDiaryByRead vim
    fi
fi

