
CHECK_GIT="$(git --version)"
if [ "$CHECK_GIT" == "-bash: git: command not found" ]; then
	echo "Seems like Git isn't installed? Exiting"
	exit $?
fi 

CURRENT_BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
if [ "$CURRENT_BRANCH_NAME" == "HEAD" ]; then
	echo "Seems like we're in detached head state. Exiting"
	exit $?
fi 

NUMBER_OF_COMMITS="$(git rev-list $CURRENT_BRANCH_NAME | wc -l)"
"$(##teamcity[appVersion '$NUMBER_OF_COMMITS'])"

echo "We're on $CURRENT_BRANCH_NAME branch. Set build number to $NUMBER_OF_COMMITS"

exit