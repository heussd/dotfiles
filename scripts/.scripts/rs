#!/bin/bash
# [ tiny || secure || rsync-based || fast ] redundant storage tool

sync_options='-auip --progress --safe-links'
defaultExcludes=~/.rsync-filter

findFilter() {
	local tries=""
	for p in $*; do
		profile=$p

		profile=${profile##*@}
		profile=${profile%%:*}

		# Catch localhost paths
		[ $profile == $PWD ] && profile=$HOSTNAME

		profile=${profile%%/}
		profile=${profile##*/}

		profile=~/.$profile-filter

		tries=$tries"\nFinding $profile..."
		[ -e $profile ] && return 0
		tries=$tries"404"
	done
	echo -e "$tries"
	return 1
}

doRsync() {
	local source=$PWD
	local target=$host

	# Syncing to remote host? 
	if [[ ! -d $host ]]; then
		# Compress traffic
		local sync_options=$sync_options" --compress"

		# Tunnel via ssh
		local sync_options=$sync_options" -e ssh"

		# Sync remote home (absolute path may differ)
		local target=$target":~${PWD##~}"
	fi

	for d in $*; do
		if [[ $d == "DOWN" ]]; then
			local source=$target
			local target=$PWD
		fi
		
		findFilter $target $source
		[ $? != 0 ] && exit
		
		rsync --filter='. '$profile $sync_options $source/ $target
		[ $? != 0 ] && exit
	done
}

# A list of parameters which don't get attached at rsync:
for param in $*; do
	case $param in
		"M")	# Mirror either up or down - be careful!
			sync_options=$sync_options" --del";;
		"UP")	# Ignore remote updates
			direction="UP";;
		"DOWN")	# Ignore local updates
			direction="DOWN";;
		"DRY")	# Don't touch anything
			sync_options="$sync_options -n"
			mirror_options="$mirror_options -n"
			;;
		*)
			# Is $param dedicated to rsync?
			if [[ ${param:0:1} == '-' ]]; then
				# Yes, add it to the rsync options
				sync_options="$sync_options $param"
			else
				# No, it must be a sync target!
				hosts="$hosts $param"
			fi
	esac
done

# Default direction: UP & DOWN
direction=${direction:-"UP DOWN"}

# When syncing $HOME, exclude everything not explicitly included
if [[ $PWD == ~ ]]; then sync_options="$sync_options --exclude=/*"; fi


if [[ -z $hosts ]]; then
	# No hosts given
	IFSbck=$IFS
	IFS=$'\n'

	for i in `cat ~/.ssh/known_hosts`; do
		host=${i%% *}
		host=${host%,*}

		if [[ -e ~/.$host-filter ]]; then

			ping -c1 $host > /dev/null
			test $? -eq 0 && hosts="$hosts $host"
		fi
	done

	IFS=$IFSbck
fi

# Sync each host with localhost
for host in $hosts; do

	# Skip myself
	if [[ $host != $HOSTNAME ]]; then

		# Aaaand... ACTION!
		doRsync $direction 
	fi
done

exit 0
