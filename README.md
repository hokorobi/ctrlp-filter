## 概要

*ctrlp-filter* は CtrlP コマンドの結果を加工するためのプラグイン。

最新版: https://github.com/hokorobi/ctrlp-filter.vim


## 使い方

例1: CtrlP で選択したファイルをバッファに挿入。

```vim
:call ctrlp#filter#do('CtrlP')
```

例2: CtrlP で選択したファイルの \ を / に変換後、先頭に .. figure:: を追加してバッファに挿入。
filtermethods に与えたリストのメソッドを順番に実行し、結果を順に渡す。

```vim
:call ctrlp#filter#do('CtrlP', #{
\   filtermethods: ['substitute', 'printf'],
\   methodsargs: #{
\     substitute: ['\\', '/', 'g'],
\     printf: ['.. figure:: %s'],
\   },
\ })
```

例3: CtrlP で選択したファイルを ExampleCommand の引数として実行。

```vim
:call ctrlp#filter#do('CtrlP', #{
\   filtermethods: ['printf', 'execute'],
\   methodsargs: #{
\     printf: ['ExampleCommand %s'],
\   },
\ })
```
