# some simple aliases
alias ll='ls -lF'
alias la='ls -AF'
alias  l='ls -CF'
alias ..='cd ..'


# disable less sniffing
unset LESSOPEN
unset LESSCLOSE


# alias for maven via hl
function mvn_with_hl() {
  mvn "${@}" 2>&1 | hl
}
alias mvn='mvn_with_hl'


# aliases regarding git
alias gitl='git log --remotes --graph --branches --decorate --oneline --tags'
alias gitlf="git log --remotes --graph --branches --pretty=format:'%C(auto)%h%d %s %Cgreen(%cr) %C(bold blue)%an%Creset'"
alias gitn="gitl -n25"
alias gits="git status -s"

alias fetchall='for DIR in `ls -d */`; do [ -d $DIR/.git ] && (cd $DIR && echo $DIR && git fetch --all 2>&1 | grep -- "->"); done'
alias statusall='for DIR in `ls -d */`; do [ -d $DIR/.git ] && ( cd $DIR && echo $DIR && gits); done'
alias repostatus='for DIR in `ls -d */`; do [ -d $DIR/.git ] && echo $DIR && (cd $DIR && git status | grep "Your branch" | grep -v "up-to-date" | sed "s/\(.*\)/\t\1/"); done'


# prompt customization
function determine_git_branch {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head == ref:\ refs/heads/* ]]; then
                git_branch=" ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=" ${head:0:7}"
            else
                git_branch=' (unknown)'
            fi
            return
        fi
        dir="../$dir"
    done
    git_branch=''
}

function determine_svn {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -d "$dir/.svn" ]; then
            svn_repo=' svn'
            return
        fi
        dir="../$dir"
    done
    svn_repo=''
}


normal='\e[0m'; red='\e[31;1m'; green='\e[32;1m'; yellow='\e[33;1m'; purple='\e[35;1m'; cyan='\e[36;1m';

export PROMPT_COMMAND='\
  RET=$?;\
  ERRMSG="";\
  if [[ $RET != 0 ]]; then\
    ERRMSG=" $RET";\
  fi;\
  determine_git_branch;
  determine_svn;
  PS1="$purple\u@\h$normal:$green\w$yellow$JAVA_DISPLAY$git_branch$svn_repo$red$ERRMSG$normal\n\$ ";\
'
# \u = user, \h = host, \w = working directory
