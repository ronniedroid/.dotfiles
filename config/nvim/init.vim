
"-----------------------Plugins-----------------------------

call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-cssomni'
Plug 'junegunn/fzf'
Plug 'chrisbra/Colorizer'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
call plug#end()

"----------------------colorscheme-----------------------
"nvim colorscheme
colorscheme nord
"lightline colorscheme
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

"FZF colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
"---------------------settings---------------------------

set nocompatible
set clipboard+=unnamedplus      " use the same clipbord as system
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set mouse=a                     " enable some mouse features
syntax on
set ignorecase
set smartcase
set encoding=utf-8
set number relativenumber
set termguicolors
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=2
set cursorline
" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" completion
set shortmess+=c
inoremap <c-c> <ESC>
" pyclang
let g:ncm2_pyclang#library_path = '/usr/lib64/libclang.so.5.0'
"------------------keybindings--------------------------------

let mapleader = " "

" Split Window
nnoremap <leader>h :split<Space><CR>
nnoremap <leader>v :vsplit<Space><CR>
" Split navigation
map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l
map <leader>d <C-w>c
" Buffer nav
noremap <leader>[ :bp<CR>
noremap <leader>] :bn<CR>
" Close buffer
noremap <leader>k :bd<CR>
map <leader>p :!clear && shellcheck %<CR>

" Enable spell checking, s for spell check
map <leader>s :setlocal spell! spelllang=en_us<CR>
" difining FZF for my usually visited files
noremap <leader>, :FZF ~<CR>
noremap <leader>f :FZF<CR>

"------------------Startify-bookmarkes----------------
    let g:startify_bookmarks = [{'vc': '~/.config/nvim/init.vim'}, {'c': '~/.config/'}, {'lc': '~/Documents/learnc/'}]

