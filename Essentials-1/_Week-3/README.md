# Week 3: Introduction to Shell Scripting

This week introduces the fundamentals of shell scripting, including variables, user input, and basic control structures.

## Learning Objectives
By the end of this week, you will be able to:
- Write and execute shell scripts
- Work with variables and user input
- Use conditional statements (if/else)
- Implement basic loops
- Handle command line arguments

## Prerequisites
- Completion of Weeks 1 and 2
- Understanding of basic file operations

## Lessons

### 1. Shell Script Basics
```bash
#!/bin/bash        # Shebang line
# This is a comment
echo "Hello World" # Basic output
name="John"        # Variable assignment
echo $name         # Variable usage
```

#### Practice Exercise 3.1
Create a script that:
1. Declares variables for name and age
2. Prints them in a formatted message
```bash
#!/bin/bash
name="Alice"
age=25
echo "$name is $age years old"
```

### 2. User Input and Arguments
```bash
# User input
read -p "Enter name: " name
echo "Hello, $name"

# Command line arguments
echo "First argument: $1"
echo "All arguments: $@"
echo "Number of arguments: $#"
```

#### Practice Exercise 3.2
Create a script that:
1. Asks for user's name and favorite color
2. Prints a personalized message using the input

### 3. Conditional Statements
```bash
if [ condition ]; then
    command
elif [ condition ]; then
    command
else
    command
fi

# Common conditions
[ $a -eq $b ]  # Equal
[ $a -ne $b ]  # Not equal
[ $a -gt $b ]  # Greater than
[ -f file ]    # File exists
[ -d dir ]     # Directory exists
```

#### Practice Exercise 3.3
Write a script that:
1. Checks if a file exists
2. Creates it if it doesn't exist
3. Adds some content if it's empty

### 4. Basic Loops
```bash
# For loop
for i in {1..5}; do
    echo $i
done

# While loop
count=1
while [ $count -le 5 ]; do
    echo $count
    ((count++))
done
```

## Assignments

### Assignment 1: Interactive User Script
Create a script that:
1. Asks for user's name, age, and location
2. Validates the age (must be a number)
3. Creates a user profile file with the information
4. Displays a summary of the saved information

### Assignment 2: File Processing Script
Write a script that:
1. Takes a directory path as an argument
2. Counts files by extension
3. Reports total size of each file type
4. Creates a summary report

### Assignment 3: Number Guessing Game
Create a script for a number guessing game:
1. Generate a random number between 1 and 100
2. Ask user to guess the number
3. Provide "higher" or "lower" hints
4. Count number of attempts
5. Allow option to play again

## Additional Resources
- [Bash Guide for Beginners](https://tldp.org/LDP/Bash-Beginners-Guide/html/)
- [Shell Scripting Tutorial](https://www.shellscript.sh/)

## Solutions
Check the solutions directory after attempting the assignments.

## Tips
- Always test scripts with sample data
- Use `set -e` to exit on errors
- Comment your code
- Use meaningful variable names
- Test edge cases

## Next Steps
Week 4 will cover more advanced control structures, functions, and error handling in shell scripts.
