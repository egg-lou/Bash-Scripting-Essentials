#!/bin/bash

# User interface functions for file management system

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to show main menu
show_main_menu() {
    clear
    echo -e "${BLUE}File Management System${NC}"
    echo "===================="
    echo
    echo "1. Scan Directory"
    echo "2. Organize Files"
    echo "3. Search Files"
    echo "4. Manage Backups"
    echo "5. Show Statistics"
    echo "6. Configure System"
    echo "7. Exit"
    echo
}

# Function to show backup menu
show_backup_menu() {
    clear
    echo -e "${BLUE}Backup Management${NC}"
    echo "================="
    echo
    echo "1. Create Backup"
    echo "2. Restore Backup"
    echo "3. List Backups"
    echo "4. Delete Backup"
    echo "5. Back to Main Menu"
    echo
    
    read -p "Select an option: " choice
    case $choice in
        1) create_backup ;;
        2) restore_backup ;;
        3) list_backups ;;
        4) delete_backup ;;
        5) return ;;
        *) echo -e "${RED}Invalid option${NC}" ;;
    esac
}

# Function to show configuration menu
show_config_menu() {
    clear
    echo -e "${BLUE}System Configuration${NC}"
    echo "==================="
    echo
    echo "1. Set Default Directory"
    echo "2. Configure File Patterns"
    echo "3. Set Backup Location"
    echo "4. Configure Logging"
    echo "5. Back to Main Menu"
    echo
    
    read -p "Select an option: " choice
    case $choice in
        1) set_default_directory ;;
        2) configure_patterns ;;
        3) set_backup_location ;;
        4) configure_logging ;;
        5) return ;;
        *) echo -e "${RED}Invalid option${NC}" ;;
    esac
}

# Function to display progress bar
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local completed=$((width * current / total))
    
    printf "\rProgress: ["
    printf "%${completed}s" | tr ' ' '#'
    printf "%$((width - completed))s" | tr ' ' '-'
    printf "] %d%%" $percentage
}

# Function to display success message
show_success() {
    echo -e "${GREEN}Success: $1${NC}"
}

# Function to display error message
show_error() {
    echo -e "${RED}Error: $1${NC}"
}

# Function to display warning message
show_warning() {
    echo -e "${YELLOW}Warning: $1${NC}"
}

# Function to display file information
show_file_info() {
    local file=$1
    
    if [ ! -f "$file" ]; then
        show_error "File not found: $file"
        return 1
    fi
    
    echo -e "${BLUE}File Information:${NC}"
    echo "=================="
    echo "Name: $(basename "$file")"
    echo "Size: $(du -h "$file" | cut -f1)"
    echo "Type: $(file -b "$file")"
    echo "Modified: $(date -r "$file")"
    echo "Permissions: $(stat -c %A "$file")"
}

# Function to display directory statistics
show_directory_stats() {
    local dir=$1
    
    if [ ! -d "$dir" ]; then
        show_error "Directory not found: $dir"
        return 1
    fi
    
    echo -e "${BLUE}Directory Statistics:${NC}"
    echo "===================="
    echo "Total size: $(du -sh "$dir" | cut -f1)"
    echo "Files: $(find "$dir" -type f | wc -l)"
    echo "Directories: $(find "$dir" -type d | wc -l)"
    echo
    echo "File types:"
    find "$dir" -type f | sed 's/.*\.//' | sort | uniq -c | sort -nr
}

# Function to confirm action
confirm_action() {
    local message=$1
    local response
    
    echo -e "${YELLOW}$message${NC}"
    read -p "Are you sure? (y/n): " response
    
    case $response in
        [Yy]* ) return 0 ;;
        * ) return 1 ;;
    esac
}

# Function to select directory
select_directory() {
    local prompt=$1
    local dir
    
    while true; do
        read -p "$prompt: " dir
        if [ -d "$dir" ]; then
            echo "$dir"
            return 0
        else
            show_error "Invalid directory"
        fi
    done
}

# Function to select file
select_file() {
    local prompt=$1
    local pattern=$2
    local file
    
    while true; do
        read -p "$prompt: " file
        if [ -f "$file" ] && [[ $file =~ $pattern ]]; then
            echo "$file"
            return 0
        else
            show_error "Invalid file"
        fi
    done
} 