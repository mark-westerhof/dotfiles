" vim:fdm=marker

"Plugins{{{
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'Valloric/YouCompleteMe', {'do': './install.py --tern-completer'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'wavded/vim-stylus'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benekastah/neomake'

if &t_Co >= 256 || has('gui_running')
    Plug 'itchyny/lightline.vim'
    Plug 'edkolev/tmuxline.vim'
endif

call plug#end()
"}}}

"General {{{
"Tabs -> 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

"Turn on some features
set nosmartindent
set number
syntax on
set nowrap
set backspace=2

"Turn off some features
set nospell
set nohlsearch

"stfu
set visualbell
set t_vb=

"Stay in the same column while navigating up/down
set virtualedit=all

"Remap leader
let mapleader = ","

"Show tabs and trailing whitespace
set list lcs=trail:·,tab:»·

"Remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

"Exit insert mode
inoremap jk <Esc>

"Window navigation
nnoremap <C-i> :wincmd h <CR>
nnoremap <C-h> :wincmd h <CR>
nnoremap <C-j> :wincmd j <CR>
nnoremap <C-k> :wincmd k <CR>
nnoremap <C-l> :wincmd l <CR>

"Tab navigation
nnoremap <silent> th :tabfirst<CR>
nnoremap <silent> tj :tabnext<CR>
nnoremap <silent> tk :tabprev<CR>
nnoremap <silent> tl :tablast<CR>
nnoremap <silent> tt :tabedit<Space>
nnoremap <silent> tn :tabnew<Space>
nnoremap <silent> tm :tabm<Space>
nnoremap <silent> td :tabclose<CR>

"Buffer navigation
nnoremap fh :bf<CR>
nnoremap fj :bn<CR>
nnoremap fk :bp<CR>
nnoremap fl :bl<CR>
nnoremap fd :bp<bar>sp<bar>bn<bar>bd<CR>

"Window shortcuts
nnoremap <Leader>o :only<CR>
nnoremap <Leader>r :redraw!<CR>

"Copy pasting between vim instances
vnoremap <leader>y :w! /tmp/vim_clipboard<CR>
nnoremap <leader>p :r! cat /tmp/vim_clipboard<CR>

"vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

"Find and replace selected
vnoremap <C-r> "hy:.,$s/<C-r>h//gc<left><left><left>

"fgtdev
nnoremap <Leader>fu :execute '!fgtdev up '.expand('%s')<CR>


"}}}

"Appearance {{{

"Lightline
if &t_Co >= 256 || has('gui_running')
    set background=dark

    if has('gui_running')
        "Gvim
        set guifont=Hack\ 11
        set guioptions-=m  "menu bar
        set guioptions-=T  "toolbar
        set guioptions-=r  "right scrollbar
        set guioptions-=L  "left scrollbar
    endif

    set laststatus=2
    set noshowmode
    set ttimeoutlen=10

    let g:lightline = {
    \   'colorscheme': 'gruvbox',
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \                 [ 'fugitive', 'filename' ] ],
    \       'right': [ ['neomake', 'lineinfo'],
    \                  ['percent'],
    \                  ['fileformat', 'fileencoding', 'filetype'] ]
    \   },
    \   'component_function': {
    \       'fugitive': 'LightLineFugitive',
    \       'filename': 'LightLineFilename',
    \       'fileformat': 'LightLineFileFormat',
    \       'filetype': 'LightLineFileType',
    \       'fileencoding': 'LightLineFileEncoding',
    \       'mode': 'LightLineMode',
    \       'lineinfo': 'LightLineLineInfo'
    \   },
    \   'component_expand': {
    \       'neomake': 'LightLineNeomake'
    \   },
    \   'component_type': {
    \       'neomake': 'error'
    \   },
    \   'separator': { 'left': '', 'right': ''},
    \   'subseparator': { 'left': '', 'right': ''}
    \}

    let s:lightline_wrap1 = 120
    let s:lightline_wrap2 = 80
    let s:lightline_wrap3 = 60

    function! LightLineModified()
        return &modified ? '+' : ''
    endfunction

    function! LightLineReadonly()
        return &readonly ? '' : ''
    endfunction

    function! LightLineFugitive()
        if exists("*fugitive#head") && winwidth(0) > s:lightline_wrap1
            let _ = fugitive#head()
            return strlen(_) ? ' '._ : ''
        endif
        return ''
    endfunction

    function! LightLineFilename()
        let fname = expand('%')
        return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
            \ ('' != fname ? (winwidth(0) > s:lightline_wrap3 ? fname : expand('%:t')) : '[No Name]') .
            \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
    endfunction

    function! LightLineFileFormat()
        return winwidth(0) > s:lightline_wrap2 ? &fileformat : ''
    endfunction

    function! LightLineFileType()
        return winwidth(0) > s:lightline_wrap2 ? (strlen(&filetype) ? &filetype : '') : ''
    endfunction

    function! LightLineFileEncoding()
        return winwidth(0) > s:lightline_wrap2 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! LightLineMode()
        return winwidth(0) > s:lightline_wrap2 ? lightline#mode() : ''
    endfunction

    function! LightLineLineInfo()
        return ' ' . printf('%3d:%-2d', line('.'), col('.'))
    endfunction

    function! LightLineNeomake()
        let total = 0
        for v in values(neomake#statusline#LoclistCounts())
            let total += v
        endfor
        for v in items(neomake#statusline#QflistCounts())
            let total += v
        endfor
        if total == 0
            return ''
        endif
        return total . ' lint issues'
    endfunction

    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
    let g:gruvbox_contrast_dark = 'medium'
    colorscheme gruvbox

    let &colorcolumn="80,100,120"

    "Disable Background Color Erase (BCE) so that color schemes
    "work properly when Vim is used inside tmux and GNU screen.
    if &term =~ '256color'
        set t_ut=
    endif

else
    "-----Basic Terminal Settings------
    colorscheme gruvbox
    highlight LineNr ctermfg=grey
    highlight clear SignColumn
    highlight ErrorMsg ctermbg=red

endif

" }}}

" Ctags & Cscope {{{
set tags=./tags;

if has('cscope')
    set cscopetag cscopeverbose

    function! LoadCscope()
        let db = findfile('cscope.out', '.;')
        if (!empty(db))
            let path = strpart(db, 0, match(db, '/cscope.out$'))
            " Suppress duplicate connection error
            set nocscopeverbose
            exe "cs add " . db . " " . path
            set cscopeverbose
        endif
    endfunction
    au BufEnter /* call LoadCscope()
endif

"Open tag in vsplit
nnoremap <Leader>] :rightb vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"}}}

"Basic Plugin Configuration {{{

"Airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#enabled = 1

"Tmuxline
let g:tmuxline_powerline_separators = 1
let g:tmuxline_preset = {
\   'a'    : '#S',
\   'win'  : '#I #W',
\   'cwin' : '#I #W',
\   'x'    : '%R',
\   'y'    : '%b %d, %Y',
\   'z'    : '#H'
\}

"Taglist Bar
nnoremap <F3> :TagbarToggle<CR>
let g:tagbar_sort = 0

"Linting
let g:neomake_verbose = 0
let g:neomake_serialize = 1
let g:neomake_airline = 0
let g:neomake_javascript_enabled_makers = ['jscs', 'jshint']
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_error_sign = {
\   'text': '✘',
\   'texthl': 'GruvboxRedSign'
\}
let g:neomake_warning_sign = {
\   'text': '⚠',
\   'texthl': 'GruvboxYellowSign'
\ }

function! g:LintStatusUpdate()
    call lightline#update()
    if neomake#statusline#LoclistStatus() != ""
        call lightline#update()
    endif
endfunction

augroup AutoLint
    autocmd!
    autocmd BufWritePost * Neomake
    autocmd BufWinEnter,CursorHold * call g:LintStatusUpdate()
augroup END

nnoremap <silent> <Leader>sc :Neomake<CR>

"Easymotion
let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_smartcase = 1
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade Comment
hi link EasyMotionTarget2First ErrorMsg
hi link EasyMotionTarget2Second ErrorMsg

"fzf
nnoremap <Space>p :Files<CR>
nnoremap <Space>d :Files %:p:h<CR>
nnoremap <Space>s :Buffers<CR>
nnoremap <Space>t :BTags<CR>

"Fugitive
nnoremap <Space>/ :Ggrep<Space>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff HEAD<CR>
vnoremap <C-g> "hy:tabedit %<CR>:Ggrep <C-r>h

"Git Gutter
let g:gitgutter_max_signs = 10000

"YouCompleteMe
set completeopt-=preview
"FortiOS has too many tags
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'c': 1
\}

"jsdoc
let g:jsdoc_default_mapping = 0

" }}}
