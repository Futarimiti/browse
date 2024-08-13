function browse#jumps#list() abort
  return execute('jumps')->split('\n')[1:]->filter({_, e -> e isnot '>'})
endfunction

function browse#jumps#open(pat) abort
  let forward = v:false
  for line in browse#jumps#list()
    if line is a:pat
      let jump = line->substitute('^>', '', '')->split()[0]->str2nr()
      execute $'normal! {jump}{forward ? "\<C-I>" : "\<C-O>"}'
      return
    elseif line =~ '^>'
      let forward = v:true
    endif
  endfor
  echohl WarningMsg
  echomsg $"'{a:pat}' is not listed"
  echohl None
endfunction
