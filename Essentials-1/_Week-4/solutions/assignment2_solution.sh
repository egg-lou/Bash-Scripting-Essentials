#!/bin/bash

# Solution for Assignment 2: System Monitor
echo "System Resource Monitor"
echo "--------------------"

# Configuration
LOG_DIR="logs"
LOG_FILE="$LOG_DIR/system_monitor.log"
ALERT_FILE="$LOG_DIR/alerts.log"
INTERVAL=5  # Seconds between checks

# Thresholds
CPU_THRESHOLD=80    # Percentage
MEM_THRESHOLD=80    # Percentage
DISK_THRESHOLD=90   # Percentage

# Create log directory
mkdir -p "$LOG_DIR"

# Error handling
set -e
trap 'handle_error $? $LINENO' ERR

# Error handling function
handle_error() {
    local exit_code=$1
    local line_number=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error at line $line_number (exit code $exit_code)" >> "$ALERT_FILE"
}

# Function to log message
log_message() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

# Function to log alert
log_alert() {
    local message=$1
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ALERT: $message" >> "$ALERT_FILE"
    echo "ALERT: $message"
}

# Function to get CPU usage
get_cpu_usage() {
    local cpu_usage
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    else
        # For Windows/Git Bash, simulate CPU usage (random value)
        cpu_usage=$((RANDOM % 100))
    fi
    echo "$cpu_usage"
}

# Function to get memory usage
get_memory_usage() {
    local mem_usage
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        mem_usage=$(free | grep Mem | awk '{print ($3/$2) * 100}' | cut -d. -f1)
    else
        # For Windows/Git Bash, simulate memory usage
        mem_usage=$((RANDOM % 100))
    fi
    echo "$mem_usage"
}

# Function to get disk usage
get_disk_usage() {
    local disk_usage
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        disk_usage=$(df -h / | tail -1 | awk '{print $5}' | cut -d% -f1)
    else
        # For Windows/Git Bash, get C: drive usage
        disk_usage=$(df -h / | tail -1 | awk '{print $5}' | cut -d% -f1)
    fi
    echo "$disk_usage"
}

# Function to check CPU
check_cpu() {
    local cpu_usage=$(get_cpu_usage)
    log_message "CPU Usage: $cpu_usage%"
    
    if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
        log_alert "High CPU usage: $cpu_usage%"
    fi
}

# Function to check memory
check_memory() {
    local mem_usage=$(get_memory_usage)
    log_message "Memory Usage: $mem_usage%"
    
    if [ "$mem_usage" -gt "$MEM_THRESHOLD" ]; then
        log_alert "High memory usage: $mem_usage%"
    fi
}

# Function to check disk
check_disk() {
    local disk_usage=$(get_disk_usage)
    log_message "Disk Usage: $disk_usage%"
    
    if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
        log_alert "High disk usage: $disk_usage%"
    fi
}

# Function to generate summary report
generate_summary() {
    local cpu_usage=$(get_cpu_usage)
    local mem_usage=$(get_memory_usage)
    local disk_usage=$(get_disk_usage)
    
    echo -e "\nSystem Resource Summary"
    echo "----------------------"
    echo "CPU Usage: $cpu_usage%"
    echo "Memory Usage: $mem_usage%"
    echo "Disk Usage: $disk_usage%"
    echo "----------------------"
}

# Function to show logs
show_logs() {
    echo -e "\nRecent System Logs:"
    tail -n 5 "$LOG_FILE"
    
    echo -e "\nRecent Alerts:"
    tail -n 5 "$ALERT_FILE"
}

# Main monitoring function
monitor_system() {
    while true; do
        check_cpu
        check_memory
        check_disk
        generate_summary
        sleep "$INTERVAL"
    done
}

# Main menu
show_menu() {
    echo -e "\nSystem Monitor Menu"
    echo "1. Start monitoring"
    echo "2. Show logs"
    echo "3. Change monitoring interval"
    echo "4. Exit"
    read -p "Select an option: " choice
    
    case $choice in
        1)
            echo "Starting system monitoring (Press Ctrl+C to stop)..."
            monitor_system
            ;;
        2)
            show_logs
            ;;
        3)
            read -p "Enter new interval in seconds: " new_interval
            if [[ "$new_interval" =~ ^[0-9]+$ ]]; then
                INTERVAL=$new_interval
                echo "Monitoring interval updated to $INTERVAL seconds"
            else
                echo "Invalid interval"
            fi
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
echo "System Monitor initialized"
while true; do
    show_menu
done 