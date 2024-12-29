# Week 2: File Operations and Text Manipulation

This week focuses on advanced file operations, text manipulation, and working with file permissions in Bash.

## Learning Objectives
By the end of this week, you will be able to:
- Manipulate file contents using text processing commands
- Understand and modify file permissions
- Use advanced file operations
- Work with text streams and pipelines

## Prerequisites
- Completion of Week 1
- Basic understanding of command line navigation

## Lessons

### 1. Text Processing Commands
```bash
cat file.txt     # Display file contents
head file.txt    # Show first 10 lines
tail file.txt    # Show last 10 lines
grep pattern file # Search for pattern
wc file.txt      # Count lines, words, characters
sort file.txt    # Sort lines alphabetically
uniq file.txt    # Remove duplicate lines
```

#### Practice Exercise 2.1
1. Create a file with multiple lines:
```bash
echo -e "apple\nbanana\ncherry\napple\ndates" > fruits.txt
```
2. Try these commands:
```bash
cat fruits.txt
sort fruits.txt
sort fruits.txt | uniq
wc -l fruits.txt
```

### 2. File Permissions
```bash
ls -l            # View permissions
chmod +x file    # Make executable
chmod 644 file   # Set specific permissions
chown user file  # Change owner
```

#### Practice Exercise 2.2
1. Create a script file:
```bash
echo '#!/bin/bash
echo "Hello, World!"' > script.sh
```
2. Make it executable:
```bash
chmod +x script.sh
./script.sh
```

### 3. Advanced File Operations
```bash
find . -name "*.txt"  # Find files
tar -czf arch.tar.gz dir/  # Create archive
tar -xzf arch.tar.gz      # Extract archive
diff file1 file2          # Compare files
```

#### Practice Exercise 2.3
1. Create multiple text files
2. Create an archive containing them
3. Extract the archive to a different directory

## Assignments

### Assignment 1: Text Processing
Create a file named `data.txt` with this content:
```
John,25,New York
Alice,30,London
Bob,22,Paris
John,35,Tokyo
Alice,28,Sydney
```

Write commands to:
1. Sort the file by names
2. Count unique names
3. Find all entries containing "John"
4. Count total number of entries

### Assignment 2: File Permissions Script
Create a script that:
1. Creates a directory structure
2. Creates different types of files
3. Sets appropriate permissions:
   - Directories: 755 (drwxr-xr-x)
   - Scripts: 755 (-rwxr-xr-x)
   - Text files: 644 (-rw-r--r--)

### Assignment 3: File Organization
Write a script that:
1. Finds all .txt files in a directory tree
2. Creates a backup of these files
3. Organizes them into directories by creation date
4. Generates a report of the organization

## Additional Resources
- [GNU Coreutils Documentation](https://www.gnu.org/software/coreutils/manual/)
- [Linux File Permissions Explained](https://www.linux.com/training-tutorials/understanding-linux-file-permissions/)

## Solutions
Check the solutions directory after attempting the assignments.

## Tips
- Use `man` command to learn more about any command
- Combine commands using pipes (|)
- Always test file operations on copies first
- Use `echo` to preview command results

## Next Steps
In Week 3, we'll dive into shell scripting fundamentals, including variables, user input, and basic control structures.
