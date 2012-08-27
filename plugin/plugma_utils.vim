" vim:set ts=4 sts=2 sw=2 tw=0 et:
"=============================================================================
" FILE:plugma_utils.vim
" AUTHOR:Arakawa Tomoaki
" Last Change:2012/08/28 00:25:30.
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
let g:plugma_util_GatesKeyBind     = 1 " default value is 0
let g:plugma_util_DirectTabSelect  = 1 " default value is 1
let g:plugma_util_EmaceLikeKeyBind = 0 " default value is 0
" FileType Support.
let g:plugma_util_AC_Perl          = 1 " default value is 1
let g:plugma_util_AC_Clang         = 1 " default value is 1

" Config 
"-----------------------------------------------------------------------------
let g:plugma_util_SelectCmd = {}
" Format Sample.
"let g:plugma_util_SelectCmd.mru = [
"	\ ['Sample MRUの選択リスト', ''],
"	\ ['> ファイルのMRU', 'MRUFile'],
"	\ ['> フォルダのMRU', 'MRUDir'],
"	\ ['> NetrwのMRU', 'MRUHistory']]

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
 nnoremap <silent> <Bslash><F5> :GuiOptionCtrl<CR>
 nnoremap <silent> <Bslash><F11> :ToggleFullScreen<CR>
 nnoremap <C-O> :browse e<CR>
 nnoremap <C-R> :promptrepl<CR>
endif

" System Util
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> <Space>B :b#<CR>
nnoremap <silent> Q :hide<CR>
nnoremap <silent> <C-I> :ToggleIncSearch<CR>

" Split
nnoremap <Space>wa :only<CR>
nnoremap <Space>ws :split<CR>
nnoremap <Space>wd :vsplit<CR>
nnoremap <Space>wt :tabedit<CR>
nnoremap <Space>wT :tabedit %<CR>

" Explore
command! Texplore tabnew | Explore
nnoremap <Space>ea :Explore<CR>
nnoremap <Space>es :Sexplore<CR>
nnoremap <Space>ed :Vexplore<CR>
nnoremap <Space>et :Texplore<CR>

" ChangeDirectory

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

" FUNCTION {{{1
" FUNCTION fullscreen {{{2
"-----------------------------------------------------------
function! ToggleFullScreen()
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
command! ToggleFullScreen call ToggleFullScreen()

" FUNCTION Toggle GUI Options {{{2
"-----------------------------------------------------------
function! ToggleGuiOptions(flag_option)
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
	elseif a:flag_option ==? 'C' "easy question is not GUI
    if &guioptions =~# 'C'
      set guioptions-=C
    else
      set guioptions+=C
    endif
  else
    echo 'bad parameter :' . a:flag_option
  endif
endfunction

" FUNCTION Toggle GUI Options(Select) {{{2
"-----------------------------------------------------------
function! GuiOptionCtrl()
	if &guioptions =~# 'T'
		let a:toolbar_mode = '-'
	else
		let a:toolbar_mode = '+'
	endif
	if &guioptions =~# 'm'
		let a:menubar_mode = '-'
	else
		let a:menubar_mode = '+'
	endif
	if (&guioptions =~# 'r') && (&guioptions =~# 'R')
		let a:scrollbar_r_mode = '-'
	else
		let a:scrollbar_r_mode = '+'
	endif
	if (&guioptions =~# 'l') && (&guioptions =~# 'L')
		let a:scrollbar_l_mode = '-'
	else
		let a:scrollbar_l_mode = '+'
	endif
	if &guioptions =~# 'e'
		let a:tab_mode = '-'
	else
		let a:tab_mode = '+'
	endif
	if &guioptions =~# 'g'
		let a:menugrayout_mode = '-'
	else
		let a:menugrayout_mode = '+'
	endif

	let a:input = inputlist(['Execute: ', '[1] ' . a:toolbar_mode     . 'T  [Toolbar             ]',
										\ '[2] ' . a:menubar_mode     . 'm  [Menebar             ]',
										\ '[3] ' . a:scrollbar_r_mode . 'lL [Scrollbar - Right   ]',
										\ '[4] ' . a:scrollbar_l_mode . 'rR [Scrollbar - Left    ]',
										\ '[5] ' . a:tab_mode         . 'e  [GUI TAB             ]',
										\ '[6] ' . a:menugrayout_mode . 'g  [Disable Menu Grayout]'])

	if strlen(a:input) < 1
		echo "Not Found Exec!"
		return
	endif

	if a:input == 1
		call ToggleGuiOptions('T')
	elseif a:input == 2
		call ToggleGuiOptions('m')
	elseif a:input == 3
		call ToggleGuiOptions('r')
	elseif a:input == 4
		call ToggleGuiOptions('l')
	elseif a:input == 6
		call ToggleGuiOptions('g')
	endif
endfunction
command! GuiOptionCtrl call GuiOptionCtrl()

" FUNCTION Toggle Incsearch {{{2
"-----------------------------------------------------------
function! ToggleIncSearch()
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
command! ToggleIncSearch call ToggleIncSearch()

" FUNCTION Select Cmd {{{2
"-----------------------------------------------------------
function! SelectCmd(key)
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

	echohl MoreMsg
	echo '> ' . a:slist[a:input][1]
	echohl None

	execute a:slist[a:input][1]
endfunction

command! -nargs=1 SelectCmd 
	\ call SelectCmd(<q-args>)
" FUNCTION CD {{{2
function! ChangeDirectory(mode)
  let a:cd_path = expand("%:p:h")

  execute a:mode . " " . a:cd_path
  echo ">" . a:mode . " " . a:cd_path
endfunction
command! CurCD call ChangeDirectory('cd')

function! MoveDirectory(mode)
  let a:mv_path = input(">" . a:mode . " " , expand("%:p:h") , "dir")
  echo "\n"
  if strlen(a:mv_path) < 1
    echo "Not Change directory!"
    return
  endif

  if isdirectory(a:mv_path)
    echo "Not Find directory!"
    return
  endif

  execute a:mode . " " . a:mv_path
  echo "Move directory!"
endfunction
command! MoveCD call MoveDirectory('cd')

" }}}1
" vim:set foldenable foldmethod=marker:
