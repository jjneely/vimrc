" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Tabs are 4 spaces unless otherwise defined
set shiftwidth=4
set expandtab
set ts=4
set smarttab
set backspace=indent,eol,start
set laststatus=2
set ruler
set showcmd
set showmatch
set wildmenu
set wildmode=longest:list,full
set incsearch
set autoindent
set autoread
set history=1000
set tabpagemax=50
set scrolloff=10
set hidden " Allow switching buffers without saving
set shell=/bin/bash
set hlsearch " Hightlight Search

syntax on

" Mouse actions take us to Visual mode and do expected selections provided
" we are not in Insert mode.  Auto copy visual selected text to the system
" clipboard (*).
set mouse=nv
set clipboard=autoselect,exclude:cons\|linux

" Change the direction of new splits to be more natural.
set splitbelow
set splitright

" colors, 16 colors scheme to match shell
set bg=dark " Dark background
colorscheme noctu

" Hit F2 in insert mode to past text without auto-indent
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" F3 to remove all trailing whitespace
nnoremap <silent> <F3> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" F4 to clear search highlight and set the highlight to be annoying
nnoremap <silent> <F4> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><F4>
highlight IncSearch cterm=NONE ctermfg=black ctermbg=yellow
highlight Search cterm=NONE ctermfg=yellow ctermbg=black
highlight Visual cterm=NONE ctermfg=black ctermbg=blue

" Pop open a Terminal
nnoremap <silent> <F5> :vert terminal<CR>

" netrw (file browser) settings -- :Vex :Sex :edit .
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 2
let g:netrw_winsize = 25
let g:netrw_altv = 1

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

" Show overlengh lines > 80 columns
set colorcolumn=80

" Highlight the current line
"set cursorline

" Line numbering
"set number
set relativenumber " relative line numbers!

"set path for file searching
set path=.,**
set tags=./tags;,.git/tags;,./TAGS,tags,TAGS

" ctags and tags (brew install ctags on macos)
command! MakeTags !ctags -R .

" Autocomplete out of the box notes
" ^N -- autocomplete
" ^X^F -- autocomplete file names
" ^X^] -- autocomplate tags
" ^X^N -- autocomplete from just this file
" Navigation: ^N and ^P

" Highlight extra whitespace
" The following alternative may be less obtrusive.
highlight ExtraWhitespace ctermbg=1 ctermfg=5
autocmd BufWritePre * :%s/\s\+$//e "trim trailing whitespace on write

" Show trailing whitespace:
call matchadd('ExtraWhitespace', '\s\+\%#\@<!$', 11)
autocmd InsertLeave * redraw!

" Work with Makefiles
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0 tw=0
autocmd FileType go set noexpandtab shiftwidth=4 softtabstop=0 tw=0
autocmd FileType template set tw=0
autocmd FileType yaml set tw=0
autocmd FileType dockerfile set tw=0
autocmd FileType gitcommit set tw=78
