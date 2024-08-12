# browse

browse scriptnames, jumplist, tags, marks, similar to `:browse oldfiles`
(ask for a number), tab completion supported

```vim
:Browse scriptnames
" not yet
" :Browse oldfiles
" :Browse jumplist
" :Browse tags
" :Browse marks
" :Browse changes
```

or use glob patterns, tab completion/expand supported

```vim
:Browse scriptnames pack
" :Browse oldfiles **/*.hs
```

or use some keymaps (diy)

```vim
nnoremap <localleader>s :Browse scriptnames 
```

### extend

add custom browsers to `g:browsers`

<!-- todo: add key-type lookup table, maybe example -->

```vim
let g:browsers.my_browser = #{
    \   list: function('list_all_entries'),  " compulsory
    \   open: function('how_to_open_pattern'),  " optional, default conf edit
    \   complete: function('customise_tab_completion')  " optional, default search in browser.list()
    \ }
```

alternatively fork this hardcode your browsers

### license

wtfpl
