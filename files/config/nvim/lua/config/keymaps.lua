local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- カッコ補完
keymap("i", "{", "{}<Left>", { noremap = true })
keymap("i", "[", "[]<Left>", { noremap = true })
keymap("i", "(", "()<Left>", { noremap = true })
keymap("i", '"', '""<Left>', { noremap = true })
keymap("i", "'", "''<Left>", { noremap = true })

-- ビジュアルモードのカッコ補完（zレジスタを使用）
keymap("v", "{", '"zdi{<C-R>z}<ESC>', { noremap = true })
keymap("v", "[", '"zdi[<C-R>z]<ESC>', { noremap = true })
keymap("v", "(", '"zdi(<C-R>z)<ESC>', { noremap = true })
keymap("v", '"', '"zdi"<C-R>z"<ESC>', { noremap = true })
keymap("v", "'", '"zdi\'<C-R>z\'<ESC>', { noremap = true })

-- 表示行移動
keymap("n", "j", "gj", { noremap = true })
keymap("n", "k", "gk", { noremap = true })

-- コマンドライン設定
keymap("c", "<C-a>", "<Home>", { noremap = true })
keymap("c", "<C-d>", "<Delete>", { noremap = true })
keymap("c", "<C-b>", "<Left>", { noremap = true })
keymap("c", "<C-f>", "<Right>", { noremap = true })

-- インサートモード
keymap("i", "<C-e>", "<End>", { noremap = true })
keymap("i", "<C-a>", "<Home>", { noremap = true })
keymap("i", "<C-f>", "<Right>", { noremap = true })
keymap("i", "<C-b>", "<Left>", { noremap = true })
keymap("i", "<C-d>", "<Delete>", { noremap = true })

-- tab関連
keymap("n", "<Tab>", ":tabnext<CR>", opts)
keymap("n", "<S-Tab>", ":tabprevious<CR>", opts)
keymap("n", "<C-t><C-t>", ":tabnew<CR>", opts)

-- ウィンドウ移動 (CTRL-[h,j,k,l])
keymap("n", "<C-h>", "<C-w>h", { noremap = true })
keymap("n", "<C-j>", "<C-w>j", { noremap = true })
keymap("n", "<C-k>", "<C-w>k", { noremap = true })
keymap("n", "<C-l>", "<C-w>l", { noremap = true })

-- ウィンドウサイズ変更 (Shift + 矢印)
keymap("n", "<S-Left>", "<C-w><<CR>", opts)
keymap("n", "<S-Right>", "<C-w>><CR>", opts)
keymap("n", "<S-Up>", "<C-w>-<CR>", opts)
keymap("n", "<S-Down>", "<C-w>+<CR>", opts)

-- Ctrl-c を ESC に
keymap("i", "<C-c>", "<ESC>", { noremap = true })

-- 括弧のペアリング移動
keymap("n", "[", "%", { noremap = true })
keymap("n", "]", "%", { noremap = true })
keymap("v", "[", "%", { noremap = true })
keymap("v", "]", "%", { noremap = true })

-- ハイライト消去
keymap("n", "<C-[><C-[>", ":noh<CR>", { noremap = true })

-- 空白挿入
keymap("n", "<Space>", "i<Space><ESC>l", { noremap = true })

-- US keyboard Setting (; と : を入れ替え)
keymap("n", ";", ":", { noremap = true })
keymap("n", ":", ";", { noremap = true })

-- 保存ショートカット (SyntasticCheckの代わりにフォーマットなどを走らせる用途でとりあえず保存のみ)
keymap("n", "<C-s>", ":w<CR>", opts)
