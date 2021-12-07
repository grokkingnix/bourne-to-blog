#! /bin/bash

# Edit these variables to fit your environment before first use
 
# Start editing
############

# Path to directory that contains the downloaded openring sourcecode, without slash at the end "/"
OPENRING_FOLDER=/openring/folder/path

# Full RSS feed URL for blog1
BLOG1=https://drewdevault.com/feed.xml

# Full RSS feed URL for blog2
BLOG2=https://emersion.fr/blog/rss.xml

# Full RSS feed URL for blog3
BLOG3=https://danluu.com/atom.xml

# Path to template HTML file for openring
IN_HTML=/path/to/the/md/files/that/will/be/built/in.html

# Stop editing
############

# Message when checking for the Go programming language
CHECKING_MSG="Checking for Go on the system"

# Message when the Go programming language is found
FOUND_MSG="Found Go installed on the system, Continuing."

# Message when the Go programming language is not found
NOT_FOUND_MSG="Go does not seem to be installed or not included in PATH. Make sure that the Go programming language package is installed and available in PATH before attempting to build posts with Openring included. Exiting now."


# Function that checks if Go is installed on the system
function checkGo() {

	# Print the CHECKING_MSG variable value to terminal
	echo $CHECKING_MSG

	# Check to see if go is found by the which command
	GO_PATH=$(/usr/bin/which go)

	# Store the exit status of the above command
	RESULT=$?
	
	# Check if the exit status is 0 (Go found)
	if [ $RESULT -eq 0 ]
	then

		# Print the FOUND_MSG variable value to terminal
		echo $FOUND_MSG
	else

		# Print the NOT_FOUND_MSG variable value to terminal
		echo $NOT_FOUND_MSG

		# Hard exit 
		exit
	fi
}

# Function that creates the Openring HTML file
function createOpenring() {

	# Check if Go is installed on the system
	checkGo

	# Change directory to OPENRING_FOLDER
	cd $OPENRING_FOLDER
	
	# Run the openring command with the BLOG1 BLOG2 and BLOG3 URLs
	$GO_PATH run $OPENRING_FOLDER/openring.go \
		-s $BLOG1 \
		-s $BLOG2 \
		-s $BLOG3 \
		< $IN_HTML \
		> $WORK_DIR/openring.tmp
}
