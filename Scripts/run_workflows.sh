#!/bin/bash

# Already inside the repository
echo "Starting workflow..."

# Create CSV file with header
echo "Name,Email,Slack Username,Area of Interest" > combined_output.csv

# Function to convert 4 lines into one CSV line
add_to_csv() {
    local out="$1"
    local name=$(echo "$out"  | sed -n '1p')
    local email=$(echo "$out" | sed -n '2p')
    local slack=$(echo "$out" | sed -n '3p')
    local area=$(echo "$out"  | sed -n '4p')
    echo "$name,$email,$slack,$area" >> combined_output.csv
}

# Run Python scripts
for file in Scripts/*.py; do
    [ -f "$file" ] && add_to_csv "$(python3 "$file")"
done

# Run JavaScript scripts
for file in Scripts/*.js; do
    [ -f "$file" ] && add_to_csv "$(node "$file")"
done

# Run R scripts
for file in Scripts/*.R; do
    [ -f "$file" ] && add_to_csv "$(Rscript "$file")"
done

# Run Ruby scripts
for file in Scripts/*.rb; do
    [ -f "$file" ] && add_to_csv "$(ruby "$file")"
done

# Show result
echo "✅ CSV file generated: combined_output.csv"
cat combined_output.csv
