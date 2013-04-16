export PATH="./bin:$HOME/.rbenv/bin:$HOME/Sites/codeplane/script:$HOME/.node/current/bin:$HOME/bin:$HOME/.bash/bin:$HOME/local/bin:$HOME/local/flex4/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export CLASSPATH="/usr/local/rhino:$CLASSPATH"
export MANPATH=/usr/local/git/man:$MANPATH
export EDITOR="/usr/bin/mate -w"
export SVN_EDITOR="/usr/bin/mate -w"
export HISTCONTROL=ignoreboth
export HISTFILESIZE=100000
export HISTIGNORE="&"
export HISTSIZE=${HISTFILESIZE}
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
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

export EC2_HOME="$HOME/.ec2"
export EC2_PRIVATE_KEY="$EC2_HOME/pk.pem"
export EC2_CERT="$EC2_HOME/cert.pem"
export EC2_AMI_HOME="$EC2_HOME/ec2-ami-tools"
export PATH="$EC2_HOME/bin:$EC2_AMI_HOME/bin:$PATH"
export JAVA_HOME="/Library/Java/Home"

export BLUE="\[\033[0;34m\]"
export NO_COLOR="\[\e[0m\]"
export GRAY="\[\033[1;30m\]"
export GREEN="\[\033[0;32m\]"
export LIGHT_GRAY="\[\033[0;37m\]"
export LIGHT_GREEN="\[\033[1;32m\]"
export LIGHT_RED="\[\033[1;31m\]"
export RED="\[\033[0;31m\]"
export WHITE="\[\033[1;37m\]"
export YELLOW="\[\033[0;33m\]"

# export DYLD_LIBRARY_PATH=/Users/vinioliveira/Developement/oracle/instantclient_10_2
# export SQLPATH=/Applications/oracle/instantclient_10_2
# export TNS_ADMIN=/Applications/oracle/network/admin
# export PATH=$PATH:$DYLD_LIBRARY_PATH

export DYLD_LIBRARY_PATH="/opt/oracle/instantclient"
# export SQLPATH="/opt/oracle/instantclient_10_2"
# export TNS_ADMIN="/opt/oracle/network/admin"
# export NLS_LANG="AMERICAN_AMERICA.UTF8"
export PATH=$PATH:$DYLD_LIBRARY_PATH
export PATH="$HOME/.rbenv/bin:$PATH"
