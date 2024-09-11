# Automated Daily Backup Script for Encrypted Password Files

This script automatically backs up any encrypted password files updated within the last 24 hours on the system. It eliminates the need for manual backups, improving efficiency and reducing human error.

## Prerequisites

Before running the script, ensure you have the following:

- **Linux or macOS**: This script is written for Unix-based systems.
- **Encryption Tools**: Ensure that your system supports the required encryption/decryption commands.
- **Backup Directory**: A directory where the backup files will be stored (ensure the script has write access to this directory).

## How to Run

1. **Clone the repository**:
   ```bash
   git clone https://github.com/DinethDilhara/secure-auto-backup-script.git
   ```
2. **Make the script executable**
 
   ```bash
   chmod +x backup.sh
   ```
3. **Run the script**
   ```bash
   ./backup.sh
   ```
4. **To automate the script**

   To automate the script execution daily, add the following entry to your cron jobs:

    ```bash
    crontab -e
    ```
    ```bash
    0 0 * * * /path/to/backup.sh
    ```
   
## Script Overview

The `backup.sh` script performs the following tasks:

1. Finds files updated in the last 24 hours.
2. Creates a backup of these files in a secure location.
3. Outputs a log of the backup process for tracking purposes.

## Final Project

This script is the final project for the **Hands-on Introduction to Linux Commands and Shell Scripting** course by IBM.

[Resourrce](https://www.coursera.org/learn/hands-on-introduction-to-linux-commands-and-shell-scripting)
