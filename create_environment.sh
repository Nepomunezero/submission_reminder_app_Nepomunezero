#!/bin/bash
read -p "State your first name without spaces: " thename

subfolders=("app" "modules" "assets" "config")
myfunction() {
	for subfolder in "${subfolders[@]}"; do
		  mkdir -p "$subfolder"
	   	 echo "Created subfolder: $subfolder"
   	 done
}
mkdir submission_reminder_$thename && cd submission_reminder_$thename && myfunction

#create startup.sh and populate it
touch startup.sh


echo "#!/bin/bash" > startup.sh
echo "./app/reminder.sh" >> startup.sh
echo "startup file created and populated"

cd ..
#create the suitable files inside suitable directories and grant them executable permissioins
cat > "submission_reminder_$thename/app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: \$ASSIGNMENT"
echo "Days remaining to submit: \$DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "\$submissions_file"
EOF

cat > "submission_reminder_$thename/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "${assignment,,}" == "${ASSIGNMENT,,}" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

cat > "submission_reminder_$thename/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
#updating the file submissions.txt with more students and their state
echo "Chinemerem, Shell Navigation, not submitted\nChiagoziem, Git, submitted\nDivine, Shell Navigation, not submitted\nAnissa, Shell Basics, submitted\nJean, Shell Navigation, not submitted\nNepo, Python if else, not submitted\nMunezero, git, submitted\nStudent1, shell navigation, not submitted\nStudent2, quantum computing, not submitted" >> submission_reminder_$thename/assets/submissions.txt

echo "populated all the subdirectories of submission_reminder_$thename"

#give execute permissions to everything that ends with .sh
chmod 777 submission_reminder_$thename/*.sh submission_reminder_$thename/*/*

#celebrate for putting the environment in place 
echo "the environment is now ready!"

