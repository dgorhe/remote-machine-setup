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
    # Your logic here
fi

if [ "$os" == "Mac" ]; then
    echo "Mac detected"
    # Your logic here
fi

if [ "$os" == "Windows" ]; then
    echo "Windows detected"
    # Your logic here
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
        break
    fi
done

if [ -z "$python_path" ]; then
    echo "No suitable Python version found in /usr/bin"
    exit 1
fi

# Installation logic
cd ~/.vim/bundle/YouCompleteMe
$python_path install.py --all

