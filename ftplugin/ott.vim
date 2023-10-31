if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal comments=:%
setlocal commentstring=%%s
setlocal iskeyword=A-Z,a-z,48-57,_,'

let b:undo_ftplugin = 'setlocal comments< commentstring< iskeyword<'

let &cpo = s:save_cpo
unlet s:save_cpo
