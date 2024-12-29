#!/bin/bash

# Example script demonstrating basic shell scripting concepts
echo "Shell Scripting Basics"
echo "--------------------"

# Variables
name="John"
age=25
city="New York"

# Using variables
echo -e "\nVariable Examples:"
echo "Name: $name"
echo "Age: $age"
echo "City: $city"

# String concatenation
full_info="$name is $age years old and lives in $city"
echo -e "\nConcatenated string:"
echo "$full_info"

# Arithmetic operations
echo -e "\nArithmetic Examples:"
a=5
b=3
sum=$((a + b))
product=$((a * b))
echo "$a + $b = $sum"
echo "$a * $b = $product"

# User input
echo -e "\nUser Input Example:"
read -p "Enter your name: " user_name
read -p "Enter your age: " user_age
echo "Hello, $user_name! You are $user_age years old."

# Command substitution
echo -e "\nCommand Substitution Example:"
current_date=$(date)
echo "Current date and time: $current_date"
files_count=$(ls | wc -l)
echo "Number of files in current directory: $files_count"

# Environment variables
echo -e "\nEnvironment Variables:"
echo "Home Directory: $HOME"
echo "Current User: $USER"
echo "Shell: $SHELL"

# Special variables
echo -e "\nSpecial Variables:"
echo "Script Name: $0"
echo "Process ID: $$"
echo "Current Directory: $PWD"

# Exit status
ls /nonexistent 2>/dev/null
echo -e "\nExit status of last command: $?"

echo -e "\nScript completed!" 