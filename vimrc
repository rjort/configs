set nocompatible

" install plugin manager of the week if fresh system

let iCanHazPlugins=1
let plug=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug)
	echon "Right now you thanks previous you..."
	silent !mkdir -p ~/.vim/autoload
	silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	let iCanHazPlugins=0
endif

call plug#begin('~/.vim/plugged')

"" Plugins
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-grepper'
Plug 'vim-airline/vim-airline-themes'
Plug 'godoctor/godoctor.vim'
Plug 'benekastah/neomake'

"" Langs
Plug 'kchmck/vim-coffee-script'
Plug 'wting/rust.vim'
Plug 'stephpy/vim-yaml'
Plug 'cespare/vim-toml'
Plug 'tpope/vim-markdown'

"" Colors
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-wombat-scheme'

call plug#end()               " required
filetype plugin indent on     " required


" install above bundles if fresh system
if iCanHazPlugins == 0
	echo "Installing yo shit, please ignore key map error messages"
	echo ""
	:PlugInstall
endif

set encoding=utf-8

set number
set relativenumber
set backspace=indent,eol,start
set history=1000
set showcmd
set showmode
set visualbell
set autoread
set t_Co=256
set term=xterm-256color
set re=1
set ttyfast
set lazyredraw
set noswapfile
set nobackup
set nowb

"if executable('usr/bin/ruby')
"	let g:ruby_path="/usr/bin/ruby"
"endif

" remappings
let mapleader=","
set pastetoggle=<F2>
noremap <silent> <leader>l :noh<CR>
noremap <silent> <leader>d :bd<CR>

" splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-J> <C-W><C-K>
nnoremap <C-J> <C-W><C-L>
nnoremap <C-J> <C-W><C-H>
nnoremap <C-=> <C-W>=

set splitbelow
set splitright
set diffopt+=vertical


"" Search Settings
set incsearch
set hlsearch
set viminfo='100,f1


"" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

augroup vimrcEx
	autocmd!

	"" when editing a file, walways jump to the last know cursor position
	"" dont do it for commit messages, when the position is invalid, or
	"" when inside an event handler (happens when dropping a file on gvim)
	autocmd BufReadPost *
	\ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
	\	exe "normal g `\"" |
	\ endif

	"" syntax highlightning for specific file types
	autocmd BufRead,BufNewFile *.md set filetype=markdown

	"" for all text files set 'textwidth' to 78 characters
  autocmd FileType text,markdown,gitcommit setlocal textwidth=78
	autocmd FileType text,markdown,gitcommit setlocal spell

	"" neomake
	autocmd! BufWritePost * Neomake!
augroup END

set nowrap
set linebreak

"" folding
set foldmethod=indent
au BufRead * normal zR

"" completion
set wildmode=list:longest

"" scrolling
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

"" airline
set laststatus=2
set noshowmode
if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif

let g:airline_theme='gruvbox'
let g:airline_section_x=''
let g:airline_section_y='%{&filetype}'
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#hunks#enabled=0

"" bufferline
let g:bufferline_echo=0

"" ag / ctrlp mods
if executable('ag')
	"" use silver searcher for grep
	set grepprg=ag\ --nogroup\ --nocolor

	"" use AG in ctrlp because aint nobody got time fo dat
	let g:ctrlp_user_command='ag %s -l --nocolor --files-with-matches -g "" --ignore "vendor/" --ignore bundle/'

	"" dont even have to leave to see new files
	let g:ctrlp_use_caching=0
endif

"" fugitive
" set statusline+=%{FugitiveStatusline()}

"" nerdtree
map <F3> :NERDTreeToggle<CR>

"" gruvbox
" let g:gruvbox_constrast_dark='hard'

"" Synstastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_check_on_open=1
"let g:syntastic_check_on_wq=0

"" theme
set list listchars=tab:»·,trail:·
set background=dark
" colorscheme gruvbox
syntax on

hi clear SignColumn
hi Normal ctermbg=NONE guibg=NONE
hi CursorLineNr ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi SpecialKey ctermbg=NONE guibg=NONE ctermfg=238 guifg=#444444
