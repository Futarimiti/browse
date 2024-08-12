function browse#scriptnames#list()
  return getscriptinfo()->map({ _, f -> f.name })
endfunction
