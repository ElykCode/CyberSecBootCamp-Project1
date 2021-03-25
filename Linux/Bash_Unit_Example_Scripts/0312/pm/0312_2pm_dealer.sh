#!/bin/bash

# full file path to the day's schdules - can be run from anywhere
schedule=/home/sysadmin/unit3/homework/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis/Dealer_Schedules_0310/0312_Dealer_schedule

#time slug to grep by
t="02:00:00 PM"

# this returns the dealer that was dealing at that $t time in the $schedule file
dealer=$(grep "$t" "$schedule" | awk -F '\t' '{print $3}')

# nicely formatted output
echo "The $t dealer from $(basename "$schedule") was: $dealer"
