#!/bin/zsh -f
# Purpose: Download all .mp3 episodes of a podcast
#
# From:	Timothy J. Luoma
# Mail:	luomat at gmail dot com
# Date:	2015-11-17

NAME="$0:t:r"

if [ -e "$HOME/.path" ]
then
	source "$HOME/.path"
else
	PATH='/usr/local/scripts:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin'
fi

	# This is the RSS feed for the podcast. It should be able to be changed to other feeds
FEED='http://arkiv.radio24syv.dk/audiopodcast/channel/12391837'

	# Get the title of the RSS feed
	# And remove special characters such as ! and : 
TITLE=`curl -sfL "$FEED" | fgrep '<title>' | head -1 | sed 's#.*<title>##g; s#</title>.*##g' | tr -d '!|:|\\|\047|"|&' `

	# Use the title of the podcast as the folder name where they will be saved 
SAVE_TO="$HOME/Music/Podcasts/${TITLE}"

	# Create the folder if needed
[[ ! -d "$SAVE_TO" ]] && mkdir -p -- "$SAVE_TO"

cd "$SAVE_TO" || cd 

echo "$NAME: saving episodes of the podcast \"$TITLE\" to $PWD:"

curl -sfL "$FEED" \
| tr -s '"|\047' '\012' \
| egrep '^http.*\.mp3' \
| while read line
do

	URL="$line"
	FILENAME="$line:t"

	echo "$NAME: Saving $URL to $PWD/$FILENAME:"
	
	if [[ -e "$FILENAME" ]]
	then
		curl --continue-at - --progress-bar --fail --location --output "$FILENAME" "$URL" 2>/dev/null

		case "$?" in	
			416)
					echo "$NAME: Already have $FILENAME"
			;;

		esac		
		
	else
		curl --progress-bar --fail --location --output "$FILENAME" "$URL"
	fi 	

done 

exit 0
#EOF
