""
"" VUNDLE START
""

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
" getting around
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'ZoomWin'
Bundle 'rking/ag.vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'vim-scripts/camelcasemotion'
Bundle 'tpope/vim-unimpaired'
" docs
Bundle 'Shougo/vimproc.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'mattn/gist-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'suan/vim-instant-markdown'
"Syntax
Bundle 'scrooloose/syntastic'
Bundle 'elzr/vim-json'
Bundle 'digitaltoad/vim-jade'
Bundle 'pangloss/vim-javascript'
Bundle 'leafgarland/typescript-vim'
Bundle 'Quramy/tsuquyomi'
Bundle 'tpope/vim-markdown'
Bundle 'wavded/vim-stylus'
Bundle 'mustache/vim-mode'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'posva/vim-vue'
" Quick text"
Bundle 'tpope/vim-surround'
Bundle 'mattn/emmet-vim'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'vim-scripts/closetag.vim'
Bundle 'vim-scripts/gitignore'

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

" Remap escape key
inoremap jk <esc>

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
  set statusline +=%{fugitive#statusline()}
  set statusline +=\ %<%F%*            "full path
  set statusline +=%m%*                "modified flag
  set statusline +=%=%5l%*             "current line
  set statusline +=/%L%*               "total lines
endif
""
"" MAPPINGS
""
" format the entire file$
nnoremap <leader>fef :normal! gg=G``<CR>$

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

"fugitive
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>

"nerdtree
noremap <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
let g:NERDTreeHijackNetrw = 0 " Stop NERDTree from hijacking netrw
let g:loaded_netrw        = 1 " Disable netrw
let g:loaded_netrwPlugin  = 1 " Disable netrw
au VimEnter * if &filetype ==# '' | :NERDTreeToggle | endif
au VimEnter * :wincmd p

"back to ctrlp
let g:ctrlp_working_path_mode = 'rw'

" vim clashes with iTerm2 on Command-T
nnoremap <leader>lx :call OpenAlloyXML()<cr>
inoremap <leader>lx <esc>:call OpenAlloyXML()<cr>
nnoremap <leader>lj :call OpenAlloy()<cr>
inoremap <leader>lj <esc>:call OpenAlloy()<cr>
nnoremap <leader>ls :call OpenAlloySTSS()<cr>
inoremap <leader>ls <esc>:call OpenAlloySTSS()<cr>
vnoremap <leader>lp :w ! ts repl --pipe<cr>

" stop .tern-port commands

""
"" AUTO COMMANDS
""

" Alloy - window splits for view, style and controller
function! OpenAlloy()
  only
  let s:view=substitute(expand('%:r'),"controllers","views","").".jade" 
  let s:style=substitute(expand('%:r'),"controllers","styles","").".tss" 
  exec '60vsp' s:style 
  set filetype=javascript
  exec 'sp' s:view
  set filetype=jade
endfunction
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
  au BufRead *.ltss set filetype=javascript
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

" Making UltiSnips and YouCompleteMe play nicely
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger       . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
let g:UltiSnipsSnippetsDir = '~/.vim/ultisnips/'
let g:UltiSnipsSnippetDirectories = ['ultisnips']

" change status line based on mode
au InsertEnter * hi StatusLine ctermbg=52
au InsertLeave * hi StatusLine ctermbg=8

" typescript . triggers
if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
