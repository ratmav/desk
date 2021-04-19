desk
====

sugar for vim buffer, window, tab, and file management.

## model

desk provides commands to help manage multiple projects in a single vim instance by grouping windows, buffers, and files under tabs, where a project is a local file directory/cloned source code repository. desk makes it possible to swap projects as "books", where things like the tree view, page name search, etc. are scoped by a given book.

tabs have a...storied history, and may not be useful for everyone. it's _highly recommended_ that users become proficient with default vim buffer and window behavior **first**, i.e. get used to using only buffers and windows. after that point, the default tab behavior may be interesting and useful to play with. finally, once the **default** vim buffer/window/tab model and use cases are well understood, desk may be a good convenience wrapper.

for a starting point, here's a high-level overview of the default vim model:

* buffers are an in-memory representation of a file on disk. vim reads a file and loads the content into a buffer.
* windows are a viewport for buffers. they can be opened, quit, split, and moved.
* tabs are _groups of windows_. this is important: vim tabs **do not** behave like tabs in other applications.

here's how desk's model and nomenclature fits in:

* a "book" is a tab, roughly.
  * file trees are scoped by book.
  * books can by searched by name
    * books are named by the last file path component.
* windows are windows.
  * windows are grouped by book.
* a "page" is a buffer.
  * pages are grouped by book.
  * pages are named after their respective files, just like regular vim.
  * pages can be seached by name

## installation

use git or your plugin manager of choice to install desk.

### dependencies

currently, desk leans on several other vim plugins. install the following:

* [vim-ctrlspace](https://github.com/vim-ctrlspace/vim-ctrlspace)
* [nerdtree](https://github.com/preservim/nerdtree)
* [ctrlp](https://github.com/ctrlpvim/ctrlp.vim)
* [vim-bufkill](https://github.com/qpkorr/vim-bufkill)

over time, these dependencies should (hopefully) be removed.

## configuration

add the following to your vim configuration:

```viml
" desk {{{
set nocompatible
set hidden
set encoding=utf-8
" }}}
```

### commands and default keybindings

`Ctrl-d`(esk) -> `command`: description:

* `<C-d>n` -> `DeskBookNew`: open a (n)ew book.
* `<C-d>l` -> `DeskBookNext`: change focus to the (n)ext book on the right.
* `<C-d>h` -> `DeskBookPrevious`: change focus to the (p)revious book on the left.
* `<C-d>q` -> `DeskBookQuit`: (q)uit/close a book.
* `<C-d>b` -> `DeskBookRebind`: re(b)ind an open book, i.e. move to a new working directory.
* `<C-d>r` -> `DeskBookRename`: (r)ename a book.
* `<C-d>t` -> `DeskBookTreeToggle`: toggle book (t)ree view.
* `<C-d>c` -> `DeskRefreshCache`: refreshes the book tree and file search (c)ache.
* `<C-d>s` -> `DeskSearchBookNames`: (s)earch books by name.
* `<C-d>s` -> `DeskSearchBookPageNames`: search book (p)ages by name.

## complimentary plugins

[vim-airline](https://github.com/vim-airline/vim-airline), with tabline enabled, has been useful for providing visual queues such as current book/working directory/git branch/buffer.

## acknowledgements

* [the vim-ctrlspace contributors and maintainers](https://github.com/vim-ctrlspace/vim-ctrlspace/graphs/contributors)
* [the nerdtree contributors and maintainers](https://github.com/preservim/nerdtree/graphs/contributors)
* [the ctrlp maintainers](https://github.com/ctrlpvim/ctrlp.vim)
* [the vim-bufkill contributors and maintainers](https://github.com/qpkorr/vim-bufkill/graphs/contributors)
* [steve losh's](https://stevelosh.com/) book, [learn vimscript the hard way](https://learnvimscriptthehardway.stevelosh.com/), was a great and useful read.
