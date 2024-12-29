#!/bin/bash

# Example script demonstrating text processing commands
echo "Text Processing Examples"
echo "----------------------"

# Create a sample text file
echo "Creating sample text file..."
cat > sample.txt << EOL
apple
banana
cherry
apple
dates
elderberry
banana
fig
EOL
echo "Created sample.txt with fruit names"

# Display the file contents
echo -e "\nDisplaying file contents using cat:"
cat sample.txt

# Count lines, words, and characters
echo -e "\nCounting lines, words, and characters:"
wc sample.txt

# Sort the file
echo -e "\nSorting the file:"
sort sample.txt

# Remove duplicates
echo -e "\nSorting and removing duplicates:"
sort sample.txt | uniq

# Search for a pattern
echo -e "\nSearching for entries containing 'berry':"
grep "berry" sample.txt

# Display first 3 lines
echo -e "\nDisplaying first 3 lines:"
head -n 3 sample.txt

# Display last 2 lines
echo -e "\nDisplaying last 2 lines:"
tail -n 2 sample.txt

# Clean up
echo -e "\nCleaning up..."
rm sample.txt
echo "Done!" 