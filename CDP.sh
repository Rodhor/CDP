#!/bin/bash

### Project Variables ###

# Specify the root directory for the search
root_directory="/home/rodhor/Documents/Projects"

### Functions ###

# Function to handle the case when required arguments are missing
no_args() {
  echo "Please add the project name as an argument"  # Inform the user that arguments are missing
  print_usage  # Display usage instructions
  exit 1  # Exit the script with a non-zero status (error)
}

# Function to display a concise usage message
print_usage() {
  echo "Usage: $0 <project_name>"  # Provide a concise usage message
}


# Function to list all layer 1 folders from the root directory
list_layer_1_folders() {
  find "$root_directory" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;
}

# Function to list all layer 2 folders inside a given layer 1 folder
list_layer_2_folders() {
  find "$1" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;
}

# Function to loop over the first layer list and print names with index
loop_over_layer_1_folders() {
  for folder in $(list_layer_1_folders); do
    echo -e "\e[1m Language:\e[0m $folder"
    
    # List layer 2 folders for the current layer 1 folder
    total_layer_2_folders=$(list_layer_2_folders "$root_directory/$folder" | wc -l)
    
    if [ $total_layer_2_folders -eq 0 ]; then
      echo -e "  - \e[2mNo projectfolders found\e[0m"
    else
      layer_2_index=0
      
      for subfolder in $(list_layer_2_folders "$root_directory/$folder"); do
        # Improved indentation and formatting
        echo -e "    -|---> $subfolder"
        
        # Check if it's the last subfolder and add a line break
        if [ $layer_2_index -eq $((total_layer_2_folders - 1)) ]; then
          echo
        fi
        
        ((layer_2_index++))
      done
    fi

    # Add a line break between different languages
    echo
  done
}






# Function to list files and directories within a folder
list_files_and_directories() {
  local folder="$1"
  
  # Print the folder name
  echo "[$folder]"

  # List files and directories within the folder
  ls "$folder"
}

# Function to perform the recursive search and change into the found directory
search_project() {
  local project_name="$1"
  
  # Use find to search for the project_name in the specified root_directory up to 2 layers deep
  local found_directory
  found_directory=$(find "$root_directory" -maxdepth 2 -type d -name "$project_name" -print -quit)

  # Check if the project directory is not found
  if [ -z "$found_directory" ]; then
    # Print an error message
    echo "Error: Project directory not found."

    # Display a list of all layer 2 folders within the root directory
    echo "The following list includes all projects within the projects directory:"
    echo

    
    # Call the custom function to list all layer 2 folders
    loop_over_layer_1_folders

    # Exit the script with a success status (0)
    exit 0 
  fi

  # Change into the found directory
  cd "$found_directory" || exit 1

  # Print the directory change message
  echo "Changed into directory: $found_directory"
  
  # Call the custom function to list files and directories within the found folder
  list_files_and_directories "$found_directory"

  # Open the directory in VSCode (assuming 'code' is the command for VSCode)
  #code .

  # Open a new shell session
  $SHELL
}

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    no_args
fi

# Capture the project name provided as an argument
project_name="$*"

# Perform the recursive search and change into the found directory
search_project "$project_name"
