import os
import requests
from datetime import datetime

# Your session token from the Advent of Code website
SESSION_TOKEN = "53616c7465645f5f37064e1ada38515f2b2cd6c443a9564dadaf60fdca1e70dab5eeb32baf7225b6d1bdd3dce907b4674aa9b2c60e446aa7357d4d2bb2959df3re"

def fetch_puzzle_input():
    # Get the current day of December
    today = datetime.now()
    if today.month != 12:
        print("Advent of Code only runs in December.")
        return
    
    day = today.day
    url = f"https://adventofcode.com/2024/day/{day}/input"
    headers = {"Cookie": f"session={SESSION_TOKEN}"}
    puzzle_file = f"2024/Day{day}.txt"
    sample_file = f"2024/Day{day}a_sample.txt"

    try:
        # Fetch and save puzzle input
        print(f"Fetching input for Day {day}...")
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            with open(puzzle_file, "w") as file:
                file.write(response.text.strip())
            print(f"Puzzle input for Day {day} saved to {puzzle_file}.")
        elif response.status_code == 404:
            print(f"Day {day} is not yet available. Please check after midnight EST.")
        else:
            print(f"Failed to fetch input: {response.status_code} - {response.reason}")
        
        # Create a blank sample file
        if not os.path.exists(sample_file):
            with open(sample_file, "w") as file:
                pass
            print(f"Sample file created: {sample_file}")
        else:
            print(f"Sample file already exists: {sample_file}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    fetch_puzzle_input()
