" fourohfour.vim - lookup HTTP status codes without leaving Vim
" Author: Josh Branchaud (joshbranchaud.com)


if exists('g:loaded_fourohfour')
  finish
endif
let g:loaded_fourohfour = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:HTTPStatusCodes()
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
        \ '304': 'Not Modified',
        \ '305': 'Use Proxy',
        \ '306': 'Switch Proxy',
        \ '307': 'Temporary Redirect',
        \ '308': 'Permanent Redirect',
        \ '400': 'Bad Request',
        \ '401': 'Unauthorized',
        \ '402': 'Payment Required',
        \ '403': 'Forbidden',
        \ '404': 'Not Found',
        \ '405': 'Method Not Allowed',
        \ '406': 'Not Acceptable',
        \ '407': 'Proxy Authentication Required',
        \ '408': 'Request Timeout',
        \ '409': 'Conflict',
        \ '410': 'Gone',
        \ '411': 'Length Required',
        \ '412': 'Precondition Failed',
        \ '413': 'Payload Too Large',
        \ '414': 'URI Too Long',
        \ '415': 'Unsupported Media Type',
        \ '416': 'Range Not Satisfiable',
        \ '417': 'Expectation Failed',
        \ '418': 'I''m a teapot',
        \ '421': 'Misdirected Request',
        \ '422': 'Unprocessable Entity',
        \ '423': 'Locked',
        \ '424': 'Failed Dependency',
        \ '426': 'Upgrade Required',
        \ '428': 'Precondition Required',
        \ '429': 'Too Many Requests',
        \ '431': 'Request Header Fields Too Large',
        \ '451': 'Unavailable For Legal Reasons',
        \ '500': 'Internal Server Error',
        \ '501': 'Not Implemented',
        \ '502': 'Bad Gateway',
        \ '503': 'Service Unavailable',
        \ '504': 'Gateway Timeout',
        \ '505': 'HTTP Version Not Supported',
        \ '506': 'Variant Also Negotiates',
        \ '507': 'Insufficient Storage',
        \ '508': 'Loop Detected',
        \ '510': 'Not Extended',
        \ '511': 'Network Authentication Required'
        \}
endfunction

function! s:FilterByKeys(dict, pattern)
  let filtered_dict = {}
  for [key,val] in items(a:dict)
    if key =~ a:pattern
      let filtered_dict[key] = val
    endif
  endfor
  return filtered_dict
endfunction

function! s:LoadStatusCodes()
  if !exists('g:fourohfour_status_codes')
    let g:fourohfour_status_codes = s:HTTPStatusCodes()
  endif
  return g:fourohfour_status_codes
endfunction

function! s:LookupHTTPStatus(...) abort
  if a:0 ==# 0
    echo 'No arguments provided'
  else
    let status_codes = s:LoadStatusCodes()
    if has_key(status_codes, a:1)
      echo a:1." - ".status_codes[a:1]
    else
      let first_char = strpart(a:1, 0, 1)
      let filtered_statuses = s:FilterByKeys(status_codes, "^".first_char)
      if !empty(filtered_statuses)
        echo "No entry for ".a:1.", but maybe you are looking for one of these:"
        for [key,val] in items(filtered_statuses)
          echo "* ".key." - ".val
        endfor
      else
        echo "No entry for ".a:1
      endif
    endif
  endif
endfunction

function! s:LookupHTTPStatusUnderCursor() abort
  call s:LookupHTTPStatus( expand('<cword>') )
endfunction

command! -nargs=* FOF call s:LookupHTTPStatus( '<args>' )

nnoremap <leader>k :call s:LookupHTTPStatusUnderCursor()<cr>


let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set sw=2 sts=2:
