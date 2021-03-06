" don't bother with vi compatibility
set nocompatible

" Disable the ruby docs popups.
:set noballooneval

" Enable syntax highlighting
syntax enable

" Sensible editor defaults
set autoindent
set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set clipboard=unnamed                                        " yank and paste with the system clipboard
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab                                                " expand tabs to spaces
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫
set number                                                   " show line numbers
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set shiftwidth=2                                             " normal mode indentation commands use 2 spaces
set showcmd
set smartcase                                                " case-sensitive search if any caps
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set tabstop=8                                                " actual tabs occupy 8 characters
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  setlocal spell spelllang=en_gb

let g:netrw_liststyle = 3 " Set directory listing style
let g:netrw_altv = 1 " Open split to the right
let g:netrw_winsize = 25 " Smaller window

" Plugins
" Make sure to use single quotes

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Visuals
Plug 'rakr/vim-two-firewatch'
Plug 'junegunn/seoul256.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'

Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'rstacruz/sparkup' "html snippets
Plug 'preservim/nerdtree'

"Linting, syntax, ...
Plug 'dense-analysis/ale'
Plug 'kchmck/vim-coffee-script'
Plug 'IN3D/vim-raml'
Plug 'chaquotay/ftl-vim-syntax'
Plug 'Galooshi/vim-import-js'
Plug 'briancollins/vim-jst'

"js/jsx/react
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Ruby/Rails specific
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'

" Svelte
Plug 'evanleck/vim-svelte'

Plug 'godlygeek/tabular'

" markdown/writing
Plug 'junegunn/goyo.vim'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }


Plug 'dhruvasagar/vim-table-mode'

" Elixir specific
Plug 'elixir-editors/vim-elixir'
call plug#end()

" Search using the silver searcher.
" Use 'ag' over 'grep'
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Custom settings

:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

set nocursorline " don't highlight current line
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/tmp/cache
" set background=dark
" set guifont=fira-code
set guifont=Inconsolata\ for\ powerline:h16

"function to format json files
com! FormatJSON %!python -m json.tool

" keyboard shortcuts
let mapleader = ','
:map <leader>f :FZF<cr>
:map <leader>a :Ag<space>
:map <leader>d :NERDTreeToggle<cr>
:map <leader>l <ESC>csw]<ESC>Ea()<ESC>i
:map <leader>j :FormatJSON<cr>

:iab <expr> cld strftime("%d-%m-%Y")

" in visual selection pres ++ to do some calculations
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

inoremap jj <ESC>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <leader><space> :call Strip_trailing()<CR>
" let g:two_firewatch_italics=1
" colo two-firewatch

colo seoul256

" Cursor settings
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
" fzf settings
if !has("gui_running")
  let g:fzf_colors =
        \ { 'fg': ['fg', 'Normal'],
        \ 'bg': ['bg', 'Normal']}
endif
" Lightline config
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ }

" Strip trailing whitespace
function! Strip_trailing()
  let previous_search=@/
  let previous_cursor_line=line('.')
  let previous_cursor_column=col('.')
  %s/\s\+$//e
  let @/=previous_search
  call cursor(previous_cursor_line, previous_cursor_column)
endfunction

" Set filetype for Jenkinsfile
au BufNewFile,BufRead Jenkinsfile setf groovy

" enable sparkup in js and jsx files
autocmd FileType javascript,jsx,ftl,javascript.jsx,svelte,javascriptreact,jst runtime! ftplugin/html/sparkup.vim

command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" Linter config
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'javascriptreact': ['eslint', 'prettier'],
\   'json': ['prettier']
\}

let g:ale_fix_on_save = 1

" Markdown writing config
let g:vim_markdown_edit_url_in = 'vsplit'
" fix broken folding
let g:vim_markdown_folding_style_pythonic = 1
" --

function! French_accented_text()
  %s/é/é/g
  %s/è/è/g
  %s/à/à/g
  %s/â/â/g
  %s/ô/ô/g
endfunction

" enable javascript snippets in javascriptreact files
autocmd FileType javascriptreact UltiSnipsAddFiletypes javascript
