# 
# This file is based on the configuration written by
# Bruno Bonfils, <asyd@debian-fr.org> 
# Written since summer 2001

#
# My functions (don't forget to modify fpath before call compinit !!)
# fpath=($HOME/.zsh/functions $fpath)
fpath=(~/.zsh/functions $fpath)

# colors
eval `dircolors $HOME/.zsh/colors`

autoload -U zutil
autoload -U complist
autoload -U compinit
compinit
autoload -U promptinit
promptinit
prompt gentoo

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:sudo:*' command-path /usr/sbin /sbin /usr/bin /bin

bindkey "\e[3~" delete-char # Delete
bindkey "\e[2~" overwrite-mode # Insert
bindkey "\e[4~" end-of-line # End
bindkey "\e[1~" beginning-of-line # Home


# Resource files
for file in $HOME/.zsh/rc/*.rc; do
	source $file
done

