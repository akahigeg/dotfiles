" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"
" An example for a Japanese version vimrc file.
" 日本語版のデフォルト設定ファイル(vimrc) - Vim7用試作
"
" Last Change: 14-Nov-2007.
" Maintainer:  MURAOKA Taro <koron@tka.att.ne.jp>
"
" 解説:
" このファイルにはVimの起動時に必ず設定される、編集時の挙動に関する設定が書
" かれています。GUIに関する設定はgvimrcに書かかれています。
"
" 個人用設定は_vimrcというファイルを作成しそこで行ないます。_vimrcはこのファ
" イルの後に読込まれるため、ここに書かれた内容を上書きして設定することが出来
" ます。_vimrcは$HOMEまたは$VIMに置いておく必要があります。$HOMEは$VIMよりも
" 優先され、$HOMEでみつかった場合$VIMは読込まれません。
"
" 管理者向けに本設定ファイルを直接書き換えずに済ませることを目的として、サイ
" トローカルな設定を別ファイルで行なえるように配慮してあります。Vim起動時に
" サイトローカルな設定ファイル($VIM/vimrc_local.vim)が存在するならば、本設定
" ファイルの主要部分が読み込まれる前に自動的に読み込みます。
"
" 読み込み後、変数g:vimrc_local_finishが非0の値に設定されていた場合には本設
" 定ファイルに書かれた内容は一切実行されません。デフォルト動作を全て差し替え
" たい場合に利用して下さい。
"
" 参考:
"   :help vimrc
"   :echo $HOME
"   :echo $VIM
"   :version

"---------------------------------------------------------------------------
" サイトローカルな設定($VIM/vimrc_local.vim)があれば読み込む。読み込んだ後に
" 変数g:vimrc_local_finishに非0な値が設定されていた場合には、それ以上の設定
" ファイルの読込を中止する。
if 1 && filereadable($VIM . '/vimrc_local.vim')
  unlet! g:vimrc_local_finish
  source $VIM/vimrc_local.vim
  if exists('g:vimrc_local_finish') && g:vimrc_local_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" ユーザ優先設定($HOME/.vimrc_first.vim)があれば読み込む。読み込んだ後に変数
" g:vimrc_first_finishに非0な値が設定されていた場合には、それ以上の設定ファ
" イルの読込を中止する。
if 0 && exists('$HOME') && filereadable($HOME . '/.vimrc_first.vim')
  unlet! g:vimrc_first_finish
  source $HOME/.vimrc_first.vim
  if exists('g:vimrc_first_finish') && g:vimrc_first_finish != 0
    finish
  endif
endif

"---------------------------------------------------------------------------
" メニューファイルが存在しない場合は予め'guioptions'を調整しておく
if 1 && !filereadable($VIMRUNTIME . '/menu.vim') && has('gui_running')
  set guioptions+=M
endif

"---------------------------------------------------------------------------
" Bram氏の提供する設定例をインクルード (別ファイル:vimrc_example.vim)。これ
" 以前にg:no_vimrc_exampleに非0な値を設定しておけばインクルードはしない。
if 1 && (!exists('g:no_vimrc_example') || g:no_vimrc_example == 0)
  if &guioptions !~# "M"
    " vimrc_example.vimを読み込む時はguioptionsにMフラグをつけて、syntax on
    " やfiletype plugin onが引き起こすmenu.vimの読み込みを避ける。こうしない
    " とencに対応するメニューファイルが読み込まれてしまい、これの後で読み込
    " まれる.vimrcでencが設定された場合にその設定が反映されずメニューが文字
    " 化けてしまう。
    set guioptions+=M
    source $VIMRUNTIME/vimrc_example.vim
    set guioptions-=M
  else
    source $VIMRUNTIME/vimrc_example.vim
  endif
endif

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの画面上での幅
set tabstop=4
" タブをスペースに展開しない (expandtab:展開する)
set noexpandtab
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1  " ぶら下り可能幅

set iminsert=0 imsearch=0
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set nonumber
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup


"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif uname =~? "freebsd"
    set term=builtin_cons25
"  elseif uname =~? "Darwin"
"    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

" Copyright (C) 2007 KaoriYa/MURAOKA Taro
"
cd ~/works

" バックアップファイルを作らない
set nobk

" ヤンクバッファとクリップボードと同期
set clipboard+=unnamed

" ビープ音消す
set visualbell t_vb=

" キーマップのカスタマイズ
map <F2> :tabp<ENTER>
map <F3> :tabn<ENTER>
map <F4> <C-w>w
map <F7> zf%
map <F8> zo
imap <C-o> <C-x><C-k>
map <LEFT> <ESC>:bp!<CR>
map <RIGHT> <ESC>:bn!<CR>
map <UP> <ESC>:ls<CR>

" 自動保存
function! AutoUp()
    if expand('%') =~ g:svbfre && !&readonly && &buftype == ''
        silent update
    endif
endfunction

autocmd CursorHold * call AutoUp()
set updatetime=500
let g:svbfre = '.\+'

au FileType html set ts=2 sw=2 expandtab
au FileType css set ts=2 sw=2 expandtab
au FileType javascript set ts=4 sw=4 expandtab
au FileType coffee set ts=4 sw=4 expandtab

au BufNewFile,BufRead *.js     set ft=javascript   fenc=utf-8
au BufNewFile,BufRead *.coffee set ft=coffee       fenc=utf-8

"------------------------------------------------------------------------
au FileType ruby  :set nowrap tabstop=2 tw=0 sw=2 expandtab
au FileType eruby :set nowrap tabstop=2 tw=0 sw=2 expandtab
au FileType objc  :set nowrap tabstop=2 tw=0 sw=2 expandtab
au FileType python :set nowrap tabstop=4 tw=0 sw=4 expandtab
au FileType markdown :set wrap tabstop=4 tw=0 sw=4 expandtab syntax=no
au FileType text :set wrap tabstop=4 tw=0 sw=4 expandtab

autocmd BufNewFile *.rb 0r ~/.vim/templates/rb.tpl

"------------------------------------------------------------------------
" normal ruby & eRuby
au BufNewFile,BufRead *.rhtml set ft=eruby fenc=utf-8
au BufNewFile,BufRead *.erb   set ft=eruby fenc=utf-8
au BufNewFile,BufRead *.rb    set ft=ruby  fenc=utf-8

"------------------------------------------------------------------------
" rails
au BufNewFile,BufRead app/*/*.rhtml  set ft=mason fenc=utf-8
au BufNewFile,BufRead app/*/*.erb  set ft=mason fenc=utf-8
au BufNewFile,BufRead app/**/*.rb  set ft=ruby  fenc=utf-8

" objc objj
au BufNewFile,BufRead *.j  set ft=objc  fenc=utf-8
au BufNewFile,BufRead *.m  set ft=objc  fenc=utf-8
au BufNewFile,BufRead *.h  set ft=objc  fenc=utf-8

au BufNewFile,BufRead *.md  set ft=markdown  fenc=utf-8

"set complete+=k~/.vim/keyword/objc_keyword
autocmd FileType objc setlocal iskeyword+=:
autocmd FileType objc set dictionary=~/.vim/dict/cocoa.dict

" php
au FileType php :set nowrap tabstop=2 tw=0 sw=2 expandtab
au BufNewFile,BufRead *.php    set ft=  fenc=utf-8

" Align 日本語環境対応
let g:Align_xstrlen = 3

"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>


" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" 対応括弧のハイライトをしない
let loaded_matchparen = 1

" スワップファイルいらない
set noswapfile

" project.vim ※タブでは使えない
"if getcwd() != $HOME
"  if filereadable(getcwd(). '/.vimprojects')
"    Project .vimprojects
"  endif
"endif

" 全角文字ハイライト
scriptencoding utf-8

augroup highlightIdegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

colorscheme default

" YankRing
:nnoremap <silent> <F7> :YRShow<CR>
:let g:yankring_max_history = 10
:let g:yankring_window_height = 13

" Dash
function! s:dash(...)
  let ft = &filetype
  if &filetype == 'python'
    let ft = ft.'2'
  endif
  let ft = ''
  let word = len(a:000) == 0 ? input('Dash search: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=* Dash call <SID>dash(<f-args>)

"
" NeoBundle
"
set nocompatible               " Be iMproved

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
"
" Note: You don't set neobundle setting in .gvimrc!
filetype plugin indent on     " Required!

" recommented
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'taichouchou2/vim-endwise.git', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ } }

" 便利
NeoBundle 'tpope/vim-surround', {
      \ 'autoload' : {
      \   'mappings' : [
      \     ['nx', '<Plug>Dsurround'], ['nx', '<Plug>Csurround'],
      \     ['nx', '<Plug>Ysurround'], ['nx', '<Plug>YSurround'],
      \     ['nx', '<Plug>Yssurround'], ['nx', '<Plug>YSsurround'],
      \     ['nx', '<Plug>YSsurround'], ['vx', '<Plug>VgSurround'],
      \     ['vx', '<Plug>VSurround']
      \ ]}}
" }}}

NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \ 'depends': 'Shougo/vimproc',
      \ 'autoload' : {
      \   'commands': ['AlpacaTagsUpdate', 'AlpacaTagsSet', 'AlpacaTagsBundle']
      \ }}

" ruby / railsサポート {{{
NeoBundle 'tpope/vim-rails'
NeoBundle 'ujihisa/unite-rake', {
      \ 'depends' : 'Shougo/unite.vim' }
NeoBundle 'basyura/unite-rails', {
      \ 'depends' : 'Shjkougo/unite.vim' }
NeoBundle 'taichouchou2/unite-rails_best_practices', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'build' : {
      \    'mac': 'gem install rails_best_practices',
      \    'unix': 'gem install rails_best_practices',
      \   }
      \ }
NeoBundle 'taichouchou2/unite-reek', {
      \ 'build' : {
      \    'mac': 'gem install reek',
      \    'unix': 'gem install reek',
      \ },
      \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] },
      \ 'depends' : 'Shougo/unite.vim' }
NeoBundle 'taichouchou2/alpaca_complete', {
      \ 'depends' : 'tpope/vim-rails',
      \ 'build' : {
      \    'mac':  'gem install alpaca_complete',
      \    'unix': 'gem install alpaca_complete',
      \   }
      \ }

let s:bundle_rails = 'unite-rails unite-rails_best_practices unite-rake alpaca_complete'

function! s:bundleLoadDepends(bundle_names) "{{{
  " bundleの読み込み
  execute 'NeoBundleSource '.a:bundle_names
  au! RailsLazyPlugins
endfunction"}}}
aug RailsLazyPlugins
  au User Rails call <SID>bundleLoadDepends(s:bundle_rails)
aug END

" reference環境
NeoBundle 'vim-ruby/vim-ruby', {
    \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml'] } }
NeoBundle 'taka84u9/vim-ref-ri', {
      \ 'depends': ['Shougo/unite.vim', 'thinca/vim-ref'],
      \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] } }
NeoBundle 'skwp/vim-rspec', {'autoload': {'filetypes': ['ruby', 'eruby', 'haml']}}
NeoBundle 'ruby-matchit', {
    \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml'] } }
" }}}

" }}}
"}}}

NeoBundle 'git://github.com/mattn/zencoding-vim.git'
NeoBundle 'Align'

" Installation check.
NeoBundleCheck

" alpaca ctags
let g:alpaca_update_tags_config = {
      \ '_' : '-R --sort=yes',
      \ 'js' : '--languages=+js',
      \ '-js' : '--languages=-js,JavaScript',
      \ 'vim' : '--languages=+Vim,vim',
      \ '-vim' : '--languages=-Vim,vim',
      \ '-style': '--languages=-css,sass,scss,js,JavaScript,html',
      \ 'scss' : '--languages=+scss --languages=-css,sass',
      \ 'sass' : '--languages=+sass --languages=-css,scss',
      \ 'css' : '--languages=+css',
      \ 'java' : '--languages=+java $JAVA_HOME/src',
      \ 'ruby': '--languages=+Ruby',
      \ 'coffee': '--languages=+coffee',
      \ '-coffee': '--languages=-coffee',
      \ 'bundle': '--languages=+Ruby --languages=-css,sass,scss,js,JavaScript,coffee',
      \ }

aug AlpacaUpdateTags
  au!
  au FileWritePost,BufWritePost * AlpacaTagsUpdate -style
  " bundleのオプションは自動で追加して実行します。
  au FileWritePost,BufWritePost Gemfile AlpacaTagsUpdateBundle
  au FileReadPost,BufEnter * AlpacaTagsSet
aug END
