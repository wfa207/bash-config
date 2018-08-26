TGT_FILE_NAMES=(bashrc bash_profile bash-powerline.sh pystartup xpather.py)

brew install TomAnthony/brews/itermocil
pip install powerline-shell

for file_name in ${TGT_FILE_NAMES[@]}; do
	ln -Fhs $(pwd)/${file_name} ~/.${file_name}
done

mkdir -p ~/.config/powerline-shell
ln -Fhs "$(pwd)/powerline-config.json" ~/.config/powerline-shell/config.json

unset file_name TGT_FILE_NAMES
