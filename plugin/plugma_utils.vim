" vim:set ts=4 sts=2 sw=2 tw=0 et:
"=============================================================================
" FILE:plugma_utils.vim
" AUTHOR:Tomoaki, Arakawa
" Last Change:2012/09/02 03:22:45.
" Version:0.0-beta
"
"=============================================================================
" LOAD GUARD {{{1
if exists('g:loaded_plugma_utils')
  finish
endif
let g:loaded_plugma_utils = 1

" }}}1
" Global Settings {{{1
" Global Variable {{{2
"-----------------------------------------------------------------------------
" Config
"-----------------------------------------------------------------------------
" Key-bind Support
let g:plugma_util_GatesKeyBind     = 1 " default value is 1
let g:plugma_util_DirectTabSelect  = 1 " default value is 1
let g:plugma_util_EmaceLikeKeyBind = 0 " default value is 0
" FileType Support.
let g:plugma_util_AC_Clang         = 1 " default value is 1
let g:plugma_util_AC_Perl          = 1 " default value is 1
let g:plugma_util_AC_PHP           = 1 " default value is 1
let g:plugma_util_AC_Ruby          = 1 " default value is 1

" Status-Line Support
let g:plugma_util_SL_Default       = 1 " default value is 1
let g:plugma_util_SL_DateTime      = 1 " default value is 1
let g:plugma_util_SL_CurDir        = 1 " default value is 1


" Config 
"-----------------------------------------------------------------------------
let g:plugma_util_SelectCmd = {}
" Format Sample.
"let g:plugma_util_SelectCmd.mru = [
"	\ ['Sample MRUの選択リスト', ''],
"	\ ['> ファイルのMRU', 'MRUFile'],
"	\ ['> フォルダのMRU', 'MRUDir'],
"	\ ['> NetrwのMRU', 'MRUHistory']]
let g:plugma_util_SelectCmd.guiopt = [
      \ ['Toggle "guioptions"' , '']                      , 
      \ ['Toolbar'             , 'PLToggleGuiOptions T']  , 
      \ ['Menubar'             , 'PLToggleGuiOptions m']  , 
      \ ['Scrollbar - Right'   , 'PLToggleGuiOptions r']  , 
      \ ['Scrollbar - Left'    , 'PLToggleGuiOptions l']  , 
      \ ['Tabbar'              , 'PLToggleGuiOptions e']  , 
      \ ['Disable Menu'        , 'PLToggleGuiOptions g']  , 
      \ ['Simple Dialog'       , 'PLToggleGuiOptions c']]

" Global autocmd {{{2
"-----------------------------------------------------------------------------
if g:plugma_util_AC_Perl == 1
  autocmd FileType perl :map <F3> <Esc>:!perl -cw %<CR>
  autocmd FileType perl :map <F4> <Esc>:!perl %<CR>
endif
if g:plugma_util_AC_Clang == 1
  autocmd FileType c :map <F3> <Esc>:shell<CR>
  autocmd FileType c :map <F4> <Esc>:make<CR>
endif
if g:plugma_util_AC_Ruby == 1
  autocmd FileType ruby :map <F3> <Esc>:!ruby -c %<CR>
  autocmd FileType ruby :map <F4> <Esc>:!ruby %<CR>
endif
if g:plugma_util_AC_PHP == 1
  autocmd FileType php :map <F3> <Esc>:!php -l %<CR>
  autocmd FileType php :map <F4> <Esc>:!php %<CR>
endif

" Global Keymap {{{2
"-----------------------------------------------------------------------------
" Space & Moving
nnoremap <silent><Space>h h
nnoremap <silent><Space>j j
nnoremap <silent><Space>k k
nnoremap <silent><Space>l <Esc>l
nnoremap <silent><Space><UP> gk
nnoremap <silent><Space><DOWN> gj

" Gates Keybind
if g:plugma_util_GatesKeyBind == 1
  " Cut, Copy, Paste, Undo, Redo
  " This keymap is pick up from $VIMRUNTIME/mswin.vim
  " Mouse & Select
  set clipboard=unnamed
  behave mswin

  " Cut
  vnoremap <C-X> "+x

  " Copy
  vnoremap <C-C> "+y

  " Paste
  map  <C-V> "+gP
  cmap <C-V> <C-R>+
  nmap <C-V> "+gp
  exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
  exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

  " Undo
  noremap <C-Z> u
  inoremap <C-Z> <C-O>u

  " Redo
  noremap <C-Y> <C-R>
  inoremap <C-Y> <C-O><C-R>
endif

" Emacs Keybind
if g:plugma_util_EmaceLikeKeyBind == 1
  nnoremap <C-X>1 :only<CR>
  nnoremap <C-X>2 :split<CR>
  nnoremap <C-X>3 :vsplit<CR>
  nnoremap <C-X>4 :tabedit %<CR>
endif

if has('gui_running')
  nnoremap <silent> <Bslash><F5> :PLSelectCmd guiopt<CR>
  nnoremap <silent> <Bslash><F11> :PLToggleFullScreen<CR>
  nnoremap <C-O> :browse e<CR>
  nnoremap <C-R> :promptrepl<CR>
endif

" System Util
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> <Space>B :b#<CR>
nnoremap <silent> Q :hide<CR>
nnoremap <silent> <C-I> :PLToggleIncSearch<CR>

" Split
nnoremap <silent><Space>wa :only<CR>
nnoremap <silent><Space>ws :split<CR>
nnoremap <silent><Space>wd :vsplit<CR>
nnoremap <silent><Space>wt :tabedit<CR>
nnoremap <silent><Space>wT :tabedit %<CR>

" Explore
command! -nargs=1 Texplore tabnew | Explore <q-args>
nnoremap <silent><Space>ea :execute 'Explore ' . getcwd()<CR>
nnoremap <silent><Space>es :execute 'Sexplore ' . getcwd()<CR>
nnoremap <silent><Space>ed :execute 'Vexplore ' . getcwd()<CR>
nnoremap <silent><Space>et :execute 'Texplore ' . getcwd()<CR>

" ChangeDirectory
nnoremap <silent><Space>cd :PLChangeDirectory<CR>
nnoremap <silent><Space>jd :PLMoveDirectory<CR>

if g:plugma_util_DirectTabSelect == 1
  nnoremap <silent><Space>1 :tabnext 1<CR>
  nnoremap <silent><Space>2 :tabnext 2<CR>
  nnoremap <silent><Space>3 :tabnext 3<CR>
  nnoremap <silent><Space>4 :tabnext 4<CR>
  nnoremap <silent><Space>5 :tabnext 5<CR>
  nnoremap <silent><Space>6 :tabnext 6<CR>
  nnoremap <silent><Space>7 :tabnext 7<CR>
  nnoremap <silent><Space>8 :tabnext 8<CR>
  nnoremap <silent><Space>9 :tabnext 9<CR>
  nnoremap <silent><Space>0 :tabnext 10<CR>

  if has('gui_running')
    nnoremap <C-Tab> :tabnext<CR>
    nnoremap <C-S-Tab> :tabprevious<CR>
  endif
endif
" Global Status-Line {{{2
"-----------------------------------------------------------------------------
if g:plugma_util_SL_Default == 1
  set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=R%l,C%v%V%6P\ \<\ %L
endif
if g:plugma_util_SL_DateTime == 1
  let &statusline .= ' [%{strftime("%Y/%b/%d %X")}]' " 時計
endif
if g:plugma_util_SL_CurDir == 1
  let &statusline .= ' [%{getcwd()}]'
endif

" FUNCTION {{{1
" FUNCTION Plugma_ToggleFullScreen {{{2
"-----------------------------------------------------------
function! s:Plugma_ToggleFullScreen()
  if has('win32')
    if &guioptions =~# 'C'
      set guioptions-=C
      if exists('s:go_temp')
        if s:go_temp =~# 'm'
          set guioptions+=m
        endif
        if s:go_temp =~# 'T'
          set guioptions+=T
        endif
      endif
      simalt ~r
    else
      let s:go_temp = &guioptions
      set guioptions+=C
      set guioptions-=m
      set guioptions-=T
      simalt ~x
    endif
  elseif has('mac')
    " this command is MacVim Only.
    if &fullscreen == 1
      set nofullscreen
    else
      set fullscreen
    endif
  endif
endfunction
command! PLToggleFullScreen call Plugma_ToggleFullScreen()

" FUNCTION Plugma_ToggleGuiOptions {{{2
"-----------------------------------------------------------
function! s:Plugma_ToggleGuiOptions(flag_option)
  if a:flag_option ==? 'T' " ツールバーの表示/非表示
    if &guioptions =~# 'T'
      set guioptions-=T
    else
      set guioptions+=T
    endif
  elseif a:flag_option ==? 'm' "メニューバーの表示/非表示
    if &guioptions =~# 'm'
      set guioptions-=m
    else
      set guioptions+=m
    endif
  elseif a:flag_option ==? 'r' "右スクロールバーの表示/非表示
    if &guioptions =~# 'r'
      set guioptions-=r
      set guioptions-=R
    else
      set guioptions+=r
      set guioptions+=R
    endif
  elseif a:flag_option ==? 'l' "左スクロールバーの表示/非表示
    if &guioptions =~# 'l'
      set guioptions-=l
      set guioptions-=L
    else
      set guioptions+=l
      set guioptions+=L
    endif
  elseif a:flag_option ==? 'e' "tabをGUIでだす
    if &guioptions =~# 'e'
      set guioptions-=e
    else
      set guioptions+=e
    endif
  elseif a:flag_option ==? 'g' "使えないボタンをグレーアウト
    if &guioptions =~# 'g'
      set guioptions-=g
    else
      set guioptions+=g
    endif
  elseif a:flag_option ==? 'c' "easy question is not GUI
    if &guioptions =~# 'c'
      set guioptions-=c
    else
      set guioptions+=c
    endif
  else
    echo 'bad parameter :' . a:flag_option
  endif
endfunction
command! -nargs=1 PLToggleGuiOptions call s:Plugma_ToggleGuiOptions(<q-args>)

" FUNCTION Plugma_ToggleIncSearch {{{2
"-----------------------------------------------------------
function! s:Plugma_ToggleIncSearch()
  if &incsearch == 1
    set incsearch!
    echohl ErrorMsg
    echo 'Incsearch OFF!'
    echohl None
  else
    set incsearch
    echohl MoreMsg
    echo 'Incsearch ON!'
    echohl None
  endif
endfunction
command! PLToggleIncSearch call s:Plugma_ToggleIncSearch()

" FUNCTION Plugma_SelectCmd {{{2
"-----------------------------------------------------------
function! s:Plugma_SelectCmd(key)
  let a:viewlist = []
  let a:idx = 0
  let a:input = 0
  let a:slist = g:plugma_util_SelectCmd[a:key]
  let a:head = ''

  while a:idx < len(a:slist)
    if a:idx == 0
      call add(a:viewlist, a:slist[a:idx][0])
    else
      execute 'let a:head = printf("[%-' . strlen(len(a:slist)) . 's]", a:idx)'
      call add(a:viewlist, a:head . ' ' . a:slist[a:idx][0])
    endif
    let a:idx = a:idx + 1
  endwhile

  let a:input = inputlist(a:viewlist)
  echo "\n"

  if a:input < 1 || a:input > len(a:slist)
    echohl ErrorMsg
    echo 'Selected-Number('.a:input.') is range over.(0-' . (len(a:slist) - 1) . ')'
    echohl None
    return
  endif

  echo '> ' . a:slist[a:input][1]

  execute a:slist[a:input][1]
endfunction

function! s:Plugma_SelectCmd_Complete(ArgLead, CmdLine, CursorPos)
  return keys(g:plugma_util_SelectCmd)
endfunction

command! -nargs=1 -complete=customlist,s:Plugma_SelectCmd_Complete PLSelectCmd 
      \ call s:Plugma_SelectCmd(<q-args>)

" FUNCTION CD {{{2
function! s:Plugma_ChangeDirectory()
  let a:cd_path = expand("%:p:h")
  execute 'cd ' . a:cd_path
  echo '>cd ' . a:cd_path
endfunction
command! PLChangeDirectory call s:Plugma_ChangeDirectory()

function! s:Plugma_MoveDirectory()
  let a:mv_path = input('Plz input Dir >' , expand("%:p:h") , "dir")
  echo "\n"
  if strlen(a:mv_path) < 1
    echohl WarningMsg
    echo "Not Change directory!"
    echohl None
    return
  endif

  if !isdirectory(a:mv_path)
    echohl ErrorMsg
    echo "Not Find directory!"
    echohl None
    return
  endif

  execute 'cd ' . a:mv_path
  echo '>cd ' . a:mv_path
endfunction
command! PLMoveDirectory call s:Plugma_MoveDirectory()
" }}}1
" vim:set foldenable foldmethod=marker:
