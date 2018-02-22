# some simple aliases
alias ll='ls -lF'
alias la='ls -AF'
alias  l='ls -CF'
alias ..='cd ..'

# disable less sniffing
unset LESSOPEN
unset LESSCLOSE

# git aliases
alias gitl='git log --remotes --graph --branches --decorate --oneline --tags'
alias gitlf="git log --remotes --graph --branches --pretty=format:'%C(auto)%h%d %s %Cgreen(%cr) %C(bold blue)%an%Creset'"
alias gitn="gitl -n25"
alias gits="git status -s"
alias gitignored='git ls-files --others -i --exclude-standard'

alias fetchall='for DIR in `ls -d */`; do [ -d $DIR/.git ] && (cd $DIR && echo $DIR && git fetch --all 2>&1 | grep -- "->"); done'
alias statusall='for DIR in `ls -d */`; do [ -d $DIR/.git ] && ( cd $DIR && echo $DIR && gits); done'
alias repostatus='for DIR in `ls -d */`; do [ -d $DIR/.git ] && echo $DIR && (cd $DIR && git status | grep "Your branch" | grep -v "up-to-date" | sed "s/\(.*\)/\t\1/"); done'
