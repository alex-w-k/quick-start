execute pathogen#infect()
syntax on "syntax highlighting on
set nocompatible "always iMproved
filetype off

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif "install vim-plug and plugins on first run

autocmd Filetype html setlocal ts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sw=2
autocmd BufNewFile,BufRead *_spec.rb set syntax=rspec "set syntax for rspec files
autocmd BufNewFile,BufRead *_test.rb set syntax=rspec "set syntax for rspec files
set tabstop=2 shiftwidth=2 softtabstop=2 "default to 2 space tabs
set autoindent  " indent on enter
set smartindent " do smart indenting when starting a new line
set shiftround  " indent to the closest shiftwidth

set background=dark "theme
colorscheme gruvbox "theme

syntax enable "enable syntax after setting rules
filetype plugin indent on "set filetype detecting after setting rules

set backspace=indent,eol,start " backspace over everything in insert mode
set syntax=whitespace "highlight whitespace

set relativenumber "set both number and relative number for specific line 
set number         "number for current line and relative to jump to lines

" When searching try to be smart about cases
set smartcase

" Use spaces instead of tabs
set expandtab

set wrap "Wrap lines

" Smart way to move between windows ctrl-direction to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

au BufWritePost .vimrc so $MYVIMRC

set ls=2  " show a status line even if there's only one window

" Improve vim's scrolling speed
set ttyfast
set ttyscroll=3
set lazyredraw

" don't create extra files
set nobackup      " don't want no backup files
set nowritebackup " don't make a backup before overwriting a file
set noswapfile    " no swap files


" Auto-reload buffers when files are changed on disk
set autoread

"create undo dir if it doesn't exist
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif
set undofile            " Save undo's after file closes
set undodir=~/.vim/undo " where to save undo histories
set undolevels=1000     " How many undos
set undoreload=10000    " number of lines to save for undo

"clean up trailing whitespace on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

set cursorline          " highlight current line
" move by visual line
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

"vim-airline setup
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0
let g:syntastic_ruby_checkers = ['rubocop', 'mri', 'jruby']
let g:syntastic_ruby_rubocop_exec = '/usr/local/bin/cookstyle'

" Automatically start NERDTree
autocmd VimEnter * NERDTree

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'vim-ruby/vim-ruby' "Ruby syntax highlighting
Plug 'scrooloose/nerdtree' "A tree explorer plugin for vim.
Plug 'Xuyuanp/nerdtree-git-plugin' "A plugin of NERDTree showing git status 
Plug 'airblade/vim-gitgutter' "shows a git diff in the gutter (sign column)
Plug 'vim-airline/vim-airline' "lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes' "themes for airline
Plug 'jreybert/vimagit' "you can perform main git operations 
Plug 'tpope/vim-fugitive' "A Git wrapper so awesome, it should be illega
Plug 'tpope/vim-endwise' "wisely add 'end' in ruby,
Plug 'tpope/vim-commentary' "Comment stuff out. Use gcc to comment out a line, gc to comment a selection
Plug 'tpope/vim-rvm' "Switch Ruby versions from inside Vim
Plug 'tpope/vim-surround' "quoting/parenthesizing made simple
Plug 'tpope/vim-bundler' "Lightweight support for Ruby's Bundler
Plug 'tpope/vim-dotenv' "Basic support for .env and Procfile
Plug 'sheerun/vim-polyglot' "A solid language pack for Vim.
Plug 'pangloss/vim-javascript' "Vastly improved Javascript indentation and syntax support
Plug 'keith/rspec.vim' "Better rspec syntax highlighting for Vim
Plug 'vim-syntastic/syntastic' "Syntax checking hacks for vim 
Plug 'ecomba/vim-ruby-refactoring' "Refactoring tool for Ruby in vim!
Plug 'skalnik/vim-vroom' "A vim plugin for running your Ruby tests
Plug 'alex-w-k/vim-chef' "my own chef/inspec syntax highlighting
Plug 'ekalinin/Dockerfile.vim' "Vim syntax file & snippets for Docker's Dockerfile 
Plug 'ervandew/supertab' "tab completion
Plug 'markcornick/vim-kitchen' "basic vim/kitchen integration 
Plug 'hashivim/vim-hashicorp-tools' "elf-contained and fairly explanatory agglomeration of HashiVim plugins
Plug 'vim-scripts/bats.vim' "Syntax highlighting for Bats - Bash Automated Testing System
Plug 'junegunn/vader.vim' "A simple Vimscript test framework 

" Initialize plugin system
call plug#end()
