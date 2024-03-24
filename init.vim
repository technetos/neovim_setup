execute pathogen#interpose('bundle/fantome')
execute pathogen#interpose('bundle/vim-filebeagle')

execute pathogen#interpose('bundle/nvim-lspconfig')
execute pathogen#interpose('bundle/nvim-cmp')
execute pathogen#interpose('bundle/cmp-nvim-lsp')
execute pathogen#interpose('bundle/cmp-nvim-lua')

execute pathogen#interpose('bundle/nvim-treesitter')

" Load the rust plugin if the file type is rust
autocmd FileType rust execute pathogen#interpose('bundle/rust.vim')

colorscheme fantome

lua << EOF
require('nvim-treesitter.configs').setup({
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = false,
    extended_mode = true,
    max_file_lines = nil,
  }
})

require('lspconfig').rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
              enable = true
            },
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
  update_in_insert = true,
  severity_sort = false,
  float = {
    focusable = false,
    source = 'always',
    header = '',
    prefix = '',
  },
})

local cmp = require'cmp'

cmp.setup({
  view = {
    entries = "custom",
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-e>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp', keyword_length = 1 },
    { name = 'nvim_lua', keyword_length = 1 },
    { name = 'buffer', keyword_length = 1 },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered({
      max_height = 40,
    })
  },
  formatting = {
    format = function(entry, item)
      
      local content = item.abbr

      local win_width = vim.api.nvim_win_get_width(0)

      local max_content_width = math.floor(win_width * 0.1)

      if #content > max_content_width then
        item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
      else
        item.abbr = content .. (" "):rep(max_content_width - #content)
      end
      return item
    end,
  },
})
EOF


" Set updatetime for CursorHold to 300ms of no cursor movement to trigger CursorHold
"
set updatetime=300

" Show diagnostic popup on cursor hover
"
autocmd CursorHold * lua vim.diagnostic.open_float()

" Spell check markdown
"
autocmd FileType markdown set spell spelllang=en_us

" have a fixed column for the diagnostics to appear in this removes the jitter when warnings/errors flow in
"
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
"
set hidden

" Disable mouse support
"
set mouse=

" Disable scratch and preview window
"
set completeopt=menuone,longest

" ctrl + hjkl to navigate between splits
"
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k

" Some useful bindings on leader
"
nmap ; :buffers<CR>
nmap <Leader>m :marks<CR>
nmap <Leader>t :files<CR>
nmap <Leader>r :tags<CR>
nmap <Leader>e :reg<CR>

" Clear all buffers except the current one
" 
function! BufOnly()
  let curr = bufnr("%")
  let last = bufnr("$")

  if curr > 1 | silent! execute "1,".(curr-1)."bd" | endif
  if curr < last | silent! execute (curr+1).",".last."bd" | endif
endfunction

" A binding on leader to clear the buffers
" 
nmap <Leader>b :call BufOnly()<CR>

" Turn off line numbering in the terminal
"
autocmd TermOpen * setlocal nonumber

" The main window stays where it is when a preview window is opened by omnicomplete using the functions defined below
"
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

autocmd WinEnter * call PreviewWindowEnterMove()
autocmd WinLeave * call PreviewWindowLeaveMove()
       
" Print the highlight information for a symbol
"
function! SynStack()    
  if !exists("*synstack")    
    return    
  endif    
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')    
endfunc    

function! SynStack ()    
  for i1 in synstack(line("."), col("."))    
    let i2 = synIDtrans(i1)    
    let n1 = synIDattr(i1, "name")    
    let n2 = synIDattr(i2, "name")    
    echo n1 "->" n2    
  endfor    
endfunction    
map gm :call SynStack()<CR>
