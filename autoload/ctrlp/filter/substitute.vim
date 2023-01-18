scriptencoding utf-8

function! ctrlp#filter#substitute#do(pat, sub, flags, line) abort
  return substitute(a:line, a:pat, a:sub, a:flags)
endfunction

