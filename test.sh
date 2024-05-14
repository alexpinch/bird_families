#!/bin/bash
# Alex Pinch, May 14 2024
line_count=$(wc -l < birds.csv)
random_line=$((RANDOM % (line_count - 1) + 2))
answer=$(awk -v line="$random_line" 'NR == line {print $0}' birds.csv | cut -d ',' -f1)
echo "Selected line: $random_line"
echo "Answer: $answer"
read -p "Guess a bird: " guess
if [ "$guess" = "$answer" ]; then
    echo "Correct"
else
    # Look for the guess in birds.csv
    guess_found=$(awk -v guess="$guess" '$0 ~ guess {print NR}' birds.csv)

    if [ -n "$guess_found" ]; then
        echo "Guess found in birds.csv at line $guess_found"

        # Check if any of the fields on $random_line match the lines on $guess_found
        fields_random_line=$(awk -v line="$random_line" 'NR == line' birds.csv)
        fields_guess_found=$(awk -v line="$guess_found" 'NR == line' birds.csv)

        if [ "$fields_random_line" = "$fields_guess_found" ]; then
            echo "Fields on the random line match the fields on the guess found"
        else
            echo "Fields on the random line do not match the fields on the guess found"
        fi
    else
        echo "Guess not found in birds.csv"
    fi
fi