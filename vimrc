" Quick reference
" <C-j/k/h/l>       - change window
" <C-c>             - close window
" <Tab>             - toggle NERDTree
" <S-Tab>           - focus NERDTree on current file
" Zz                - exit Vim if no buffers have changes
" :cw               - open quickfix window
" ,j / ,k           - next/previous location in quickfix list
" <J / <K           - next/previous location in location list
" :Rg <pattern>     - search with rg (fzf)
" :Rgi <pattern>    - search with rg, case insensitive (fzf)
" \g                - search for word under cursor using rg (fzf)
" <C-P>             - CtrlP
" <C-B>             - CtrlPBuffer
" <C-@>             - delete buffer (in CtrlPBuffer)
" <C-G>             - git files (fzf)
" \gs               - git status
" \gd               - git diff
" \hp               - GitGutterPreviewHunk
" \hu               - GitGutterUndoHunk
" \hs               - GitGutterStageHunk
" [c / ]c           - previous/next hunk
" :FixWhitespace    - remove trailing whitespaces
" :Man [n] <name>   - open manpage
" \K                - open manpage for word under cursor
" ,T                - run ctags on C++ headers
" t                 - taglist toggle
" <C-]>             - follow tag
" g <C-]>           - follow tag (multiple matches)
" :tn / :tp         - next/previous tag match
" \m                - write all and make
" \x                - write all and make in terminal window
" \of               - switch source/hearder
" <BS>              - turn off highlighted search matches
"
" Insert mode
" <C-x><C-k>        - complete word (fzf)
" <C-x><C-l>        - complete line (fzf)
"
" Within fzf results
" <C-N/P>           - next/previous result
" <Tab> / <S-Tab>   - switch selection, move to next/previous
" <Alt-A/D>         - select/deselect all
" <Enter>           - open selected files / add results to quickfix list
"
" Links
" - Many things can be done with fzf: https://github.com/junegunn/fzf.vim
" - Replace a word with yanked text: https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text

" Vundle - Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'
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
Plugin 'jez/vim-superman'
Plugin 'rust-lang/rust.vim'
Plugin 'tell-k/vim-autopep8'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

call ctrlp_bdelete#init()
runtime! ftplugin/man.vim

" Put your non-Plugin stuff after this line

set hidden
set ic
set wildignore+=*.o,*.pyc,*.pyo
set updatetime=100
set title
"set laststatus=2
set cursorline

noremap <C-c> <C-w>c
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
" TODO conflicts with e.g. control+G popup window - but C-p/n can be used!
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-h> <C-w>h
tnoremap <C-l> <C-w>l
nmap ,j :cn<CR>
nmap ,k :cp<CR>
nmap ,e :copen<CR>/error:<CR><CR>
nmap <J :lne<CR>
nmap <K :lp<CR>
nmap Zz :qa<CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gd :Gdiff<CR>
map <Tab> :NERDTreeToggle<CR>
map <S-Tab> :NERDTreeFind<CR>
let NERDTreeRespectWildIgnore = 1
let NERDTreeIgnore = ['__pycache__']
map <C-B> :CtrlPBuffer<CR>
map t :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
"let g:localvimrc_file_directory_only = 1
let g:localvimrc_persistent = 1
nmap <Leader>m :wa<CR>:make<CR>
nmap <Leader>x :wa<CR>:term make<CR>
nmap <silent> <Leader>of :FSHere<cr>
let c_no_curly_error=1
nmap ,T :!find . -name '*.h' \| xargs ctags --sort=yes --c++-kinds=+p --fields=+iaS --extras=+q<CR>

" search behavior
set hlsearch
set incsearch
nnoremap <silent> <BS> :nohls<Bar>:echo<CR>

" highlight word without moving
nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" fzf
map <C-G> :GFiles<CR>
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-l> <plug>(fzf-complete-line)

" additional rg arguments, e.g. "-g '*.cpp' -g '*.h' -g '*.hpp'"
let g:rg_args=''

" search with rg
command! -bang -nargs=1 Rg
    \ call fzf#vim#grep('rg -n --column '.g:rg_args.' '.shellescape(<f-args>), 0, <bang>0)
command! -bang -nargs=1 Rgi
    \ call fzf#vim#grep('rg -n --column -i '.g:rg_args.' '.shellescape(<f-args>), 0, <bang>0)

" search for word under cursor using rg
nmap <leader>g :call fzf#vim#grep('rg -n --column '.g:rg_args.' '.shellescape(expand('<cword>')), 1)<CR>

" color scheme
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}
silent! colorscheme jellybeans
hi Search cterm=NONE ctermfg=NONE ctermbg=DarkBlue
hi CursorLine cterm=NONE ctermbg=Black ctermfg=NONE
hi GitGutterDelete ctermfg=1

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
