[[ -f /etc/profile.d/bash-completion ]] && source /etc/profile.d/bash-completion

PS1='\[\e[01;32m\][\u@\[\e[01;33m\]\h \[\e[01;34m\]\W] `[[ -d .git ]] && echo -n -e "\[\e[01;33m\](branch:$(git branch | sed -e "/^ /d" -e "s/* \(.*\)/\1/"))\[\e[01;34m\] "`\$ \[\e[00m\]'
