" desk#commands#BookName: set the book name. {{{
function! desk#commands#BookName(name) abort
  call ctrlspace#tabs#SetTabLabel(tabpagenr(), a:name, 0)
  redraw!
endfunction
" }}}

" desk#commands#BookNew: start a new book. {{{
function! desk#commands#BookNew() abort
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

" desk#commands#BookNext: change focus to next book on right. {{{
function! desk#commands#BookNext() abort
  tabnext
endfunction
" }}}

" desk#commands#BookPrevious: change focus to previous book on left. {{{
function! desk#commands#BookPrevious() abort
  tabprevious
endfunction
" }}}

" desk#commands#BookQuit: quit/close a book. {{{
function! desk#commands#BookQuit() abort
  if tabpagenr("$") == 1
    echo "rebind the remaining book, or quit"
  else
    call ctrlspace#tabs#CloseTab()
    echo "closed " . getcwd() . " book"
  end
endfunction
" }}}

" desk#commands#BookRebind: rebind an open book, i.e. move to a new working directory. {{{
function! desk#commands#BookRebind() abort
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

" desk#commands#BookRename: rename a book. {{{
function! desk#commands#BookRename() abort
  call inputsave()
  let name = input("new book name: ")
  call inputrestore()
  if name != ""
    call DeskBookName(name)
  end
endfunction
" }}}

" desk#commands#BookTreeToggle: toggle book tree view. {{{
function! desk#commands#BookTreeToggle() abort
  call g:NERDTreeCreator.ToggleTabTree(".")
endfunction
" }}}

" desk#commands#Init: opens and names initial book on startup. {{{
function! desk#commands#Init() abort
  " TODO: the vim-ctrlspace file search complains about
  " the project root not being set if vim is opened in a directory
  " without a .git, etc. directory, i.e. if ctrlspace#roots#FindProjectRoot()
  " comes back empty. need the just set it to whatever the tcd is.
  " a 'project root not set'   " set the book name to the last dir on path
  call BookName(fnamemodify(getcwd(), ':t\'))
endfunction
" }}}

" desk#commands#RefreshCache: refresh the tree and file search cache. {{{
function! desk#commands#RefreshCache() abort
  call g:NERDTree.ForCurrentTab().getRoot().refresh()
  call ctrlspace#files#RefreshFiles()
endfunction
" }}}

" desk#commands#SearchBookNames: search books by name. {{{
function! desk#commands#SearchBookNames() abort
  execute 'CtrlSpace L'
endfunction
" }}}

" desk#commands#SearchPageNames: search book pages by name. {{{
function! desk#commands#SearchPageNames() abort
  "" using pure vimscript (probably glob) for search and ignore logic
  "" like ctrlp would be nice.
  execute 'CtrlSpace O'
endfunction
" }}}
