# Install itermocil
brew install TomAnthony/brews/itermocil

# Install powerline-shell
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
PATH=/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/bin python setup.py install
cd ..
rm -rf powerline-shell

mkdir -p ~/.config/powerline-shell
ln -Fhs "$(pwd)/powerline-config.json" ~/.config/powerline-shell/config.json

# Install powerline fonts & clean-up after
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Create sym links for needed files & clean-up name-space
TGT_FILE_NAMES=(bashrc bash_profile inputrc bash-powerline.sh pystartup xpather.py)

for file_name in ${TGT_FILE_NAMES[@]}; do
	ln -Fhs $(pwd)/${file_name} ~/.${file_name}
done

unset file_name TGT_FILE_NAMES
