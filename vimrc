set scrolloff=20
set number
set relativenumber
set noexpandtab
inoremap jk <Esc>
vnoremap jk <Esc>

call plug#begin('~/.vim/plugings')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'Luxed/ayu-vim' 
call plug#end()

set termguicolors   
set background=light
set background=dark 

let g:ayucolor="mirage" " for mirage version of theme
let g:ayucolor="dark"   " for dark version of theme
" NOTE: g:ayucolor will default to 'dark' when not set.

colorscheme ayu

"colorscheme space-vim-dark
"   Range:   233 (darkest) ~ 238 (lightest)
"   Default: 235
"let g:space_vim_dark_background = 233
"color space-vim-dark
" Vim Script
"let g:airline_theme='violet'

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.vimrc<CR>
nnoremap <leader>fz :FZF<CR>
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

