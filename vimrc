" vim:fdm=marker

"Plugins{{{
call plug#begin('~/.vim/plugged')

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

Plug 'chriskempson/base16-vim'
Plug 'mark-westerhof/vim-lightline-base16'
Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/float-preview.nvim'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tern', {'do': 'npm install'}
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'wavded/vim-stylus'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'pangloss/vim-javascript'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'sakhnik/nvim-gdb', { 'do': './install.sh' }

if &t_Co >= 256 || has('gui_running')
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
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
set spell
set nowrap
set backspace=indent,eol,start
if has('nvim')
    set inccommand=nosplit
endif

"Turn off some features
set nohlsearch
set mouse=

"stfu
set visualbell
set t_vb=

"Stay in the same column while navigating up/down
set virtualedit=all

"Remap leader
let mapleader = ","

"Clear search highlight when esc is pressed
nnoremap <silent> <esc> :noh<cr><esc>

"Show tabs and trailing whitespace
set list lcs=trail:·,tab:»·

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

"Buffer navigation
set hidden
nnoremap <silent> fh :bf<CR>
nnoremap <silent> fj :bn<CR>
nnoremap <silent> fk :bp<CR>
nnoremap <silent> fl :bl<CR>
nnoremap <silent> fd :bp<bar>sp<bar>bn<bar>bd<CR>

"Window shortcuts
nnoremap <Leader>o :only<CR>

"Copy pasting between vim instances and remote clipboard
vnoremap <leader>y :w! /tmp/vim_clipboard<CR>
vnoremap <leader>r :w !ssh -p 6788 localhost pbcopy<CR>
nnoremap <leader>p :r! cat /tmp/vim_clipboard<CR>

"vimrc
nnoremap <Leader>ev :e $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

"Find and replace selected
vnoremap <C-r> "hy:.,$s/<C-r>h//g<left><left>
vnoremap <C-s> "hy:.,$s/<C-r>h//gc<left><left><left>

"}}}

"Appearance {{{

"Lightline
if &t_Co >= 256 || has('gui_running')
    set background=dark

    set laststatus=2
    set noshowmode
    set noshowcmd
    set ttimeoutlen=10

    let base16_theme = 'base16-' . $BASE_16_THEME

    let g:lightline = {
    \   'tabline': {
    \       'left': [ ['buffers'] ],
    \       'right': [ ['close'] ]
    \   },
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \                 [ 'fugitive', 'filename' ] ],
    \       'right': [ ['linter_checking', 'linter_errors', 'linter_warnings',
    \                      'linter_ok', 'lineinfo'],
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
    \       'lineinfo': 'LightLineLineInfo',
    \   },
    \   'component_expand': {
    \       'buffers': 'lightline#bufferline#buffers',
    \       'linter_checking': 'lightline#ale#checking',
    \       'linter_warnings': 'lightline#ale#warnings',
    \       'linter_errors': 'lightline#ale#errors',
    \       'linter_ok': 'lightline#ale#ok',
    \   },
    \   'component_type': {
    \       'buffers': 'tabsel',
    \       'linter_checking': 'ok',
    \       'linter_warnings': 'warning',
    \       'linter_errors': 'error',
    \       'linter_ok': 'ok',
    \   },
    \   'separator': { 'left': "\ue0b0", 'right': "\ue0b2"},
    \   'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3"}
    \}

    let g:lightline.colorscheme = substitute(base16_theme, '-', '_', 'g')

    let s:lightline_wrap1 = 120
    let s:lightline_wrap2 = 80
    let s:lightline_wrap3 = 60
    let s:lightline_fname_max = 80

    function! LightLineModified()
        return &modified ? "\uf196" : ''
    endfunction

    function! LightLineReadonly()
        return &readonly ? "\uf023" : ''
    endfunction

    function! LightLineFugitive()
        if exists('*fugitive#head') && winwidth(0) > s:lightline_wrap1
            let _ = fugitive#head()
            return strlen(_) ? "\uf126 "._ : ''
        endif
        return ''
    endfunction

    function! LightLineFilename()
        let fname = expand('%:t')
        if fname =~ 'NERD_tree' || fname =~ 'term://'
            return ''
        endif
        return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
            \ ('' != fname ? (winwidth(0) > s:lightline_wrap3 &&
            \ strlen(fname) < s:lightline_fname_max ? fname : expand('%:t')) : '[No Name]') .
            \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
    endfunction

    function! LightLineFileFormat()
        let fname = expand('%:t')
        if fname =~ 'NERD_tree' || fname =~ 'term://'
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
        if expand('%:t') =~ 'NERD_tree'
            return 'Files'
        endif
        return winwidth(0) > s:lightline_wrap2 ? lightline#mode() : ''
    endfunction

    function! LightLineLineInfo()
        if expand('%:t') =~ 'NERD_tree'
            return ''
        endif
        return "\ue0a1 " . printf('%3d:%-2d', line('.'), col('.'))
    endfunction

    if has('nvim')
        set termguicolors
    endif

    execute 'colorscheme' base16_theme

    let &colorcolumn="80,100,120"

    "Disable Background Color Erase (BCE) so that color schemes
    "work properly when Vim is used inside tmux and GNU screen.
    if &term =~ '256color'
        set t_ut=
    endif

    "Bufferline
    set showtabline=2
    let g:lightline#bufferline#enable_devicons = 1
    let g:lightline#bufferline#filename_modifier = ':t'

else
    "-----Basic Terminal Settings------
    colorscheme desert
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
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tsserver', 'tslint'],
\   'html': []
\}
let g:ale_lint_delay = 1000
let g:ale_pattern_options = {
\   '.*migadmin/lang/.*\.js$': {'ale_enabled': 0}
\}

let g:ale_sign_error = "\uf06a"
let g:ale_sign_warning = "\uf071"
highlight link ALEErrorSign DiffDelete

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf06a "
let g:lightline#ale#indicator_ok = "\uf00c "

"Easymotion
let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_smartcase = 1
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

"fzf
nnoremap <Space>p :Files<CR>
nnoremap <Space>d :Files %:p:h<CR>
nnoremap <Space>s :Buffers<CR>
nnoremap <Space>t :BTags<CR>
let g:fzf_history_dir = '~/.local/share/fzf-history'

"Match theme
let g:fzf_colors = {
\   'fg':      ['fg', 'Normal'],
\   'bg':      ['bg', 'Normal'],
\   'hl':      ['fg', 'Comment'],
\   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\   'hl+':     ['fg', 'Statement'],
\   'info':    ['fg', 'PreProc'],
\   'border':  ['fg', 'Ignore'],
\   'prompt':  ['fg', 'Conditional'],
\   'pointer': ['fg', 'Exception'],
\   'marker':  ['fg', 'Keyword'],
\   'spinner': ['fg', 'Label'],
\   'header':  ['fg', 'Comment']
\}

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

"Nerdtree
autocmd vimenter * NERDTree
autocmd vimenter * call lightline#update()
autocmd vimenter * wincmd p
nnoremap <silent><leader>f :NERDTreeToggle<CR>:call lightline#update()<CR>
nnoremap <silent><leader>r :NERDTreeFind<CR>:call lightline#update()<CR>
let g:NERDTreeMinimalUI = 1

"Fugitive
nnoremap <Space>/ :Ggrep<Space>
nnoremap <Leader>gd :Gdiff HEAD<CR>
vnoremap <C-g> "hy:Ggrep <C-r>h

"Javascript
let g:javascript_plugin_jsdoc = 1

"Typescript
let g:nvim_typescript#diagnostics_enable = 0
autocmd FileType typescript nnoremap <buffer> <C-]> :TSTypeDef<CR>
autocmd FileType typescript nnoremap <buffer> <Leader>] :TSDefPreview<CR>
autocmd FileType typescript nnoremap <buffer> <silent> K :TSDoc<CR>

"Git Gutter
let g:gitgutter_max_signs = 10000
set signcolumn=yes

"ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone,noselect
autocmd CompleteDone * silent! pclose!

inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

"jsdoc
let g:jsdoc_enable_es6 = 1

" }}}
