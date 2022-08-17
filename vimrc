"              __                                   
"             /  |                                  
"   __     __ $$/  _____  ____    ______    _______ 
"  /  \   /  |/  |/     \/    \  /      \  /       |
"  $$  \ /$$/ $$ |$$$$$$ $$$$  |/$$$$$$  |/$$$$$$$/ 
"   $$  /$$/  $$ |$$ | $$ | $$ |$$ |  $$/ $$ |      
"  __$$ $$/   $$ |$$ | $$ | $$ |$$ |      $$ \_____ 
" /  |$$$/    $$ |$$ | $$ | $$ |$$ |      $$       |
" $$/  $/     $$/ $$/  $$/  $$/ $$/        $$$$$$$/ 
"                                                 
" -----------   vim run commands file -------------
"
"

" set encoding
set encoding=utf-8

" plugins
call plug#begin()
    " theme
    Plug 'arcticicestudio/nord-vim'

    " customize editor
    Plug 'preservim/nerdcommenter'
    Plug 'TaDaa/vimade'
    Plug 'Yggdroot/indentLine'
    Plug 'jiangmiao/auto-pairs'
    Plug 'vim-airline/vim-airline'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'zivyangll/git-blame.vim'
    Plug 'mattn/emmet-vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " lsp
    Plug 'dense-analysis/ale'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'marlonfan/coc-phpls'
 
call plug#end()

" lsp
let g:ale_linters = { 'php': ['php', 'psalm'] }

filetype plugin on

" enable clipboard share
set clipboard=unnamedplus

" theme
silent! colorscheme nord "https://www.nordtheme.com/docs/ports/vim

" editor config
syntax enable

" enable automatic indentation
set autoindent

" enable indentation based by language
set smartindent

" Set VIM to use 256 colors
set t_Co=256

" show existing tab with 4 spaces width
set tabstop=4

" when indenting with '>', use 4 spaces width
set shiftwidth=4

" On pressing tab, insert 4 spaces
set expandtab

" open vertical splits on right
set splitright

" open slip horizontal on below
set splitbelow

" enable horizontal scroll for big lines
set nowrap

" guide line to max 80 characters per line
set colorcolumn=80

"set configs to vimade
let g:vimade = {}
let g:vimade.fadelevel = 0.3
let g:vimade.enablesigns = 1
let g:vimade.basebg='#0a0a0a'


"# mappings
" copy to clipboard
vnoremap <silent><Leader>y "yy <Bar> :call system('xclip -sel clip', @y)<CR>

" navigate between buffers
nnoremap <M-Right> :bn<cr>
nnoremap <M-Left>  :bp<cr>
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

" toggle comments
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

"reindent
map <F9> gg=G

"fzf shortcut
nnoremap <silent> <C-p> :GFiles<CR>

"vimrc edit shortcut
nmap <Leader>vc :e $MYVIMRC<CR> 

"# auto commands
" auto 'reload' configs when save .vimrc
autocmd BufWritePost .vimrc source %


" fix typos
command WQ wq
command Wq wq
command W w
command Q q
command QW wq

