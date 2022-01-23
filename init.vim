execute pathogen#interpose('bundle/fantome')
execute pathogen#interpose('bundle/vim-filebeagle')
execute pathogen#interpose('bundle/nvim-lspconfig')
execute pathogen#interpose('bundle/rust.vim')

colorscheme fantome

lua << EOF
local nvim_lsp = require'lspconfig'

nvim_lsp.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

vim.diagnostic.config({
  virtual_text = false,
  float = {
    focusable = false,
  }
}, nil)
EOF

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.diagnostic.open_float()

" Spell check markdown
autocmd FileType markdown set spell spelllang=en_us

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

set termguicolors

set number
set nobackup
set noswapfile
set noundofile
set autoindent
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

" Disable scratch and preview window
set completeopt=menuone,longest

" ctrl + hjkl to navigate between splits
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k

" Some useful bindings on leader
nmap ; :buffers<CR>
nmap <Leader>m :marks<CR>
nmap <Leader>t :files<CR>
nmap <Leader>r :tags<CR>
nmap <Leader>e :reg<CR>

" Clear all buffers except the current one
function! BufOnly()
  let curr = bufnr("%")
  let last = bufnr("$")

  if curr > 1 | silent! execute "1,".(curr-1)."bd" | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

" A binding on leader to clear the buffers
nmap <Leader>b :call BufOnly()<CR>

" Turn off line numbering in the terminal
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
