# reload source
reload() {
  exec zsh;
}

gwcoi() {
  local GIT_WT_BASE_PATH=~/dev/projects/copyai/copy-ai.git
  local origin=`pwd`
  builtin cd $GIT_WT_BASE_PATH
  local gwt_path=`g wt list | fzf | sed 's/\([^[:space:]]*\).*$/\1/g'`
  if [[ ! -z $gwt_path ]]; then
    cd $gwt_path
  else
    cd $origin
  fi
}

gwcoid() {
  local GIT_WT_BASE_PATH=~/dev/projects/copyai/copy-ai.git
  local origin=`pwd`
  builtin cd $GIT_WT_BASE_PATH
  local gwt_path=`g wt list | fzf | sed 's/\([^[:space:]]*\).*$/\1/g'`
  if [[ ! -z $gwt_path ]]; then
    echo $gwt_path
    echo "Deleting ... "
    cd $gwt_path
    git wt remove $gwt_path
    if [[ "$origin" == "$gwt_path" ]]; then
      cd ..
    else
      cd $origin
    fi
  fi
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
