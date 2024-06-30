#!/bin/bash

# Check if the input CSV file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_csv_file>"
    exit 1
fi

input_file=$1
output_file="${input_file%.csv}.json"

# Read the CSV file and convert it to JSON format
awk -F',' 'BEGIN {
    print "["
    first_record = 1
}
NR > 1 {
    gsub(/"/, "\\\"", $0)  # Escape double quotes
    if (!first_record) {
        printf ",\n"
    }
    printf "  {\n"
    printf "    \"COMMON_NAME\": \"%s\",\n", $1
    printf "    \"LATIN_NAME\": \"%s\",\n", $2
    printf "    \"GENUS\": \"%s\",\n", $3
    printf "    \"FAMILY\": \"%s\",\n", $4
    printf "    \"ORDER\": \"%s\"\n", $5
    printf "  }"
    first_record = 0
}
END {
    print "\n]"
}
' "$input_file" > "$output_file"

echo "Converted $input_file to $output_file"
