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

#move the suitable files to suitable directories and grant them executable permissioins
chmod +x reminder.sh ; mv reminder.sh submission_reminder_$thename/app
chmod +x functions.sh ; mv reminder.sh submission_reminder_$thename/modules
chmod +x submissions.txt ; mv reminder.sh submission_reminder_$thename/assets
chmod +x config.env ; mv reminder.sh submission_reminder_$thename/config

echo "the environment is now ready!the environment is now ready"


