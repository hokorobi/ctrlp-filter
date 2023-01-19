scriptencoding utf-8

function! ctrlp#action#execute#do(action, line) abort
  call ctrlp#exit()

  execute(ctrlp#filter#filtermethods(a:line))

  let g:ctrlp_open_func = {}
endfunction

