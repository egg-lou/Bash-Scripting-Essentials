#!/bin/bash

# Example script demonstrating file permissions
echo "File Permissions Examples"
echo "----------------------"

# Create a test directory
echo "Creating test directory..."
mkdir -p test_permissions
cd test_permissions

# Create different types of files
echo "Creating test files..."

# Create a regular text file
echo "This is a regular file" > regular.txt
echo "Created regular.txt"

# Create a script file
cat > script.sh << 'EOL'
#!/bin/bash
echo "This is a test script"
EOL
echo "Created script.sh"

# Create a directory
mkdir data_dir
echo "Created data_dir"

# Display initial permissions
echo -e "\nInitial permissions:"
ls -l

# Modify permissions for the script
echo -e "\nMaking script executable..."
chmod +x script.sh
echo "New permissions for script.sh:"
ls -l script.sh

# Set specific permissions for text file
echo -e "\nSetting specific permissions for regular.txt (644)..."
chmod 644 regular.txt
echo "New permissions for regular.txt:"
ls -l regular.txt

# Set directory permissions
echo -e "\nSetting directory permissions (755)..."
chmod 755 data_dir
echo "New permissions for data_dir:"
ls -ld data_dir

# Demonstrate permission meanings
echo -e "\nPermission Explanation:"
echo "For regular.txt (644):"
echo "6 (rw-) - Owner can read and write"
echo "4 (r--) - Group can read only"
echo "4 (r--) - Others can read only"

echo -e "\nFor script.sh (755):"
echo "7 (rwx) - Owner can read, write, and execute"
echo "5 (r-x) - Group can read and execute"
echo "5 (r-x) - Others can read and execute"

# Clean up
echo -e "\nCleaning up..."
cd ..
rm -r test_permissions
echo "Done!" 