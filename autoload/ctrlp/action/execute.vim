scriptencoding utf-8

function! ctrlp#action#execute#do(action, line) abort
  call ctrlp#exit(a:line)

  execute(ctrlp#filter#filterfunc())

  let g:ctrlp_open_func = {}
endfunction

