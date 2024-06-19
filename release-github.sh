#!/bin/bash

signin_gh_release() {
	gh auth login -p https -w
}

create_tag() {
	Major=0
	Minor=0
	Patch=0

	get_commit_message_header=$(git show -s --format=%B HEAD | awk '{print $1}'| tr -d ':')

	
	case ${get_commit_message_header} in 
		Release)
			latest_tag=$(git describe --tags `git rev-list --tags --max-count=1`)
			commit_message=$(git show -s --format=%B HEAD | cut -d : -f2)
			echo "${latest_tag}"
			version=$(echo "${Major}.${Minor}.${Patch}")
			echo "$version"
#			if [ -z ${latest_tag} ]; then
#				git tag ${version} HEAD -m "${commit_message}"
#			else
#				git tag ${version} HEAD -m "${commit_message}"
#				((Major++))
#                        	((Minor++))
#                        	((Patch++))
#			fi
			;;
		*)
			echo "exit 1"
			;;
	esac



}

#signin_gh_release
create_tag
