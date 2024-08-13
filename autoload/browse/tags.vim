function browse#tags#list() abort
  return gettagstack().items->map({_,tag->$"{tag.matchnr} {tag.tagname}"})
endfunction

function browse#tags#open(pat) abort
  let forward = v:false
  for line in browse#tags#list()
    if line is a:pat
      let [matchnr, tagname] = line->split()
      execute $'{str2nr(matchnr)}tag {tagname}'
      return
    endif
  endfor
  echohl WarningMsg
  echomsg $"'{a:pat}' is not listed"
  echohl None
endfunction
