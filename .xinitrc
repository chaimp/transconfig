#!/bin/sh

#使.Xresources中的设置生效
xrdb -merge .Xresources

#ck-launch-session lxde-session

#修正OOo界面与系统一致
export GTK2_RC_FILES="`pwd`/.gtkrc-2.0"
export SAL_USE_VCLPLUGIN="gtk"
#export OOO_FORCE_DESKTOP="gnome"

#export GTK_MODULES=globalmenu-gnome
#gnome-panel &

#桌面背景图片轮换
#while true;
#do
#   find $HOME/.wallpaper -type f -name '*.jpg' -o -name '*.png' | shuf -n 1 | xargs feh --bg-scale
#   sleep 15m
#done &

#桌面背景设置
feh --bg-scale $HOME/win7-2.jpg &

#鼠标样式修正
xsetroot -cursor_name left_ptr &

#输入法环境变量
#export XMODIFIERS="@im=ibus"
#export XIM="ibus"
#export XIM_PROGRAM="ibus"
#export GTK_IM_MODULE="ibus"
#export QT_IM_MODULE="ibus"
#ibus-daemon -d -x &

#启动时自动载入程序
fcitx &
parcellite &
#wicd-client &

#键盘按键反应速度修正
xset r rate 280 25

#窗口管理器
exec /usr/bin/awesome
#exec gnome-session
#exec enlightenment_start
#exec startkde
#exec startxfce4

#exec ck-launch-session xmonad

