#!/bin/bash

# Solution for Assignment 1: Interactive User Script
echo "User Profile Creator"
echo "------------------"

# Function to validate age
validate_age() {
    local age=$1
    if [[ ! $age =~ ^[0-9]+$ ]]; then
        return 1
    elif [ $age -lt 0 ] || [ $age -gt 150 ]; then
        return 2
    else
        return 0
    fi
}

# Function to create profile
create_profile() {
    local name=$1
    local age=$2
    local location=$3
    local filename="user_profile_$(date +%Y%m%d_%H%M%S).txt"

    cat > "$filename" << EOL
User Profile
===========
Created: $(date)

Personal Information:
-------------------
Name: $name
Age: $age
Location: $location

System Information:
-----------------
Created from: $PWD
System: $(uname -a)
EOL

    echo "Profile created: $filename"
    return 0
}

# Main script
echo -e "\nPlease provide your information:"

# Get user's name
while true; do
    read -p "Enter your name: " name
    if [ -n "$name" ]; then
        break
    else
        echo "Error: Name cannot be empty"
    fi
done

# Get user's age
while true; do
    read -p "Enter your age: " age
    validate_age "$age"
    case $? in
        0)
            break
            ;;
        1)
            echo "Error: Age must be a number"
            ;;
        2)
            echo "Error: Age must be between 0 and 150"
            ;;
    esac
done

# Get user's location
while true; do
    read -p "Enter your location: " location
    if [ -n "$location" ]; then
        break
    else
        echo "Error: Location cannot be empty"
    fi
done

# Create the profile
echo -e "\nCreating user profile..."
if create_profile "$name" "$age" "$location"; then
    echo "Profile created successfully!"
    
    # Display profile summary
    echo -e "\nProfile Summary:"
    echo "---------------"
    echo "Name: $name"
    echo "Age: $age"
    echo "Location: $location"
else
    echo "Error: Failed to create profile"
    exit 1
fi

echo -e "\nScript completed!" 