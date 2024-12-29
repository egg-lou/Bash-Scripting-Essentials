# Week 4: Advanced Control Structures and Functions

This week covers advanced scripting concepts including functions, error handling, and script debugging techniques.

## Learning Objectives
By the end of this week, you will be able to:
- Create and use functions in scripts
- Implement error handling
- Debug shell scripts effectively
- Use advanced control structures
- Work with arrays and associative arrays

## Prerequisites
- Completion of Weeks 1-3
- Understanding of basic scripting concepts

## Lessons

### 1. Functions
```bash
# Function definition
function greet() {
    echo "Hello, $1!"
    return 0
}

# Function with return value
function add() {
    local result=$(($1 + $2))
    echo $result
}

# Function calls
greet "John"
sum=$(add 5 3)
echo "Sum is: $sum"
```

#### Practice Exercise 4.1
Create functions that:
1. Calculate factorial of a number
2. Check if a number is prime
3. Convert temperature between Celsius and Fahrenheit

### 2. Error Handling
```bash
# Exit on error
set -e

# Custom error handling
function handle_error() {
    echo "Error on line $1"
    exit 1
}
trap 'handle_error $LINENO' ERR

# Check command success
if ! command; then
    echo "Command failed"
    exit 1
fi
```

#### Practice Exercise 4.2
Write a script that:
1. Attempts to create directories and files
2. Handles permission errors
3. Logs all errors to a file
4. Cleans up on failure

### 3. Arrays and Associative Arrays
```bash
# Regular arrays
fruits=("apple" "banana" "cherry")
echo ${fruits[0]}     # First element
echo ${fruits[@]}     # All elements
echo ${#fruits[@]}    # Array length

# Associative arrays
declare -A user
user[name]="John"
user[age]=25
echo ${user[name]}
```

#### Practice Exercise 4.3
Create a script using arrays to:
1. Store and process multiple file paths
2. Keep track of success/failure status
3. Generate a summary report

### 4. Advanced Control Structures
```bash
# Case statement
case $input in
    start)
        echo "Starting..."
        ;;
    stop)
        echo "Stopping..."
        ;;
    *)
        echo "Unknown command"
        ;;
esac

# Select menu
select option in "Start" "Stop" "Quit"
do
    case $option in
        "Start")
            echo "Starting..."
            ;;
        "Stop")
            echo "Stopping..."
            ;;
        "Quit")
            break
            ;;
    esac
done
```

## Assignments

### Assignment 1: Library Management Script
Create a script that manages a library of books:
1. Functions for adding, removing, and listing books
2. Store books in an associative array
3. Save/load data to/from a file
4. Include error handling
5. Implement an interactive menu

### Assignment 2: System Monitor
Write a script that:
1. Monitors system resources (CPU, memory, disk)
2. Logs statistics to a file
3. Sends alerts for threshold violations
4. Uses functions for each monitoring task
5. Implements proper error handling

### Assignment 3: Advanced File Processor
Create a script that:
1. Recursively processes files in directories
2. Uses arrays to track processed files
3. Implements parallel processing
4. Handles errors and generates reports
5. Provides progress updates

## Additional Resources
- [Advanced Bash Scripting Guide](https://tldp.org/LDP/abs/html/)
- [Bash Functions and Arrays](https://www.gnu.org/software/bash/manual/html_node/Arrays.html)

## Solutions
Check the solutions directory after attempting the assignments.

## Tips
- Use functions to make code modular
- Implement proper error handling
- Test edge cases thoroughly
- Document complex functions
- Use meaningful variable names

## Next Steps
Congratulations! You're ready for the Final Project, where you'll apply everything you've learned in a comprehensive script.
