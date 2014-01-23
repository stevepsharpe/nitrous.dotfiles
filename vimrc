" no vi-compatible
set nocompatible
set encoding=utf-8 " Necessary to show Unicode glyphs

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Bundles from GitHub repos:

" Fugitive
Bundle 'fugitive.vim'
" Better file browser
Bundle 'scrooloose/nerdtree'
" Class/module browser
Bundle 'majutsushi/tagbar'
" Code and files fuzzy finder
Bundle 'kien/ctrlp.vim'
" Zen coding
Bundle 'mattn/emmet-vim'
" Git integration
Bundle 'motemen/git-vim'
" Tab list panel
Bundle 'kien/tabman.vim'
" Rails
Bundle 'tpope/vim-rails'
" Surround
Bundle 'tpope/vim-surround'
" Endwise
Bundle 'tpope/vim-endwise'
" Autoclose
Bundle 'Townk/vim-autoclose'
" Tabular
Bundle 'godlygeek/tabular'
" Undo
Bundle 'Gundo'
" Gist
Bundle 'mattn/gist-vim'

Bundle 'chriskempson/base16-vim'
Bundle 'kchmck/vim-coffee-script.git'
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'chriskempson/tomorrow-theme'
Bundle 'airblade/vim-gitgutter'
Bundle 'tComment'
Bundle 'tpope/vim-unimpaired'
" Syntastic
Bundle 'scrooloose/syntastic'

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

syntax enable

" allow plugins by file type
filetype plugin on
filetype indent on

" tabs and spaces handling
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

let mapleader = ','
let maplocalleader = '\'

map <Leader>i mmgg=G`m<CR>
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

let g:airline_theme = 'jellybeans'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:tmuxline_preset = 'powerline'

" always show status bar
set ls=2

" Tell vim to shut up
set visualbell

" backup and noswap
set noswapfile
set nobackup
set autoread
set history=1000
set backspace=indent,eol,start
set ruler

set autoindent
set nowrap
set showmatch

" incremental search
set incsearch

" highlighted search results
set hlsearch

" smartcase
set ignorecase
set smartcase

" line numbers
set relativenumber
set numberwidth=5
set cursorline

" toggle Tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on Tagbar open
let g:tagbar_autofocus = 1

" NERDTree (better file browser) toggle
map <F3> :NERDTreeToggle<CR>

" tab navigation
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm 
map tt :tabnew 
map <S-l> :tabn<CR>
map <S-h> :tabp<CR>

" navigate windows with meta+arrows
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-k> <c-w>k
map <c-m> <c-w>j

" automatically close autocompletion window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" old autocomplete keyboard shortcut
imap <C-J> <C-X><C-O>

" show pending tasks list
" map <F2> :TaskList<CR>

" save as sudo
ca w!! w !sudo tee "%"

" Toggle Paste
set pastetoggle=<leader>p

" CtrlP (new fuzzy finder)
let g:ctrlp_map = '<Leader>t'
nmap ; :CtrlPBuffer<CR>
nmap ,g :CtrlPBufTag<CR>
nmap ,G :CtrlPBufTagAll<CR>
nmap ,f :CtrlPLine<CR>
nmap ,m :CtrlPMRUFiles<CR>
" to be able to call CtrlP with default search text
function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    execute ':CtrlP' . a:ctrlp_command_end
    call feedkeys(a:search_text)
endfunction
" CtrlP with default text
nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
" Don't change working directory
let g:ctrlp_working_path_mode = 0
" Ignore files on fuzzy finder
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" tabman shortcuts
let g:tabman_toggle = 'tl'
let g:tabman_focus  = 'tf'

" use 256 colors when possible
if &term =~? 'mlterm\|xterm\|screen-256\|xterm-256color'
  let &t_Co = 256
  " color
end

  set background=dark
  colorscheme jellybeans

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" to use fancy symbols for powerline, uncomment the following line and use a
" patched font (more info on the README.rst)
" let g:Powerline_symbols = 'fancy'
let g:Powerline_theme = 'default'

" Toggle noh
map  <c-x> :set hls!<CR>
imap <c-x> <ESC>:set hls!<CR>a
vmap <c-x> <ESC>:set hls!<CR>gv

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel 
map <Leader>c :Rcontroller 
map <Leader>v :Rview 
map <Leader>u :Runittest 
map <Leader>f :Rfunctionaltest 
map <Leader>tm :RTmodel 
map <Leader>tc :RTcontroller 
map <Leader>tv :RTview 
map <Leader>tu :RTunittest 
map <Leader>tf :RTfunctionaltest 
map <Leader>sm :RSmodel 
map <Leader>sc :RScontroller 
map <Leader>sv :RSview 
map <Leader>su :RSunittest 
map <Leader>sf :RSfunctionaltest 

