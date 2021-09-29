let s:hex00 = "1c1810"
let s:hex01 = "2a261c"
let s:hex02 = "3a3527"
let s:hex03 = "504b38"
let s:hex04 = "5f5b45"
let s:hex05 = "736e55"
let s:hex06 = "bab696"
let s:hex07 = "f8f5de"
let s:hex08 = "e35142"
let s:hex09 = "fba11b"
let s:hex0A = "f2ff27"
let s:hex0B = "5ceb5a"
let s:hex0C = "5aebbc"
let s:hex0D = "489bf0"
let s:hex0E = "FF8080"
let s:hex0F = "F69BE7"

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

let s:lastMode = ''

function! RedrawModeColors(mode)
  " Normal mode
  if a:mode == 'n'
    if s:lastMode != 'n'
        call <sid>modehi(s:hex04, s:hex02, s:hex04, s:hex02, s:cterm04, s:cterm02, s:cterm04, s:cterm02)
        let s:lastMode = 'n'
    endif
  " Insert mode
  elseif a:mode == 'i'
    if s:lastMode != 'i'
        call <sid>modehi(s:hex00, s:hex0E, s:hex04, s:hex02, s:cterm00, s:cterm0E, s:cterm0E, s:cterm02)
        let s:lastMode = 'i'
    endif
  " Replace mode
  elseif a:mode == 'R'
    if s:lastMode != 'R'
        call <sid>modehi(s:hex00, s:hex08, s:hex04, s:hex02, s:cterm00, s:cterm08, s:cterm08, s:cterm02)
        let s:lastMode = 'R'
    endif
  " Visual mode
  elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
    if s:lastMode != 'v'
        call <sid>modehi(s:hex00, s:hex0A, s:hex04, s:hex02, s:cterm00, s:cterm0A, s:cterm0A, s:cterm02)
        let s:lastMode = 'v'
    endif
  " Command mode
  elseif a:mode == 'c'
    if s:lastMode != 'c'
        call <sid>modehi(s:hex04, s:hex02, s:hex04, s:hex02, s:cterm04, s:cterm02, s:cterm04, s:cterm02)
        let s:lastMode = 'c'
    endif
  " Terminal mode
  elseif a:mode == 't'
    if s:lastMode != 't'
        call <sid>modehi(s:hex04, s:hex02, s:hex04, s:hex02, s:cterm04, s:cterm02, s:cterm04, s:cterm02)
        let s:lastMode = 't'
    endif
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

let s:lastWarningLevel = ''

function! SetWarnings()
    let info = get(b:, 'coc_diagnostic_info', {})
    let errorCount = get(info, 'error', 0)
    let warningCount = get(info, 'warning', 0)
    let infoCount = get(info, 'information', 0)

    let result = ''

    if errorCount
        if s:lastWarningLevel != 4
            call g:Base16StatusLineHighlight("Base16StatusLineWarning", s:hex08, "none", s:cterm08, "none")
            call g:Base16StatusLineHighlight("Base16StatusLineWarningBody", s:hex0A, s:hex08, s:cterm0A, s:cterm08)
            let s:lastWarningLevel = 4
        endif
        let result = '  ' . errorCount
    elseif warningCount
        if s:lastWarningLevel != 3
            call g:Base16StatusLineHighlight("Base16StatusLineWarning", s:hex0A, "none", s:cterm0A, "none")
            call g:Base16StatusLineHighlight("Base16StatusLineWarningBody", s:hex08, s:hex0A, s:cterm08, s:cterm0A)
            let s:lastWarningLevel = 3
        endif
        let result = '  ' . warningCount
    elseif infoCount
        if s:lastWarningLevel != 2
            call g:Base16StatusLineHighlight("Base16StatusLineWarning", s:hex0D, "none", s:cterm0D, "none")
            call g:Base16StatusLineHighlight("Base16StatusLineWarningBody", s:hex00, s:hex0D, s:cterm00, s:cterm0D)
            let s:lastWarningLevel = 2
        endif
        let result = '  ' . infoCount
    else
        if s:lastWarningLevel != 1
            call g:Base16StatusLineHighlight("Base16StatusLineWarning", s:hex0B, "none", s:cterm0B, "none")
            call g:Base16StatusLineHighlight("Base16StatusLineWarningBody", s:hex00, s:hex0B, s:cterm00, s:cterm0B)
            let s:lastWarningLevel = 1
        endif
        let result = '  '
    endif

    return result . get(g:, 'coc_status', '')
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
hi SignColumn guibg=none ctermbg=none
hi EndOfBuffer guifg=bg ctermfg=bg

call g:Base16StatusLineHighlight("GitGutterAdd", s:hex0B, "none", s:cterm0B, "none")
call g:Base16StatusLineHighlight("GitGutterChange", s:hex0D, "none", s:cterm0D, "none")
call g:Base16StatusLineHighlight("GitGutterDelete", s:hex08, "none", s:cterm08, "none")
call g:Base16StatusLineHighlight("GitGutterChangeDelete", s:hex0E, "none", s:cterm0E, "none")

highlight link CocErrorSign WarningMsg
highlight link CocWarningSign Label
highlight link CocInfoSign Directory

" Buffer tabline
hi TabLine guibg=none ctermbg=none
hi TabLineFill guibg=none ctermbg=none
call g:Base16StatusLineHighlight("BufTabLineCurrent", s:hex00, s:hex0E, s:cterm00, s:cterm0E)
call g:Base16StatusLineHighlight("BufTabLineActive", s:hex0E, "none", s:cterm0E, "none")
