#Name: getWebpageLinks.sh
#Description: fetches all links from a webpage and outputs to file or console
#Author: Justin Martin(http://www.1justinmartin.com)

#clear console
clear

if [[ $1 ]] #if required parameters are set
then
	#install lynx, if not already installed
	echo 'Installing Lynx, if not already installed...'
	echo
	sudo apt-get -qq -y install lynx

	#fetch and parse page HTML
	webpageLinks=`lynx -dump $1 | awk '/http/{print $2}'`

	if [[ -z $2 ]] #if printing to console
	then
		#then output header
		echo "Links from $1"
		echo '==================================='
	else
		#remove output file, if it already exists
		rm -f $2
	fi
	for webpageLink in $webpageLinks
	do
		if [[ -z $2 ]]
		then
			echo $webpageLink
		else
			echo $webpageLink >> $2
		fi
	done

	if [[ -z $2 ]] #if printing to console
	then
		#then output footer
		echo '==================================='
	fi
else
	#print required program parameters
	echo "bash getWebpageLinks.sh URL OUTPUT_FILE(optional)"
	echo
fi

