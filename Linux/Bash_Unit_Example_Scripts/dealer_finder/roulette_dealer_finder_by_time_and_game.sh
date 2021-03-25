#! /bin/bash

### DEALER FINDER BY TIME AND GAME ###

### CHANGELOG ###
# WHEN		WHO		WHAT
# 20210105	Kyle Smeaton	Added initial code

# ACK
# Thanks to this site for background info on associative arrays in Bash. Very fun!
# https://linuxhint.com/associative_arrays_bash_examples/

# And of course, https://devhints.io/bash, because I keep forgetting random Bash syntax...

### DECLARATIONS ###

# assign argments
dealer_time="$1"
dealer_date="$2"

# replace the spaces in the user input with underscores so the regex to match the array works
dealer_game=$(echo "$3" | sed 's/\s/_/g')

# associative array to correlate game names with numerical indexes. there are definitely easier ways to do this, but it's fun.
# format: valid_games[game]=index_in_schedule ; valid_games = ( [game 1]=index_1 [game 2]=index_2 ... )
declare -A valid_games
valid_games=( [Black_Jack]=2 [Roulette]=3 [Texas_Hold_Em]=4 )

# location of schedules:
sched_loc=/home/sysadmin/unit3/homework/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/Dealer_Schedules_0310
sched_name="_Dealer_schedule"

### END DECLARATIONS

### MAIN ###

grep "$dealer_time" "$sched_loc/$dealer_date$sched_name" | awk -F'\t' -v gameindex="${valid_games[$dealer_game]}" '{print $gameindex}'
