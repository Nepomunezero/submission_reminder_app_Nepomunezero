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
#populate the submissions.txt file more

echo -e "Jean, Python Hello world, not submitted\nNepo, Python if else, not submitted\nMunezero, git, submitted\nStudent1, shell navigation, not submitted\nStudent2, quantum computing, not submitted" >> submissions.txt



echo "submissions.txt file content appended"


#move the suitable files to suitable directories and grant them executable permissioins
cp reminder.sh submission_reminder_$thename/app
cp functions.sh submission_reminder_$thename/modules
cp submissions.txt submission_reminder_$thename/assets
cp config.env  submission_reminder_$thename/config

echo "populated all the subdirectories of submission_reminder_$thename"

#give execute permissions to everything that ends with .sh
chmod +x submission_reminder_$thename/*.sh submission_reminder_$thename/*/*.sh

#celebrate for putting the environment in place 
echo "the environment is now ready!"

