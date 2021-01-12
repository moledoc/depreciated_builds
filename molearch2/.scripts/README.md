## Description of the scripts

  * brightnesscontrol -- self explanatory. Meant to be used in scripts.
  * current -- Save the current path to variable cur in the cmdline. Meant to be used together with an alias 'cur'
  * edit_configs (depreciated) -- Script, that makes dmenu prompt with given config files and opens the selected.
  * floating_apps -- opens given program/scipt in floating window.
  * floating_terminal_apps -- spawns new terminal and uses floating_apps script in the new terminal.
  * help -- pipes sxhkd to less. Meant to be used with scripts (such as floating_terminal_apps) and a keybinding.
  * manuals -- Script to give dmenu prompt of manual list and then open selected manual in zathura.
  * monitors -- Script to use second monitor, if attached. By default primary is set to eDP1 and secondary (external) to HDMI1.
  * moleSetup -- Setup script that is NOT tested. Also serves as a system setup documentation (currently at least, for pdf documentation see previous molearch repo).
  * new_cur_term -- Open new terminal in current (update: or given) path.
  * open_bu (depreciated) -- script that takes filetype and path argument (both optional, default filetype is 'f') and fzf finds all given filetypes from given path. Then depending on whether filetype is directory or file, either cd's into the dir or opens the file in corresponding program (default is $EDITOR).
  * opend -- script that takes path argument (optional, default is pwd) and fzf finds all directories starting from given path. Selected directoy path is echo'd and cd into.
  * openf -- script that takes path argument (optional, default is pwd) and fzf finds all files starting from given path. Selected file is opened in corresponding program. Default is $EDITOR.
  * open_file (depreciated) -- make fzf list and open selected file in $EDITOR
  * open_file2 (depreciated) -- make fzf list and open selected file in corresponding program, default is $EDITOR.
  * panel -- lemonbar panel launcher
  * panel_bar -- lemonbar panel 
  * redshiftcontrol -- Controls redshift red levels. Meant to be used in scripts/keybindings.
  * run (semi depriciated) -- pipes /bin to fzf and runs the selected program.
  * template -- Script to copy template to given filename, if template exists for given filetype in $HOME/Templates.
  * tvim -- open python, (R,) haskell with terminal. In case of python (and R) program 'screen' is used.
  * update_repo -- copies selected file to molearch repo, that is located in $HOME/Documents
  * volumecontrol -- self explanatory. Meant to be used with scripts/keybindings.
