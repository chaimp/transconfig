#!/bin/sh


#xcompmgr &
#xcompmgr -cCfF -r7 -o.65 -l-10 -t-8 -D7 &

xrdb .Xresources
export GTK2_RC_FILES="`pwd`/.gtkrc-2.0"
export SAL_USE_VCLPLUGIN="gtk"
#export OOO_FORCE_DESKTOP="gnome"


#while true;
#do
#   find $HOME/.wallpaper -type f -name '*.jpg' -o -name '*.png' | shuf -n 1 | xargs feh --bg-scale
#   sleep 15m
#done &

feh --bg-scale $HOME/win7-2.jpg &

xsetroot -cursor_name left_ptr &

#trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand true --width 10 --transparent true --tint 0x191970 --height 12 &

#export XMODIFIERS="@im=ibus"
#export XIM="ibus"
#export XIM_PROGRAM="ibus"
#export GTK_IM_MODULE="ibus"
#export QT_IM_MODULE="ibus"
#ibus-daemon -d -x &

fcitx &
parcellite &
wicd-client &

xset r rate 280 25

#DEFAULT_SESSION=awesome
#case $1 in
#  awesome) exec /usr/bin/awesome ;;
#  xfce4) exec /usr/bin/tartxfce4 ;;
#  xmonad) exec /usr/bin/xmonad ;;
#  *) exec $DEFAULT_SESSION ;;
#esac

#.xmonad/conkyscript &
#sleep 6 && xmobar &

exec /usr/bin/awesome
#exec gnome-session
#exec enlightenment_start
#exec startkde
