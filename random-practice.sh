URLS=(https://www.google.com https://www.espn.com https://www.interviewcake.com https://www.npsfoothealth.com)
NUM=$(($RANDOM%${#URLS[@]}))
open -a "Google Chrome" ${URLS[$NUM]}