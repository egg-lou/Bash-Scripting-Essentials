#!/bin/bash

# Example script demonstrating control structures
echo "Control Structures Examples"
echo "------------------------"

# If-else statement
echo -e "\n1. If-else Example:"
read -p "Enter a number: " num

if [ "$num" -gt 10 ]; then
    echo "Number is greater than 10"
elif [ "$num" -eq 10 ]; then
    echo "Number is equal to 10"
else
    echo "Number is less than 10"
fi

# File test conditions
echo -e "\n2. File Test Example:"
read -p "Enter a filename: " filename

if [ -f "$filename" ]; then
    echo "$filename exists and is a regular file"
elif [ -d "$filename" ]; then
    echo "$filename exists and is a directory"
else
    echo "$filename does not exist"
fi

# For loop
echo -e "\n3. For Loop Example:"
echo "Counting from 1 to 5:"
for i in {1..5}; do
    echo "Number: $i"
done

# For loop with command output
echo -e "\n4. For Loop with ls Example:"
echo "Files in current directory:"
for file in $(ls); do
    echo "Found file: $file"
done

# While loop
echo -e "\n5. While Loop Example:"
counter=1
while [ $counter -le 3 ]; do
    echo "While loop iteration $counter"
    ((counter++))
done

# Until loop
echo -e "\n6. Until Loop Example:"
counter=3
until [ $counter -lt 1 ]; do
    echo "Until loop iteration $counter"
    ((counter--))
done

# Case statement
echo -e "\n7. Case Statement Example:"
read -p "Enter a color (red/green/blue): " color

case $color in
    "red")
        echo "You chose red"
        ;;
    "green")
        echo "You chose green"
        ;;
    "blue")
        echo "You chose blue"
        ;;
    *)
        echo "Unknown color"
        ;;
esac

# Break and continue
echo -e "\n8. Break and Continue Example:"
echo "Demonstrating break:"
for i in {1..5}; do
    if [ $i -eq 3 ]; then
        echo "Breaking at $i"
        break
    fi
    echo "Iteration $i"
done

echo -e "\nDemonstrating continue:"
for i in {1..5}; do
    if [ $i -eq 3 ]; then
        echo "Skipping $i"
        continue
    fi
    echo "Iteration $i"
done

echo -e "\nScript completed!" 