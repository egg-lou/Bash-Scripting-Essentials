#!/bin/bash

# Solution for Assignment 2: File Permissions Script
echo "File Permissions Assignment Solution"
echo "--------------------------------"

# Function to display permissions
show_permissions() {
    echo "Current permissions for $1:"
    ls -l "$1"
}

# Create base directory
echo "Creating directory structure..."
mkdir -p project/{scripts,docs,data}

# Create different types of files
echo -e "\nCreating files..."

# Create scripts
cat > project/scripts/backup.sh << 'EOL'
#!/bin/bash
echo "Backup script"
EOL

cat > project/scripts/process.sh << 'EOL'
#!/bin/bash
echo "Processing script"
EOL

# Create documentation
echo "Project documentation" > project/docs/readme.txt
echo "User guide" > project/docs/guide.txt

# Create data files
echo "Sample data 1" > project/data/data1.txt
echo "Sample data 2" > project/data/data2.txt

# Set permissions
echo -e "\nSetting permissions..."

# Set directory permissions (755)
echo "Setting directory permissions to 755..."
chmod 755 project project/scripts project/docs project/data
echo "Directory permissions set"

# Set script permissions (755)
echo -e "\nSetting script permissions to 755..."
chmod 755 project/scripts/*.sh
echo "Script permissions set"

# Set text file permissions (644)
echo -e "\nSetting text file permissions to 644..."
chmod 644 project/docs/*.txt project/data/*.txt
echo "Text file permissions set"

# Display results
echo -e "\nFinal permissions:"
echo "Directories:"
ls -ld project project/*/

echo -e "\nScripts:"
ls -l project/scripts/

echo -e "\nDocumentation:"
ls -l project/docs/

echo -e "\nData files:"
ls -l project/data/

# Permission explanation
echo -e "\nPermission Explanation:"
echo "Directories (755 - drwxr-xr-x):"
echo "- Owner: read, write, execute"
echo "- Group: read, execute"
echo "- Others: read, execute"

echo -e "\nScripts (755 - -rwxr-xr-x):"
echo "- Owner: read, write, execute"
echo "- Group: read, execute"
echo "- Others: read, execute"

echo -e "\nText files (644 - -rw-r--r--):"
echo "- Owner: read, write"
echo "- Group: read"
echo "- Others: read"

# Clean up
echo -e "\nCleaning up..."
rm -r project
echo "Done!" 