if exists('g:loaded_browse')
  finish
endif

let g:loaded_browse = 1

" browsers - modes and their corresponding command complete function, browsing
" function and pattern match function
let g:browsers = {}

" default browsers
let g:browsers.scriptnames = #{ list: { -> getscriptinfo()->map({ _, f -> f.name }) } }
let g:browsers.oldfiles = #{ list: { -> v:oldfiles } }
let g:browsers.jumps = #{
      \ list: function('browse#jumps#list'),
      \ open: function('browse#jumps#open'),
      \ complete: { -> [] }
      \ }
let g:browsers.tags = #{
      \ list: function('browse#tags#list'),
      \ open: function('browse#tags#open'),
      \ complete: { -> [] }
      \ }
let g:browsers.marks = #{
      \ list: function('browse#marks#list'),
      \ open: function('browse#marks#open'),
      \ complete: { -> [] }
      \ }

" prompt user to choose one item from the list
" return 0 if no selection (can be) made or out of range
function s:choose(list) abort
  if empty(a:list)
    echomsg 'nothing to browse'
    return 0
  endif
  let choice = a:list->copy()->map({ i, x -> $"{i + 1}.\t{x}" })->inputlist()
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
  call get(browser, 'open',
        \ { file -> execute($'confirm edit `={file}`') })(choice)
endfunction

function s:browse_search(mode, pat) abort
  let browser = g:browsers->get(a:mode, 0)
  if browser is 0
    echohl ErrorMsg
    echomsg $"'{a:mode}' is not a valid mode to browse"
    echohl None
    return
  endif
  if browser->get('open') is 0
    let listed = browser.list()->index(a:pat, 0, &ignorecase) != -1
    if !listed
      echohl WarningMsg
      echomsg $"'{a:pat}' is not listed"
      echohl None
    endif
    confirm edit `=a:pat`
  else
    call browser.open(a:pat)
  endif
endfunction

function BrowseMore(...) abort
  if a:0 == 1
    let mode = a:1
    call s:browse(mode)
  else
    let [mode, pat] = a:000[:1]
    call s:browse_search(mode, pat)
  endif
endfunction

command -complete=customlist,browse#complete -nargs=+ BrowseMore call BrowseMore(<f-args>)
