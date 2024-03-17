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
    
    # Download packer.nvim if not already installed
    if [ -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
        echo "packer.nvim is already installed"
    else
        git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim 
    fi

    # Download and set up neovim if not already installed
    if [ command -v nvim &> /dev/null ]; then
        echo "Neovim is already installed"
    else
        echo "Neovim is not installed, installing now..."
        
        wget -O $HOME/nvim-linux64.tar.gz "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
        tar -xvzf $HOME/nvim-linux64.tar.gz 
        rm -rf $HOME/nvim-linux64.tar.gz
        sudo mv $HOME/nvim-linux64 /usr/local/nvim
        export PATH=$PATH:/usr/local/nvim/bin
    fi

    # Install pre-requisites for plugins and LSP servers
    sudo apt install npm python3-dev python3-pip cmake ripgrep fd-find -y

    # Install miniconda
    if [ command -v conda &> /dev/null ]; then
        echo "Miniconda is already installed"
    else
        echo "Miniconda is not installed, installing now..."
        mkdir -p ~/miniconda3
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
        bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
        rm -rf ~/miniconda3/miniconda.sh
        ~/miniconda3/bin/conda init bash
    fi

    # Install Miniforge3
    wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
    bash Miniforge3-$(uname)-$(uname -m).sh
fi

if [ "$os" == "Mac" ]; then
    echo "Mac detected"

    # Download packer.nvim if not already installed
    if [ -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
        echo "packer.nvim is already installed"
    else
        git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim 
    fi

    # Install neovim via Homebrew
    brew install neovim

    # Install pre-requisites for plugins and LSP servers
    brew install npm python3 cmake ripgrep fd
fi

if [ "$os" == "Windows" ]; then
    echo "Windows detected"
    echo "I don't use Windows computers so I don't know how to install neovim the right way :/"
fi
