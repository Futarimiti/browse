# browse

<img src='https://github.com/user-attachments/assets/76d4f8c9-1bc9-4848-a847-db289db7478c' width='640' height='106' alt='We have so much to browse: oldfiles, scriptnames, jumplist, tags, marks... why can we only have :browse oldfiles?'/>


* browse scriptnames, jumplist, tags, marks, similar to `:browse oldfiles`
  (ask for a number), tab completion supported

```vim
:Browse scriptnames
:Browse oldfiles
" not yet
" :Browse jumplist
" :Browse tags
" :Browse marks
" :Browse changes
```

* or use glob patterns, tab completion/expand supported

not a `:browse oldfiles` feature, i just feel i need this

```vim
:Browse scriptnames pack
:Browse oldfiles **/*.hs
```

or use some keymaps (diy)

```vim
nnoremap <localleader>s :Browse scriptnames 
```

### extend

you can fork this and hardcode your browsers

alternatively add them to `g:browsers`

<!-- todo: add key-type lookup table, maybe example -->

```vim
let g:browsers.my_browser = #{
    \   list: function('list_all_entries'),  " compulsory
    \   open: function('how_to_open_pattern'),  " optional, default conf edit
    \   complete: function('customise_tab_completion')  " optional, default search in browser.list()
    \ }
```
### limitations

* the full command is not `:Browse` but actually `:BrowseMore`
  otherwise [`:GBrowse` fucking dies](https://github.com/tpope/vim-fugitive/blob/master/autoload/fugitive.vim#L7432)
  though you can use `:Browse` given there are no conflicting commands

### license

wtfpl
