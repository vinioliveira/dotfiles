export PATH="./bin:$HOME/.bash/bin:$HOME/bin:$HOME/local/bin:$HOME/local/ruby/gems/bin:$HOME/local/sbin:$HOME/Sites/codeplane/scripts:/bin:/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/usr/X11/bin"
export INSTALL_DIR="$HOME/local"
export EVENT_NOKQUEUE=1
export MANPATH=/usr/local/git/man:$MANPATH

if [[ "$(uname)" != "Darwin" ]]; then
  export EDITOR=vim
else
  export EDITOR="$HOME/bin/mate -w"
fi

export SVN_EDITOR="/usr/bin/mate -w"
export HISTCONTROL=ignoreboth
export HISTFILESIZE=1000000
export HISTIGNORE="&"
export HISTSIZE=${HISTFILESIZE}
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CDPATH=.:~:~/Sites:~/Sites/github
export CDHISTORY="/tmp/cd-${USER}"

export RUBYLIB='.'
export RUBYOPT=''

export LESS_TERMCAP_mb=$'\E[04;33m'
export LESS_TERMCAP_md=$'\E[04;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[00;32m'

export PATH="$EC2_HOME/bin:$EC2_AMI_HOME/bin:$PATH"
export JAVA_HOME="/Library/Java/Home"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.grail2/bin:$PATH" 
export GRAILS="/Users/vinicius/Development/Ambiente/Groovy/grails-2.2.1/bin"
export PATH="$GRAILS:$PATH"
