#!/bin/bash

# Check if the number of arguments is correct
if [[ $# != 2 ]]; then
  echo "Usage: backup.sh target_directory_name destination_directory_name"
  exit 1
fi

# Check if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]; then
  echo "Error: Invalid directory path provided."
  exit 1
fi

# [TASK 1] Assign arguments to variables
targetDirectory=$1
destinationDirectory=$2

# [TASK 2] Display the input arguments
echo "Target directory: $targetDirectory"
echo "Destination directory: $destinationDirectory"

# [TASK 3] Get current timestamp (in seconds)
currentTS=$(date +%s)

# [TASK 4] Create the backup file name using the current timestamp
backupFileName="backup-$currentTS.tar.gz"

# [TASK 5] Save the original absolute path
origAbsPath=$(pwd)

# [TASK 6] Navigate to the destination directory and get its absolute path
cd $destinationDirectory || { echo "Failed to change directory to $destinationDirectory"; exit 1; }
destDirAbsPath=$(pwd)

# [TASK 7] Return to the original path and navigate to the target directory
cd $origAbsPath || { echo "Failed to return to original directory"; exit 1; }
cd $targetDirectory || { echo "Failed to change directory to $targetDirectory"; exit 1; }

# [TASK 8] Calculate the timestamp for "yesterday" (24 hours ago)
yesterdayTS=$(($currentTS - 24 * 60 * 60))

# Declare an array to store the list of files that need to be backed up
declare -a toBackup

# [TASK 9] Use `find` to list files and loop through them
while IFS= read -r file; do
  # [TASK 10] Check if the file has been modified in the last 24 hours
  if [[ -f $file && $(date -r "$file" +%s) -gt $yesterdayTS ]]; then
    # [TASK 11] Add the file to the backup array
    toBackup+=("$file")
  fi
done < <(find . -type f)

# [TASK 12] Create the backup archive with the files that need to be backed up
if [[ ${#toBackup[@]} -gt 0 ]]; then
  tar -czvf "$backupFileName" "${toBackup[@]}"
else
  echo "No files have been updated in the last 24 hours."
  exit 0
fi

# [TASK 13] Move the backup file to the destination directory
mv "$backupFileName" "$destDirAbsPath" || { echo "Failed to move backup file to $destDirAbsPath"; exit 1; }

echo "Backup completed successfully. File saved to: $destDirAbsPath/$backupFileName"

