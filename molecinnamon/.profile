# if zsh is not the loggin shell,
# then source .zprofile anyway.
# Bit of a hack solution, but will work for now.
source .zprofile
echo "6500" > /tmp/cur_redshift #see .scripts/redshiftcontrol.zsh
