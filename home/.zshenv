# パスの設定
export PATH=/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/opt/local/android-sdk/tools:/opt/jruby/bin:$HOME/bin:$PATH
export MANPATH=/opt/local/man:$MANPATH

if [ -d $HOME/.rbenv/bin ]; then
    export RBENV_ROOT=$HOME/.rbenv
    export PATH="$RBENV_ROOT/bin:$PATH"
    export PATH="$RBENV_ROOT/shims:$PATH"
    eval "$(rbenv init -)"
fi
