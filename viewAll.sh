#!/bin/bash
# AUTHOR: RUSLAN ZHABSKYI
# DESCRIPTION: This script is an object of catalogue.sh to list All records in easy to read format 

echo -e "\vPlease see the full catalogue below:"
sort -t '|' -k 2,2 -k3,3r ./musicEventsCatalogue.txt | awk -F\| 'BEGIN {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "ID", "Name", "Date", "Time", "Concert Hall", "City",  "Artist(s)", "Age Restrictions", "Contact Number", "Accessibility", "Starting Price" }
                 {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______"}
                 {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", $1, $2, $3, $4, $5, $6, $8, $10, $11, $12, $13}'