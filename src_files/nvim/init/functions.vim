
" SCB_VSPLIT
" ==========
function! g:Scb_vsplit()
    set noscb
    rightbelow vsplit
    set noscb
    normal gGCf
    normal gGCe
    normal gGCe
    set scb
    normal gh
    set scb
endfunction
nnoremap <leader>v :call Scb_vsplit()<CR>
"# AUTO SCB_VSPLIT
"augroup scb_vsplit
"    au!
"    autocmd VimEnter * call s:scb_vsplit()
"augroup END


"GETVISUALSELECTION
"==================
function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    if lnum1 == 0 && lnum2 == 0 && col1 == 0 && col2 == 0
        return ''
    endif
    let lines[-1] = lines[-1][:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    let ret = join(lines, "\n")
    return ret
endfunction

"terminal close
"==============
function! s:termexit() abort
    execute 'buffer #'
endfunction

"python run
"==========
"function! Python_run(arg, ...)
"    execute 'w /tmp/%.vimrun'
"    execute ':b bash'
"    execute ':cd #:h'
"    call deol#send('python run
"nnoremap [Space]rp :w /tmp/%.vimrun<CR>:b bash<CR>:cd #:h<CR>imv /tmp/vimrun.py ./vimrun.py; python vimrun.py; rm -rf vimrun.py 

command! -nargs=? MyRustRun call My_rust_run(<f-args>)
function! My_rust_run(...)
    execute "w"
    "normal !echo \"%:p:h\" > /tmp/deol_cd.tmp
    execute "b bash"
    "normal icd $(cat /tmp/deol_cd.tmp); cargo run<Space>"
    execute "call deol#send(\"cd \" . expand(\"#:p:h\") . \"; \" . \"cargo run " . join(a:000, " ") . "\")"
endfunction

command! -nargs=? MyAg call My_Ag(<f-args>)
function! My_Ag(...)
    execute "Ag " . join(a:000, " ") . " %"
endfunction

command! -nargs=? Add call Add_Func(<f-args>)
function! Add_Func(...)
    execute "!rusgit ac % -a " . join(a:000, " ")
endfunction

command! -nargs=? Remove call Remove_Func(<f-args>)
function! Remove_Func(...)
    execute "!rusgit ac % -r " . join(a:000, " ")
endfunction

command! -nargs=? Change call Change_Func(<f-args>)
function! Change_Func(...)
    execute "!rusgit ac % -c " . join(a:000, " ")
endfunction

command! -nargs=? Improve call Improve_Func(<f-args>)
function! Improve_Func(...)
    execute "!rusgit ac % -i " . join(a:000, " ")
endfunction

command! -nargs=? Support call Support_Func(<f-args>)
function! Support_Func(...)
    execute "!rusgit ac % -s " . join(a:000, " ")
endfunction

command! -nargs=? Fix call Fix_Func(<f-args>)
function! Fix_Func(...)
    execute "!rusgit ac % -f " . join(a:000, " ")
endfunction

command! -nargs=? Use call Use_Func(<f-args>)
function! Use_Func(...)
    execute "!rusgit ac % -u " . join(a:000, " ")
endfunction

command! -nargs=? Update call Update_Func(<f-args>)
function! Update_Func(...)
    execute "!rusgit ac % -U " . join(a:000, " ")
endfunction

command! -nargs=? Allow call Allow_Func(<f-args>)
function! Allow_Func(...)
    execute "!rusgit ac % -l " . join(a:000, " ")
endfunction

command! -nargs=? Avoid call Avoid_Func(<f-args>)
function! Avoid_Func(...)
    execute "!rusgit ac % -v " . join(a:000, " ")
endfunction

command! -nargs=? Refactor call Refactor_Func(<f-args>)
function! Refactor_Func(...)
    execute "!rusgit ac % -R " . join(a:000, " ")
endfunction

" GREP
" ====
command! -nargs=? Frep call Frep_Func(<f-args>)
function! Frep_Func(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    let regexp = join(args[1:], " ")
    let regexp = substitute(regexp, '"', '\\"', "g")
    execute "w"
    execute "b bash"
    if argc > 2
        let cmd = "call deol#send(\"frep " . path . " " . regexp . "\")"
        execute cmd
    else
        let cmd = "call deol#send(\"frep " . path . " " . regexp . "\")"
        execute cmd
    endif
endfunction

command! -nargs=? Frepl call Frepl_Func(<f-args>)
function! Frepl_Func(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    let regexp = join(args[1:], " ")
    let regexp = substitute(regexp, '"', '\\"', "g")
    execute "w"
    execute "b bash"
    if argc > 2
        let cmd = "call deol#send(\"frepl " . path . " " . regexp . "\")"
        execute cmd
    else
        let cmd = "call deol#send(\"frepl " . path . " " . regexp . "\")"
        execute cmd
    endif
    normal i
endfunction

command! -nargs=? GitStatus call Git_Status(<f-args>)
function! Git_Status(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    execute "w"
    execute "b bash"
    let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit status --ls='exa  --group-directories-first'\")"
    execute cmd
endfunction

command! -nargs=? GitLog call Git_Log(<f-args>)
function! Git_Log(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    execute "w"
    execute "b bash"
    if argc > 1
        let n = args[1]
        let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit log " . n . "\")"
    else
        let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit log \")"
    endif
    execute cmd
endfunction

command! -nargs=? GitDiff call Git_Diff(<f-args>)
function! Git_Diff(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    execute "w"
    execute "b bash"
    if argc > 1
        let options = args[1]
        let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit diff " . path . " " . options . "\")"
    else
        let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit diff " . path . "\")"
    endif
    execute cmd
endfunction

command! -nargs=? GitStatus call Git_Status(<f-args>)
function! Git_Status(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    execute "w"
    execute "b bash"
    let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit status --ls='exa  --group-directories-first'\")"
    execute cmd
endfunction

command! -nargs=? GitLog call Git_Log(<f-args>)
function! Git_Log(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    execute "w"
    execute "b bash"
    if argc > 1
        let n = args[1]
        let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit log " . n . "\")"
    else
        let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit log \")"
    endif
    execute cmd
endfunction

command! -nargs=? GitDiff call Git_Diff(<f-args>)
function! Git_Diff(...)
    let args = split(a:000[0], " ")
    let argc = len(args)
    let path = expand(args[0])
    execute "w"
    execute "b bash"
    if argc > 1
        let options = args[1]
        let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit diff " . path . " " . options . "\")"
    else
        let cmd = "call deol#send(\"cdrepobase " . path . " && rusgit diff " . path . "\")"
    endif
    execute cmd
endfunction

" quick_open
" ==========
function! g:Quick_open()
    let l:path = system("cat /tmp/viming_path")
    let l:pathes = split(l:path, "\n")
    for l:x in l:pathes
        execute "e " . l:x
    endfor
endfunction
nnoremap <leader>o :call Quick_open()<CR>

" my_vimgrep
" ==========
command! -nargs=? MyVimgrep call My_vimgrep(<f-args>)
function! My_vimgrep(...)
    execute "mark a"
    execute "vimgrep /" . join(a:000, " ") . "/ %" . " | cw"
    normal gk
    set cursorline
endfunction

" save this file name
" ===================
command! -nargs=? SaveThisFileName call SaveThisFileName(<f-args>)
function! SaveThisFileName(...)
    execute "r !echo %:p"
    normal ddk
    execute "w!"
    execute "e /tmp/viming_path"
    normal Vp
    execute "w"
    execute "bd"
endfunction

" my_vimgrepadd
" ==============
command! -nargs=? MyVimgrepadd call My_vimgrepadd(<f-args>)
function! My_vimgrepadd(...)
    let l:args = join(a:000, " ")
    let l:cmd = "bufdo vimgrepadd /" . l:args . "/ %"
    execute "mark a"
    execute "cex ''"
    execute l:cmd
    execute "cw"
    normal gk
    set cursorline
    execute "call Quick_open()"
endfunction

" my_vimgrep_all
" ==============
command! -nargs=? MyVimgrepAll call My_vimgrep_all(<f-args>)
function! My_vimgrep_all(...)
    let l:args = split(a:000[0], " ")
    let l:argc = len(args)
    let l:num = l:argc -2
    let l:last = l:argc - 1
    execute "mark a"
    execute "cd %:h"
    execute "vimgrep /" . join(l:args[0:l:num], " ") . "/ " . l:args[l:last] . " | cw"
    normal gk
    set cursorline
endfunction

" make
" ====
command! -nargs=? MB call MB(<f-args>)
function! MB(...)
    execute "make build | cw"
endfunction

" Denite Grep
" ===========
command! -nargs=? DG call Denite_grep(<f-args>)
function! Denite_grep(...)
    execute "mark a"
    execute "Denite -buffer-name=search -auto-highlight -winheight=10 line"
endfunction
nnoremap <silent>/ :<C-u>DG<CR>

" CNEXT
" =====
command! -nargs=? CN call CN(<f-args>)
function! CN(...)
    execute "cnext"
    normal zz
    set cursorline
endfunction
nnoremap <silent><C-n> :<C-u>CN<CR>
nnoremap <silent><C-j> :<C-u>CN<CR>

" CPREV
" =====
command! -nargs=? CP call CP(<f-args>)
function! CP(...)
    execute "cNext"
    normal zz
    set cursorline
endfunction
nnoremap <silent><C-p> :<C-u>CP<CR>
nnoremap <silent><C-k> :<C-u>CP<CR>

" QuickFix Closer
" ===============
command! -nargs=? QC call QC(<f-args>)
function! QC(...)
    set nocursorline
    normal gj
    execute "bd"
endfunction
nnoremap <silent><C-h> :<C-u>QC<CR>
