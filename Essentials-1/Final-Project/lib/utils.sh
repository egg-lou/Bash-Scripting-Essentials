#!/bin/bash

# Utility functions for file management system

# Function to initialize logging
init_logging() {
    mkdir -p logs
    touch "$LOG_FILE"
    log_info "Logging initialized"
}

# Function to log information
log_info() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $message" >> "$LOG_FILE"
}

# Function to log error
log_error() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $message" >> "$LOG_FILE"
    show_error "$message"
}

# Function to log warning
log_warning() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') [WARNING] $message" >> "$LOG_FILE"
    show_warning "$message"
}

# Function to create default configuration
create_default_config() {
    cat > "$CONFIG_FILE" << EOL
# File Management System Configuration

# Default directories
DEFAULT_SCAN_DIR=\$HOME
DEFAULT_BACKUP_DIR=backup

# File patterns (regex)
DOCUMENT_PATTERNS="\\.pdf|\\.docx?|\\.txt|\\.rtf"
IMAGE_PATTERNS="\\.jpe?g|\\.png|\\.gif|\\.bmp"
AUDIO_PATTERNS="\\.mp3|\\.wav|\\.flac|\\.m4a"
VIDEO_PATTERNS="\\.mp4|\\.avi|\\.mkv|\\.mov"
ARCHIVE_PATTERNS="\\.zip|\\.rar|\\.tar\\.gz|\\.7z"
CODE_PATTERNS="\\.sh|\\.py|\\.js|\\.cpp|\\.java"

# Logging configuration
LOG_LEVEL=INFO
MAX_LOG_SIZE=10M
ROTATE_LOGS=true

# Backup configuration
BACKUP_COMPRESS=true
MAX_BACKUPS=10
AUTO_BACKUP=false
EOL
    
    log_info "Default configuration created"
}

# Function to load configuration
load_config() {
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
        log_info "Configuration loaded from $CONFIG_FILE"
    else
        log_error "Configuration file not found"
        return 1
    fi
}

# Function to save configuration
save_config() {
    if [ -f "$CONFIG_FILE" ]; then
        cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
    fi
    
    declare -p | grep "^declare -x CONFIG_" > "$CONFIG_FILE"
    log_info "Configuration saved to $CONFIG_FILE"
}

# Function to get file checksum
get_checksum() {
    local file=$1
    if [ -f "$file" ]; then
        sha256sum "$file" | cut -d' ' -f1
    else
        return 1
    fi
}

# Function to get file type
get_file_type() {
    local file=$1
    file --mime-type "$file" | cut -d: -f2 | tr -d ' '
}

# Function to get human readable size
get_human_size() {
    local size=$1
    local units=("B" "K" "M" "G" "T")
    local unit=0
    
    while [ $size -gt 1024 ]; do
        size=$((size / 1024))
        ((unit++))
    done
    
    echo "$size${units[$unit]}"
}

# Function to validate path
validate_path() {
    local path=$1
    if [[ "$path" =~ ^[a-zA-Z0-9_/.-]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to clean filename
clean_filename() {
    local filename=$1
    echo "$filename" | tr -cd '[:alnum:]._-'
}

# Function to get relative path
get_relative_path() {
    local path=$1
    local base=$2
    realpath --relative-to="$base" "$path"
}

# Function to rotate logs
rotate_logs() {
    if [ -f "$LOG_FILE" ]; then
        local size=$(stat -f%z "$LOG_FILE" 2>/dev/null || stat -c%s "$LOG_FILE")
        if [ $size -gt $((10*1024*1024)) ]; then  # 10MB
            mv "$LOG_FILE" "$LOG_FILE.$(date +%Y%m%d_%H%M%S)"
            touch "$LOG_FILE"
            log_info "Log file rotated"
        fi
    fi
}

# Function to clean old backups
clean_old_backups() {
    local max_backups=${1:-10}
    local backup_dir="backup"
    
    if [ -d "$backup_dir" ]; then
        # List backups by date and keep only the latest $max_backups
        ls -t "$backup_dir"/*.tar.gz 2>/dev/null | 
        tail -n +$((max_backups + 1)) |
        while read backup; do
            rm "$backup"
            log_info "Removed old backup: $backup"
        done
    fi
}

# Function to validate configuration
validate_config() {
    local valid=true
    
    # Check required directories
    for dir in "$DEFAULT_SCAN_DIR" "$DEFAULT_BACKUP_DIR"; do
        if [ ! -d "$dir" ]; then
            log_warning "Directory not found: $dir"
            valid=false
        fi
    done
    
    # Check log file permissions
    if [ ! -w "$LOG_FILE" ]; then
        log_error "Cannot write to log file: $LOG_FILE"
        valid=false
    fi
    
    # Check pattern syntax
    for pattern in "$DOCUMENT_PATTERNS" "$IMAGE_PATTERNS" "$AUDIO_PATTERNS" "$VIDEO_PATTERNS"; do
        if ! echo "test" | grep -E "$pattern" >/dev/null 2>&1; then
            log_error "Invalid pattern: $pattern"
            valid=false
        fi
    done
    
    $valid
}

# Function to initialize system
init_system() {
    # Create required directories
    mkdir -p config logs backup
    
    # Create default config if not exists
    if [ ! -f "$CONFIG_FILE" ]; then
        create_default_config
    fi
    
    # Load and validate configuration
    load_config && validate_config
    
    # Initialize logging
    init_logging
    
    # Clean old logs and backups
    rotate_logs
    clean_old_backups
    
    log_info "System initialized"
} 