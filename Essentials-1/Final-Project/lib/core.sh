#!/bin/bash

# Core functionality for file management system

# File categorization patterns
declare -A FILE_PATTERNS=(
    ["documents"]="\.pdf$|\.docx?$|\.txt$|\.rtf$"
    ["images"]="\.jpe?g$|\.png$|\.gif$|\.bmp$"
    ["audio"]="\.mp3$|\.wav$|\.flac$|\.m4a$"
    ["video"]="\.mp4$|\.avi$|\.mkv$|\.mov$"
    ["archives"]="\.zip$|\.rar$|\.tar\.gz$|\.7z$"
    ["code"]="\.sh$|\.py$|\.js$|\.cpp$|\.java$"
)

# Function to scan directory
scan_directory() {
    local target_dir
    read -p "Enter directory path to scan: " target_dir
    
    if [ ! -d "$target_dir" ]; then
        log_error "Invalid directory: $target_dir"
        return 1
    fi
    
    log_info "Scanning directory: $target_dir"
    local file_count=0
    local dir_count=0
    
    # Create temporary file for results
    local temp_file=$(mktemp)
    
    # Scan directory
    while IFS= read -r -d '' file; do
        if [ -f "$file" ]; then
            ((file_count++))
            echo "$file" >> "$temp_file"
        elif [ -d "$file" ]; then
            ((dir_count++))
        fi
    done < <(find "$target_dir" -print0)
    
    # Display results
    echo "Scan complete:"
    echo "Files found: $file_count"
    echo "Directories found: $dir_count"
    
    # Save results for further processing
    mv "$temp_file" "logs/last_scan.txt"
}

# Function to organize files
organize_files() {
    local source_dir
    read -p "Enter directory to organize: " source_dir
    
    if [ ! -d "$source_dir" ]; then
        log_error "Invalid directory: $source_dir"
        return 1
    fi
    
    # Create category directories
    for category in "${!FILE_PATTERNS[@]}"; do
        mkdir -p "$source_dir/$category"
    done
    
    # Process each file
    local moved_count=0
    while IFS= read -r -d '' file; do
        if [ ! -f "$file" ]; then
            continue
        fi
        
        local filename=$(basename "$file")
        local moved=0
        
        # Check each category
        for category in "${!FILE_PATTERNS[@]}"; do
            if [[ "$filename" =~ ${FILE_PATTERNS[$category]} ]]; then
                # Move file to category directory
                mv "$file" "$source_dir/$category/"
                ((moved_count++))
                moved=1
                log_info "Moved $filename to $category"
                break
            fi
        done
        
        # Move unmatched files to misc
        if [ $moved -eq 0 ]; then
            mkdir -p "$source_dir/misc"
            mv "$file" "$source_dir/misc/"
            log_info "Moved $filename to misc"
            ((moved_count++))
        fi
    done < <(find "$source_dir" -type f -print0)
    
    echo "Organization complete:"
    echo "Files moved: $moved_count"
}

# Function to search files
search_files() {
    local search_term
    read -p "Enter search term: " search_term
    
    if [ -z "$search_term" ]; then
        log_error "Search term cannot be empty"
        return 1
    fi
    
    echo "Searching for files matching: $search_term"
    
    # Search in last scanned directory
    if [ -f "logs/last_scan.txt" ]; then
        while IFS= read -r file; do
            if [[ "$(basename "$file")" =~ $search_term ]]; then
                echo "Found: $file"
            fi
        done < "logs/last_scan.txt"
    else
        log_error "No scan data available. Please scan a directory first."
        return 1
    fi
}

# Function to create backup
create_backup() {
    local source_dir
    read -p "Enter directory to backup: " source_dir
    
    if [ ! -d "$source_dir" ]; then
        log_error "Invalid directory: $source_dir"
        return 1
    fi
    
    local backup_file="backup/backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    
    echo "Creating backup..."
    if tar -czf "$backup_file" -C "$source_dir" .; then
        log_info "Backup created: $backup_file"
        echo "Backup created successfully: $backup_file"
    else
        log_error "Backup failed"
        return 1
    fi
}

# Function to restore backup
restore_backup() {
    local backup_file
    local target_dir
    
    # List available backups
    echo "Available backups:"
    ls -1 backup/*.tar.gz 2>/dev/null
    
    read -p "Enter backup file to restore: " backup_file
    read -p "Enter target directory: " target_dir
    
    if [ ! -f "$backup_file" ]; then
        log_error "Invalid backup file: $backup_file"
        return 1
    fi
    
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
    fi
    
    echo "Restoring backup..."
    if tar -xzf "$backup_file" -C "$target_dir"; then
        log_info "Backup restored to: $target_dir"
        echo "Backup restored successfully"
    else
        log_error "Restore failed"
        return 1
    fi
}

# Function to generate statistics
generate_statistics() {
    local target_dir
    read -p "Enter directory for statistics: " target_dir
    
    if [ ! -d "$target_dir" ]; then
        log_error "Invalid directory: $target_dir"
        return 1
    fi
    
    echo "Generating statistics..."
    
    # File type statistics
    echo "File types:"
    find "$target_dir" -type f | sed 's/.*\.//' | sort | uniq -c | sort -nr
    
    # Size statistics
    echo -e "\nTotal size:"
    du -sh "$target_dir"
    
    # File count by category
    echo -e "\nFiles by category:"
    for category in "${!FILE_PATTERNS[@]}"; do
        local count=$(find "$target_dir" -type f -regextype posix-extended -regex ".*${FILE_PATTERNS[$category]}" | wc -l)
        echo "$category: $count files"
    done
} 