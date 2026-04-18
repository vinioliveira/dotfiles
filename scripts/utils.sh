# reload source
reload() {
  exec zsh;
}

pg() {
  op whoami &>/dev/null || op signin

  local item
  item=$(op item list --tags pgcli --format json 2>/dev/null \
    | jq -r '.[].title' \
    | fzf --prompt ' db  ' \
          --border=double \
          --border-label=' pg connections ' \
          --color 'border:#6C7086,label:#CDD6F4')
  [[ -z "$item" ]] && return

  local url
  url=$(op item get "$item" --fields label="connection string" --reveal --format json 2>/dev/null | jq -r '.value')
  [[ -z "$url" ]] && { echo "no 'connection string' field found in '$item'"; return 1; }

  pgcli "$url"
}

ts() {
  local result key query session
  result=$(
    tmux list-sessions -F '#{session_name}' 2>/dev/null \
    | fzf --border=double \
          --border-label=' tmux sessions ' \
          --color 'border:#6C7086,label:#CDD6F4' \
          --prompt '  ' \
          --print-query \
          --expect=ctrl-n \
          --header 'ctrl-n: new  ctrl-x: kill' \
          --bind 'ctrl-x:execute-silent(printf {} > /tmp/.ts_killed && tmux kill-session -t {})+reload(tmux list-sessions -F "#{session_name}" 2>/dev/null)+transform-header(printf "killed $(cat /tmp/.ts_killed)  |  ctrl-n: new  ctrl-x: kill")'
  )
  query=$(sed -n '1p' <<< "$result")
  key=$(sed -n '2p' <<< "$result")
  session=$(sed -n '3p' <<< "$result")

  if [[ "$key" == "ctrl-n" ]]; then
    [[ -z "$query" ]] && read "query?Session name: "
    [[ -z "$query" ]] && return
    if [[ -n "$TMUX" ]]; then
      tmux new-session -ds "$query" && tmux switch-client -t "$query"
    else
      tmux new-session -s "$query"
    fi
  elif [[ -n "$session" ]]; then
    if [[ -n "$TMUX" ]]; then
      tmux switch-client -t "$session"
    else
      tmux attach -t "$session"
    fi
  fi
}

_notify_terminal_pwd() {
  local host_name
  host_name="$(hostname -f 2>/dev/null || hostname)"
  printf '\033]7;file://%s%s\007' "$host_name" "$PWD"
}

#Let's create a variant of the gwcoi called gwfi for fullcast
# we want to reuse most if not all of the logic from gwcoi and gwcoid
# so we will create a function that takes the base path as an argument
# and then we will create gwcoi and gwfi that call that function with the appropriate base path

# copyai path: ~/dev/projects/copyai/copy-ai.git
# fullcast path: ~/dev/projects/fullcast/data-intelligence.git
_tmux_session_for_worktree() {
  local session_name="${1//\./_}"
  session_name="${session_name//\//_}"
  local target_dir="$2"

  if ! tmux has-session -t="$session_name" 2>/dev/null; then
    tmux new-session -ds "$session_name" -c "$target_dir"
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session_name"
  else
    tmux attach-session -t "$session_name"
  fi
}

_gw() {
  local GIT_WT_BASE_PATH=$1
  local origin=`pwd`
  builtin cd $GIT_WT_BASE_PATH
  local gwt_line=`g wt list | fzf`
  local gwt_path=`echo $gwt_line | sed 's/\([^[:space:]]*\).*$/\1/g'`
  if [[ ! -z $gwt_path ]]; then
    local branch=$(git -C "$gwt_path" rev-parse --abbrev-ref HEAD)
    _tmux_session_for_worktree "$branch" "$gwt_path"
  fi
  cd $origin
  _notify_terminal_pwd
}

gwcoi(){
  _gw ~/dev/projects/copyai/copy-ai.git
}

gwfi(){
  _gw ~/dev/projects/fullcast/data-intelligence.git
}

_gwo() {
  local GIT_WT_BASE_PATH=$1
  local branch=$2
  [[ -z "$branch" ]] && { echo "usage: gwfo/gwco <branch>"; return 1; }
  local gwt_path=$(git -C "$GIT_WT_BASE_PATH" worktree list | grep "\[$branch\]" | awk '{print $1}')
  if [[ -z "$gwt_path" ]]; then
    echo "No worktree found for branch '$branch'"
    return 1
  fi
  _tmux_session_for_worktree "$branch" "$gwt_path"
  _notify_terminal_pwd
}

gwco(){
  _gwo ~/dev/projects/copyai/copy-ai.git "$1"
}

gwfo(){
  _gwo ~/dev/projects/fullcast/data-intelligence.git "$1"
}

_gwd() {
  local GIT_WT_BASE_PATH=$1
  local origin=`pwd`
  builtin cd $GIT_WT_BASE_PATH
  local gwt_path=`g wt list | fzf | sed 's/\([^[:space:]]*\).*$/\1/g'`
  if [[ ! -z $gwt_path ]]; then
    cd $gwt_path
    local branch=`git rev-parse --abbrev-ref HEAD`
    echo "\e[1;41m Deleting worktree (  $branch ) \e[0m"

    if [[ `git status --porcelain` ]]; then
      echo "There are uncommitted changes. Do you want to continue? (y/n)"
      read -k 1 REPLY
      echo

      if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Deleting ... "
        git wt remove $gwt_path -f
      else
        echo "Aborted"
        return 1
      fi
    else
      echo "Deleting ... "
      git wt remove $gwt_path
    fi

    if [[ "$origin" == "$gwt_path" ]]; then
      cd ..
    else
      cd $origin
    fi
    _notify_terminal_pwd
  fi
}
gwcoid(){
  _gwd ~/dev/projects/copyai/copy-ai.git
}

gwfid(){
  _gwd ~/dev/projects/fullcast/data-intelligence.git
}


  # PATH=$(g wt list | sed  "$SED_REGEX/$SED_OUTPUT" | fzf | sed 's/^\([^[:space:]]*\)[[:space:]]*\([^[:space:]]*\).*\[\(.*\)\]$/\3 \[\2\] \1/g')
  # "cd $(g wt list | sed  's/\([^[:space:]]*\).\([^[:space:]]*\).*\[\(.*\)\]$/\3 \[\2\] \1/g' | fzf | sed  'ss/\([^[:space:]]*\).*$/\1/g')/\([^[:space:]]*\).*$/\1/g')"
# Check if given url is giving gzipped content
#
#   $ gzipped http://simplesideias.com.br
#
gzipped() {
  local r=`curl -L --write-out "%{size_download}" --output /dev/null --silent $1`
  local g=`curl -L -H "Accept-Encoding: gzip,deflate" --write-out "%{size_download}" --output /dev/null --silent $1`
  local message

  local rs=`expr ${r} / 1024`
  local gs=`expr ${g} / 1024`

  if [[ "$r" =  "$g" ]]; then
    message="Regular: ${rs}KB\n\033[31m → Gzip: ${gs}KB\033[0m"
  else
    message="Regular: ${rs}KB\n\033[32m → Gzip: ${gs}KB\033[0m"
  fi

  echo -e $message
  return 0
}

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1        ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1       ;;
      *.rar)       rar x $1     ;;
      *.gz)        gunzip $1     ;;
      *.tar)       tar xf $1        ;;
      *.tbz2)      tar xjf $1      ;;
      *.tgz)       tar xzf $1       ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1    ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#netinfo - shows network information for your system
netinfo () {
  echo "--------------- Network Information ---------------"
  /sbin/ifconfig | awk /'inet addr/ {print $2}'
  /sbin/ifconfig | awk /'Bcast/ {print $3}'
  /sbin/ifconfig | awk /'inet addr/ {print $4}'
  /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
  myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
  echo "${myip}"
  echo "---------------------------------------------------"
}

#dirsize - finds directory sizes and lists them for the current directory
dirsize () {
  du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
  egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
  egrep '^ *[0-9.]*M' /tmp/list
  egrep '^ *[0-9.]*G' /tmp/list
  rm -rf /tmp/list
}

#copy and go to dir
cpg (){
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

#move and go to dir
mvg (){
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}

fbr() {
  local branches branch
  # branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
    fzf --height 20% --reverse -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

colortab() {
  for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
      printf "\n";
    fi
  done
}

# autoload -U add-zsh-hook
# add-zsh-hook -Uz chpwd (){ ls -lhF; }
