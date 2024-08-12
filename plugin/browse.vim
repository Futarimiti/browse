if exists('g:loaded_browse')
  finish
endif

let g:loaded_browse = 1

" browsers - modes and their corresponding command complete function, browsing
" function and pattern match function
let g:browsers = {}

" prompt user to choose one item from the list
" return 0 if no selection made or out of range
function s:choose(list) abort
  let choice = a:list->copy()->map({ i, x -> $'{i + 1}. {x}' })->inputlist()
  return choice is 0 ? 0 : a:list->get(choice - 1, 0)
endfunction

function s:browse(mode) abort
  let browser = g:browsers->get(a:mode, 0)
  if browser is 0
    echohl ErrorMsg
    echomsg $"'{a:mode}' is not a valid mode to browse"
    echohl None
    return
  endif
  let choice = s:choose(browser.list())
  if choice is 0
    return
  endif
  confirm edit `=choice`
endfunction

function s:browse_search(mode, pat) abort
  let browser = g:browsers->get(a:mode, 0)
  if browser is 0
    echohl ErrorMsg
    echomsg $"'{a:mode}' is not a valid mode to browse"
    echohl None
    return
  endif
  " echo 'browse in' a:mode 'and glob search for' a:pat 'using browser' browser
  let listed = browser.list()->index(a:pat, 0, &ignorecase) != -1
  if !listed
    echohl WarningMsg
    echomsg $"'{a:pat}' is not listed"
    echohl None
  endif

  let open = browser->get('open')
  if open is 0
    confirm edit `=a:pat`
  else
    call open(a:pat)
  endif
endfunction

function Browse(...) abort
  if a:0 == 1
    let mode = a:1
    call s:browse(mode)
  else
    let [mode, pat] = a:000[:1]
    call s:browse_search(mode, pat)
  endif
endfunction

command -complete=customlist,browse#complete -nargs=+ Browse call Browse(<f-args>)
