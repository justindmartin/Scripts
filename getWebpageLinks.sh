#Name: getWebpageLinks.sh
#Description: fetches all links from a webpage and outputs to file or console
#Author: Justin Martin(http://www.1justinmartin.com)

if [[ $1 ]]
then
	webpageLinks=`lynx -dump $1 | awk '/http/{print $2}'`

	#if printing to console, then output header
	if [[ -z $2 ]]
	then
		echo "Links from $1"
		echo '==================================='
	fi
	for webpageLink in $webpageLinks
	do
		isLinkDuplicate=0
		for existingLink in $webpageLinks
		do
			if [["$existingLink" == "$webpageLink"]]
			then
				$isLinkDuplicate = 1
			fi
		done
		if ["$isLinkDuplicate" == 0]
		then
			if [[ -z $2 ]]
			then
				echo $webpageLink
			else
				echo $webpageLink > $2
				if [[ $webpageLink != $webpageLinks[0] ]]
				then
					echo > $2
				fi
			fi
		fi
	done
	#if print to console, then output footer
	if [[ -z $2 ]]
	then
		echo '==================================='
	fi
else
	clear
	echo "bash getWebpageLinks.sh URL OUTPUT_FILE(optional)"
	echo
fi

