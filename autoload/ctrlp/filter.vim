scriptencoding utf-8

" Example:
" call ctrlp#filter#do('CtrlP', #{filtermethods: ['printf', 'execute'], filtersargs: #{printf: ['GinBuffer log --all --graph -100 --oneline --decorate %s']}, openfunc: 'ctrlp#action#execute#do'})
" call ctrlp#filter#do('CtrlP', #{filtermethods: ['substitute'], filtersargs: #{substitute: ['\\', '/', 'g']}})
" call ctrlp#filter#do('CtrlP', #{filtermethods: ['substitute', 'printf'], filtersargs: #{substitute: ['\\', '/', 'g'], printf: ['.. figure:: %s']}})
function! ctrlp#filter#do(ctrlp, params) abort
  if exists(":" .. a:ctrlp) != 2
    echohl WarningMsg | echomsg a:ctrlp .. ": 存在しないコマンドです。" | echohl None
    return
  endif
  let openfunc = get(a:params, 'openfunc', 'ctrlp#action#paste#do')
  if !s:existsfunc(openfunc)
    return
  endif
  if !s:existsfunc(get(a:params, 'filterfunc', ''))
    return
  endif

  let g:ctrlp_filter_params = a:params
  let g:ctrlp_open_func = { get(a:params, 'kind', 'files'): openfunc }
  execute join(extend([a:ctrlp], get(a:params, 'ctrlpargs', [])))
endfunction
function! s:existsfunc(func) abort
  if a:func ==# ''
    return v:true
  endif

  if exists("?" .. a:func)
    echohl WarningMsg | echomsg a:func .. ": 存在しない関数です。" | echohl None
    return v:false
  endif
  return v:true
endfunction

function! ctrlp#filter#filtermethods(line) abort
  let filtermethods = get(g:ctrlp_filter_params, 'filtermethods', [])
  let result = a:line
  if len(filtermethods) > 0
    for method in filtermethods
      let Method = function(method, get(g:ctrlp_filter_params.filtersargs, method, []))
      let result = result->Method()
      echom result
    endfor
  endif
  return result
endfunction
