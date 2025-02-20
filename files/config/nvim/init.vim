" init.vimを保存したら自動反映
autocmd BufWritePost  ~/.config/nvim/init.vim  so ~/.config/nvim/init.vim

set cursorline
set cursorcolumn
set autoindent
set smartindent
set showmode
set number
set showmatch
set autowrite
set list
set hlsearch
set laststatus=2
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l/%L,%c%V%8P
set cmdheight=2
set lcs=tab:.\ ,trail:-,eol:$
" set lcs=tab:.\ ,trail:-,eol:↲
set tabstop=4
set shiftwidth=4
set expandtab
set fileencodings=utf-8,euc-jp,sjis
set wildmode=list:longest,full
set ignorecase
set t_Co=256
set showtabline=2
set clipboard=unnamed

set colorcolumn=80,100

set noswapfile

" marker による折りたたみを有効にする (勝手にたたまない)
set foldmethod=syntax
set foldlevel=100

" since ver.8.0
set breakindent
set showbreak=↳\ 

let g:python_recommended_style = 0
let g:python3_host_prog = '/usr/bin/python3'
" let g:python_host_prog = '/usr/bin/python' 

" undo
if has('persistent_undo')
    set undodir=~/.config/nvim/undo
    set undofile
endif
" backup
set backupdir=~/.config/nvim/tmp

" Use grep Command, when open cwindow"
autocmd QuickFixCmdPost *grep* cwindow

" カッコ補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

nnoremap j gj
nnoremap k gk

" コマンドライン設定
cnoremap <C-a> <Home>
cnoremap <C-d> <Delete>
cnoremap <C-b> <LEFT>
cnoremap <C-f> <Right>

" insert mode
inoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-d> <Delete>

" tab関連
noremap <Tab> :tabnext<CR>
noremap <S-Tab> :tabprevious<CR>
noremap <C-t><C-t> :tabnew<CR>

" CTRL-[h,j,k,l] for window switch
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" remap key Ctrl-c to ESC
inoremap <C-c> <ESC>

" pairing the parentheses
" nnoremap <Tab> %
nnoremap [ %
nnoremap ] %
" vnoremap <Tab> %
vnoremap [ %
vnoremap ] %

noremap <C-[><C-[> :noh<CR>
noremap <SPACE> i<SPACE><ESC>l

" US keyboard Setting
noremap ; :
noremap : ;

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
autocmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" if has('lua')
"     " NeoCompleteを有効にする
"     let g:neocomplete#enable_at_startup = 1
"     " 補完が自動で開始される文字数
"     let g:neocomplete#auto_completion_start_length = 3
"     " smart case有効化。 大文字が入力されるまで大文字小文字の区別を無視する
"     let g:neocomplete#enable_smart_case = 1
"     " シンタックスをキャッシュするときの最小文字長を3に
"     let g:neocomplete#min_syntax_length = 3
"     " 補完候補の一番先頭を選択状態にする(AutoComplPopと似た動作)
"     let g:neocomplete#enable_auto_select = 0
"     "ポップアップメニューで表示される候補の数。初期値は100
"     let g:neocomplete#max_list = 20
" end

" use EnhCommentify
helptags ~/.config/nvim/doc

" install dein
let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/Shougo/dein.vim' s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endif

" " use dein.vim
if &compatible
  set nocompatible
endif
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.config/nvim/dein'))

call dein#add('Shougo/dein.vim')
" call dein#add('vim-scripts/VimClojure')
call dein#add('Shougo/unite.vim')
" if has('lua')
"     call dein#add('Shougo/neocomplete.vim')
" endif
call dein#add('scrooloose/syntastic')
call dein#add('Shougo/vimfiler.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('tpope/vim-fugitive')
call dein#add('sjl/gundo.vim')
call dein#add('tomtom/tcomment_vim')
call dein#add('LeafCage/yankround.vim')
call dein#add('Shougo/vimproc', {'build': 'make'})
" call dein#add('davidhalter/jedi-vim')
" call dein#add('lambdalisue/vim-pyenv', {
"     \ 'depends' : ['davidhalter/jedi-vim'],
"     \ 'autoload' : {
"     \   'filetypes' : ['python'],
"     \ }})
" call dein#add('lambdalisue/vim-django-support')

call dein#add('tpope/vim-markdown')

call dein#end()


" syntastic setting
let g:syntastic_python_checkers = ['pycodestyle', 'pylint',]
let g:syntastic_python_pylint_post_args =
    \ '--msg-template="{path}:{line}:{column}:{C}: [{msg_id}: {symbol}] {msg}"'

let g:syntastic_javascript_checkers = ['eslint', 'jshint']
let g:syntastic_javascript_eslint_exec = 'eslint'
" let g:loaded_syntastic_python_pylint_checker = 0
" let g:syntastic_auto_loc_list = 1
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['rst', 'php', 'sh', 'zsh', 'vim', 'python', 'html', 'xhtml', 'htmldjango', 'javascript']
            \}
noremap <C-s> :w<CR> :SyntasticCheck<CR>

" unite setting
noremap <C-w><C-b> :Unite buffer<CR>
noremap <C-w><C-t> :Unite tab<CR>

set nocompatible

set runtimepath+='$HOME/.config/nvim/dein/repos/github.com/Shougo/unite.vim'
set runtimepath+='$HOME/.config/nvim/dein/repos/github.com/Shougo/vimfiler'
set runtimepath+='$HOME/.config/nvim/dein/repos/github.com/tpope/vim-fugitive'

" vimfiler setting
noremap <C-w><C-e> :VimFilerExplorer -winwidth=50<CR>
let g:vimfiler_ignore_pattern = '\%(^\.\|.pyo$\|.mo$\|.pyc$\)'


" tcomment_vim setting
noremap \x :TComment<CR>
noremap \a yy:TComment<CR>p

" taglist setting
let Tlist_Ctags_Cmd = $HOME."/.homebrew/bin/ctags"
" let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_WinWidth = 50
noremap tt :TlistToggle<CR>

" yankroud setting
let g:yankround_dir = '~/.vim/cache/yankround'
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
xmap p <Plug>(yankround-p)
xmap gp <Plug>(yankround-gp)

" インサートモードに入った時にカーソル行(列)の色を変更する
augroup vimrc_change_cursorline_color
    autocmd!
    autocmd InsertEnter * highlight CursorLine ctermbg=22 guibg=#00875f | highlight CursorColumn ctermbg=22 guibg=#00875f
    autocmd InsertLeave * highlight CursorLine ctermbg=235 guibg=Grey20 | highlight CursorColumn ctermbg=235 guibg=Grey20
augroup END

" アクティブウィンドウに限りカーソル行(列)を強調する
augroup vimrc_set_cursorline_only_active_window
    autocmd!
    autocmd VimEnter,BufWinEnter,WinEnter * setlocal cursorline | setlocal cursorcolumn
    autocmd WinLeave * setlocal nocursorline | setlocal nocursorcolumn
augroup END

" lightline setting
let s:p = g:lightline#colorscheme#wombat#palette
let s:p.tabline.left = [ [ '#999999', '#444444', 7, 238, '' ] ]
let s:p.tabline.tabsel = [ [ '#00ffff', '#000000', 6, 0, 'bold' ] ]
unlet s:p

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'mode_map': { 'c': 'NORMAL' },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'filename' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype', 'pyenv' ] ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'gitbranch', 'filename' ] ]
    \ },
    \ 'tabline': {
    \   'left': [ [ 'tabs' ] ],
    \   'right': [ [ 'cd' ] ]
    \ },
    \ 'tab': {
    \   'active': [ 'tabnum', 'readonly', 'filename', 'modified' ],
    \   'inactive': [ 'tabnum', 'readonly', 'filename', 'modified' ]
    \ },
    \ 'component_function': {
    \   'modified': 'MyModified',
    \   'readonly': 'MyReadonly',
    \   'gitbranch': 'MyFugitive',
    \   'filename': 'MyFilename',
    \   'fileformat': 'MyFileformat',
    \   'filetype': 'MyFiletype',
    \   'fileencoding': 'MyFileencoding',
    \   'mode': 'MyMode',
    \   'pyenv': 'pyenv#statusline#component',
    \   'cd': 'CurrentDirectory',
    \ },
    \ 'tab_component_function': {
    \   'filename': 'LightlineTabFilename',
    \   'modified': 'lightline#tab#modified',
    \   'readonly': 'TabReadonly',
    \   'tabnum': 'lightline#tab#tabnum',
    \ },
    \ }

function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! CurrentDirectory()
  return fnamemodify(getcwd(), ":~")
endfunction

function! LightlineTabFilename(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let _ = pathshorten(expand('#'.buflist[winnr - 1].':f'))
  return _ !=# '' ? _ : '[No Name]'
endfunction

function! TabReadonly(n)
    let winnr = tabpagewinnr(a:n)
    return gettabwinvar(a:n, winnr, '&readonly') ? '⭤' : ''
endfunction

function! MyFilename()
    return CurrentDirectory() .'/' .('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
        \ &ft == 'unite' ? unite#get_status_string() : 
        \ '' != expand('%:f') ? expand('%:f') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
    if exists("*FugitiveHead")
        let _ = FugitiveHead()
        return strlen(_) ? ' '._ : ''
    endif
    return ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


filetype plugin indent on

" color settings
syntax on
source ~/.config/nvim/highlight.vim
