" Load plugins for every FileType
execute pathogen#interpose('bundle/agit.vim')
execute pathogen#interpose('bundle/nvim-completion-manager')
execute pathogen#interpose('bundle/vim-quantum')
execute pathogen#interpose('bundle/vim-workspace')
execute pathogen#interpose('bundle/vim-filebeagle')
execute pathogen#interpose('bundle/golden-ratio')

" Load plugins & configurations for rust
autocmd FileType rust execute pathogen#interpose('bundle/rust.vim')
autocmd FileType rust let g:rust_recommended_style = 0
autocmd FileType rust execute pathogen#interpose('bundle/nvim-cm-racer')
autocmd FileType rust let g:racer_experimental_completer = 1
autocmd FileType rust execute pathogen#interpose('bundle/vim-racer')
autocmd FileType rust nnoremap <C-]> :call racer#GoToDefinition()<CR>
autocmd FileType rust setlocal omnifunc=racer#RacerComplete

" Load plugins for markdown
autocmd FileType markdown execute pathogen#interpose('bundle/vim-markdown-composer')
autocmd FileType markdown let g:markdown_composer_syntax_theme = 'ir_black'
autocmd FileType markdown set spell spelllang=en_us

" Golden ratio autocmd off
let g:golden_ratio_autocommand = 0

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
set mouse=

noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k

inoremap jj <Esc>
tnoremap jj <C-\><C-n>  

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

let g:workspace_autosave = 0
