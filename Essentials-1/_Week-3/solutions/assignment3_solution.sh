#!/bin/bash

# Solution for Assignment 3: Number Guessing Game
echo "Number Guessing Game"
echo "------------------"

# Function to generate random number
generate_number() {
    echo $((RANDOM % 100 + 1))
}

# Function to play one round
play_round() {
    local target=$1
    local attempts=0
    local guess
    
    echo -e "\nI'm thinking of a number between 1 and 100"
    
    while true; do
        ((attempts++))
        read -p "Enter your guess (attempt $attempts): " guess
        
        # Validate input
        if [[ ! $guess =~ ^[0-9]+$ ]]; then
            echo "Please enter a valid number"
            ((attempts--))
            continue
        fi
        
        # Compare guess with target
        if [ $guess -eq $target ]; then
            echo -e "\nCongratulations! You got it in $attempts attempts!"
            return $attempts
        elif [ $guess -lt $target ]; then
            echo "Higher!"
        else
            echo "Lower!"
        fi
    done
}

# Function to display game statistics
show_stats() {
    local games=$1
    local total_attempts=$2
    local best_score=$3
    
    echo -e "\nGame Statistics"
    echo "--------------"
    echo "Games played: $games"
    echo "Average attempts: $(bc <<< "scale=2; $total_attempts / $games")"
    echo "Best score: $best_score attempts"
}

# Main game loop
games_played=0
total_attempts=0
best_score=999999

while true; do
    # Start new game
    ((games_played++))
    echo -e "\nGame #$games_played"
    echo "============"
    
    # Play one round
    target=$(generate_number)
    play_round $target
    attempts=$?
    
    # Update statistics
    total_attempts=$((total_attempts + attempts))
    if [ $attempts -lt $best_score ]; then
        best_score=$attempts
    fi
    
    # Ask to play again
    while true; do
        read -p $'\nWould you like to play again? (y/n): ' play_again
        case $play_again in
            [Yy]*)
                break
                ;;
            [Nn]*)
                # Show final statistics
                show_stats $games_played $total_attempts $best_score
                echo -e "\nThanks for playing!"
                exit 0
                ;;
            *)
                echo "Please answer y or n"
                ;;
        esac
    done
done 