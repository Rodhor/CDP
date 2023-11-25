# Project Description

The **Project Explorer Script** is a versatile Bash script designed to simplify the navigation and exploration of project directories within a specified root directory. Whether you're working on a complex software project with multiple layers or organizing various projects in a structured manner, this script helps you quickly find and access the project you're looking for.

## Features

- **Interactive Exploration:** The script provides an interactive way to explore your projects, presenting a structured view of project folders based on layers.

- **Easy Navigation:** With a simple command-line interface, you can easily navigate through different layers of projects to locate the one you need.

- **Integrated with VSCode:** The script includes an option to open the found project directly in Visual Studio Code for seamless editing and development.

## Usage

1. **Navigate to the Root Directory:**
   ```bash
   ./project_explorer.sh
This command will display a list of available projects within the root directory.

2. **Search for a Specific Project:**
   ```bash
   ./project_explorer.sh project_name
Replace project_name with the name of the project you're searching for. The script will recursively search for the project within the specified root directory and its subdirectories.

3. **Explore Projects Interactively:**
The script organizes projects into layers, providing an interactive interface to explore and navigate through different levels of project directories.

4. **Open Project in VSCode:**
After finding the desired project, the script offers an option to open it directly in Visual Studio Code using the code . command.

## Project Structure

The script is organized into functions, each serving a specific purpose:

- **`no_args`:** Handles the case when required arguments are missing.
- **`print_usage`:** Displays a concise usage message.
- **`list_layer_1_folders`:** Lists all layer 1 folders from the root directory.
- **`list_layer_2_folders`:** Lists all layer 2 folders inside a given layer 1 folder.
- **`loop_over_layer_1_folders`:** Loops over the first layer list and prints names with an index.
- **`list_files_and_directories`:** Lists files and directories within a folder.
- **`search_project`:** Performs a recursive search and changes into the found directory.

## Dependencies

The script relies on basic Bash functionality and does not have external dependencies. It should work on most Unix-like systems.
