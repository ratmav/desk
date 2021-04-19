" desk#init#DetectOS: detect operating system {{{
function! desk#init#DetectOS() abort
  if has("win64") || has("win32") || has("win16")
      let s:vimfiles = "~/AppData/Local/nvim"
      let s:os = "windows"
  else
      let s:vimfiles = "~/.config/nvim"
      if has("mac")
        let s:os = "darwin"
      else
        let s:os = "linux"
      endif
  endif
endfunction
"}}}

function! desk#init#Init() abort
  call desk#init#DetectOS()

  " nvim workaround: use the default vim-ctrlspace mapping key.
  let g:CtrlSpaceDefaultMappingKey = "<C-space> "

  " show hidden files in the tree.
  let g:NERDTreeShowHidden=1

  " opens and names initial book on startup.
  call desk#utils#BookName(fnamemodify(getcwd(), ':t\'))

  call desk#init#Commands()
endfunction

" desk#init#Commands: set user commands {{{
function! desk#init#Commands() abort
  command! DeskBookNew :call desk#commands#BookNew()
  command! DeskBookNext :call desk#commands#BookNext()
  command! DeskBookPrevious :call desk#commands#BookPrevious()
  command! DeskBookQuit :call desk#commands#BookQuit()
  command! DeskBookRebind :call desk#commands#BookRebind()
  command! DeskBookRename :call desk#commands#BookRename()
  command! DeskBookTreeToggle :call desk#commands#BookTreeToggle()
  command! DeskRefreshCache :call desk#commands#RefreshCache()
  command! DeskSearchBookNames :call desk#commands#SearchBookNames()
  command! DeskSearchBookPageNames :call desk#commands#SearchBookPageNames()
endfunction
" }}}
