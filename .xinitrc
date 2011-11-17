#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
#XSESSION=xmonad
# merge in defaults and keymaps

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#修正OOo界面与系统一致
export GTK2_RC_FILES="`pwd`/.gtkrc-2.0"
export XDG_MENU_PREFIX=lxde-
export SAL_USE_VCLPLUGIN="gtk"
export XMODIFIERS="@im=fcitx"
export XIM=fcitx
export XIM_PROGRAM=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

habak -ms -hi /usr/share/wallpapers/Lovelock_Stripes/contents/images/1280x800.png &

xset r rate 250 25 &
#xset m 3 1
xsetroot -cursor_name left_ptr &

#parcellite &
#wicd-client &
#nm-applet &
#volumeicon &
#tint2 &
#cairo-dock -o &
#unclutter -root -jitter 150 &
#urxvt &
xmonad
