scriptencoding utf-8

function! ctrlp#action#execute#do(action, line) abort
  call ctrlp#exit()

  let filterfunc = get(g:ctrlp_filter_params, 'filterfunc', '')
  if filterfunc ==# ''
    let result = a:line
  else
    let Func = function(filterfunc, get(g:ctrlp_filter_params, 'filterargs', []))
    let result = Func(a:line)
  endif

  execute(result)
  let g:ctrlp_open_func = {}
endfunction

