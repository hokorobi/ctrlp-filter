scriptencoding utf-8

function! ctrlp#action#paste#do(action, line) abort
  call ctrlp#exit()

  let filterfunc = get(g:ctrlp_filter_params, 'filterfunc', '')
  if filterfunc ==# ''
    let result = a:line
  else
    " let func = function(filterfunc, extend([a:line], get(g:ctrlp_filter_params, 'filterargs', [])))
    let Func = function(filterfunc, get(g:ctrlp_filter_params, 'filterargs', []))
    let result = Func(a:line)
  endif

  let backregz = getreg('z')
  call setreg('z', result)
  noautocmd normal! "zp
  call setreg('z', backregz)

  let g:ctrlp_open_func = {}
endfunction

