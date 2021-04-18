function! desk#init#Init() abort
  " os detection for vim-ctrlspace {{{
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

  " use the default vim-ctrlspace mapping key.
  let g:CtrlSpaceDefaultMappingKey = "<C-space> "

  " show hidden files in the tree.
  let g:NERDTreeShowHidden=1

  " TODO: the vim-ctrlspace file search complains about
  " the project root not being set if vim is opened in a directory
  " without a .git, etc. directory, i.e. if ctrlspace#roots#FindProjectRoot()
  " comes back empty. need the just set it to whatever the tcd is.
  " a 'project root not set'   " set the book name to the last dir on path
  "
  " opens and names initial book on startup.
  call desk#utils#BookName(fnamemodify(getcwd(), ':t\'))

  " define end-user commands.
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
