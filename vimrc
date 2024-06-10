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

" Use leader key followed by ll to move to the left window
nnoremap <leader>ll <C-w>l
nnoremap <leader>hh <C-w>h
nnoremap <leader>kk <C-w>k
nnoremap <leader>jj <C-w>j






" Automating cpp workflow :
function! CreateCppClass(classname, ...)
    let args = a:000
    let create_hpp = 0
    let create_cpp = 0
    let create_tpp = 0
    let create_makefile = 0

    " Parse the flags
    for arg in args
        if arg == '--hpp'
            let create_hpp = 1
        elseif arg == '--cpp'
            let create_cpp = 1
        elseif arg == '--tpp'
            let create_tpp = 1
        elseif arg == '--makefile'
            let create_makefile = 1
        endif
    endfor

    " Generate header file (hpp) if flag is set
    if create_hpp
        let hpp_filename = a:classname . '.hpp'
        execute 'edit ' . hpp_filename
        call setline(1, [
        \ '#ifndef ' . toupper(a:classname) . '_HPP',
        \ '#define ' . toupper(a:classname) . '_HPP',
        \ '',
        \ 'class ' . a:classname . ' {',
        \ 'public:',
        \ '    ' . a:classname . '();',
        \ '    ~' . a:classname . '();',
        \ '',
        \ 'private:',
        \ '',
        \ '};',
        \ '',
        \ '#endif // ' . toupper(a:classname) . '_HPP'
        \ ])
        write
    endif

    " Generate source file (cpp) if flag is set
    if create_cpp
        let cpp_filename = a:classname . '.cpp'
        execute 'edit ' . cpp_filename
        call setline(1, [
        \ '#include "' . a:classname . '.hpp"',
        \ '',
        \ a:classname . '::' . a:classname . '() {',
        \ '',
        \ '}',
        \ '',
        \ a:classname . '::~' . a:classname . '() {',
        \ '',
        \ '}'
        \ ])
        write
    endif

    " Generate template implementation file (tpp) if flag is set
    if create_tpp
        let tpp_filename = a:classname . '.tpp'
        execute 'edit ' . tpp_filename
        call setline(1, [
        \ '#ifndef ' . toupper(a:classname) . '_TPP',
        \ '#define ' . toupper(a:classname) . '_TPP',
        \ '',
        \ '#include "' . a:classname . '.hpp"',
        \ '',
        \ '#endif // ' . toupper(a:classname) . '_TPP'
        \ ])
        write
    endif

    " Generate Makefile if flag is set
    if create_makefile
        execute 'edit Makefile'
        call setline(1, [
        \ 'CXX = g++',
        \ 'CXXFLAGS = -Wall -Wextra -Werror',
        \ '',
        \ 'TARGET = ' . a:classname,
        \ 'SRCS = ' . a:classname . '.cpp',
        \ 'OBJS = $(SRCS:.cpp=.o)',
        \ '',
        \ 'all: $(TARGET)',
        \ '',
        \ '$(TARGET): $(OBJS)',
        \ '    $(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS)',
        \ '',
        \ 'clean:',
        \ '    rm -f $(OBJS)',
        \ '',
        \ 'fclean: clean',
        \ '    rm -f $(TARGET)',
        \ '',
        \ 're: fclean all',
        \ '',
        \ '.PHONY: all clean fclean re'
        \ ])
        write
    endif
endfunction

" Map :CreateClass ClassName [--hpp] [--cpp] [--tpp] [--makefile] to the function
command! -nargs=+ CreateClass call CreateCppClass(<f-args>)
