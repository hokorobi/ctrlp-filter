scriptencoding utf-8

function! ctrlp#action#paste#do(action, line) abort
  call ctrlp#exit()

  let backregz = getreg('z')
  call setreg('z', ctrlp#filter#filtermethods(a:line))
  noautocmd normal! "zp
  call setreg('z', backregz)
endfunction

