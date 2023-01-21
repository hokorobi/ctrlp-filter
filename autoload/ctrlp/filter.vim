function! ctrlp#filter#do(ctrlp, params={}) abort
  let s:ctrlp_open_func_back = get(g:, 'ctrlp_open_func', {})
  let g:ctrlp_open_func = { get(a:params, 'kind', 'files'): get(a:params, 'openfunc', s:getdefaultopenfunc(a:params)) }
  let s:ctrlp_filter_params = a:params
  try
    execute join(extend([a:ctrlp], get(a:params, 'ctrlpargs', [])))
  finally
    let g:ctrlp_open_func = s:ctrlp_open_func_back
  endtry
endfunction
function! s:getdefaultopenfunc(params) abort
  return get(a:params, 'filtermethods', [])->get(-1, '') ==# 'execute' ? 'ctrlp#filter#execute' : 'ctrlp#filter#paste'
endfunction

function! ctrlp#filter#filtermethods(line) abort
  let result = a:line
  for method in get(s:ctrlp_filter_params, 'filtermethods', [])
    let Method = function(method, get(s:ctrlp_filter_params.methodsargs, method, []))
    let result = result->Method()
  endfor
  return result
endfunction

" action
function! ctrlp#filter#execute(action, line) abort
  call ctrlp#exit()

  execute(ctrlp#filter#filtermethods(a:line))
endfunction

function! ctrlp#filter#paste(action, line) abort
  call ctrlp#exit()

  let backregz = getreg('z')
  try
    call setreg('z', ctrlp#filter#filtermethods(a:line))
    noautocmd normal! "zp
  finally
    call setreg('z', backregz)
  endtry
endfunction

