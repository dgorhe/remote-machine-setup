set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'valloric/youcompleteme'
    Plugin 'leafgarland/typescript-vim'
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'davidhalter/jedi-vim'
    Plugin 'tmhedberg/simpylfold'
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    Plugin 'lervag/vimtex'
    Plugin 'snakemake/snakefmt'
    Plugin 'https://github.com/snakemake/snakemake.git', {'rtp': 'misc/vim/'}
    Plugin 'mg979/vim-visual-multi'

call vundle#end()

filetype plugin indent on
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set omnifunc=htmlcomplete#CompleteTags

" Set tabstop to 4 spaces
set tabstop=4

" Set the number of spaces used for each step of (auto)indentation to 4
set shiftwidth=4

" Use spaces instead of tabs
set expandtab

" Line numbering
:set number
:set relativenumber

" Default to opening a new pane on the right
:set splitright
" :set splitbelow

" Search settings
set incsearch
set hlsearch

" Syntax highlighting
syntax on

set foldmethod=indent
set nofoldenable

" Allow backspace to delete newline and return to previous line
set bs=eol

" Use Ctrl + h, j, k, l for moving between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" nnoremap <space> za
onoremap b i[|
onoremap p i(|
onoremap c i{|
onoremap q i"|
