scriptencoding utf-8


" call ctrlp#filter#do('CtrlP', #{filterfunc: 'ctrlp#filter#affix#do', filterargs: ['prefix', 'suffix']})
" call ctrlp#filter#do('CtrlP', #{filterfunc: 'ctrlp#filter#substitute#do', filterargs: ['\\', '/', 'g']})
" TODO: filtersfuncs: ['substitute', 'affix'], filtersargs: {substitute: [], affix: []}
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

function! ctrlp#filter#filterfunc(line) abort
  let filterfunc = get(g:ctrlp_filter_params, 'filterfunc', '')
  if filterfunc ==# ''
    let result = a:line
  else
    let Func = function(filterfunc, get(g:ctrlp_filter_params, 'filterargs', []))
    let result = Func(a:line)
  endif
  return result
endfunction
