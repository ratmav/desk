" desk#utils#BookName: set the book name. {{{
function! desk#utils#BookName(name) abort
  call ctrlspace#tabs#SetTabLabel(tabpagenr(), a:name, 0)
  redraw!
endfunction
" }}}
