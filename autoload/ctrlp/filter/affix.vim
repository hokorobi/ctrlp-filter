scriptencoding utf-8

function! ctrlp#filter#affix#do(prefix, suffix, line) abort
  return join([a:prefix, a:line, a:suffix], '')
endfunction

