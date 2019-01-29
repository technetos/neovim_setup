" Load plugins for every FileType
execute pathogen#interpose('bundle/agit.vim')
execute pathogen#interpose('bundle/deoplete.nvim')
execute pathogen#interpose('bundle/vim-quantum')
execute pathogen#interpose('bundle/vim-workspace')
execute pathogen#interpose('bundle/vim-filebeagle')
execute pathogen#interpose('bundle/golden-ratio')
" -----------------------------------------------------------------------------
" Use deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}

" Disable scratch and preview window
"set completeopt=menu,menuone,longest
set completeopt=menuone,longest
" -----------------------------------------------------------------------------
" Load plugins & configurations for rust
autocmd FileType rust execute pathogen#interpose('bundle/rust.vim')
autocmd FileType rust execute pathogen#interpose('bundle/deoplete-rust')
autocmd FileType rust execute pathogen#interpose('bundle/vim-racer')

" Configure racer
autocmd FileType rust let g:racer_experimental_completer = 1
autocmd FileType rust nnoremap <C-]> :call racer#GoToDefinition()<CR>
autocmd FileType rust setlocal omnifunc=racer#RacerComplete

" Configure deoplete
autocmd FileType rust let g:deoplete#sources#rust#racer_binary='/home/plant/.cargo/bin/racer'
autocmd FileType rust let g:deoplete#sources#rust#show_duplicates=0
autocmd FileType rust let g:deoplete#sources#rust#disable_keymap=1
autocmd FileType rust let g:deoplete#sources.rust = ['rust']
autocmd FileType rust let g:deoplete#sources.disabled_syntaxes = ['member', 'omni', 'buffer', 'around', 'dictionary']

" -----------------------------------------------------------------------------
" Load plugins for markdown
autocmd FileType markdown set spell spelllang=en_us
" -----------------------------------------------------------------------------

" Golden ratio autocmd off
let g:golden_ratio_autocommand = 0

" Dont auto create a workspace
let g:workspace_autosave = 0

set termguicolors

set autoindent
set number
set nobackup
set noswapfile
set noundofile
set shiftwidth=2
set tabstop=2
set expandtab

set cursorline
set cursorcolumn
set splitbelow
set splitright

set textwidth=80
set wrapmargin=2

set foldmethod=marker

" This allows you to move away from a buffer without saving
set hidden

" Disable mouse support
set mouse=

noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k

nmap ; :buffers<CR>
nmap <Leader>m :marks<CR>
nmap <Leader>t :files<CR>
nmap <Leader>r :tags<CR>
nmap <Leader>s :ToggleWorkspace<CR>
nmap <Leader>e :reg<CR>

function! BufOnly()
  let curr = bufnr("%")
  let last = bufnr("$")

  if curr > 1 | silent! execute "1,".(curr-1)."bd" | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

nmap <Leader>b :call BufOnly()<CR>

colorscheme quantum

autocmd TermOpen * setlocal nonumber

" The main window stays where it is when a preview
" window is opened by omnicomplete using the functions
" defined below
function! PreviewWindowEnterMove()
  if &previewwindow
    normal! Hmx``
  endif
endfunction

function! PreviewWindowLeaveMove()
  if &previewwindow
    normal! `xzt``
  endif
endfunction
    
autocmd * WinEnter call PreviewWindowEnterMove()
autocmd * BufDelete call PreviewWindowLeaveMove()
