"Simple vimrc that I give to people just starting to use Vim."
"Lines beginning with a double quote are comments."

" Basic settings
set nocompatible "Fixes old Vi bugs
syntax on
set backspace=2 "Makes backspace work
set history=500 "Sets undo history size
set ruler "Sets up status bar
set laststatus=2 "Always keeps the status bar active
set number "Turns on line numbering
" Indentation settings
set tabstop=2 "Sets display width of tabs
set shiftwidth=2 "Sets indentation width
set autoindent "Turns on auto-indenting
set smartindent "Remembers previous indent when creating new lines

autocmd FileType python setlocal ts=4 sw=4 sts=0 expandtab
"
"Choose between tabs and spaces for indentation by uncommenting one of
"these two. Expand for spaces, noexpand for tabs:"
set expandtab

" visual stuff
set cursorline "Horizontal Current Line
set cursorcolumn "Verticle Current Line
hi CursorLine cterm=None ctermbg=darkgray ctermfg=white


" Search settings
set hlsearch "Highlights search terms
set showmatch "Highlights matching parentheses
set ignorecase "Ignores case when searching
set smartcase "Unless you put some caps in your search term
set incsearch "Search as things are entered

" Key mappings
"Use jj instead of escape in insert mode
inoremap jj <Esc>`^

" Enable mouse 
set mouse=a 
if &term =~ '^screen'
    set ttymouse=xterm2
endif

" Close window if nerd tree is the last thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"Turn on plugin & indentation support for specific filetypes
" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

" Create a plugged folder if it doesn't exist

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Jedi Vim: Vim Autocompletion
Plug 'davidhalter/jedi-vim'

" Ag: Searching in vim 
Plug 'rking/ag.vim'

" CtrlP: Fuzzy file opener
Plug 'kien/ctrlp.vim'

" Tmux Nav: Split navigation that works with tmux
Plug 'christoomey/vim-tmux-navigator'

" Fugitive: Git from within Vim
Plug 'tpope/vim-fugitive'

" ZoomWin: zoom into vim windows
Plug 'vim-scripts/ZoomWin'

" Alias: allows aliases in vim
Plug 'vim-scripts/cmdalias.vim'

" NERDTree: filesystem for vim
Plug 'scrooloose/nerdtree'

" Colorschemes: colorschemes for vim
Plug 'flazz/vim-colorschemes'

" AutoPep8: Make PY Pretty Again
Plug 'tell-k/vim-autopep8'

" Prettier: Make JS Pretty Again
Plug 'mitermayer/vim-prettier', {
           \ 'do': 'npm install',
           \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'],
           \ 'tag': '0.0.7'}

" Prettier: Config
let g:prettier#config#print_width = 110
let g:prettier#config#tab_width = 2
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'true'
let g:prettier#autoformat = 0

" Prettier: run prettier on files before writing out the vim buffer to files with these extensions
autocmd BufWritePre *.js,*.jsx Prettier

" AutoPep8: config
let g:autopep8_disable_show_diff=1
let g:autopep8_ignore="E501,E121,E125,E126,E128"

" AutoPep8: run autopepe8 obefore writng out the vim buffer to files with py
autocmd BufWritePre *.py Autopep8

" code linters
Plug 'scrooloose/syntastic', { 'for': ['php', 'python', 'javascript', 'css'] }
let g:syntastic_python_checkers = ['python', 'pyflakes', 'pep8']
let g:syntastic_javascript_checkers = ['eslint']
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
    let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
        let g:syntastic_javascript_eslint_exec = local_eslint
endif

filetype plugin indent on                   " required!
call plug#end()

colorscheme Monokai
