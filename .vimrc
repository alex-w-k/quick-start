execute pathogen#infect()
syntax on
set nocompatible
filetype off

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd Filetype html setlocal ts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sw=2
autocmd BufNewFile,BufRead *_spec.rb set syntax=rspec
autocmd BufNewFile,BufRead *_test.rb set syntax=rspec
" autocmd BufNewFile,BufRead */controls/*.rb set syntax=rspec
" autocmd FileType ruby,eruby set filetype=ruby.eruby.chef
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent  " indent on enter
set smartindent " do smart indenting when starting a new line
set shiftround  " indent to the closest shiftwidth

set background=dark
colorscheme gruvbox

syntax enable
filetype plugin indent on

set nu
set number
set backspace=indent,eol,start " backspace over everything in insert mode
set syntax=whitespace

set relativenumber
set number

" When searching try to be smart about cases
set smartcase

set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Smart way to move between windows
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

set nobackup      " don't want no backup files
set nowritebackup " don't make a backup before overwriting a file
set noswapfile    " no swap files


" Auto-reload buffers when files are changed on disk
set autoread

set undofile            " Save undo's after file closes
set undodir=~/.vim/undo " where to save undo histories
set undolevels=1000     " How many undos
set undoreload=10000    " number of lines to save for undo

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

" Rust vim stuff:

let g:rust_clip_command = 'pbcopy'
let g:rustfmt_autosave = 1

" Automatically start NERDTree
autocmd VimEnter * NERDTree

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-ruby/vim-ruby'
Plug 'nelsyeung/twig.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rvm'
Plug 'pangloss/vim-javascript'
Plug 'keith/rspec.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'tmhedberg/matchit'
Plug 'groenewege/vim-less'
Plug 'vim-syntastic/syntastic'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tomlion/vim-solidity'
Plug 'tpope/vim-surround'
Plug 'skalnik/vim-vroom'
Plug 'tpope/vim-bundler'
Plug 'alex-w-k/vim-chef'
Plug 'tpope/vim-cucumber'
Plug 'rhysd/vim-crystal'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-dotenv'
Plug 'ervandew/supertab'
Plug 'markcornick/vim-kitchen'
Plug 'kchmck/vim-coffee-script'
Plug 'rust-lang/rust.vim'
Plug 'mattn/webapi-vim'
Plug 'hashivim/vim-terraform'
Plug 'bfontaine/Brewfile.vim'
Plug 'vim-scripts/bats.vim'
Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }

" Initialize plugin system
call plug#end()
