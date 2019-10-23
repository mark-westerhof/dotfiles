let s:hex00 = "feffff"
let s:hex01 = "392551"
let s:hex02 = "7b6d8b"
let s:hex03 = "9c92a8"
let s:hex04 = "ddd6e5"
let s:hex05 = "5a496e"
let s:hex06 = "470546"
let s:hex07 = "190134"
let s:hex08 = "27d9d5"
let s:hex09 = "bdb6c5"
let s:hex0A = "5ba2b6"
let s:hex0B = "f80059"
let s:hex0C = "c33678"
let s:hex0D = "47f9f5"
let s:hex0E = "bd0152"
let s:hex0F = "dedae2"

let s:cterm00 = "00"
let s:cterm03 = "08"
let s:cterm05 = "07"
let s:cterm07 = "15"
let s:cterm08 = "01"
let s:cterm0A = "03"
let s:cterm0B = "02"
let s:cterm0C = "06"
let s:cterm0D = "04"
let s:cterm0E = "05"
if exists('base16colorspace') && base16colorspace == "256"
  let s:cterm01 = "18"
  let s:cterm02 = "19"
  let s:cterm04 = "20"
  let s:cterm06 = "21"
  let s:cterm09 = "16"
  let s:cterm0F = "17"
else
  let s:cterm01 = "10"
  let s:cterm02 = "11"
  let s:cterm04 = "12"
  let s:cterm06 = "13"
  let s:cterm09 = "09"
  let s:cterm0F = "14"
endif

function! g:Base16StatusLineHighlight(group, guifg, guibg, ctermfg, ctermbg)
    if a:guifg != ""
        exec "hi " . a:group . " guifg=#" . a:guifg
    endif
    if a:guibg != ""
        exec "hi " . a:group . " guibg=#" . a:guibg
    endif
    if a:ctermfg != ""
        exec "hi " . a:group . " ctermfg=" . a:ctermfg
    endif
    if a:ctermbg != ""
        exec "hi " . a:group . " ctermbg=" . a:ctermbg
    endif
endfunction

function <sid>modehi(guifg, guibg, guifg2, guibg2, ctermfg, ctermfg2, ctermbg, ctermbg2)
    call g:Base16StatusLineHighlight("Base16StatusLineAccent", a:guibg, "none", a:ctermbg, "none")
    call g:Base16StatusLineHighlight("Base16StatusLineAccentBody", a:guifg, a:guibg, a:ctermfg, a:ctermbg)
    call g:Base16StatusLineHighlight("Base16StatusLineFilename", a:guifg2, a:guibg2, a:ctermfg2, a:ctermbg2)
    call g:Base16StatusLineHighlight("Base16StatusLineSeparator", a:guibg2, "none", a:ctermbg2, "none")
endfunction

" Do not show mode under the statusline since the statusline itself changes
" color depending on mode
set noshowmode

set laststatus=2

function! RedrawModeColors(mode)
  " Normal mode
  if a:mode == 'n'
    call <sid>modehi(s:hex04, s:hex02, s:hex04, s:hex02, s:cterm04, s:cterm02, s:cterm04, s:cterm02)
  " Insert mode
  elseif a:mode == 'i'
    call <sid>modehi(s:hex00, s:hex0E, s:hex04, s:hex02, s:cterm00, s:cterm0E, s:cterm0E, s:cterm02)
  " Replace mode
  elseif a:mode == 'R'
    call <sid>modehi(s:hex00, s:hex08, s:hex04, s:hex02, s:cterm00, s:cterm08, s:cterm08, s:cterm02)
  " Visual mode
  elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
    call <sid>modehi(s:hex00, s:hex0A, s:hex04, s:hex02, s:cterm00, s:cterm0A, s:cterm0A, s:cterm02)
  " Command mode
  elseif a:mode == 'c'
    call <sid>modehi(s:hex04, s:hex02, s:hex04, s:hex02, s:cterm04, s:cterm02, s:cterm04, s:cterm02)
  " Terminal mode
  elseif a:mode == 't'
    call <sid>modehi(s:hex04, s:hex02, s:hex04, s:hex02, s:cterm04, s:cterm02, s:cterm04, s:cterm02)
  endif
  " Return empty string so as not to display anything in the statusline
  return ''
endfunction

function! SetModifiedSymbol(modified, readonly)
    if a:readonly
        return " "
    elseif a:modified == 1
        return " "
    else
        return ""
    endif
endfunction

function! SetWarnings()
    let info = get(b:, 'coc_diagnostic_info', {})
    let errorCount = get(info, 'error', 0)
    let warningCount = get(info, 'warning', 0)
    let infoCount = get(info, 'information', 0)

    let result = ''

    if errorCount
        call g:Base16StatusLineHighlight("Base16StatusLineWarning", s:hex08, "none", s:cterm08, "none")
        call g:Base16StatusLineHighlight("Base16StatusLineWarningBody", s:hex0A, s:hex08, s:cterm0A, s:cterm08)
        let result = '  ' . errorCount . ' '
    elseif warningCount
        call g:Base16StatusLineHighlight("Base16StatusLineWarning", s:hex0A, "none", s:cterm0A, "none")
        call g:Base16StatusLineHighlight("Base16StatusLineWarningBody", s:hex08, s:hex0A, s:cterm08, s:cterm0A)
        let result = '  ' . warningCount . ' '
    elseif infoCount
        call g:Base16StatusLineHighlight("Base16StatusLineWarning", s:hex0D, "none", s:cterm0D, "none")
        call g:Base16StatusLineHighlight("Base16StatusLineWarningBody", s:hex00, s:hex0D, s:cterm00, s:cterm0D)
        let result = '  ' . infoCount . ' '
    else
        call g:Base16StatusLineHighlight("Base16StatusLineWarning", s:hex0B, "none", s:cterm0B, "none")
        call g:Base16StatusLineHighlight("Base16StatusLineWarningBody", s:hex00, s:hex0B, s:cterm00, s:cterm0B)
        let result = '  '
    endif

    return result
endfunction

" Statusbar items
" ====================================================================

" This will not be displayed, but the function RedrawModeColors will be
" called every time the mode changes, thus updating the colors used for the
" components.
set statusline=%{RedrawModeColors(mode())}

" Left side items
" =======================
set statusline+=%#Base16StatusLineAccent#\ 
set statusline+=%#Base16StatusLineAccentBody#\ \ 

" Filename + modified
set statusline+=%#Base16StatusLineFilename#\ %.50f%{SetModifiedSymbol(&modified,&readonly)}\ 
set statusline+=%#Base16StatusLineSeparator#\ 

" Right side items
" =======================
set statusline+=%=

" Line, column, and scroll progress
set statusline+=%#Base16StatusLineBasic#
set statusline+=%#Base16StatusLineBasicBody#\ \ %p%%\ %l:%c\ 
set statusline+=%#Base16StatusLineBasic#\ 

" CoC warnings
set statusline+=%#Base16StatusLineWarning#
set statusline+=%#Base16StatusLineWarningBody#%{SetWarnings()}
set statusline+=%#Base16StatusLineWarning#\ 

" Static colors
call g:Base16StatusLineHighlight("StatusLine", s:hex04, "none", s:cterm04, "none")
call g:Base16StatusLineHighlight("StatusLineNC", s:hex02, "none", s:cterm02, "none")

call g:Base16StatusLineHighlight("Base16StatusLineBasic", s:hex02, "none", s:cterm02, "none")
call g:Base16StatusLineHighlight("Base16StatusLineBasicBody", s:hex04, s:hex02, s:cterm04, s:cterm02)

call g:Base16StatusLineHighlight("Base16StatusLineFileType", s:hex02, "none", s:cterm02, "none")

" Theme modifications to complement statusline
hi LineNr guibg=none ctermbg=none

hi GitGutterAdd guibg=none ctermbg=none
hi GitGutterChange guibg=none ctermbg=none
hi GitGutterDelete guibg=none ctermbg=none
hi GitGutterChangeDelete guibg=none ctermbg=none

highlight link CocErrorSign WarningMsg
highlight link CocWarningSign Label
highlight link CocInfoSign Directory

" Buffer tabline
hi TabLine guibg=none ctermbg=none
hi TabLineFill guibg=none ctermbg=none
call g:Base16StatusLineHighlight("BufTabLineCurrent", s:hex00, s:hex0E, s:cterm00, s:cterm0E)
call g:Base16StatusLineHighlight("BufTabLineActive", s:hex0E, "none", s:cterm0E, "none")
