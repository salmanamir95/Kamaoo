import os
import json

# --- Configuration ---
JSON_FILE = 'mapping.json'
# --- End Configuration ---

def get_file_extension(filename):
    """Extracts the file extension from a filename."""
    return os.path.splitext(filename)[1]

def sanitize_filename(name):
    """Removes curly braces {} from the new name."""
    return name.strip('{}')

def handle_duplicates(new_filepath):
    """Appends a number if the file already exists."""
    base, ext = os.path.splitext(new_filepath)
    counter = 1
    # Loop until we find a name that doesn't exist
    while os.path.exists(new_filepath):
        new_filepath = f"{base}_{counter}{ext}"
        counter += 1
    return new_filepath

def rename_images():
    """
    Renames images based on the mapping in the JSON file.
    Handles duplicate new names to prevent overwriting.
    """
    try:
        with open(JSON_FILE, 'r', encoding='utf-8') as f:
            rename_data = json.load(f)
    except FileNotFoundError:
        print(f"Error: The file '{JSON_FILE}' was not found.")
        print("Please make sure it is in the same directory as the script.")
        return
    except json.JSONDecodeError:
        print(f"Error: Could not decode the JSON from '{JSON_FILE}'.")
        print("Please check for syntax errors in the file.")
        return

    print(f"Loaded {len(rename_data)} rename tasks from '{JSON_FILE}'.\n")
    
    success_count = 0
    fail_count = 0
    already_done_count = 0

    # This set will track new names we've already used in this run
    # to handle cases like the sneakers which map to the same new name.
    used_new_names = set()

    for item in rename_data:
        try:
            old_name = item[0]
            # item[1] is filepath, but we assume it's same as old_name
            new_name_raw = item[2]

            # 1. Check if the old file exists
            if not os.path.exists(old_name):
                # Check if it was already renamed to the new name
                ext = get_file_extension(old_name)
                potential_new_name = sanitize_filename(new_name_raw) + ext
                if os.path.exists(potential_new_name):
                    print(f"SKIPPED: '{old_name}' not found (already renamed to '{potential_new_name}'?)")
                    already_done_count += 1
                else:
                    print(f"FAILED:  Original file not found: '{old_name}'")
                    fail_count += 1
                continue

            # 2. Prepare the new name
            # Get extension from the *original* file
            extension = get_file_extension(old_name) 
            # Clean up the new name and add the original extension
            new_name_clean = sanitize_filename(new_name_raw)
            new_filepath = new_name_clean + extension

            # 3. Handle potential duplicate new names (e.g., three sneaker images)
            if new_filepath in used_new_names:
                # If we've already used this name in this *run*,
                # start appending numbers.
                new_filepath = handle_duplicates(new_filepath)
            else:
                # If the file *already exists on disk* but we haven't
                # used its name yet, it's still a duplicate.
                if os.path.exists(new_filepath):
                    new_filepath = handle_duplicates(new_filepath)
            
            # Add the final chosen name to our set
            used_new_names.add(new_filepath)

            # 4. Rename the file
            os.rename(old_name, new_filepath)
            print(f"SUCCESS: '{old_name}' -> '{new_filepath}'")
            success_count += 1

        except Exception as e:
            print(f"ERROR:   Failed to rename '{old_name}'. Reason: {e}")
            fail_count += 1

    print("\n--- Rename Complete ---")
    print(f"Successful: {success_count}")
    print(f"Failed:     {fail_count}")
    print(f"Skipped:    {already_done_count}")
    print("-----------------------")

if __name__ == "__main__":
    rename_images()
