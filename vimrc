" vim:fdm=marker

"Plugins{{{
call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'felixjung/vim-base16-lightline'
Plug 'tomtom/tcomment_vim'
Plug 'Yggdroot/indentLine'
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
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'

if &t_Co >= 256 || has('gui_running')
    Plug 'itchyny/lightline.vim'
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
set mouse=

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

"Better split behaviour
set splitbelow
set splitright

"Window navigation
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

"Terminal window navigation
if has('nvim')
    nnoremap <C-w>% :vsp <CR>:terminal<CR>
    nnoremap <C-w>" :sp <CR>:terminal<CR>

    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-[> <C-\><C-n>
endif

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

"Copy pasting between vim instances and remote clipboard
vnoremap <leader>y :w! /tmp/vim_clipboard<CR>
vnoremap <leader>r :w !ssh -p 6788 localhost pbcopy<CR>
nnoremap <leader>p :r! cat /tmp/vim_clipboard<CR>

"vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

"Find and replace selected
vnoremap <C-r> "hy:.,$s/<C-r>h//gc<left><left><left>

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
    \   'colorscheme': 'base16_ocean',
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \                 [ 'fugitive', 'filename' ] ],
    \       'right': [ ['syntastic', 'lineinfo'],
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
    \       'syntastic': 'SyntasticStatuslineFlag'
    \   },
    \   'component_type': {
    \       'syntastic': 'error'
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
        if exists('*fugitive#head') && winwidth(0) > s:lightline_wrap1
            let _ = fugitive#head()
            return strlen(_) ? ' '._ : ''
        endif
        return ''
    endfunction

    function! LightLineFilename()
        let fname = expand('%')
        if fname =~ 'term://'
            return ''
        endif
        return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
            \ ('' != fname ? (winwidth(0) > s:lightline_wrap3 ? fname : expand('%:t')) : '[No Name]') .
            \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
    endfunction

    function! LightLineFileFormat()
        if expand('%') =~ 'term://'
            return ''
        endif
        return winwidth(0) > s:lightline_wrap2 ? &fileformat : ''
    endfunction

    function! LightLineFileType()
        return winwidth(0) > s:lightline_wrap2 ? (strlen(&filetype) ? &filetype : '') : ''
    endfunction

    function! LightLineFileEncoding()
        if expand('%') =~ 'term://'
            return ''
        endif
        return winwidth(0) > s:lightline_wrap2 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! LightLineMode()
        return winwidth(0) > s:lightline_wrap2 ? lightline#mode() : ''
    endfunction

    function! LightLineLineInfo()
        return ' ' . printf('%3d:%-2d', line('.'), col('.'))
    endfunction

    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
    colorscheme base16-ocean

    let &colorcolumn="80,100,120"

    "Disable Background Color Erase (BCE) so that color schemes
    "work properly when Vim is used inside tmux and GNU screen.
    if &term =~ '256color'
        set t_ut=
    endif

else
    "-----Basic Terminal Settings------
    colorscheme base16-ocean
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
nnoremap <Leader>] :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"}}}

"Basic Plugin Configuration {{{

"Vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>

"Taglist Bar
nnoremap <F3> :TagbarToggle<CR>
let g:tagbar_sort = 0

"Linting
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_enable_highlighting = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_style_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_warning_symbol = "⚠"
let g:syntastic_javascript_checkers = ['jscs', 'jshint']
let g:syntastic_ignore_files = ['.*\.json', '.*migadmin/lang/.*\.js']

function! g:SyntaxCheck()
    SyntasticCheck
    call lightline#update()
endfunction

augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost * call g:SyntaxCheck()
augroup END

nnoremap <silent> <Leader>sc :call g:SyntaxCheck()<CR>

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
