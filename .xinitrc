#!/bin/sh

xrdb .Xresources

#export XMODIFIERS="@im=ibus"
#export XIM="ibus"
#export XIM_PROGRAM="ibus"
#export GTK_IM_MODULE="ibus"
#export QT_IM_MODULE="ibus"



export XIM=fcitx
export XIM_PROGRAM=fcitx
export XMODIFIERS="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
#exec fcitx &

#xcompmgr &
xsetroot -cursor_name left_ptr &

exec /usr/bin/awesome
#exec /usr/bin/xmonad
