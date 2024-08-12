# browse

browse scriptnames, jumplist, tags, marks, similar to `:browse oldfiles`
(ask for a number)

```vim
:Browse oldfiles
:Browse scriptnames
:Browse jumplist
:Browse tags
:Browse marks
:Browse changes
```

or use glob patterns, tab completions supported

```vim
:Browse scriptnames pack
:Browse oldfiles **/*.hs
```

or use some keymaps (diy)

```vim
nnoremap <localleader>s :Browse scriptnames 
```

### license

wtfpl
