local opt = vim.opt

-- 基本設定
opt.cursorline = true      -- set cursorline
opt.cursorcolumn = true    -- set cursorcolumn
opt.autoindent = true      -- set autoindent
opt.smartindent = true     -- set smartindent
opt.showmode = true        -- set showmode
opt.number = true          -- set number
opt.showmatch = true       -- set showmatch
opt.autowrite = true       -- set autowrite
opt.list = true            -- set list
opt.hlsearch = true        -- set hlsearch
opt.laststatus = 2         -- set laststatus=2
opt.cmdheight = 2          -- set cmdheight=2
opt.listchars = { tab = ". ", trail = "-", eol = "$" } -- set lcs=tab:.\ ,trail:-,eol:$
opt.tabstop = 4            -- set tabstop=4
opt.shiftwidth = 4         -- set shiftwidth=4
opt.expandtab = true       -- set expandtab
opt.fileencodings = { "utf-8", "euc-jp", "sjis" } -- set fileencodings=utf-8,euc-jp,sjis
opt.wildmode = { "list:longest", "full" } -- set wildmode=list:longest,full
opt.ignorecase = true      -- set ignorecase
opt.termguicolors = true   -- set t_Co=256 のモダンな代替
opt.showtabline = 2        -- set showtabline=2
opt.clipboard = "unnamed"  -- set clipboard=unnamed
opt.autoread = true       -- ファイルが外部で変更されたら自動で読み直す

opt.colorcolumn = "80,100" -- set colorcolumn=80,100

opt.swapfile = false       -- set noswapfile

-- marker による折りたたみを有効にする
opt.foldmethod = "syntax"  -- set foldmethod=syntax
opt.foldlevel = 100        -- set foldlevel=100

opt.breakindent = true     -- set breakindent
opt.showbreak = "↳ "       -- set showbreak=↳\ 

-- Pythonのパス（必要に応じて環境に合わせて変更してください）
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.python_recommended_style = 0

-- Undo / Backup
if vim.fn.has("persistent_undo") == 1 then
  opt.undodir = vim.fn.expand("~/.config/nvim/undo")
  opt.undofile = true
end
opt.backupdir = vim.fn.expand("~/.config/nvim/tmp")
