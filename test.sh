#!/bin/bash
# Alex Pinch, May 14 2024
line_count=$(wc -l < birds.csv)
random_line=$((RANDOM % (line_count - 1) + 2))
answer=$(awk -v line="$random_line" 'NR == line {print $0}' birds.csv | cut -d ',' -f1)
echo "Selected line: $random_line"
echo "Answer: $answer"
read -p "Guess the mystery bird: " guess
if [ "$guess" = "$answer" ]; then
    echo "Correct!"
else
    guess_found=$(awk -v guess="$guess" '$0 ~ guess {print NR}' birds.csv)
    if [ -n "$guess_found" ]; then
        fields_random_line=$(awk -v line="$random_line" 'NR == line {print $2,$3,$4}' birds.csv)
        fields_guess_found=$(awk -v line="$guess_found" 'NR == line {print $2,$3,$4}' birds.csv)
        echo "fields_random_line: $fields_random_line"
        echo "fields_guess_found: $fields_guess_found"
        if [ "$fields_random_line" = "$fields_guess_found" ]; then
            echo "Fields on the random line match the fields on the guess found"
            
        else
            echo "Nothing in common with the mystery bird."
        fi
    else
        echo "Unrecognized bird"
    fi
fi