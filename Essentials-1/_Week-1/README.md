# Week 1: Introduction to Bash and Command Line Basics

Welcome to your first week of Bash scripting! This week focuses on understanding the basics of the command line interface and essential Bash commands.

## Learning Objectives
By the end of this week, you will be able to:
- Navigate the file system using command line
- Understand basic Bash commands
- Create and manipulate directories
- Use basic file operations

## Prerequisites
- Git Bash installed (Windows users)
- Text editor of your choice

## Lessons

### 1. Basic Navigation Commands
```bash
pwd   # Print Working Directory
cd    # Change Directory
ls    # List contents
```

#### Practice Exercise 1.1
1. Open Git Bash
2. Type `pwd` to see your current location
3. Create a new directory: `mkdir practice_week1`
4. Navigate into it: `cd practice_week1`
5. Verify your location: `pwd`

### 2. File System Navigation
```bash
cd ..          # Move up one directory
cd ~           # Go to home directory
cd /path/to/dir # Go to specific directory
ls -l          # Detailed list
ls -a          # Show hidden files
```

#### Practice Exercise 1.2
1. Create this directory structure:
```
practice_week1/
├── documents/
├── images/
└── scripts/
```
Use these commands:
```bash
mkdir documents
mkdir images
mkdir scripts
```

### 3. File Operations
```bash
touch file.txt    # Create empty file
cp file1 file2    # Copy files
mv file1 file2    # Move/rename files
rm file           # Remove files
```

#### Practice Exercise 1.3
1. Create a text file: `touch notes.txt`
2. Copy it to documents: `cp notes.txt documents/`
3. Move to images: `mv documents/notes.txt images/`
4. Create multiple files: `touch file1.txt file2.txt file3.txt`

## Assignments

### Assignment 1: Directory Structure Creation
Create the following directory structure:
```
my_workspace/
├── projects/
│   ├── project1/
│   └── project2/
├── documents/
│   ├── personal/
│   └── work/
└── backups/
```

### Assignment 2: File Management
1. Create 5 text files in projects/project1
2. Copy 2 files to projects/project2
3. Move 1 file to documents/work
4. List the contents of each directory
5. Navigate through the entire structure using cd

### Assignment 3: Command Practice
Create a text file named `commands_practice.txt` and write down:
1. The command to list all files, including hidden ones
2. The command to go to your home directory
3. The command to create a new directory
4. The command to copy a file

## Additional Resources
- [Bash Command Cheat Sheet](https://devhints.io/bash)
- [Linux Command Line Basics](https://ubuntu.com/tutorials/command-line-for-beginners)

## Solutions
Solutions are provided in the `solutions` directory, but try to complete the exercises on your own first!

## Tips
- Use the up arrow to recall previous commands
- Use tab completion to avoid typing full paths
- Keep track of your current directory with `pwd`

## Next Steps
Once you're comfortable with these basics, you're ready to move on to Week 2, where we'll dive into more advanced file operations and text manipulation.
