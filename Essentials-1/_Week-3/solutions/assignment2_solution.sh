#!/bin/bash

# Solution for Assignment 2: File Processing Script
echo "File Processing Script"
echo "-------------------"

# Function to display usage
usage() {
    echo "Usage: $0 <directory_path>"
    echo "Example: $0 /path/to/directory"
    exit 1
}

# Function to get file extension
get_extension() {
    local filename=$1
    echo "${filename##*.}"
}

# Function to get human readable size
human_readable_size() {
    local size=$1
    if [ $size -ge 1073741824 ]; then
        echo "$(bc <<< "scale=2; $size/1073741824")G"
    elif [ $size -ge 1048576 ]; then
        echo "$(bc <<< "scale=2; $size/1048576")M"
    elif [ $size -ge 1024 ]; then
        echo "$(bc <<< "scale=2; $size/1024")K"
    else
        echo "${size}B"
    fi
}

# Check arguments
if [ $# -ne 1 ]; then
    usage
fi

directory="$1"

# Check if directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist"
    exit 1
fi

# Create temporary files
temp_file=$(mktemp)
summary_file="file_summary_$(date +%Y%m%d_%H%M%S).txt"

echo "Processing directory: $directory"
echo "Creating summary in: $summary_file"

# Process files
echo "Scanning files..."
find "$directory" -type f | while read file; do
    if [ -f "$file" ]; then
        ext=$(get_extension "$file")
        size=$(stat -f %z "$file" 2>/dev/null || stat -c %s "$file" 2>/dev/null)
        echo "$ext:$size" >> "$temp_file"
    fi
done

# Generate report
{
    echo "File Processing Report"
    echo "===================="
    echo "Generated: $(date)"
    echo "Directory: $directory"
    echo
    echo "File Type Summary"
    echo "----------------"
    
    # Process each unique extension
    sort "$temp_file" | while IFS=: read -r ext size; do
        if [ -n "$ext" ]; then
            total_size=0
            count=0
            
            # Calculate totals for this extension
            grep "^$ext:" "$temp_file" | while IFS=: read -r _ fsize; do
                total_size=$((total_size + fsize))
                count=$((count + 1))
            done
            
            # Display summary for this extension
            human_size=$(human_readable_size $total_size)
            echo ".$ext files:"
            echo "  Count: $count"
            echo "  Total size: $human_size"
            echo
        fi
    done
    
    echo "Overall Summary"
    echo "--------------"
    total_files=$(wc -l < "$temp_file")
    total_size=0
    while IFS=: read -r _ size; do
        total_size=$((total_size + size))
    done < "$temp_file"
    
    echo "Total files: $total_files"
    echo "Total size: $(human_readable_size $total_size)"
    
} > "$summary_file"

# Clean up
rm "$temp_file"

echo -e "\nReport generated successfully!"
echo "See $summary_file for details" 