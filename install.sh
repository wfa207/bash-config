BASH_FILE_NAMES=(bashrc bash_profile bash-powerline.sh pystartup xpather.py)

for file_name in ${BASH_FILE_NAMES[@]}; do
	ln -s ~/.bash-config/.${file_name} ~/.${file_name}
done

unset file_name BASH_FILE_NAMES
