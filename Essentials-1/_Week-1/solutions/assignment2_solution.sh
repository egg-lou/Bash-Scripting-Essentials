#!/bin/bash

# Solution for Assignment 2: File Management
# This script demonstrates file management tasks

echo "Starting File Management Assignment..."

# Navigate to project1 directory
cd my_workspace/projects/project1

# Create 5 text files
echo "Creating 5 text files in project1..."
for i in {1..5}; do
    echo "This is file $i" > "file$i.txt"
done
echo "Created 5 files in project1"

# List the files
echo -e "\nFiles in project1:"
ls -l

# Copy 2 files to project2
echo -e "\nCopying 2 files to project2..."
cp file1.txt file2.txt ../project2/
echo "Copied files to project2"

# Move 1 file to documents/work
echo -e "\nMoving file3.txt to documents/work..."
mv file3.txt ../../documents/work/
echo "Moved file3.txt"

# List contents of each directory
echo -e "\nContents of project1:"
ls -l

echo -e "\nContents of project2:"
ls -l ../project2

echo -e "\nContents of documents/work:"
ls -l ../../documents/work

echo -e "\nFile management tasks completed!"
echo "Try navigating through these directories using cd commands" 