# 
# Inspired from Nima Saed install script 
# https://gitlab.com/NimaSaed/dotfiles/-/blob/master/install.sh
#
# run with:
# bash -x install.sh
#
set -o nounset		# Treat unset variables as errors

dependencies="maim grim xclip wl-copy jq swaywsr git vim-runtime gvim swaybg swayimg"

ln -snf ${PWD}/bash/bash_profile	${HOME}/.bash_profile
ln -snf ${PWD}/bash/bashrc 		${HOME}/.bashrc
ln -snf ${PWD}/bash/bash_aliases	${HOME}/.bash_aliases
#ln -snf ${PWD}/.colors		${HOME}
#ln -snf ${PWD}/dircolors/dracula	${HOME}/.dircolors
ln -snf ${PWD}/vim/vimrc 		${HOME}/.vimrc
#ln -snf ${PWD}/xres/Xresources 		${HOME}/.Xresources
#ln -snf ${PWD}/i3/config		${HOME}/.config/i3
#ln -snf ${PWD}/rofi/config.rasi		${HOME}/.config/rofi
#ln -snf ${PWD}/screenlayout		${HOME}/.screenlayout
ln -snf ${PWD}/git/gitconfig		${HOME}/.gitconfig

# Make directory if not existing yet
if [ ! -d ${HOME}/.config/mutt ]; then
	mkdir -p ${HOME}/.config/mutt
	mkdir -p ${HOME}/.mutt/hcache
fi
ln -snf ${PWD}/mutt/muttrc	${HOME}/.config/mutt/muttrc
ln -snf ${PWD}/mutt/colors-dracula.rc	${HOME}/.config/mutt/colors-dracula.rc
ln -snf ${PWD}/mutt/colors-gruvbox.rc	${HOME}/.config/mutt/colors-gruvbox.rc
ln -snf ${PWD}/mutt/colors-neonwolf.rc	${HOME}/.config/mutt/colors-neonwolf.rc
ln -snf ${PWD}/mutt/colors-solarized-dark-256.rc	${HOME}/.config/mutt/colors-solarized-dark-256.rc
ln -snf ${PWD}/mutt/gpg.rc	${HOME}/.config/mutt/gpg.rc

# SMTP cannot be link and needs special permissions
install -Dm600 msmtp/msmtprc		${HOME}/.msmtprc

# Make directory if not existing yet
if [ ! -d ${HOME}/.config/i3status-rust ]; then
	mkdir -p ${HOME}/.config/i3status-rust
fi
ln -snf ${PWD}/i3status-rust/config.toml	${HOME}/.config/i3status-rust/config.toml

# Make directory if not existing yet
if [ ! -d ${HOME}/.config/i3wsr ]; then
	mkdir -p ${HOME}/.config/i3wsr
fi
ln -snf ${PWD}/i3wsr/config.toml	${HOME}/.config/i3wsr/config.toml

# Make directory if not existing yet
if [ ! -d ${HOME}/.config/sway ]; then
	mkdir -p ${HOME}/.config/sway
fi
ln -snf ${PWD}/sway/config		${HOME}/.config/sway/config

# Make directory if not existing yet
if [ ! -d ${HOME}/.config/foot ]; then
	mkdir -p ${HOME}/.config/foot
fi
ln -snf ${PWD}/foot/foot.ini		${HOME}/.config/foot/foot.ini

# Install Vim package manager
if [ ! -d ${HOME}/.vim/bundle/Vundle.vim ]; then
	git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
fi

# Install Git completion scripts if installed
if command -v git > /dev/null 2>&1; then
	git_version=$(git --version | cut -d' ' -f3)
	git_base_url="https://git.kernel.org/pub/scm/git/git.git/plain/contrib/completion"
	if [ ! -f ${HOME}/.git-completion.bash ]; then
		wget -O ${HOME}/.git-completion.bash "${git_base_url}/git-completion.bash?h=v${git_version}"
	fi
	if [ ! -f ${HOME}/.git-prompt.sh ]; then
		wget -O ${HOME}/.git-prompt.sh "${git_base_url}/git-prompt.sh?h=v${git_version}"
	fi
fi

# Allow unrestricted access to dmesg
if [[ $(cat /proc/sys/kernel/dmesg_restrict) -eq 1 ]]; then
	echo "Allowing unrestricted access to dmesg (needs sudo)"
	sudo sysctl -w kernel.dmesg_restrict=0
fi
