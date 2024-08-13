function browse#complete(arglead, cmdline, _) abort
  let args = a:cmdline
        \->substitute('\v^.*B%[rowseMore]', '', '')
        \->split()
  if len(args) == 0
    return s:complete_mode('')
  elseif len(args) == 1
    let [mode] = args
    if a:cmdline =~ '\s$'
      return s:complete_pat(mode, '')
    else
      return s:complete_mode(mode)
    endif
  elseif len(args) == 2 && a:cmdline !~ '\s$'
    let [mode, pat] = args
    return s:complete_pat(mode, pat)
  else
    return []
  endif
endfunction

function s:complete_mode(what) abort
  return g:browsers
        \->keys()
        \->copy()
        \->filter({ _, mode -> match(mode, a:what) == 0 })
endfunction

" complete the search pattern.
" if the browser supplies custom complete method, use that
" otherwise regard the search pattern as glob pattern
" and search in browser.list().
function s:complete_pat(mode, pattern) abort
  let browser = g:browsers->get(a:mode, #{ list: { -> [] } })
  return browser->get('complete', { globpat -> browser.list()->filter({ _, item -> item =~ glob2regpat(globpat .. '*') }) })(a:pattern)
endfunction
