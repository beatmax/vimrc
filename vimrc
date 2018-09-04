" Quick reference
" :cw               - Open quickfix window
" <C-P>             - CtrlP
" <C-B>             - CtrlPBuffer
" <C-@>             - Delete buffer (in CtrlPBuffer)
" <C-G>             - Git files (fzf)
" :Gstatus          - Git status
" :Gdiff            - Git diff
" \hp               - GitGutterPreviewHunk
" \hu               - GitGutterUndoHunk
" \hs               - GitGutterStageHunk
" [c / ]c           - previous/next hunk
" :FixWhitespace    - remove trailing whitespaces
" t                 - taglist toggle
" <C-]>             - follow tag
" g <C-]>           - follow tag (multiple matches)
" :tn / :tp         - next/previous tag match
" \of               - switch source/hearder
"
" Insert mode
" <c-x><c-k>        - complete word (fzf)
" <c-x><c-l>        - complete line (fzf)
"
" Many things can be done with fzf, see: https://github.com/junegunn/fzf.vim

" Vundle - Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'd11wtq/ctrlp_bdelete.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'taglist.vim'
Plugin 'craigemery/vim-autotag'
Plugin 'brookhong/cscope.vim'
Plugin 'danro/rename.vim'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'embear/vim-localvimrc'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'gioele/vim-autoswap'
Plugin 'scrooloose/syntastic'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

call ctrlp_bdelete#init()

" Put your non-Plugin stuff after this line

map <Tab> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
map <C-B> :CtrlPBuffer<CR>
map t :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
"let g:localvimrc_file_directory_only = 1
let g:localvimrc_persistent = 1
nmap <silent> <Leader>of :FSHere<cr>
let c_no_curly_error=1

" fzf
map <C-G> :GFiles<CR>
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-l> <plug>(fzf-complete-line)

let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
colorscheme jellybeans

set hidden
set ic
set wildignore+=*.pyc
set updatetime=100

" -- Cscope --
let g:cscope_silent=1
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

" -- Syntastic --
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["cpp"] }

" --
