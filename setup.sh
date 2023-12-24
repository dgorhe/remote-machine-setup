#!/bin/bash

# Detect Operating System
case "$(uname -s)" in
    Linux*)     os=Linux;;
    Darwin*)    os=Mac;;
    CYGWIN*)    os=Windows;;
    MINGW*)     os=Windows;;
    *)
        echo "Unknown OS"
        exit 1
        ;;
esac

# OS-specific Logic
if [ "$os" == "Linux" ]; then
    echo "Linux detected"

    # Install the Vundle plugin manager
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    # Copy over this .vimrc into the system's vimrc
    cp .vimrc ~/.vimrc

    # Install all the Vundle plugins and then quit all windows in vim
    vim -c "PluginInstall" -c "qa"

    # Install pre-requisites for youcompleteme on Ubuntu
    sudo apt install build-essential cmake vim-nox python3-dev -y
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_current.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt install mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm -y

    # Install miniconda
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh
    ~/miniconda3/bin/conda init bash

    # Install Miniforge3
    wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
    bash Miniforge3-$(uname)-$(uname -m).sh
fi

if [ "$os" == "Mac" ]; then
    echo "Mac detected"

    # Install the Vundle plugin manager
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    # Copy over this .vimrc into the system's vimrc
    cp .vimrc ~/.vimrc

    # Install all the Vundle plugins and then quit all windows in vim
    vim -c "PluginInstall" -c "qa"
fi

if [ "$os" == "Windows" ]; then
    echo "Windows detected"
    echo "I don't use Windows computers so idk how to install vim the right way :/"
fi

# Check Python version
python_path=""
for py_version in $(ls /usr/bin | grep -E 'python3(\.[0-9]+)?$'); do
    version_string=$(/usr/bin/$py_version -c 'import sys; print(".".join(map(str, sys.version_info[:3])))' 2>/dev/null)
    IFS='.' read -ra version_parts <<< "$version_string"
    major_version=${version_parts[0]}
    minor_version=${version_parts[1]}
  
    if [ "$major_version" -eq 3 ] && [ "$minor_version" -ge 8 ]; then
        python_path="/usr/bin/$py_version"

        # Installation logic for YouCompleteMe completion engine
        cd ~/.vim/bundle/youcompleteme
        $python_path install.py --all

        break
    fi
done

if [ -z "$python_path" ]; then
    echo "No suitable Python version found in /usr/bin"
    exit 1
fi


