#!/bin/sh

#使.Xresources中的设置生效
xrdb -merge .Xresources

#修正OOo界面与系统一致
export GTK2_RC_FILES="`pwd`/.gtkrc-2.0"
export SAL_USE_VCLPLUGIN="gtk"

#桌面背景图片轮换
#while true;
#do
#   find $HOME/.wallpaper -type f -name '*.jpg' -o -name '*.png' | shuf -n 1 | xargs #feh --bg-scale
#   sleep 15m
#done &

#桌面背景设置
#feh --bg-scale $HOME/macosx.jpg &
#feh -Z --bg-scale $HOME/win8.jpg &
habak -ms -hi $HOME/win8.jpg &

xmodmap .Xmodmap

#输入法环境变量
#export XMODIFIERS="@im=ibus"
#export XIM="ibus"
#export XIM_PROGRAM="ibus"
#export GTK_IM_MODULE="ibus"
#export QT_IM_MODULE="ibus"
#ibus-daemon -d -x &

#启动时自动载入程序
parcellite &
wicd-client &
#nm-applet &
volumeicon &
tint2 &
#unclutter -root -jitter 150 &
urxvt &
#stjerm &

export XMODIFIERS="@im=fcitx"
export XIM="fcitx"
export XIM_PROGRAM="fcitx"
export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
fcitx &

#键盘按键反应速度修正
xset r rate 250 25
#xset m 3 1

#鼠标样式修正
xsetroot -cursor_name left_ptr &

#窗口管理器
#exec enlightenment_start
#exec  ck-launch-session startkde
#exec startxfce4
#exec ck-launch-session lxde-session
#exec ck-launch-session awesome
#exec ck-launch-session gnome-session
exec ck-launch-session xmonad
#exec ck-launch-session scrotwm
