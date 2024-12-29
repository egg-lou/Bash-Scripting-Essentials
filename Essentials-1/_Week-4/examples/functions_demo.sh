#!/bin/bash

# Example script demonstrating functions in Bash
echo "Functions Demo"
echo "-------------"

# Basic function
function hello() {
    echo "Hello, World!"
}

# Function with parameters
function greet() {
    local name=$1
    echo "Hello, $name!"
}

# Function with return value
function add() {
    local result=$(($1 + $2))
    echo $result
}

# Function with multiple return values using echo
function get_user_info() {
    echo "John Doe"
    echo "30"
    echo "New York"
}

# Function with local variables
function calculate_area() {
    local length=$1
    local width=$2
    local area=$((length * width))
    echo "Area is: $area"
}

# Function with default parameter
function greet_with_default() {
    local name=${1:-"Guest"}
    echo "Welcome, $name!"
}

# Function that uses global variable
GLOBAL_VAR="I am global"
function show_scope() {
    local local_var="I am local"
    echo "Global: $GLOBAL_VAR"
    echo "Local: $local_var"
}

# Recursive function
function factorial() {
    local n=$1
    if [ $n -le 1 ]; then
        echo 1
    else
        local prev=$(factorial $((n-1)))
        echo $((n * prev))
    done
}

# Function with error handling
function divide() {
    if [ $2 -eq 0 ]; then
        echo "Error: Division by zero"
        return 1
    fi
    echo $((1 / $2))
    return 0
}

# Demo all functions
echo -e "\n1. Basic function:"
hello

echo -e "\n2. Function with parameters:"
greet "Alice"

echo -e "\n3. Function with return value:"
sum=$(add 5 3)
echo "5 + 3 = $sum"

echo -e "\n4. Function with multiple return values:"
read name age city <<< $(get_user_info)
echo "Name: $name"
echo "Age: $age"
echo "City: $city"

echo -e "\n5. Function with local variables:"
calculate_area 5 4

echo -e "\n6. Function with default parameter:"
greet_with_default
greet_with_default "Bob"

echo -e "\n7. Function demonstrating scope:"
show_scope

echo -e "\n8. Recursive function (factorial):"
result=$(factorial 5)
echo "Factorial of 5 is: $result"

echo -e "\n9. Function with error handling:"
divide 10 2
divide 10 0

echo -e "\nScript completed!" 