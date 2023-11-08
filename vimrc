" references {{{
" http://dougblack.io/words/a-good-vimrc.html
" }}}

set modelines=1

" automatic reloading of .vimrc
" autocmd! bufwritepost .vimrc source %

" vundle{{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'
Plugin 'vim-airline/vim-airline'
Plugin 'davidhalter/jedi-vim'
Plugin 'msanders/snipmate.vim.git'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive.git'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-unimpaired'
Plugin 'bling/vim-bufferline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()

filetype plugin indent on     " required
" }}}

" basic settings {{{
syntax on
filetype on
set number
set numberwidth=2
set backspace=2
set incsearch           " search as characters are entered
set hlsearch
set showmatch         " highlight matching [{()}]
set wildmenu
set wildmode=full
set cursorline        " highlight current line
" set lazyredraw        " redraw only when we need to
" }}}

" indentation {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
" }}}

" auto-completion ignores {{{
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**
" }}}

" folding {{{
set foldenable          " enable folding
set foldmethod=indent
set foldlevel=99
" }}}

" leader shortcuts {{{
" rebind <Leader> key
let mapleader = ","
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR> " remove whitespace
vnoremap <leader>s :sort<CR>
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" }}}

" show whitespace {{{
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
" }}}

" colors {{{
set background=dark
colorscheme xoria256
set colorcolumn=80
highlight ColorColumn ctermbg=233
" }}}

" airline {{{
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='bubblegum'
let g:airline_enable_branch = 1
" }}}

" syntastic {{{
let g:syntastic_python_checkers=['flake8']
"let g:syntastic_enable_highlighting=0
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }
noremap <F6> :SyntasticCheck<CR> :SyntasticToggleMode<CR>
" }}}

" jedi-vim {{{
let g:jedi#usages_command = "<leader>z"
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 1
"}}}

" omnicomplete {{{
" navigate through omnicomplete with j and k
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>
" }}}

" settings by file type {{{
" file type specific changes
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2,*.tpl setlocal ft=html
autocmd FileType html,xhtml,xml,css,htmldjango,sql,javascript,lua setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" python specific
" au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" }}}

" opens .vimrc with sections folded up by marker
" leave it commented out. it's how it's supposed to be
" vim:foldmethod=marker:foldlevel=0
"
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
