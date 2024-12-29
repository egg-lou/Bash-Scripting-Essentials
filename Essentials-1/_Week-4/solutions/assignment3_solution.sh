#!/bin/bash

# Solution for Assignment 3: Advanced File Processor
echo "Advanced File Processor"
echo "--------------------"

# Configuration
MAX_PARALLEL_JOBS=4
PROCESSED_DIR="processed"
FAILED_DIR="failed"
LOG_FILE="processing.log"
PROGRESS_FILE="progress.txt"

# Initialize arrays for tracking
declare -A processed_files
declare -A failed_files

# Error handling
set -e
trap 'handle_error $? $LINENO' ERR

# Error handling function
handle_error() {
    local exit_code=$1
    local line_number=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error at line $line_number (exit code $exit_code)" >> "$LOG_FILE"
}

# Function to log message
log_message() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

# Function to update progress
update_progress() {
    local current=$1
    local total=$2
    local percentage=$((current * 100 / total))
    echo -ne "Progress: [$percentage%] [$current/$total]\r"
    echo "$current/$total" > "$PROGRESS_FILE"
}

# Function to process a single file
process_file() {
    local file=$1
    local base_name=$(basename "$file")
    
    # Create output directories if they don't exist
    mkdir -p "$PROCESSED_DIR" "$FAILED_DIR"
    
    # Process the file based on its type
    case "${file,,}" in
        *.txt)
            # Text file processing
            log_message "Processing text file: $base_name"
            {
                wc -l "$file" > "$PROCESSED_DIR/$base_name.stats"
                sort "$file" > "$PROCESSED_DIR/$base_name.sorted"
                processed_files["$base_name"]=1
            } || {
                failed_files["$base_name"]="Text processing failed"
                mv "$file" "$FAILED_DIR/"
                return 1
            }
            ;;
        *.log)
            # Log file processing
            log_message "Processing log file: $base_name"
            {
                grep -i "error" "$file" > "$PROCESSED_DIR/$base_name.errors"
                grep -i "warning" "$file" > "$PROCESSED_DIR/$base_name.warnings"
                processed_files["$base_name"]=1
            } || {
                failed_files["$base_name"]="Log processing failed"
                mv "$file" "$FAILED_DIR/"
                return 1
            }
            ;;
        *.csv)
            # CSV file processing
            log_message "Processing CSV file: $base_name"
            {
                sort -t',' -k1 "$file" > "$PROCESSED_DIR/$base_name.sorted"
                cut -d',' -f1 "$file" | sort | uniq -c > "$PROCESSED_DIR/$base_name.summary"
                processed_files["$base_name"]=1
            } || {
                failed_files["$base_name"]="CSV processing failed"
                mv "$file" "$FAILED_DIR/"
                return 1
            }
            ;;
        *)
            # Unknown file type
            log_message "Unknown file type: $base_name"
            failed_files["$base_name"]="Unknown file type"
            mv "$file" "$FAILED_DIR/"
            return 1
            ;;
    esac
    
    return 0
}

# Function to process files in parallel
process_files_parallel() {
    local dir=$1
    local file_count=$(find "$dir" -type f | wc -l)
    local current=0
    local job_count=0
    
    log_message "Starting parallel processing of $file_count files"
    
    # Process files in parallel
    find "$dir" -type f | while read -r file; do
        ((job_count++))
        
        # Process file in background
        process_file "$file" &
        
        # Limit parallel jobs
        if [ $job_count -ge $MAX_PARALLEL_JOBS ]; then
            wait
            job_count=0
        fi
        
        ((current++))
        update_progress $current $file_count
    done
    
    # Wait for remaining jobs
    wait
    echo -e "\nProcessing complete!"
}

# Function to generate report
generate_report() {
    local report_file="processing_report.txt"
    
    {
        echo "File Processing Report"
        echo "====================="
        echo "Generated: $(date)"
        echo
        
        echo "Successfully Processed Files"
        echo "--------------------------"
        for file in "${!processed_files[@]}"; do
            echo "✓ $file"
        done
        
        echo -e "\nFailed Files"
        echo "------------"
        for file in "${!failed_files[@]}"; do
            echo "✗ $file - ${failed_files[$file]}"
        done
        
        echo -e "\nSummary"
        echo "-------"
        echo "Total files: $((${#processed_files[@]} + ${#failed_files[@]}))"
        echo "Successful: ${#processed_files[@]}"
        echo "Failed: ${#failed_files[@]}"
        
    } > "$report_file"
    
    echo "Report generated: $report_file"
}

# Main menu
show_menu() {
    echo -e "\nAdvanced File Processor Menu"
    echo "1. Process directory"
    echo "2. Show progress"
    echo "3. Generate report"
    echo "4. Exit"
    read -p "Select an option: " choice
    
    case $choice in
        1)
            read -p "Enter directory path: " dir
            if [ -d "$dir" ]; then
                process_files_parallel "$dir"
                generate_report
            else
                echo "Invalid directory"
            fi
            ;;
        2)
            if [ -f "$PROGRESS_FILE" ]; then
                read current total < "$PROGRESS_FILE"
                echo "Current progress: $current/$total files"
            else
                echo "No processing in progress"
            fi
            ;;
        3)
            generate_report
            ;;
        4)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
}

# Main loop
echo "Advanced File Processor initialized"
while true; do
    show_menu
done 