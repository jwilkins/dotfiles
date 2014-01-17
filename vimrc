" -------------------------------------------------------------------------
" Motion:
"   % - Jump to matching brace (or back to previous)
" Find:
"   * - word under cursor (forward)
"   # - word under cursor (backward)
" Copy_Cut_and_Paste:
"   dd - delete line
"   p - paste line
"   "0p - paste line
"   "3p - paste the third most recent buffer
" Replace:
"  :12,20s/foo/bar/ - from line 12 to 20 replace foo with bar
"  :s/foo/bar/g     - current line replace foo with bar
"  .,+20s/foo/bar/g - next 20 lines replace foo with bar
"  :%s;\\;/;g       - replace \\ with / using ; as substution delimiter
"                     instead of /
"  :%s/\n\([^ ]\)/ \1/g - replace with backreferences
" Spelling:
"   zg - adds word under cursor to dictionary
" Autocomplete:
"   Ctrl-x - Auto Completion
"     Ctrl-n - Word from buffer
"     Ctrl-k - Word from dictionary
"     Ctrl-l - Line
" Registers:
"   "ayy - yank line to register a
"   "Ayy - yank line and append to register a
" Markers:
"   m[a-z] - set marker
"   m[A-Z] - set end of block marker
"   y'[a-z] - copy marked block
"   g`[a-z] - go to marker
"   d`[a-z] - delete to marker
"   :'a,'bs/^/#/ - comment all lines between mark a and mark b
"   :'a,'bs/^#// - uncomment all lines between mark a and mark b
" Math:
"   Ctrl-r=2+2 - When in insert mode, evaluate expression
" Formatting:
"   gq - formats selected block (ie v4jgq will create a block of 4 lines and
"      format it
"   '0-'9 : open last n used file (0 = last, 1 = last + 1, ...)
" Block Insert:
"   ctrl-shift-v <select block> I <stuff to prefix> <escape> <enter>
" Macros:
"   q[a-z] - start recording
"   q      - stop  recording
"   @[a-z] - play macro
"   @@     - replay last used macro
"   "ap    - edit macro in register a
"   "add   - delete current line and move to register a
" Misc:
"   ! - Execute
"   !! - Execute and insert result
"   :%s/\r\r/g - For files with just \r's, convert to \n
" Settings:
"   set fileformat=dos - change file mode (unix <> dos)
" Ifdef:
"  if has("win32")
"  else
"  endif
" -------------------------------------------------------------------------

" References --------------------------------------------------------------
" http://www.stripey.com/vim/keys.html

" Externals ---------------------------------------------------------------

" Code Auditing -----------------------------------------------------------
" http://redundancy.redundancy.org/plan/plan@400000004a39324e1e481d04.html
" - ctags -R .
" - cscope -R ^D
" - http://cscope.sourceforge.net/cscope_maps.vim

" Basic Stuff--------------------------------------------------------------
set nocp
syntax on
set t_Co=256
filetype on " without this vim emits a zero exit status, later, because of :ft off

" Line wrap without line breaks
set wrap
set linebreak
set nolist  " list disables linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=l
" tab size
set shiftwidth=2
set tabstop=2
set expandtab
set autochdir
set backupdir=/Users/jwilkins/.vimbackup
"call mkdir(set backupdir?, 'p')
set undofile
set undodir=/Users/jwilkins/.vimundo
"call mkdir(set undodir?, 'p')

" Colors
"color calmar256-dark

set encoding=utf-8
set laststatus=2
"set t_Sf=[3%dm
"set t_Sb=[4%dm
     "set t_Sf=^[[3%dm
     "set t_Sb=^[[4%dm
     "    set t_Co=8
     "    set t_Sf=^[[3%p1%dm
     "    set t_Sb=^[[4%p1%dm
     "  else
     "    set t_Co=8
     "    set t_Sf=^[[3%dm
     "    set t_Sb=^[[4%dm
set rnu

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='50,\"100,:50,%,n~/.viminfo

" Keystroke mappings ------------------------------------------------------

set macmeta
let mapleader=","

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

vmap <“> >gv
vmap <‘> <gv

nmap <“> >>
nmap <‘> <<

omap <“> >>
omap <‘> <<

imap <“> <Esc>>>i
imap <‘> <Esc><<i

" blackhole register is "_
" this makes xx equivalent to cut and dd deletes without yanking
"noremap x d
"noremap xx dd
"noremap d "_d
"noremap dd "_dd

"noremap x "_d
"noremap xx "_dd

"nnoremap <Space> gwap<CR>
"map <Esc>[B <Down>           " for tmux, may help arrow key behavior
noremap Y y$                  " Yank to the end of line
vmap D y'>p                   " Duplicate selected below
cnoremap <C-Space> gwap       " format current paragraph
map! <S-space> <esc>          " shift-space to escape
nmap S <Esc><C-w><C-w>
map <silent> <F2> :TagbarToggle<CR>
nnoremap <silent> <F2> :TagbarToggle<CR>
map <F3> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
map <F4> :execute "noautocmd vimgrep /" . expand("<cword>") . "/gj **/*." .  expand("%:e") <Bar> cw<CR>
map <silent> <F6> :TlistToggle<CR>
nnoremap <silent> <F6> :TlistToggle<CR>
set pastetoggle=<F7>        " Formatting of paste
nnoremap <silent> <F8> :set hls!<CR>  " Highlighting of search terms
map <silent> <F9> :NERDTreeToggle<CR>
nnoremap map <silent> <F9> :NERDTreeToggle<CR>
"nnoremap <silent> <F8> :TlistToggle<CR>  " ctrl-w ctrl-w to switch pane
nmap <C-N><C-N> :set invnumber<CR>


"map <silent> <leader>N :set number!<CR>
"map <silent> <leader>n :set rnu!<CR>
nnoremap <leader>n :NumbersToggle<CR>
map <silent> <leader>cf <Esc><C-V>}I#<Esc><CR>
nnoremap s xph

" double key presses
" timeoutlen
"inoremap jj <Esc>
"inoremap ff <C-v><Tab>
"inoremap aa <BS>
nnoremap ;; :
" clipboard stuff
vmap <silent> <leader>c y:call system("pbcopy", getreg("\""))<CR>
nmap <silent> <leader>v :call setreg("\"",system("pbpaste"))<CR>p
imap <silent> <leader>v <Esc><D-v>a

"nnoremap j gj
"nnoremap k gk

" Unbind the cursor keys in insert, normal and visual modes.
"for prefix in ['i', 'n', 'v']
"  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
"     exe prefix . "noremap " . key . " <Nop>"
"   endfor
"endfor

" support for files in multiple tabs --------------------------------------
nnoremap <silent> Z :tabprevious<cr>
nnoremap <silent> X :tabnext<cr>
nnoremap <silent> A :bprevious<cr>
nnoremap <silent> S :bnext<cr>
nnoremap <silent> Q :cprevious<cr>
nnoremap <silent> W :cnext<cr>

" ctags
"set tags=/mnt/foo/tags
set tags=tags

set notimeout
set ttimeout
set timeoutlen=50


" highlight currently selected word
highlight flicker cterm=bold ctermfg=white
au CursorMoved <buffer> exe 'match flicker /\V\<'.escape(expand('<cword>'), '/').'\>/'

autocmd FileType ruby compiler ruby


" colors for tabs
hi TabLine      cterm=NONE       ctermbg=NONE        ctermfg=lightgrey
" file name of selected tab (GUI default is bold black on white)
hi TabLineSel   cterm=NONE,bold  ctermbg=NONE        ctermfg=red
" fillup and tab-delete "X" at right
hi TabLineFill  cterm=NONE       ctermbg=NONE        ctermfg=red
" tab and file number 1:2/3 (meaning "tab 1: window 2 of 3) for selected tab
hi User1        cterm=none       ctermbg=green       ctermfg=black
" tab and file number 1:2/3 for unselected tab
hi User2        cterm=none       ctermbg=lightgrey   ctermfg=black
set iskeyword=48-57,65-90,97-122


" Strip the newline from the end of a string
"function! Chomp(str)
"  return substitute(a:str, '\n$', '', '')
"endfunction

" Find a file and pass it to cmd
"function! DmenuOpen(cmd)
"  let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
"  if empty(fname)
"    return
"  endif
"  execute a:cmd . " " . fname
"endfunction

"map <c-t> :call DmenuOpen("tabe")<cr>
"map <c-f> :call DmenuOpen("e")<cr>

" automatically choose the longest common completion
set completeopt=longest,menuone
" enter selects completion
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<C-n>" : ""<CR>'
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"autocmd BufWritePre * <Esc>ms <Bar> :%s/\s\+$//e <Bar> 's <Bar> :delm s
"autocmd BufWritePre * exe "normal maHmb" | :%s/\s*$// | exe "normal `bzt`a"
"autocmd BufWritePre * exe <silent> "normal ma" | :%s/\s*$// | exe "normal 'a"


" Whitespace
autocmd BufReadPost * match BadWhitespace /\s\+$/
autocmd InsertEnter * match BadWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match BadWhitespace /\s\+$/
highlight BadWhitespace ctermbg=1
" Remove trailing whitespace on <leader>S
nnoremap <leader>S ms :%s/\s\+$//<cr>:let @/=''<CR>'s
"set list listchars=tab:>-,trail:_
set list listchars=tab:»·,trail:·

" Maximum Awesome stuff? ------------------------
set autoindent
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                 " Fix broken backspace in some setups
set backupcopy=yes              " see :help crontab
"set clipboard=unnamed          " yank and paste with the system clipboard
"set directory-=.                " don't store swapfiles in the current directory
:set directory=$HOME/.vim/swapfiles//
set encoding=utf-8
set expandtab                   " expand tabs to spaces
set ignorecase                  " case-insensitive search
set incsearch                   " search as you type
set laststatus=2                " always show statusline
set list                        " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                      " show line numbers
set ruler                       " show where you are
set scrolloff=3                 " show context above/below cursorline
set shiftwidth=2                " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                   " case-sensitive search if any caps
set softtabstop=2               " insert mode tab and backspace use 2 spaces
set tabstop=8                   " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                    " show a navigable menu for tab completion
set wildmode=longest,list,full

" Enable basic mouse behavior such as resizing buffers.
"set mouse=a
"if exists('$TMUX')  " Support resizing in tmux
"  set ttymouse=xterm2
"endif

" keyboard shortcuts
let mapleader = ','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>l :Align
nmap <leader>a :Ack<space>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>d :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>
nmap <leader>t :CtrlP<CR>
nmap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nmap <leader>] :TagbarToggle<CR>
nmap <leader><space> :call whitespace#strip_trailing()<CR>
nmap <leader>g :GitGutterToggle<CR>
nmap <leader>c <Plug>Kwbd
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" End Maximum Awesome stuff -------------------------------
"
" ------- Bundle stuff ----------------
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" commandline install: vim +BundleInstall +qall
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" install Vundle bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

"===============================================================
"Bundle 'gmarik/vundle'

"Bundle 'Rainbow-Parentheses-Improved-and2'
"let g:rainbow_active    = 1
"let g:rainbow_operators = 1
"Bundle 'amdt/vim-niji'  " fail
"Bundle 'kien/rainbow_parentheses.vim'  " untested
"Bundle 'oblitum/rainbow'  " works
"au FileType ruby,c,cpp,objc,objcpp call rainbow#load()

" Needs a git subtree add, have local mods
"Bundle 'rainbow-end'
"au FileType ruby call RainbowEndOn()

"Bundle 'tpope/vim-unimpaired'  " in vimrc.bundles.local
Bundle 'sjl/gundo.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'milkypostman/vim-togglelist'
Bundle 'vim-scripts/AnsiEsc.vim'
Bundle 'sjl/vitality.vim'
"Bundle 'maxbrunsfeld/vim-yankstack'

"Bundle 'YankRing.vim'
"nnoremap <silent> <F1> :YRShow<CR>
"let g:yankring_replace_n_pkey = '<m-p>'
"let g:yankring_replace_n_nkey = '<m-n>'

"Bundle 'Valloric/YouCompleteMe'
"Bundle 'tpope/vim-eunuch'
"Bundle 'vim-scripts/renamer'

Bundle 'openssl.vim'
let g:openssl_backup = 1


" using slimux instead
"Bundle 'jpalardy/vim-slime'
"let g:slime_target = "tmux"
"let g:slime_default_config = {"socket_name": "default", "target_pane": "6"}

"Bundle 'altercation/vim-colors-solarized' " in vimrc.bundles
"color solarized
set background=dark
" solarized options
let g:solarized_termcolors  = 256
"let g:solarized_visibility = "high"
"let g:solarized_contrast   = "high"
let ruby_operators          = 1
let ruby_space_errors       = 1
"colorscheme solarized

"Bundle 'airblade/vim-gitgutter' " in vimrc.bundles

Bundle 'Lokaltog/vim-easymotion'

Bundle 'vim-scripts/restore_view.vim'
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']

"Bundle 'kien/ctrlp.vim'
"let g:ctrlp_map = '<c-w>'
"let g:ctrlp_cmd = 'CtrlP'

Bundle 'godlygeek/tabular'
" plugin usage:
"   :Tabularize /=                    to align on =

"not this Bundle 'Lokaltog/powerline'
"Bundle 'Lokaltog/vim-powerline'
" need the droid slashed for powerline
" http://alexyoung.org/2012/01/13/using-powerline-with-mac-os/
"let g:Powerline_symbols = 'unicode'
"let g:Powerline_symbols = 'fancy'
"let g:Powerline_theme       = 'solarized256'
"let g:Powerline_colorscheme = 'solarized256'


">>>>>>> 71542cc3b5fa1c9c4fed5f4237b1fda1b7752d85

" plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:gitgutter_enabled = 0

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" extra rails.vim help
autocmd User Rails silent! Rnavcommand decorator      app/decorators            -glob=**/* -suffix=_decorator.rb
autocmd User Rails silent! Rnavcommand observer       app/observers             -glob=**/* -suffix=_observer.rb
autocmd User Rails silent! Rnavcommand feature        features                  -glob=**/* -suffix=.feature
autocmd User Rails silent! Rnavcommand job            app/jobs                  -glob=**/* -suffix=_job.rb
autocmd User Rails silent! Rnavcommand mediator       app/mediators             -glob=**/* -suffix=_mediator.rb
autocmd User Rails silent! Rnavcommand stepdefinition features/step_definitions -glob=**/* -suffix=_steps.rb
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Go crazy!
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  "
  " set autowrite
  " set nocursorline
  " set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.vimrc.local
endif
if filereadable(expand("~/.vimrc.after"))
  source ~/.vimrc.after
endif
" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on
