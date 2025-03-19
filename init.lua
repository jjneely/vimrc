require "jjneely.options"
require "jjneely.keymaps"
require "jjneely.plugins"
--require "jjneely.cmp"

require "jjneely.colors"

vim.cmd [[
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Go go gadget spell checking!
" Set spell check on for unknow files
autocmd BufRead,BufNewFile * if &ft == '' | set spell spelllang=en_us | endif
 " spell check text files
autocmd FileType text setlocal spell  spelllang=en_us
autocmd FileType markdown setlocal spell  spelllang=en_us
set spellfile=~/.vim/spell.en_us.add
" zg to add word to word list
" zw to reverse
" zug to remove word from word list
" z= to get list of possibilities

autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0 tw=0
autocmd FileType go set noexpandtab shiftwidth=4 softtabstop=0 tw=0
autocmd FileType template set tw=0
autocmd FileType yaml set tw=0
autocmd FileType dockerfile set tw=0
autocmd FileType gitcommit set tw=78
autocmd FileType markdown set tw=78
]]
