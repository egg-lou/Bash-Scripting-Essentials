#!/bin/bash

# Solution for Assignment 1: Directory Structure Creation
# This script creates the required directory structure

echo "Creating workspace directory structure..."

# Create the main workspace directory
mkdir -p my_workspace

# Change into the workspace
cd my_workspace

# Create the main subdirectories
mkdir -p projects documents backups

# Create project subdirectories
cd projects
mkdir -p project1 project2
cd ..

# Create document subdirectories
cd documents
mkdir -p personal work
cd ..

# Display the created structure
echo -e "\nDirectory structure created successfully!"
echo "Here's the complete structure:"
tree

echo -e "\nNote: If 'tree' command is not found, install it or use 'ls -R' instead"
echo "You can verify the structure using: ls -R my_workspace" 