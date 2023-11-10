#!/bin/bash
# AUTHOR: RUSLAN ZHABSKYI
# DESCRIPTION: This script is an object of catalogue.sh to add a record
# DISCLAIMER: Error handling added but not scalled to all options. 
##Examples: empty values, incorrect date and time, incorrect phone number, incorrect county name

    echo -e "\v\e[1;31mDatabase management.\e[0m \e[33mAdd new record\e[0m"
    echo

while true; do 

        echo -e "\v\e[34mWould you like to:\e[0m" 
        echo -e "\t1.Continue"
        echo -e "\t2.Return to main menu"
        read -p "Select an option: " answer

    case $answer in
        1)
            echo "Please enter the details below"

            while true; do
            read -p "Enter Event Name: " eventName
              if [ -n "$eventName" ]; then
            break
              else
            echo -e "\tThe field cannot be empty"
            fi        
            done  

    echo -e "\vEnter Event Date"

        while true; do
            read -p "Year (ex. $(date +%Y)): " eventYear
            currentYear=$(date +%Y)  # Store the current year in a variable

            if [[ $eventYear =~ ^[0-9]{4}$ ]] && [ "$eventYear" -ge "$currentYear" ]; then
                break  # Exit the loop since a valid year is provided
            else
                echo "$eventYear is in the incorrect format or is in the past. Please enter a correct year (ex. $(date +%Y))"
            fi
        done

        while true; do
            read -p "Month (ex. 01 OR 11): " eventMonth
            monthPerYear=12
            if [[ $eventMonth =~ ^[0-9]{2}$ ]] && [ "$eventMonth" -le "$monthPerYear" ] && [ "$eventMonth" -ne "00" ]; then
                break  # Exit the loop since a valid month is provided
            else
                echo "$eventMonth is in the incorrect format or exceeds number of month per year. Please enter a correct month (ex. 01 OR 11)"
            fi
        done

        while true; do
            read -p "Day (ex. 01 OR 22): " eventDay 
            calendarDays=31
            if [[ $eventDay =~ ^[0-9]{2}$ ]] && [ "$eventDay" -le "$calendarDays" ] && [ "$eventDay" -ne "00" ]; then
                break  # Exit the loop since a valid day is provided
            else
                echo "$eventDay is in the incorrect format or exceeds maximum days in a month. Please enter a correct day (ex. 01 OR 21)"
            fi
        done
     
    echo -e "\vEnter Event Time"

        while true; do
            read -p "Hour (ex. 20): " eventHour 
            hoursPerDay=23
            if [[ $eventDay =~ ^[0-9]{2}$ ]] && [ "$eventHour" -le "$hoursPerDay" ]; then
                break  # Exit the loop since a valid hour is provided
            else
                echo "$eventHour is in the incorrect format or exceeds maximum hours in a day. Please enter a correct hour (ex. 09 OR 20)"
            fi
        done

        while true; do
            read -p "Minutes (ex.00 OR 30): " eventMin 
            minInHour=59
            if [[ $eventMin =~ ^[0-9]{2}$ ]] && [ "$eventMin" -le "$minInHour" ]; then
                break  # Exit the loop since a valid time is provided
            else
                echo "$eventMin is in the incorrect format or exceeds maximum minutes in an hour. Please enter a correct minutes (ex. 00 OR 30)"
            fi
        done


    echo -e "\vEnter Event Location"
    read -p "Venue: " venue
    read -p "City: " city

        while true; do
            read -p "County: " county
            found=$(grep -i -x "$county" ./counties.txt)
                if [ $? -eq 0 ]; then
                    break #Exit loop since valid county provided
                else 
                echo "Please enter correct county name (ex. Dublin)"
                fi
        done

    read -p "Artist (if more than 1, separate by comma): " artist
    read -p "Genre (if more that 1, separate by comma): " genre
    read -p "Age Restrictions (ex. +18): " ageRestrictions
    while true; do
        read -p "Enter a phone number (e.g., 0861112233): " phoneNumber

            if [[ $phoneNumber =~ ^\+?[0-9]{5,15}$ ]]; then
                break  # Exit the loop since a valid phone number is provided
                else
                echo "$phoneNumber is in the incorrect format. Please enter correct phone number (e.g., 0861112233, 00353863344111 OR +3538711122333)."
            fi
    done

    read -p "Accessibility: " accessibility
    read -p "Starting Price (in Euro, ex. 20): " startingPrice


    echo -e "\v\t\e[33mPlease see your input below\e[0m"
        echo "Event Name: " $eventName
        echo "Event date and time:  $eventYear-$eventMonth-$eventDay $eventHour:$eventMin" 
        echo "Event Location: $venue, $city, $county"
        echo "Artist: " $artist
        echo "Genre: " $genre
        echo "Age Restrictions: " $ageRestrictions
        echo "Contact Phone Number: " $phoneNumber
        echo  "Accessibility: " $accessibility
        echo "Starting Price: " $startingPrice

    echo "Would you like to save your input? (Y/N)"
        read answer

    while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "YES" ] && [ $answer != "yes" ] && [ $answer != "N" ] && [ $answer != "n" ] && [ $answer != "NO" ] && [ $answer != "no" ]; do
            echo "Please type Yes or No"
            read answer
    done

        case $answer in
                [yY] | [yY][Ee][Ss] )
                    #Look for the last ID and create a new ID for the entry
                    ID=$(sort -t '|' -k 1,1n ./musicEventsCatalogue.txt | tail -n1 | awk -F '|' '{print $1}')
                    ID=$((ID + 1))
                    echo "$ID|$eventName|$eventYear-$eventMonth-$eventDay|$eventHour:$eventMin|$venue|$city|$county|$artist|$genre|$ageRestrictions|$phoneNumber|$accessibility|$startingPrice" >> ./musicEventsCatalogue.txt 
                    echo -e "╔══════════════════════════╗"
                    echo -e "║                          ║"
                    echo -e "║  Your input has been     ║"
                    echo -e "║  saved                   ║"
                    echo -e "║                          ║"
                    echo -e "╚══════════════════════════╝"
                    ;;
                [nN] | [nN][Oo] )
                    echo -e "\e[33mThe input has NOT been saved\e[0m"
                    ;;
                *)
                    echo -e "\e[1;31mInvalid input. Please type Yes or No\e[0m"
                    ;;
        esac
    ;;

    2)
        exit 0
        ;;

    *)
        echo "Invalid option. Please choose a valid menu option (example: 1)"
        ;;
    esac

done

