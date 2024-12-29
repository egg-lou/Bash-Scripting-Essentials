#!/bin/bash

# Advanced File Management System
# Main script that ties all components together

# Import library files
source "lib/core.sh"
source "lib/ui.sh"
source "lib/utils.sh"

# Configuration
CONFIG_FILE="config/settings.conf"
LOG_FILE="logs/operations.log"

# Initialize system
init_system() {
    echo "Initializing File Management System..."
    
    # Create required directories
    mkdir -p config logs backup
    
    # Create default config if not exists
    if [ ! -f "$CONFIG_FILE" ]; then
        create_default_config
    fi
    
    # Load configuration
    load_config
    
    # Initialize logging
    init_logging
    
    echo "Initialization complete"
}

# Main program loop
main() {
    init_system
    
    while true; do
        show_main_menu
        read -p "Select an option: " choice
        
        case $choice in
            1) scan_directory ;;
            2) organize_files ;;
            3) search_files ;;
            4) manage_backups ;;
            5) show_statistics ;;
            6) configure_system ;;
            7) 
                echo "Goodbye!"
                exit 0
                ;;
            *)
                echo "Invalid option"
                ;;
        esac
    done
}

# Start the program
main 