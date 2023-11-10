#!/bin/bash
# AUTHOR: RUSLAN ZHABSKYI
# DESCRIPTION: This script is an object of catalogue.sh to search for records
# DISCLAIMER: Error handling added but not scalled to all options. Example: incorrect county name


echo -e "\v\e[1;31mDatabase\e[0m \e[33mSearch\e[0m"
echo
while true; do 
  echo -e "\v\e[34mSearch:\e[0m" 
  echo -e "\t1. By County"
  echo -e "\t2. By Genre"
  echo -e "\t3. By KeyWord"
  echo -e "\t4. For Accessible Events"
  echo -e "\t5. Show 5 most affordable events"
  echo -e "\t6. Return to main menu"
  read -p "Select an option: " answer

  case $answer in
    1)
      while true; do
        read -p "County: " county
        found=$(grep -i -x "$county" ./counties.txt)
        if [ $? -eq 0 ]; then
          break #Exit loop since valid county provided
        else 
          echo "Please enter correct county name (ex. Dublin)"
        fi
      done

      echo -e "\v\e[93mPlease see below events in $county\e[0m"
      awk -F "|" -v county="$county" 'tolower($7) == tolower(county) {printf "%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13;}' ./musicEventsCatalogue.txt  | awk -F\| 'BEGIN {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "ID", "Name", "Date", "Time", "Concert Hall", "City",  "Artist(s)", "Age Restrictions", "Contact Number", "Accessibility", "Starting Price" }
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______"}
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", $1, $2, $3, $4, $5, $6, $8, $10, $11, $12, $13}'
    ;;

    2)
      read -p "Genre: " genre
      echo -e "\v\e[93mPlease below $genre events\e[0m"
      awk -F "|" -v genre="$genre" 'tolower($9) ~ tolower(genre) {printf "%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13;}' ./musicEventsCatalogue.txt  | awk -F\| 'BEGIN {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "ID", "Name", "Date", "Time", "Concert Hall", "City",  "Artist(s)", "Age Restrictions", "Contact Number", "Accessibility", "Starting Price" }
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______"}
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", $1, $2, $3, $4, $5, $6, $8, $10, $11, $12, $13}'
    ;;
              
    3)
      read -p "Search for: " keyWord
      echo -e "\v\e[93mPlease below searches matched $keyWord\e[0m"
      grep -i "$keyWord" ./musicEventsCatalogue.txt | awk -F\| 'BEGIN {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "ID", "Name", "Date", "Time", "Concert Hall", "City",  "Artist(s)", "Age Restrictions", "Contact Number", "Accessibility", "Starting Price" }
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______"}
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", $1, $2, $3, $4, $5, $6, $8, $10, $11, $12, $13}'
    ;; 

    4)
      echo -e "\v\e[93mPlease see below accessible events\e[0m"
      awk -F "|" 'tolower($12) != "none" && tolower($12) != "na" && tolower($12) != "" {printf "%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13;}' ./musicEventsCatalogue.txt  | awk -F\| 'BEGIN {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "ID", "Name", "Date", "Time", "Concert Hall", "City",  "Artist(s)", "Age Restrictions", "Contact Number", "Accessibility", "Starting Price" }
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______"}
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", $1, $2, $3, $4, $5, $6, $8, $10, $11, $12, $13}'        
    ;;
              
    5)
      echo -e "\v\e[93mPlease see TOP 5 affordable events\e[0m"
      sort -t "|" -k13,13n musicEventsCatalogue.txt | head -n5 | awk -F\| 'BEGIN {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "ID", "Name", "Date", "Time", "Concert Hall", "City",  "Artist(s)", "Age Restrictions", "Contact Number", "Accessibility", "Starting Price" }
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______", "______"}
                       {printf "%-10s %-25s %-10s %-10s %-22s %-10s %-25s %-20s %-20s %-20s %-10s\n", $1, $2, $3, $4, $5, $6, $8, $10, $11, $12, $13}'        
    ;;

    6)
      exit 0
    ;;

    *)
      echo "Invalid option. Please choose a valid menu option (example: 1)"
    ;;
  
  esac

done
