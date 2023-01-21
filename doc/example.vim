
call ctrlp#filter#do('CtrlP', #{filtermethods: ['printf', 'execute'], methodsargs: #{printf: ['GinBuffer log ++opener=tabnew --all --graph -100 --oneline --decorate %s']}})
call ctrlp#filter#do('CtrlP', #{filtermethods: ['substitute'], methodsargs: #{substitute: ['\\', '/', 'g']}})
call ctrlp#filter#do('CtrlP', #{filtermethods: ['substitute', 'printf'], methodsargs: #{substitute: ['\\', '/', 'g'], printf: ['.. figure:: %s']}})
