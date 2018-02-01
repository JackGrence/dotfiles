set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
"Plugin 'file:///home/jackgrence/.vim/plugin/eclim.vim'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'https://github.com/kien/ctrlp.vim.git'
Plugin 'https://github.com/Valloric/YouCompleteMe.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'

"Plugin 'tomasr/molokai'
" Plugin 'Yggdroot/indentLine'
" Plugin 'nathanaelkane/vim-indent-guides'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set relativenumber
set nu
set tabstop=4
set expandtab
set ai
set cursorline
set shiftwidth=4
set background=dark
set hlsearch
set encoding=utf-8

syntax enable
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256
set mouse=n

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }
let g:ctrlp_user_command = 'find %s -type f'
" let g:indentLine_setColors = 0
" let g:indentLine_color_tty_light = 7 " (default: 4)
" let g:indentLine_color_dark = 1 " (default: 2)
"Plugin 'tomasr/molokai'
" let g:indentLine_color_term = 1
"let g:indentLine_char = '.'
"let g:indentLine_concealcursor = 'inc'
"let g:indentLine_conceallevel = 2
" let g:indentLine_enabled = 0
" let g:indentLine_setConceal = 0
" set list lcs=tab:\|\
func! RubyIndent()
    set shiftwidth=2
    set softtabstop=2
endf

func! NormalIndent()
    set shiftwidth=4
    set softtabstop=4
endf

function! Pair( part )
    let l:next_char = strpart( getline( '.' ), col('.'), 1 )
    if l:next_char == a:part
        execute 'normal! l'
    else
        execute 'normal! a' . a:part
    endif
endfunction

func! CodeStyle()
    exec "w"
    let l:exp = expand("%:e")
    if l:exp == 'py'
        exec "!pep8 %"
    elseif l:exp == 'rb'
        exec "!rubocop %"
    endif
endf

" expand( "%:e" )
func! Compile(...)
    exec "w"

    let l:args = ''
    if a:0 >= 1
        call inputsave()
        echo "\n"
        let l:args = ' ' . input('input your args:')
        call inputrestore()
    endif

    let l:exp = expand( "%:e" )
    if l:exp == 'c'
        exec CompileC() . l:args
    elseif l:exp == 'py'
        exec CompilePython() . l:args
    elseif l:exp == 'java'
        exec CompileJava() . l:args
    elseif l:exp == 'rb'
        exec CompileRuby() . l:args
    elseif l:exp == 'R'
        exec CompileR() . l:args
    elseif l:exp == 'asm'
        exec CompileAsm() . l:args
        exec "!count=0;for i in $(objdump -d %< | grep '^ ' | cut -f2); do echo -n \\\\x$i; count=$(($count+1)); done; echo; echo length:$count"
    endif
endf

func! CompileAsm()
    call inputsave()
    echo "\n(1)elf64 (2)elf32"
    let l:select = input('input:')
    call inputrestore()

    if l:select == '1'
        return "!nasm -f elf64 % && ld -s -o %< %<.o && ./%<"
    elseif l:select == '2'
        return "!nasm -f elf32 % && ld -m elf_i386 -s -o %< %<.o && ./%<"
    endif

    return 'protect'
endf

func! CompileR()
    return "!Rscript %"
endf

func! CompileRuby()
    return "!ruby %"
endf

func! CompileJava()
    return "!sed -e 's/$/\r/' % > ms_% && javac -d . % && java %<"
endf

func! CompilePython()
    call inputsave()
    echo "\n(1)py2 (2)py3"
    let l:select = input('input:')
    call inputrestore()

    if l:select == '1'
        return "!python %"
    elseif l:select == '2'
        return "!python3 %"
    endif
    return 'protect'
endf


func! CompileC()
    return "!gcc % -o %<.out && ./%<.out"
endf
" other------
func! ToWindows()
    exec "!sed -e 's/$/\r/' % > ms_%"
endf
" test--------
func! MakeProject()
    exec "!make"
    exec "!./%<"
endf



" ------------

set pastetoggle=<F2>
inoremap } <Esc>:call Pair("}")<cr>a
inoremap ( ()<Esc>i
inoremap ) <Esc>:call Pair(")")<cr>a
inoremap {<CR> {<CR>}<Esc>ko
inoremap [ []<Esc>i
inoremap ] <Esc>:call Pair("]")<cr>a

nnoremap <F5> :call Compile()<cr>
nnoremap <F6> :call Compile('with_arg')<cr>
nnoremap <F7> :call CodeStyle()<cr>
nnoremap <c-j> :m+<cr>
nnoremap <c-k> :m-2<cr>
nnoremap <c-h> :tabp<cr>
nnoremap <c-l> :tabn<cr>

vnoremap ( s()<esc>hp
vnoremap [ s[]<esc>hp
vnoremap { s{}<esc>hp
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2
let g:airline_theme='dark'

" tagbar
" let g:tagbar_left = 1
let g:tagbar_width = 30
nmap <F8> :TagbarToggle<CR>
autocmd VimEnter * nested :TagbarOpen
"autocmd FileType * nested :call tagbar#autoopen(0)
"autocmd BufEnter * nested :call tagbar#autoopen(0)

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
colorscheme molokai
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:EclimCompletionMethod = 'omnifunc'

" Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
