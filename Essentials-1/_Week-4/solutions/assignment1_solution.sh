#!/bin/bash

# Solution for Assignment 1: Library Management Script
echo "Library Management System"
echo "----------------------"

# Configuration
DATA_FILE="library_data.txt"
BACKUP_DIR="backups"

# Initialize associative array for books
declare -A library

# Error handling
set -e
trap 'handle_error $? $LINENO' ERR

# Error handling function
handle_error() {
    local exit_code=$1
    local line_number=$2
    echo "Error: Command failed at line $line_number with exit code $exit_code"
}

# Function to load data from file
load_data() {
    if [ -f "$DATA_FILE" ]; then
        while IFS="|" read -r id title author status; do
            library["$id"]="$title|$author|$status"
        done < "$DATA_FILE"
        echo "Data loaded successfully"
    else
        echo "No existing data file found"
    fi
}

# Function to save data to file
save_data() {
    > "$DATA_FILE"  # Clear file
    for id in "${!library[@]}"; do
        IFS="|" read -r title author status <<< "${library[$id]}"
        echo "$id|$title|$author|$status" >> "$DATA_FILE"
    done
    echo "Data saved successfully"
}

# Function to create backup
create_backup() {
    mkdir -p "$BACKUP_DIR"
    local backup_file="$BACKUP_DIR/library_$(date +%Y%m%d_%H%M%S).bak"
    cp "$DATA_FILE" "$backup_file" 2>/dev/null || true
    echo "Backup created: $backup_file"
}

# Function to add a book
add_book() {
    echo "Adding new book"
    read -p "Enter book ID: " id
    
    if [ -n "${library[$id]}" ]; then
        echo "Error: Book ID already exists"
        return 1
    fi
    
    read -p "Enter title: " title
    read -p "Enter author: " author
    library["$id"]="$title|$author|available"
    echo "Book added successfully"
    save_data
}

# Function to remove a book
remove_book() {
    read -p "Enter book ID to remove: " id
    
    if [ -z "${library[$id]}" ]; then
        echo "Error: Book not found"
        return 1
    fi
    
    unset library["$id"]
    echo "Book removed successfully"
    save_data
}

# Function to list all books
list_books() {
    echo -e "\nLibrary Catalog:"
    echo "---------------"
    printf "%-10s %-30s %-20s %-10s\n" "ID" "Title" "Author" "Status"
    echo "------------------------------------------------------------"
    
    for id in "${!library[@]}"; do
        IFS="|" read -r title author status <<< "${library[$id]}"
        printf "%-10s %-30s %-20s %-10s\n" "$id" "$title" "$author" "$status"
    done
}

# Function to search books
search_books() {
    read -p "Enter search term: " search_term
    echo -e "\nSearch Results:"
    echo "--------------"
    
    local found=0
    for id in "${!library[@]}"; do
        if [[ "${library[$id]}" =~ $search_term ]]; then
            IFS="|" read -r title author status <<< "${library[$id]}"
            printf "%-10s %-30s %-20s %-10s\n" "$id" "$title" "$author" "$status"
            ((found++))
        fi
    done
    
    echo -e "\nFound $found matches"
}

# Function to change book status
change_status() {
    read -p "Enter book ID: " id
    
    if [ -z "${library[$id]}" ]; then
        echo "Error: Book not found"
        return 1
    fi
    
    IFS="|" read -r title author status <<< "${library[$id]}"
    
    echo "Current status: $status"
    read -p "Enter new status (available/checked_out): " new_status
    
    library["$id"]="$title|$author|$new_status"
    echo "Status updated successfully"
    save_data
}

# Main menu function
show_menu() {
    echo -e "\nLibrary Management System"
    echo "1. Add book"
    echo "2. Remove book"
    echo "3. List all books"
    echo "4. Search books"
    echo "5. Change book status"
    echo "6. Create backup"
    echo "7. Exit"
    read -p "Select an option: " choice
    
    case $choice in
        1) add_book ;;
        2) remove_book ;;
        3) list_books ;;
        4) search_books ;;
        5) change_status ;;
        6) create_backup ;;
        7) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option" ;;
    esac
}

# Initialize system
echo "Initializing Library Management System..."
load_data

# Main loop
while true; do
    show_menu
done 