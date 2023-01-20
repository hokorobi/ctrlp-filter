scriptencoding utf-8

" Example:
" call ctrlp#filter#do('CtrlP', #{filtermethods: ['printf', 'execute'], methodsargs: #{printf: ['GinBuffer log ++opener=tabnew --all --graph -100 --oneline --decorate %s']}, openfunc: 'ctrlp#filter#execute'})
" call ctrlp#filter#do('CtrlP', #{filtermethods: ['substitute'], methodsargs: #{substitute: ['\\', '/', 'g']}})
" call ctrlp#filter#do('CtrlP', #{filtermethods: ['substitute', 'printf'], methodsargs: #{substitute: ['\\', '/', 'g'], printf: ['.. figure:: %s']}})
function! ctrlp#filter#do(ctrlp, params) abort
  let g:ctrlp_open_func_back = g:ctrlp_open_func
  let g:ctrlp_filter_params = a:params
  let g:ctrlp_open_func = { get(a:params, 'kind', 'files'): get(a:params, 'openfunc', 'ctrlp#action#paste#do') }
  try
    execute join(extend([a:ctrlp], get(a:params, 'ctrlpargs', [])))
  finally
    let g:ctrlp_open_func = g:ctrlp_open_func_back
  endtry
endfunction

function! ctrlp#filter#filtermethods(line) abort
  let result = a:line
  for method in get(g:ctrlp_filter_params, 'filtermethods', [])
    let Method = function(method, get(g:ctrlp_filter_params.methodsargs, method, []))
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

