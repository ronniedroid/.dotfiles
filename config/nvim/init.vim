
"-----------------------Plugins-----------------------------

call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'chrisbra/Colorizer'
Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdtree'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'joshdick/onedark.vim'
call plug#end()

"----------------------colorscheme-----------------------
"nvim colorscheme
colorscheme onedark
"lightline colorscheme
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

"24bit support
if (empty($TMUX))
  if (has("nvim"))
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
    if (has("termguicolors"))
    set termguicolors
  endif
endif

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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
command! -nargs=0 Prettier :CocCommand prettier.formatFile
"------------------coc-configuration-----------------------
let g:coc_node_path="/bin/node"

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

" Enable spell checking, s for spell check
map <leader>s :setlocal spell! spelllang=en_us<CR>
" difining FZF for my usually visited files
noremap <leader>, :FZF ~<CR>
noremap <leader>f :FZF<CR>
noremap <leader>n :NERDTreeToggle<CR>


let g:UltiSnipsExpandTrigger="<tab>"  " use <Tab> trigger autocompletion
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


"-----------------Macros-------------------

let @r = "I<li>A</li>j"
let @t = "I'A',j"
let @y = "A,j"
