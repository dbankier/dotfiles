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
Bundle 'marijnh/tern_for_vim'
Bundle 'Valloric/YouCompleteMe'
" getting around
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'kien/ctrlp.vim'
Bundle 'ZoomWin'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'vim-scripts/camelcasemotion'
Bundle 'tpope/vim-unimpaired'
Bundle 'terryma/vim-multiple-cursors'
" docs
Bundle 'tpope/vim-fugitive'
Bundle 'mattn/gist-vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'suan/vim-instant-markdown'
"Syntax
Bundle 'bling/vim-airline'
Bundle 'scrooloose/syntastic'
Bundle 'elzr/vim-json'
Bundle 'digitaltoad/vim-jade'
Bundle 'pangloss/vim-javascript'
Bundle 'derekwyatt/vim-scala'
Bundle 'leafgarland/typescript-vim'
Bundle 'tpope/vim-markdown'
Bundle 'mustache/vim-mode'
" Quick text"
Bundle 'tpope/vim-surround'
Bundle 'mattn/emmet-vim'
Bundle 'dbankier/SnappiTi.vim'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'zerowidth/vim-copy-as-rtf'
Bundle 'vim-scripts/closetag.vim'

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
colorscheme wombat256
set number
set ruler
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
set wildignore+=*/build/**

"reload files changed outside
set autoread

" airline - init

function! AirlineInit()
  let g:airline_powerline_fonts = 1
  set laststatus=2
  let g:airline#extensions#hunks#enabled = 0
  let g:airline_section_x = airline#section#create([''])  
  let g:airline_section_y = airline#section#create(['%l:%c'])  
  let g:airline_section_z = airline#section#create(['%P'])  
  let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '^V' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '^S' : 'S',
      \ }
endfunction
autocmd VimEnter * call AirlineInit()

""
"" MAPPINGS
""
" format the entire file$
nnoremap <leader>fef :normal! gg=G``<CR>$

" Map the arrow keys to be based on display lines, not physical lines$
map <Down> gj$
map <Up> gk

" TiShadow Key Bindings
:map <F6> <Esc>:w<CR>:!tishadow run --update<CR>a
:imap <F6> <Esc>:w<CR>:!tishadow run --update<CR>a
:map <S-F6> <Esc>:w<CR>:!tishadow run<CR>a
:imap <S-F6> <Esc>:w<CR>:!tishadow run<CR>a

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

" vim clashes with iTerm2 on Command-T
nnoremap <leader>l :call OpenAlloy()<cr>
inoremap <leader>l <esc>:call OpenAlloy()<cr>
nnoremap <leader>k :call OpenAlloyLTSS()<cr>
inoremap <leader>k <esc>:call OpenAlloyLTSS()<cr>
nnoremap <C-f> :CtrlP<cr>
inoremap <C-f> <esc>:CtrlP<cr>

" stop .tern-port commands
let g:tern#arguments = ["--no-port-file"]


""
"" AUTO COMMANDS
""

" Alloy - window splits for view, style and controller
function! OpenAlloy()
  let s:view=substitute(expand('%:r'),"controllers","views","").".jade" 
  let s:style=substitute(expand('%:r'),"controllers","styles","").".tss" 
  exec '60vsp' s:style 
  set filetype=javascript
  exec 'sp' s:view
  set filetype=jade
endfunction
function!  OpenAlloyLTSS()
  let s:view=substitute(expand('%:r'),"controllers","views","").".jade" 
  let s:style=substitute(expand('%:r'),"controllers","styles","").".ltss" 
  exec '60vsp' s:style 
  set filetype=javascript
  exec 'sp' s:view
  set filetype=jade
endfunction
if has('autocmd')
  " Change scheme and spell check based on file type
  au BufEnter * colorscheme wombat256 | set nospell
  au BufEnter *.markdown colorscheme peaksea | set spell
  au BufEnter *.md colorscheme peaksea | set spell
  "Alloy stuff
  au BufRead *.tss set filetype=javascript
  au BufRead *.ltss set filetype=javascript
  au BufRead *.jmk set filetype=javascript
  au BufRead *.ejs set filetype=html
  "au BufRead */controllers/*.js call OpenAlloy()
  au BufRead,BufNewFile *.json set filetype=json 
  "Autoformatting off
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
endif

" closetag fix (for xml)
let b:unaryTagsStack=""

" Making UltiSnips and YouCompleteMe play nicely
function! g:UltiSnips_Complete()
  call UltiSnips_ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips_JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsSnippetsDir = '~/.vim/snippets/'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'snippets']

" change status line based on mode
au InsertEnter * hi StatusLine ctermbg=52
au InsertLeave * hi StatusLine ctermbg=8


