# 文字コードの設定
export LANG=ja_JP.UTF-8

# パスの設定
export PATH=$HOME/bin:$HOME/.cabal/bin:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/opt/local/android-sdk/tools:/opt/jruby/bin:/opt/local/scala/bin:$HOME/bin/AWS-ElasticBeanstalk-CLI-2.3.1/eb/linux/python2.7:$PATH
export MANPATH=/opt/local/man:$MANPATH

# 関数
find-grep () { find . -type f -print | xargs grep -n --binary-files=without-match $@ }

# エイリアスの設定
alias g='git'
alias gs='git status'
alias gc='git commit -a -m'
alias gnow='git commit -a -m "."'
alias gp='git push'
alias ga='git add'
alias go='git checkout'
alias gb='git branch'
alias gl='git log'
alias ls='ls -a'
alias ll='ls -la'
alias mysql='mysql5'
alias chrome='open -a "Google Chrome"'

alias b='bundle'
alias be='bundle exec'
alias bi='bundle install'

# プロンプトの設定
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats ':(%s)%b'
zstyle ':vcs_info:*' actionformats ':(%s)%b|%a'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
PROMPT="%{${fg[yellow]}%}%n%1(v|%F{green}%1v%f|)%{${fg[yellow]}%}%{${reset_color}%}%b:# "
#PROMPT='%n:# '
RPROMPT="[%~]"

# ヒストリの設定
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# 履歴ファイルに時刻を記録
setopt extended_history

# 補完するかの質問は画面を超える時にのみに行う｡
LISTMAX=0

# 補完の利用設定
autoload -Uz compinit; compinit

# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# cdのタイミングで自動的にpushd
setopt auto_pushd

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history

# 補完候補が複数ある時に、一覧表示
setopt auto_list

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完
setopt auto_menu

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# ビープ音を鳴らさないようにする
setopt NO_beep

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# 重複したヒストリは追加しない
setopt hist_ignore_all_dups

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示しない
setopt NO_list_types

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 8 ビット目を通すようになり、日本語のファイル名を表示可能
setopt print_eight_bit

# シェルのプロセスごとに履歴を共有
setopt share_history

# Ctrl+wで､直前の/までを削除する｡
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# cd をしたときにlsを実行する
function chpwd() { ls }

# ディレクトリ名だけで､ディレクトリの移動をする｡
setopt auto_cd

# C-s, C-qを無効にする。
setopt NO_flow_control

export SVN_EDITOR=/usr/bin/vi

#export JRUBY_HOME=/opt/jruby
export CLASSPATH=/opt/local/scala-2.8.0.final/lib/scala-library.jar

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
