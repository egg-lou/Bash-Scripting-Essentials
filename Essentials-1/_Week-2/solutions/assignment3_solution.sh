#!/bin/bash

# Solution for Assignment 3: File Organization
echo "File Organization Assignment Solution"
echo "---------------------------------"

# Function to create backup
create_backup() {
    local source_dir="$1"
    local backup_dir="$2"
    
    echo "Creating backup of $source_dir..."
    tar -czf "$backup_dir/backup_$(date +%Y%m%d).tar.gz" "$source_dir"
}

# Function to organize files by date
organize_by_date() {
    local source_dir="$1"
    local target_dir="$2"
    
    echo "Organizing files by creation date..."
    
    # Process each .txt file
    find "$source_dir" -type f -name "*.txt" | while read file; do
        # Get creation date
        creation_date=$(date -r "$file" +%Y-%m-%d)
        
        # Create date directory if it doesn't exist
        mkdir -p "$target_dir/$creation_date"
        
        # Copy file to appropriate directory
        cp "$file" "$target_dir/$creation_date/"
        
        echo "Moved $(basename "$file") to $creation_date directory"
    done
}

# Function to generate report
generate_report() {
    local target_dir="$1"
    local report_file="$2"
    
    echo "Generating organization report..."
    
    # Create report header
    cat > "$report_file" << EOL
File Organization Report
Generated on: $(date)
======================

Files by Date:
EOL
    
    # Add file listing to report
    for date_dir in "$target_dir"/*; do
        if [ -d "$date_dir" ]; then
            echo -e "\nDate: $(basename "$date_dir")" >> "$report_file"
            echo "Files:" >> "$report_file"
            ls -l "$date_dir" >> "$report_file"
        fi
    done
    
    # Add summary
    echo -e "\nSummary:" >> "$report_file"
    echo "Total directories: $(find "$target_dir" -type d | wc -l)" >> "$report_file"
    echo "Total files: $(find "$target_dir" -type f | wc -l)" >> "$report_file"
}

# Main script
echo "Setting up test environment..."

# Create test directory structure
mkdir -p test_files
cd test_files

# Create sample text files with different dates
for i in {1..5}; do
    echo "Content $i" > "file$i.txt"
    # Set different timestamps
    touch -d "$i days ago" "file$i.txt"
done

# Create directories for organization
mkdir -p {backup,organized}

# Create backup
create_backup "." "backup"

# Organize files
organize_by_date "." "organized"

# Generate report
generate_report "organized" "organization_report.txt"

# Display report
echo -e "\nReport contents:"
cat organization_report.txt

# Clean up
echo -e "\nCleaning up..."
cd ..
rm -r test_files
echo "Done!" 