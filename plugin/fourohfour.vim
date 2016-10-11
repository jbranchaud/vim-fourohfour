" fourohfour.vim - lookup HTTP status codes without leaving Vim
" Author: Josh Branchaud (joshbranchaud.com)


if exists('g:loaded_fourohfour')
  finish
endif
let g:loaded_fourohfour = 1

function! HTTPStatusCodes()
  return {
        \ '100': 'Continue',
        \ '101': 'Switching Protocols',
        \ '102': 'Processing',
        \ '200': 'OK',
        \ '201': 'Created',
        \ '202': 'Accepted',
        \ '203': 'Non-Authoritative Information',
        \ '204': 'No Content',
        \ '205': 'Reset Content',
        \ '206': 'Partial Content',
        \ '207': 'Multi-Status',
        \ '208': 'Already Reported',
        \ '226': 'IM Used',
        \ '300': 'Multiple Choices',
        \ '301': 'Moved Permanently',
        \ '302': 'Found',
        \ '303': 'See Other',
        \ '304': 'Not Modified'
        \}
endfunction

function! LookupHTTPStatus(...) abort
  if a:0 ==# 0
    echo 'No arguments provided'
  else
    echo a:1." - ".HTTPStatusCodes()[a:1]
  endif
endfunction

command! -nargs=* FOF call LookupHTTPStatus( '<args>' )

" vim:set sw=2 sts=2:
