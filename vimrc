"""""""""""""""""""""""""""""""""""""
" エンコーディング
"""""""""""""""""""""""""""""""""""""

"書き込み時の文字コードをUFT-8に設定
set fileencoding=utf-8

" 読み込む時のエンコードを指定
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp

" ファイルタイプを自動で検知する
filetype on


"""""""""""""""""""""""""""""""""""""
" 基本設定
"""""""""""""""""""""""""""""""""""""

" バックアップファイルを作らない
set nobackup

" スワップファイルを作らない
set noswapfile

" 編集中のファイルが変更されたら自動で読み直す
set autoread

" バッファが編集中でもその他のファイルを開けるように
set hidden

" 入力中のコマンドをステータスに表示する
set showcmd

" コマンドラインの履歴を10000件保存する
set history=10000

" 挿入モードでautoindent, 改行, 挿入区間の始めを超えて<BS>, <Del>, CTRL-W, CTRL-Uを動作
set backspace=indent,eol,start

" 上下n行見える状態でスクロール
set scrolloff=5


"""""""""""""""""""""""""""""""""""""
" 表示
"""""""""""""""""""""""""""""""""""""

" カーソルが何行目の何列目に置かれているかを表示する
set ruler

" 行番号を表示
set number

" 現在の行を強調表示
set cursorline

" 現在の行を強調表示（縦）
" set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore

" インデントはスマートインデント
set smartindent

" ビープ音を可視化
set visualbell

" 括弧入力時の対応する括弧を表示
set showmatch

" コマンドラインの補完
set wildmode=list:longest

" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk

" シンタックスハイライトの有効化
syntax enable

" コメントの色を指定
hi Comment ctermfg=gray


"""""""""""""""""""""""""""""""""""""
" ステータス表示
"""""""""""""""""""""""""""""""""""""

" ステータスラインのフォーマット
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>

" ステータスラインを常に表示
set laststatus=2

highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=white


"""""""""""""""""""""""""""""""""""""
" Tab
"""""""""""""""""""""""""""""""""""""

" 不可視文字を可視化(改行、タブ、行末に続くスペース)
set list
set listchars=eol:↲,tab:»-,trail:_

" Tab文字を半角スペースにする
set expandtab

" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2

" 行頭でのTab文字の表示幅
set shiftwidth=2


"""""""""""""""""""""""""""""""""""""
" 検索
"""""""""""""""""""""""""""""""""""""

" 大文字と小文字を区別せずに検索する
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" 検索語をハイライト表示
set hlsearch

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>


"""""""""""""""""""""""""""""""""""""
" Undoの永続化
"""""""""""""""""""""""""""""""""""""

" ~/.vim/undoディレクトリ配下に変更履歴を保存
" ファイルを閉じても変更履歴が残るようにする
if has('persistent_undo')
  let undo_path = expand('~/.vim/undo')

  " ディレクトリが存在しなければディレクトリを作成
  if !isdirectory(undo_path)
    call mkdir(undo_path, 'p')
  endif

  exe 'set undodir=' .. undo_path
  set undofile
endif


"""""""""""""""""""""""""""""""""""""
" 入力の設定
"""""""""""""""""""""""""""""""""""""

" 新しい行を開始したとき、新しい行のインデントを現在行と同じにする
set autoindent

" ヤンク、プットするときにクリップボードを使用できるようにする
set clipboard+=unnamed

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

" <Leader>というプレフィックスキーにスペースを使用する
let g:mapleader = "\<Space>"

" スペース + wでファイル保存
nnoremap <Leader>w :w<CR>

" 入力モード時のカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" 文字の削除、置き換え時yankしないようにする
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X
nnoremap s "_s
vnoremap s "_s
nnoremap S "_S
vnoremap S "_S
xnoremap <expr> p 'pgv"'.v:register.'y`>'

" 日本語入力後にインサートモードを抜けると自動でIMEを無効にする
" IMEをコマンド経由で変更できるim-selectというソフトウェアが必要
" hammerspoonで実現したのでコメントアウト (2023-12-01)
" brew tap daipeihust/tap
" brew install im-select
" autocmd InsertLeave * :silent !/opt/homebrew/bin/im-select com.apple.keylayout.ABC

"""""""""""""""""""""""""""""""""""""
" プラグインマネジャー vim-jetpack
"""""""""""""""""""""""""""""""""""""

" https://github.com/tani/vim-jetpack を自動インストール
" https://github.com/tani/vim-jetpack#automatic-installation-on-startup を参考
let s:jetpackfile = '~/.vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

" プラグインを設定
packadd vim-jetpack
call jetpack#begin()
  "https://github.com/tani/vim-jetpack
  Jetpack 'tani/vim-jetpack', {'opt': 1}
call jetpack#end()
