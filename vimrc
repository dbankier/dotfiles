""
"" VUNDLE START
""
if has('python3')
  silent! python3 1
endif

set nocompatible               " be iMproved
filetype off                   " required!

call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" getting around
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'rking/ag.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/camelcasemotion'
Plug 'tpope/vim-unimpaired'
Plug 'RRethy/vim-illuminate'
" docs
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'airblade/vim-gitgutter'
Plug 'suan/vim-instant-markdown'
"Syntax
Plug 'prettier/vim-prettier'
Plug 'w0rp/ale'
Plug 'elzr/vim-json'
Plug 'digitaltoad/vim-jade'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'tpope/vim-markdown'
Plug 'wavded/vim-stylus'
Plug 'mustache/vim-mode'
Plug 'cakebaker/scss-syntax.vim'
Plug 'posva/vim-vue'
" Quick text"
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'alvan/closetag.vim'
Plug 'vim-scripts/gitignore'
Plug 'zerowidth/vim-copy-as-rtf'
call plug#end()


filetype plugin indent on

""
"" SETTINGS
""

" clipboard
set clipboard=unnamed

" backup and swap dirs
set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files.

" Default theme
syntax enable
colorscheme Tomorrow-Night-Eighties
set number
set ruler
scriptencoding utf-8
set encoding=utf-8

" whitespace
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Spell Checking on
set spell

" Changes the default ui font
set guifont=Menlo\ Regular:h13
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/build/**,*/node_modules/**,*/vendor/**

"reload files changed outside
set autoread

"simple status line (back)
if has('statusline')
  set laststatus=2

  set statusline=
  set statusline +=\ %<%F%*            "full path
  set statusline +=%m%*                "modified flag
  set statusline +=%=%5l%*             "current line
  set statusline +=/%L%*               "total lines
endif
""
"" MAPPINGS
""
" format the entire file$
nnoremap <leader>fef :normal! gggqG<CR><C-o><C-o>

" Map the arrow keys to be based on display lines, not physical lines$
map <Down> gj$
map <Up> gk

" Slows down instant markdown
let g:instant_markdown_slow = 1

" reselect visual block after indent/outdent via: tilvim.com
vnoremap < <gv
vnoremap > >gv

" CamelCase movement: via tilvim.com
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

"nerdtree
noremap <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
let g:NERDTreeHijackNetrw = 0 " Stop NERDTree from hijacking netrw
let g:loaded_netrw        = 1 " Disable netrw
let g:loaded_netrwPlugin  = 1 " Disable netrw
au VimEnter * if &filetype ==# '' | :NERDTreeToggle | endif
au VimEnter * :wincmd p

"back to fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
nnoremap <c-p> :FZF<cr>


" vim clashes with iTerm2 on Command-T
nnoremap <leader>lx :call OpenAlloyXML()<cr>
inoremap <leader>lx <esc>:call OpenAlloyXML()<cr>
nnoremap <leader>ls :call OpenAlloySTSS()<cr>
inoremap <leader>ls <esc>:call OpenAlloySTSS()<cr>
vnoremap <leader>lp :w ! ts repl --pipe<cr>


""
"" AUTO COMMANDS
""

" Alloy - window splits for view, style and controller
function! OpenAlloyXML()
  only
  let s:view=substitute(expand('%:r'),"controllers","views","").".xml"
  let s:style=substitute(expand('%:r'),"controllers","styles","").".tss"
  exec '60vsp' s:style
  set filetype=javascript
  exec 'sp' s:view
  set filetype=xml
endfunction

function!  OpenAlloySTSS()
  only
  let s:view=substitute(expand('%:r'),"controllers","views","").".jade"
  let s:style=substitute(expand('%:r'),"controllers","styles","").".stss"
  exec '60vsp' s:style
  set filetype=scss
  exec 'sp' s:view
  set filetype=jade
endfunction

if has('autocmd')
  " Change scheme and spell check based on file type
  au BufEnter * colorscheme Tomorrow-Night-Eighties | set nospell
  au BufEnter *.markdown colorscheme Tomorrow | set spell
  au BufEnter *.md colorscheme Tomorrow | set spell
  "Alloy stuff
  au BufRead *.tss set filetype=javascript
  au BufRead *.stss set filetype=scss
  au BufRead *.ejs set filetype=html
  "au BufRead */controllers/*.js call OpenAlloy()
  au BufRead,BufNewFile *.json set filetype=json
  "Autoformatting off
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  "Auto-remove trailing spaces on save
  autocmd FileType javascript autocmd BufWritePre <buffer> :%s/\s\+$//e
endif

" closetag fix (for xml)
let b:unaryTagsStack=""

" change status line based on mode
au InsertEnter * hi StatusLine ctermbg=52
au InsertLeave * hi StatusLine ctermbg=8

" Ale
let g:ale_completion_enabled = 1
" Prettier
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#single_quote = 'true'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue Prettier
