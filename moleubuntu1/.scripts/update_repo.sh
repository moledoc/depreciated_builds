#!/bin/sh

# README: Update current build

if [ -z $1 ]
then
	printf "Need commit message, updating repo cancelled"
	exit(1)
fi

# run readmeGen
$SHELL $HOME/.scripts/gen_readme.sh

# save terminal, DE etc settings
$SHELL $HOME/.scripts/save_settings.sh
