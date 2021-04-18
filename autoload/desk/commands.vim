" BookName: set the book name. {{{
function! BookName(name)
  call ctrlspace#tabs#SetTabLabel(tabpagenr(), a:name, 0)
  redraw!
endfunction
" }}}

" BookNew: start a new book. {{{
function! BookNew()
  call inputsave()
  let path = input("new book path: ", "", "file")
  call inputrestore()

  " check that path exists
  if !empty(glob(path))
    " create tab and set tab current directory
    tabnew
    execute ":tcd " . path

    " set vim-ctrlspace project root
    call ctrlspace#roots#SetCurrentProjectRoot(path)

    " set the book name to the last dir on path
    call BookName(fnamemodify(getcwd(), ':t\'))
  else
    redraw!
    echo "invalid book path"
  end
endfunction
" }}}

" BookNext: change focus to next book on right. {{{
function! BookNext()
  tabnext
endfunction
" }}}

" BookPrevious: change focus to previous book on left. {{{
function! BookPrevious()
  tabprevious
endfunction
" }}}

" BookQuit: quit/close a book. {{{
function! BookQuit()
  if tabpagenr("$") == 1
    echo "rebind the remaining book, or quit"
  else
    call ctrlspace#tabs#CloseTab()
    echo "closed " . getcwd() . " book"
  end
endfunction
" }}}

" BookRebind: rebind an open book, i.e. move to a new working directory. {{{
function! BookRebind()
  call inputsave()
  let path = input("bind book to: ", "", "file")
  call inputrestore()

  " check that path exists
  if !empty(glob(path))
    " close all buffers
    silent tabdo %bd!

    " create tab and set tab current directory
    execute ":tcd " . path

    " set vim-ctrlspace project root
    call ctrlspace#roots#SetCurrentProjectRoot(path)

    " set the book name to the last dir on path
    call BookName(fnamemodify(getcwd(), ':t\'))
  else
    redraw!
    echo "invalid book path"
  end
endfunction
" }}}

" BookRename: rename a book. {{{
function! BookRename()
  call inputsave()
  let name = input("new book name: ")
  call inputrestore()
  if name != ""
    call DeskBookName(name)
  end
endfunction
" }}}

" BookTreeToggle: toggle book tree view. {{{
function! BookTreeToggle()
  call g:NERDTreeCreator.ToggleTabTree(".")
endfunction
" }}}

" Init: opens and names initial book on startup. {{{
function! Init()
  " TODO: the vim-ctrlspace file search complains about
  " the project root not being set if vim is opened in a directory
  " without a .git, etc. directory, i.e. if ctrlspace#roots#FindProjectRoot()
  " comes back empty. need the just set it to whatever the tcd is.
  " a 'project root not set'   " set the book name to the last dir on path
  call BookName(fnamemodify(getcwd(), ':t\'))
endfunction
" }}}

" RefreshCache: refresh the tree and file search cache. {{{
function! RefreshCache()
  call g:NERDTree.ForCurrentTab().getRoot().refresh()
  call ctrlspace#files#RefreshFiles()
endfunction
" }}}

" SearchBookNames: search books by name. {{{
function! SearchBookNames()
  execute 'CtrlSpace L'
endfunction
" }}}

" SearchPageNames: search book pages by name. {{{
function! SearchPageNames()
  "" using pure vimscript (probably glob) for search and ignore logic
  "" like ctrlp would be nice.
  execute 'CtrlSpace O'
endfunction
" }}}
