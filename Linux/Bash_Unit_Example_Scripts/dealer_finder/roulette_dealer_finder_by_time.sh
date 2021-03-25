#!/bin/bash

### FORWARD ###
# This script is designed to identify a dealer working on a specific day at a specific time

### CHANGELOG ###
# WHEN		WHO			WHAT
# 20210103	Kyle Smeaton		Added initial code	
# 20210103	Kyle Smeaton		Added main case statement, simplified functions
# 20210103	Kyle Smeaton		Fixed timestamps to read 2021, not 2020

### TODO ###
# - Fix the Billy Jones Bug
# - Add more graceful error handling if the user inputs an invalid time

### BUGS ###
# The Billy Jones Bug
#	- if the given time is not quoted, it's searched twice. fix: add a flag for AM or PM?

#OPTIONS
# strict bash
set -Eeuo pipefail

# DECLARATIONS
version="0.0.2.1"
last_updated="2021-01-03"
schedule_dir="/home/sysadmin/unit3/homework/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/Dealer_Schedules_0310/"

#function to tell us what went wrong
function error_notifier {
	echo "ERROR on $(caller): ${BASH_COMMAND}"
}

# function to show usage information
function print_usage {
	echo 'USAGE:' $0 '-d <schedule date> -t "<time to search>"'
	echo '	EXAMPLE:' $0 '-d 0310 -t "08:00:00 AM"'
	echo "USAGE: $0 -v || -h"		
}

# MAIN

# trap errors
trap error_notifier ERR

# get the arguments to the script
while getopts ":d:t:vh" option; do 
	case "$option" in
		# schedule option
		d )
			# set the schedule date to the option argument
			schedule_date="$OPTARG"
			schedule_file=$(find $schedule_dir -name "$schedule_date*" -and -name "*_Dealer_schedule")
			;;
		# date option
		t )
			# set the search time to the option argument
			search_time="$OPTARG"
			# the roulette dealer is the 3rd field in the schedule file
			# BUG: if the dealer appears twice in the file, the name is repeated 
			dealer=$(grep "$search_time" "$schedule_file" | awk -F '\t' '{print $3;}')
			;;
		# version option
		v )
			echo "Dealer Finder Script - Version $version"
			echo "Author: Kyle Smeaton"
			echo "Last updated on $last_updated"
			exit
			;;
		# help option
		h )
			print_usage
			exit
			;;
		# invalid option
		/? )
			echo "Invalid option!"
			print_usage
			;;
		# missing argument
		: )
			echo "Missing argument!"
			print_usage
			;;
		# anything else we didn't expect
		* )
			print_usage
			exit
			;;
	esac
done
# print the Roulette dealer's name
echo "The Roulette dealer from schedule" $(basename "$schedule_file") "at" "$search_time" "was" "$dealer"
# DEBUG
#echo 'DEBUG: $dealer' "is $dealer"
#echo "DEBUG: END OF SCRIPT"
# END DEBUG
