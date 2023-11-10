#!/bin/bash
# AUTHOR: RUSLAN ZHABSKYI
# DESCRIPTION: This script is an object of catalogue.sh to delete records
# DISCLAIMER: Error handling added but not scalled to all options. 
##Examples: empty/incorrect values
echo -e "\v\e[1;31mDatabase management.\e[0m \e[33mDELETE record\e[0m"
echo -e "\v\e[1;31m!Deleted records CANNOT be restored!\e[0m"
echo

while true; do 

    echo -e "\v\e[34mWould you like to:\e[0m" 
    echo -e "\t1.Display all records"
    echo -e "\t2.Delete record by ID"
    echo -e "\t3.Delete multiple records by IDs"
    echo -e "\t4.Delete ALL empty lines"
    echo -e "\t5.Delete ALL duplicates"
    echo -e "\t6.Return to main menu"
    read -p "Select an option: " answer

    case $answer in
        1)
                echo -e "\v\e[93mPlease see below the full list of records\e[0m"
                ./viewAll.sh
        ;;
                
        2)
            while true; do
                read -p "Enter ID of the record you would like to delete (or 'Q' to exit): " ID
                if [ "$ID" = "q" ] || [ "$ID" = "Q" ]; then
                    exit 0  # Exit the loop when 'q' or 'Q' is entered
                else
                    found=$(awk -F "|" '{print $1}' ./musicEventsCatalogue.txt | grep -i -x $ID)
                    if [ $? -eq 0 ]; then
                        echo -e "\vRecord details for ID $ID:"
                        break  # Exit the loop since a valid ID was provided
                    else
                            echo "Please enter a valid ID, or 'Q' to exit."
                    fi
                fi
            done

        awk -F "|" -v ID="$ID" 'tolower($1) == tolower(ID) {printf "%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13;}' ./musicEventsCatalogue.txt
                

        echo -e "\vWould you like to delete record ID:$ID from the catalogue?\v\e[1;31mIMPORTANT: After record deleted it CANNOT be restored\e[0m" 
        read -p "DELETE THE RECORD (Y/N):" answer

            while true; do
                case $answer in
                    [yY] | [yY][Ee][Ss] )
                        echo -e "\v\t\e[33mDELETED record ID:$ID\e[0m"
                        sed -i "/^$ID|/d" ./musicEventsCatalogue.txt #delete lines starting with specified ID
                            break
                    ;;
                    [nN] | [nN][Oo] )
                        echo -e "\v\t\e[33mRecord ID:$ID has NOT been deleted\e[0m"
                        break           
                    ;;

                    [qQ] )
                       break
                    ;;
                    *)
                        echo -e "\v\tInvalid input. Please type Yes or No"
                        read -p "DELETE THE RECORD (Y/N): " answer
                    ;;
                esac
            done
        ;;

        3)
            # Create an array to store entered IDs - used chatGPT to create an array
            declare -a entered_ids

            while true; do
                read -p "Enter ID$i of the record you would like to delete. Enter Q once all IDs are provided: " ID
                if [ "$ID" = "q" ] || [ "$ID" = "Q" ]; then
                    break  # Exit the loop when 'q' or 'Q' is entered
                else
                    found=$(awk -F "|" '{print $1}' ./musicEventsCatalogue.txt | grep -i -x "$ID")
                    if [ $? -eq 0 ]; then
                        entered_ids+=("$ID")  # Add the entered ID to the array
                    else
                        echo "Please enter a valid ID, or 'Q' to exit."
                    fi
                fi
            done

            # Print the entered IDs
            echo -e "\t\vPlease see the list of records you would like to DELETE"
            for j in "${entered_ids[@]}"; do
                awk -F "|" -v ID="$j" 'tolower($1) == tolower(ID) {printf "%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s|%s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13;}' ./musicEventsCatalogue.txt
            done

            echo -e "\vWould you like to delete these records from the catalogue?\v\e[1;31mIMPORTANT: After record deleted it CANNOT be restored\e[0m" 
            read -p "DELETE THE RECORD (Y/N):" answer

            while true; do
                case $answer in
                    [yY] | [yY][Ee][Ss] )
                        echo -e "\v\t\e[33mDELETED records\e[0m"
                        for j in "${entered_ids[@]}"; do
                            sed -i "/^$j|/d" ./musicEventsCatalogue.txt #delete lines starting with specified ID
                        done
                        break
                    ;;
                    [nN] | [nN][Oo] )
                            echo -e "\v\t\e[33mRecords have NOT been deleted\e[0m"
                        break           
                    ;;

                    [qQ] )
                        break
                    ;;
                    *)
                        echo -e "\v\tInvalid input. Please type Yes or No"
                        read -p "DELETE THE RECORD(s) (Y/N): " answer
                    ;;
                    esac
            done

            unset entered_ids
        ;;

        4)
            sed -i '/^$/d' ./musicEventsCatalogue.txt

            if [ $? -eq 0 ]; then
                echo -e "\n\t\e[33mDELETED empty lines\e[0m"
            else
                echo -e "\n\t\e[33mError occurred...\e[0m"
            fi
        ;; 

        5)
            echo -e "\n\t\e[33mPlease see the output bellow\e[0m"
            awk -F "|" '!seen[$2, $3, $4, $5, $6, $13]++' ./musicEventsCatalogue.txt  #used chatGTP to design this line of code
            echo
            read -p "Would you like to publish the changes(Y/N)" answer

            while true; do
                case $answer in
                    [yY] | [yY][Ee][Ss] )
                        echo -e "\v\t\e[33mDELETED duplicate records\e[0m"
                        awk -F "|" '!seen[$2, $3, $4, $5, $6, $13]++' ./musicEventsCatalogue.txt > ./tmpfile && mv ./tmpfile ./musicEventsCatalogue.txt
                        break
                    ;;

                    [nN] | [nN][Oo] )
                        echo -e "\v\t\e[33mRecords have NOT been deleted\e[0m"
                        break           
                    ;;

                    [qQ] )
                       break
                    ;;

                    *)
                        echo -e "\v\tInvalid input. Please type Yes or No"
                        read -p "DELETE DUPLICATE RECORDS (Y/N): " answer
                    ;;
                esac
            done
        ;;

        6)
            exit 0
        ;;
        
    esac 
done


