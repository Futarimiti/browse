function browse#marks#list() abort
  return execute('marks')->split('\n')[1:]
endfunction

function browse#marks#open(pat) abort
  for line in browse#marks#list()
    if line is a:pat
      let dest = line->split()[0]->str2nr()
      execute $"normal! '{dest}"
      return
    endif
  endfor
  echohl WarningMsg
  echomsg $"'{a:pat}' is not listed"
  echohl None
endfunction
