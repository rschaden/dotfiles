" vim: nowrap fdm=marker "  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

silent! runtime bundles.vim
runtime plugins/bclose.vim

"  ---------------------------------------------------------------------------
"  General
"  ---------------------------------------------------------------------------

filetype plugin indent on
let mapleader = ","
let g:mapleader = ","
set modelines=0
set history=10000
set nobackup
set nowritebackup
syntax enable
set autoread

"  ---------------------------------------------------------------------------
"  UI {{{
set title
set encoding=utf-8
set ruler
set scrolloff=3
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set backspace=indent,eol,start
set laststatus=2
set number
set undofile
set splitbelow splitright

if has('mouse')
  set mouse=a
endif
"  }}}

"  Text Formatting {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set nowrap
set textwidth=79
set formatoptions=n

" check to make sure vim has been compiled with colorcolumn support
" before enabling it
if exists("+colorcolumn")
  set colorcolumn=79
endif
" }}}

"  ---------------------------------------------------------------------------
"  Mappings
"  ---------------------------------------------------------------------------
" Turn off arrow keys {{{
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>"
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" }}}

" Searching / moving {{{
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
" }}}

" Center screen when scrolling search results {{{
nmap n nzz
nmap N Nzz
" }}}

" ACK {{{
set grepprg=ack
nnoremap <leader>a :Ack
" }}}

" Easy commenting {{{
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>
" }}}

" Switch between buffers {{{
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>
" }}}

" Move between splits {{{
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" Ignore some binary, versioning and backup files when auto-completing
set wildignore=.svn,CVS,.git,*.swp,*.jpg,*.png,*.gif,*.pdf,*.bak
" Set a lower priority for .old files
set suffixes+=.old

" rvm-vim automatically as you switch from buffer to buffer {{{
augroup rvm
  autocmd!
  autocmd BufEnter * Rvm
augroup END
" }}}

"  Function Keys {{{

" Press F5 to toggle GUndo tree
nnoremap <F5> :GundoToggle<CR>

" indent file and return cursor and center cursor
map   <silent> <F6> mmgg=G`m^zz
imap  <silent> <F6> <Esc> mmgg=G`m^zz
" }}}

"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

" eradicate all trailing whitespace all the time
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

" AutoClose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'}
let g:AutoCloseProtectedRegions = ["Character"]

" CtrlP
nmap <leader>f :CtrlP<cr>

" Add settings for tabular
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" align function {{{----------------------------------------------------------
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
" }}}

" Tabularize {{{
if exists(":Tab")
  nmap <leader>a\| :Tab /\|<CR>
  vmap <leader>a\| :Tab /\|<CR>
  nmap <leader>a= :Tab /=<CR>
  vmap <leader>a= :Tab /=<CR>
  nmap <leader>a: :Tab /:\zs<CR>
  vmap <leader>a: :Tab /:\zs<CR>
endif
" }}}

" Powerline {{{
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
let g:Powerline_symbols='fancy'
" }}}

"  ---------------------------------------------------------------------------
"  Language Mappings
"  ---------------------------------------------------------------------------

" Other files to consider Ruby
au BufRead,BufNewFile Gemfile,Rakefile,Thorfile,config.ru,Vagrantfile,Guardfile,Capfile set ft=

" CoffeeScript {{{
let coffee_compile_vert = 1
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
" }}}

" SASS / SCSS {{{
au BufNewFile,BufReadPost *.scss setl foldmethod=indent
au BufNewFile,BufReadPost *.sass setl foldmethod=indent
au BufRead,BufNewFile *.scss set filetype=scss
" }}}

"  ---------------------------------------------------------------------------
"  Directories
"  ---------------------------------------------------------------------------

set backupdir=~/tmp,/tmp
set undodir=~/.vim/.tmp,~/tmp,~/.tmp,/tmp

" Ctags path (brew install ctags)
let Tlist_Ctags_Cmd = 'ctags'

" Make Vim use RVM correctly when using Zsh
" https://rvm.beginrescueend.com/integration/vim/
set shell=/bin/sh

" Finally, load custom configs
if filereadable($HOME . '.vimrc.local')
  source ~/.vimrc.local
endif

"  MacVIM {{{
if has("gui_running")
  set guioptions-=T " no toolbar set guioptions-=m " no menus
  set guioptions-=r " no scrollbar on the right
  set guioptions-=R " no scrollbar on the right
  set guioptions-=l " no scrollbar on the left
  set guioptions-=b " no scrollbar on the bottom
  set guioptions=aiA
endif
" }}}

"  ---------------------------------------------------------------------------
"  GnomeTerminal
"  ---------------------------------------------------------------------------
"
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"  ---------------------------------------------------------------------------
"  Colors
"  ---------------------------------------------------------------------------
" let g:solarized_termcolors=256
set background=dark
colorscheme solarized

"  ---------------------------------------------------------------------------
"  Misc
"  ---------------------------------------------------------------------------

" When vimrc, either directly or via symlink, is edited, automatically reload it
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost vimrc source %

noremap <leader>d orequire 'pry';binding.pry
noremap <leader>D Orequire 'pry';binding.pry

" close buffer
nmap <leader>c :Bclose<CR>
" close all buffers
nmap <leader>C :bufdo bd<CR>

" let macro
noremap <leader>l :RExtractLet<cr>

" make uppercase
inoremap <c-u> <esc>viwUi
nnoremap <c-u> viwU

" edit vimrc
noremap <leader>ev :vsplit $MYVIMRC<cr>
" wrap in single quotes
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" jk to leave insert mode
inoremap jk <esc>

"operator pending mappings
"in parantheses
onoremap p i(
"next parantheses
onoremap in( :<c-u>normal! f(vi(<cr>

" Vimscript file settings ----------------------- {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
set foldlevelstart=0
" }}}

" Specname function {{{
" returns the corresponding spec name for a file
function! Specname()
  let filename = @%
  if filename =~? '_spec.rb'
    return filename
  else
    let filename = substitute(filename, ".rb", "_spec.rb", "")
    if filename =~? 'app/'
      return substitute(filename, "app/", "spec/", "")
    elseif filename =~? 'lib/'
      return substitute(filename, "lib/", "spec/lib/", "")
    else
      return filename
    endif
  endif
endfunction
" }}}

" run current file with rspec
" noremap <leader>t :execute "!clear && rspec " . Specname()<CR>
" noremap <leader>T :execute "!clear && bundle exec rspec " . Specname()<CR>
" run spec in current line
" noremap <leader>r :execute "!clear && rspec " . Specname(). ":" . line('.')<CR>
" noremap <leader>R :execute "!clear && bundle exec rspec " . Specname(). ":" . line('.')<CR>

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

noremap <leader>os :execute "vsplit " . Specname()<CR>

set background=light
noremap <Leader>p :!pdflatex expose_ma && bibtex expose_ma && pdflatex expose_ma && pdflatex expose_ma && open expose_ma.pdf<CR>


map <F8> :set spell spelllang_en_us<CR>
map <F9> :set nospell<CR>
