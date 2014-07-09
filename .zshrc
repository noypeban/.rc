## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
#export LANG=ja_JP.EUC-JP
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export EDITOR=vim
bindkey -e

#command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line

#smart
autoload smart-insert-unmeta
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
bindkey '^]' insert-last-word

## set prompt
#PROMPT="%U$USER@%m%%%u "
PROMPT="> "
RPROMPT="[%~]"

# バックグラウンドジョブの状態変化を即時報告する
setopt notify       

## 単語区切り
#autoload -Uz select-word-style
#select-word-style default
#zstyle ':zle:*' word-chars "_-./;@"
#zstyle ':zle:*' word-style unspecified
export WORDCHARS="*?_-.[]~&;!#$%^(){}<>"

## 補完機能の強化
autoload -U compinit
compinit

## 先方予測機能を有効に設定
autoload predict-on
predict-on

## 大文字小文字を区別しない
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

## 補完候補を詰めて表示
setopt list_packed
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## 補完候補を一覧表示
setopt auto_list
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups hist_save_nodups
## 以下はヒストリに追加しない
compdef -d ls
compdef -d ll
compdef -d \.\.
## cd 時に自動で push
#setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## TAB で順に補完候補を切り替える
setopt auto_menu
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## 出力時8ビットを通す
setopt print_eight_bit
## ヒストリを共有
setopt share_history
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
zstyle ':completion:*:default' list-colors ''
## ディレクトリ名だけで cd
setopt auto_cd
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## スペルチェック
setopt correct
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## 補完候補を詰めて表示
setopt list_packed
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

source ~/.alias

# extract; copy from http://d.hatena.ne.jp/itchyny/20130227/1361933011
function extract() {
    case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -dc $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
    esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
# mycd; mod from http://d.hatena.ne.jp/hi_igu/20110623
function chpwd(){
#histf=$HOME/.zsh_history
ls
#echo "cd" $PWD >> $histf
}

case "${TERM}" in
    screen*|ansi*)
        preexec()
        {
            echo -ne "\ek${1%% 2%% *}\e\\"
        }
        precmd()
        {
            echo -ne "\ek$(basename $(pwd))\e\\"
            #echo -ne "\ek$(basename $SHELL)\e\\"
        }
        ;;
esac

# zaw
zstyle ':completion:*' menu select
zstyle ':completion:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
typeset -ga chpwd_functions

autoload -U chpwd_recent_dirs cdr
chpwd_functions+=chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-max 500
zstyle ":chpwd:*" recent-dirs-default true
zstyle ":completion:*" recent-dirs-insert always

source /home/toshikazu/.zsh_plugins/zaw/zaw.zsh
bindkey '^@' zaw-cdr
