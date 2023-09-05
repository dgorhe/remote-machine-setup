git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cp ./.vimrc ~/.vimrc
vim ~/.vimrc -c "PluginInstall" -c "qa"

#!/bin/bash

# Check Python version
python_version=$(/usr/bin/python3 -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')

# Split the version into an array
IFS='.' read -ra version_parts <<< "$python_version"

# Check major and minor version
major_version=${version_parts[0]}
minor_version=${version_parts[1]}

if [ "$major_version" -ge 3 ] && [ "$minor_version" -ge 8 ]; then
    cd ~/.vim/bundle/YouCompleteMe
    /usr/bin/python3 install.py --all
else
    echo "Python version 3.8 or higher is required to install youcompleteme (don't use conda python path)"
fi

