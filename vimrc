set scrolloff=20
set number
set relativenumber
set noexpandtab
set cursorline
inoremap jk <Esc>
vnoremap jk <Esc>

call plug#begin('~/.vim/plugings')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'Luxed/ayu-vim' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'doums/darcula'
call plug#end()

syntax enable
set background=dark
colorscheme darcula

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'dark'
"set guifont=FiraCode\ Nerd\ Font:h12 " Set a font similar to JetBrains Mono
set guifont=JetBrains\ Mono:h12
set number                " Show line numbers
set relativenumber        " Show relative line numbers
set cursorline            " Highlight the current line
set termguicolors   






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

nnoremap <leader>ll <C-w>l
nnoremap <leader>hh <C-w>h
nnoremap <leader>kk <C-w>k
nnoremap <leader>jj <C-w>j
nnoremap <silent> <leader>cf :%!clang-format<CR>





" Automating cpp workflow :
" Automating cpp workflow :
" Function to create a new C++ class with flags
function! CreateCppClass(classname, ...)
    let args = a:000
    let create_hpp = 0
    let create_cpp = 0
    let create_class_cpp = 0
    let create_tpp = 0
    let create_makefile = 0
    let create_mainfile = 0

    " Parse the flags
    for arg in args
        if arg == '--hpp'
            let create_hpp = 1
        elseif arg == '--cpp'
            let create_cpp = 1
        elseif arg == '--class-cpp'
            let create_class_cpp = 1
        elseif arg == '--tpp'
            let create_tpp = 1
        elseif arg == '--makefile'
            let create_makefile = 1
        elseif arg == '--mainfile'
            let create_mainfile = 1
        endif
    endfor

    " Generate main.cpp file :
    if create_mainfile
        let main_filename = 'main.cpp'
        execute 'edit ' . main_filename
        call setline(1, [
        \ '#include <iostream>',
        \ '',
        \ 'int main(int argc, char **argv)',
        \ '{',
        \ '    std::cout << "Hello, World!" << std::endl;',
        \ '    return 0;',
        \ '}'
        \ ])
        write
    endif

    " Generate header file (hpp) if flag is set
    if create_hpp
        let hpp_filename = a:classname . '.hpp'
        execute 'edit ' . hpp_filename
        call setline(1, [
        \ '#ifndef ' . toupper(a:classname) . '_HPP',
        \ '#define ' . toupper(a:classname) . '_HPP',
        \ '',
        \ 'class ' . a:classname,
        \ '{',
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
        \ a:classname . '::' . a:classname . '()',
        \ '{',
        \ '',
        \ '}',
        \ '',
        \ a:classname . '::~' . a:classname . '()',
        \ '{',
        \ '',
        \ '}'
        \ ])
        write
    endif

    " Generate class source file (.class.cpp) if flag is set
    if create_class_cpp
        let class_cpp_filename = a:classname . '.class.cpp'
        execute 'edit ' . class_cpp_filename
        call setline(1, [
        \ '#include "' . a:classname . '.hpp"',
        \ '',
        \ a:classname . '::' . a:classname . '()',
        \ '{',
        \ '',
        \ '}',
        \ '',
        \ a:classname . '::~' . a:classname . '()',
        \ '{',
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
        \ 'CXX = c++',
        \ 'CXXFLAGS = -Wall -Wextra -Werror -std=c++98',
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

" Map :CreateClass ClassName [--hpp] [--cpp] [--class-cpp] [--tpp] [--makefile] [--mainfile] to the function
command! -nargs=+ CreateClass call CreateCppClass(<f-args>)
