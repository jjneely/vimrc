vim.cmd [[
    match errorMsg /\s\+$/
    set background=dark
    try
      colorscheme darkplus
      hi Normal ctermbg=NONE guibg=NONE
      hi LineNr ctermfg=7 guifg=normal
      hi LineNrAbove ctermfg=11 guifg=#808080
      hi LineNrBelow ctermfg=11 guifg=#808080
    catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
    endtry
]]
