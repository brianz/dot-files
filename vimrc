" ------------------------------------------------
" ---------- Vundle config -----------------------
" ------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugin 'SirVer/ultisnips'
" Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'itchyny/lightline.vim'
"Plugin 'honza/vim-snippets'
"Plugin 'isRuslan/vim-es6'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'fatih/vim-go'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'lambdatoast/elm.vim'
Plugin 'mxw/vim-jsx'
Plugin 'tomtom/tcomment_vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Set ultisnips triggers
" let g:UltiSnipsExpandTrigger="<tab>"                                            
" let g:UltiSnipsJumpForwardTrigger="<tab>"                                       
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>" 

" used with lightline
" set laststatus=2
" if !has('gui_running')
    " set t_Co=256
" endif

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" set syntax on for all file types
syntax enable

set number
set showmode

set autoindent

" Insert spaces whenever "tab" is pressed
set expandtab
" 4 spaces for a tab
set tabstop=4
" spaces for indentation
set shiftwidth=4
"  makes the backspace key treat the four spaces like a tab (so one backspace goes back a full 4 spaces).
set softtabstop=4

" make backspaces more powerfull
set backspace=indent,eol,start

" Wrap text after a certain number of characters.  Do this for all file types.
set textwidth=99

hi Comment ctermfg=2

set ruler
set showmatch

set hlsearch
let loaded_matchparen = 1
set complete-=i
set completeopt=longest

" Shortcuts 
" these are old comment shortcuts which are superceded by gc plugin
" map ,# :s/^/#/<CR><Esc>:nohlsearch<CR>
" map ,!# :s/^#//<CR><Esc>:nohlsearch<CR>

map \l :set number!<CR>
map \o :set paste!<CR>

" vimrc file for following the coding standards specified in PEP 7 & 8.
"
" To use this file, source it in your own personal .vimrc file (``source
" <filename>``) or, if you don't have a .vimrc file, you can just symlink to it
" (``ln -s <this file> ~/.vimrc``).  All options are protected by autocmds
" (read below for an explanation of the command) so blind sourcing of this file
" is safe and will not affect your settings for non-Python or non-C files.
"
"
" All setting are protected by 'au' ('autocmd') statements.  Only files ending
" in .py or .pyw will trigger the Python settings while files ending in *.c or
" *.h will trigger the C settings.  This makes the file "safe" in terms of only
" adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.
" Some suggested options are listed but commented out at the end of this file.

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4
" 
" Now for html and js
au BufRead,BufNewFile *.html,*.js,*.jsx,*.scss,*.jade set tabstop=2

" Strip trailing whitespace on save
au BufWritePre *.py,*.pyw,*.c,*.h,*.sh,*.js,*.jsx,*.scss,*.jade,*.rb :%s/\s\+$//e

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
" HTML/js/web/ruby
au BufRead,BufNewFile *.html,*.js,*.jsx,*.scss,*.jade,*.rb set shiftwidth=2

" This should be redundant since we're already setting tabstop and shifwidth,
" but leave it in for explicitness.
au BufRead,BufNewFile *.py,*pyw set softtabstop=4
au BufRead,BufNewFile *.py,*.pyw,*.html set expandtab
fu Select_c_style()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el 
        set shiftwidth=4
        set expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.sh match BadWhitespace /\s\+$/

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" rst docs
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.rst match BadWhitespace /\s\+$/
" Strip trailing whitespace on save
au BufWritePre *.rst :%s/\s\+$//e

" Bad whitespace for html, js, css, yaml, etc.
au BufRead,BufNewFile *.html,*.css,*.js,*.jsx,*.scss,*.less,*.yml,*.sls match BadWhitespace /^\t\+/
au BufRead,BufNewFile *.html,*.css,*.js,*.jsx,*.scss,*.less,*.yml,*.sls match BadWhitespace /\s\+$/
au BufWritePre *.html,*.css,*.js,*.jsx,*.scss,*.less,*.yml,*.sls :%s/\s\+$//e


" ----------------------------------------------------------------------------
" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
" let python_highlight_all=1

" Automatically indent based on file type:
filetype indent on

" Folding based on indentation: ``set foldmethod=indent``

" highlight the current line & column - use \c to turn on
" hi CursorLine   cterm=NONE ctermbg=235
" hi CursorColumn cterm=NONE ctermbg=235
" nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Highlight the current line
set cursorline
" Set cursorline colors
" hi CursorLine ctermbg=235
" Set color of number column on cursorline
" hi CursorLineNR ctermbg=235 ctermfg=221
" Set line number color in left tray
hi LineNr ctermfg=220

" -----------------------------------
au BufNewFile,BufRead *.less set filetype=less

" set syntax for salt/sls files
au BufNewFile,BufRead *.sls,*.yml set filetype=yaml shiftwidth=2 tabstop=2
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim

au BufNewFile,BufRead *.json set filetype=javascript shiftwidth=2 tabstop=2

" set syntax for jinja files
au BufNewFile,BufRead *.j2,*.jinja set filetype=jinja shiftwidth=2 tabstop=2
