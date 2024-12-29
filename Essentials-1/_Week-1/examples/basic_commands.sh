#!/bin/bash

# This script demonstrates basic Bash commands
# Run this script to see how each command works

echo "Welcome to Basic Bash Commands Demo!"
echo "-----------------------------------"

# Create a test directory
echo "Creating test directory..."
mkdir test_directory
echo "Created directory: test_directory"

# Change into the directory
echo -e "\nChanging into test_directory..."
cd test_directory
echo "Current location: $(pwd)"

# Create some files
echo -e "\nCreating test files..."
touch file1.txt file2.txt file3.txt
echo "Created 3 files"

# List files
echo -e "\nListing files in current directory:"
ls -l

# Create a subdirectory
echo -e "\nCreating a subdirectory..."
mkdir subdirectory
echo "Created: subdirectory"

# Copy a file
echo -e "\nCopying file1.txt to subdirectory..."
cp file1.txt subdirectory/
echo "Copied file1.txt"

# Move a file
echo -e "\nMoving file2.txt to subdirectory..."
mv file2.txt subdirectory/
echo "Moved file2.txt"

# List contents of subdirectory
echo -e "\nContents of subdirectory:"
ls -l subdirectory

# Go back to parent directory
echo -e "\nGoing back to parent directory..."
cd ..
echo "Current location: $(pwd)"

echo -e "\nDemo completed! Try these commands yourself!" 