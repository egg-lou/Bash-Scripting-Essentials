#!/bin/bash

# Example script demonstrating error handling in Bash
echo "Error Handling Demo"
echo "-----------------"

# Set up error handling
set -e  # Exit on error
trap 'handle_error $? $LINENO' ERR

# Error handling function
handle_error() {
    local exit_code=$1
    local line_number=$2
    echo "Error: Command failed at line $line_number with exit code $exit_code"
    cleanup
    exit $exit_code
}

# Cleanup function
cleanup() {
    echo "Performing cleanup..."
    [ -d "$temp_dir" ] && rm -rf "$temp_dir"
    [ -f "$temp_file" ] && rm -f "$temp_file"
}

# Create temporary directory and file
temp_dir=$(mktemp -d)
temp_file=$(mktemp)
echo "Created temporary files"

# Function to check command existence
check_command() {
    local cmd=$1
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: Required command '$cmd' not found"
        return 1
    fi
    return 0
}

# Function to validate input
validate_number() {
    local num=$1
    if [[ ! $num =~ ^[0-9]+$ ]]; then
        echo "Error: '$num' is not a valid number"
        return 1
    fi
    return 0
}

# Function demonstrating file operations with error checking
process_file() {
    local file=$1
    
    # Check if file exists
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' does not exist"
        return 1
    fi
    
    # Check if file is readable
    if [ ! -r "$file" ]; then
        echo "Error: File '$file' is not readable"
        return 2
    fi
    
    # Try to process file
    echo "Processing file: $file"
    cat "$file" > "$temp_file" || return 3
    
    return 0
}

# Example usage with error handling
echo -e "\n1. Command checking:"
if check_command "ls"; then
    echo "Command 'ls' is available"
else
    echo "Command 'ls' is not available"
fi

echo -e "\n2. Input validation:"
numbers=(5 "abc" 10 "-1")
for num in "${numbers[@]}"; do
    if validate_number "$num"; then
        echo "'$num' is valid"
    else
        echo "'$num' is invalid"
    fi
done

echo -e "\n3. File operations:"
# Try to process non-existent file
process_file "nonexistent.txt" || echo "Failed to process file"

# Create and process a test file
echo "Test content" > "$temp_dir/test.txt"
process_file "$temp_dir/test.txt" && echo "Successfully processed file"

echo -e "\n4. Demonstrating set -e:"
{
    set -e
    echo "This will work"
    nonexistent_command || true  # This will be caught by trap
    echo "This won't be reached"
} || echo "Command failed but script continues"

echo -e "\n5. Demonstrating error reporting:"
function_with_error() {
    local line=$LINENO
    echo "Current line number: $line"
    return 1
}

function_with_error || echo "Error occurred at line $LINENO"

# Clean up at the end
trap cleanup EXIT
echo -e "\nScript completed!" 