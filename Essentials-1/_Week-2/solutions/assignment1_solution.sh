#!/bin/bash

# Solution for Assignment 1: Text Processing
echo "Text Processing Assignment Solution"
echo "--------------------------------"

# Create the data file
echo "Creating data.txt..."
cat > data.txt << EOL
John,25,New York
Alice,30,London
Bob,22,Paris
John,35,Tokyo
Alice,28,Sydney
EOL
echo "Created data.txt with sample data"

# 1. Sort the file by names
echo -e "\n1. Sorting file by names:"
sort data.txt

# 2. Count unique names
echo -e "\n2. Counting unique names:"
cut -d',' -f1 data.txt | sort | uniq -c

# 3. Find all entries containing "John"
echo -e "\n3. Finding entries with 'John':"
grep "John" data.txt

# 4. Count total number of entries
echo -e "\n4. Total number of entries:"
wc -l data.txt

# Additional Analysis
echo -e "\nAdditional Analysis:"

# Average age
echo "Average age:"
cut -d',' -f2 data.txt | awk '{ sum += $1 } END { print sum/NR }'

# List all cities
echo -e "\nUnique cities:"
cut -d',' -f3 data.txt | sort | uniq

# Clean up
echo -e "\nCleaning up..."
rm data.txt
echo "Done!" 