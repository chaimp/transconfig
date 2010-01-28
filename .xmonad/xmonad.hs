import XMonad
import Data.Monoid
import System.Exit
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Prompt.XMonad
import XMonad.Prompt.AppLauncher

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName 
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout
import XMonad.Layout.Accordion
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders

import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.XSelection
import XMonad.Util.WorkspaceCompare
import XMonad.Util.WindowProperties
import XMonad.Util.NamedWindows (getName)

import XMonad.Actions.SinkAll
import XMonad.Actions.CycleWS
import XMonad.Actions.NoBorders
import Data.List(isPrefixOf)
import Data.Ratio ((%))
import qualified System.IO.UTF8 as U
import qualified XMonad.StackSet as W
import qualified XMonad.Actions.FlexibleResize as Flex
import qualified Data.Map        as M

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myBorderWidth   = 0
myNormalBorderColor  = "#729fcf"
myFocusedBorderColor = "#7292cf"


myFont               = "xft:WenQuanYi Micro Hei:pixelsize=8"
-- dzen settings:
dzFont             = "WenQuanYi Micro Hei-8:Bold"
--dzFont             = "OpenLogos-8"
dzFgColor          = "skyblue"
dzBgColor          = "#729fcf"

--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_r     ), spawn "exe=`dmenu_run` && eval \"exec $exe\"")
    , ((modm .|. shiftMask, xK_r     ), spawn "gmrun")
    , ((modm .|. shiftMask, xK_c     ), kill)
    , ((0 ,                0x1008ff11), spawn "ossmix vmix0-outvol -- -1")
    , ((0 ,                0x1008ff13), spawn "ossmix vmix0-outvol -- +1")
    , ((0 ,                0x1008ff2f), spawn "gksudo pm-suspend")
    , ((0 ,                0x1008ff93), spawn "gksudo pm-hibernate")
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n     ), refresh)
    , ((modm,               xK_b     ), sendMessage ToggleStruts)
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_5]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_p] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]


myManageHook = composeAll . concat $
    [ [className =? c  --> doFloat  | c <- myFloats]
    , [title     =? t  --> doFloat  | t <- myTitleFloats]
    , [resource  =? r  --> doIgnore | r <- myIgnores]
--    , [className =? s  --> doTile   | s <- myTiles]
    ]
    where
    myFloats      = ["Gpick", "Chromium-bin", "Gimp", "MPlayer", "Smplayer", "Realplay", "Vlc", "Lxrandr", "Audacious2", "VirtualBox", "Firefox", "Firefox-bin", "Linux-fetion", "Gmlive"]
    myTitleFloats = ["Downloads", "Preferences", "Save As...", "Add-ons", "Firefox", "Chromium", "exe", "Options", "首选项", "Wicd Network Manager"]
    myIgnores     = ["trayer", "dzen", "stalonetray"]
--    myTiles       = ["tilda", "pcmanfm", "thunar", "dolphin", "lxterminal"]

myStatusBar :: String
myStatusBar = "dzen2  -fg '" ++ dzFgColor ++ "' -bg '" ++ dzBgColor ++ "' -e 'button3=' -h '20' -fn '" ++ dzFont ++ "' -ta l"
myConkyBar :: String
--myConkyBar = "conky | dzen2 -fg '" ++ dzFgColor ++ "' -bg '" ++ dzBgColor ++ "' -x '700' -h '20' -fn '" ++ dzFont ++ "' -sa c -ta r"
myConkyBar = "sleep 1; conky | dzen2 -e '' -h '20' -x '780' -ta r -fg '" ++ dzFgColor ++ "' -bg '" ++dzBgColor ++ "' -fn '" ++ dzFont ++ "'"
mySysTray :: String
mySysTray = "sleep 3; trayer --expand true  --alpha 0 --edge top --align right --SetDockType true --transparent flase --SetPartialStrut true --widthtype request --tint 0x729fcf --height 20 --margin 53"

 
myLogHook h = dynamicLogWithPP $ defaultPP
      { ppCurrent     = dzenColor "#4386CE" "#E2EDF9" . pad
        , ppVisible     = dzenColor "skyblue" "" . pad 
        , ppHidden      = dzenColor "#204a87"  "#8fb580" . pad 
        , ppHiddenNoWindows = dzenColor "#4e9a06" "#8FB171" . pad 
        , ppUrgent      = dzenColor "#2e3436" "#fce94f" . pad 
        , ppWsSep    = ""
        , ppSep      = "|"
        , ppLayout   = dzenColor "skyblue" "" .
                          (\ x -> case x of
                              "Tall"                   -> "^i(/home/zhou/.xmonad/dzen/layouts/tile.xpm)"
                              "Mirror Tall"            -> "^i(/home/zhou/.xmonad/dzen/layouts/tilebottom.xpm)"
                              "Full"                   -> "^i(/home/zhou/.xmonad/dzen/layouts/fullscreen.xpm)"
                              "Grid"                   -> "^i(/home/zhou/.xmonad/dzen/layouts/fairv.xpm)"
                              "Spiral"                 -> "(@)"
                              "Accordion"              -> "Acc"
                              "Tabbed Simplest"        -> "Tab"
                              "Tabbed Bottom Simplest" -> "TaB"
                              "Simple Float"           -> "^i(/home/zhou/.xmonad/dzen/layouts/floating.xpm)"
                              "IM"                     -> "IM "
                              "Dishes 2 (1%6)"         -> "Dsh"
                              _                        -> pad x
                          )
        , ppTitle    = (" " ++) . dzenColor "white" "" . dzenEscape
        , ppOutput   = hPutStrLn h
      }

--
-- Layouts
genericLayout = tiled
            ||| Mirror tiled ||| Full ||| Grid ||| Accordion ||| simpleFloat
--            ||| imLayout
--            ||| titled
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio = 1/2
     -- Percent of screen to increment by when resizing panes
     delta = 3/100
myLayout =  genericLayout

main :: IO ()
main = do
  spawn "killall trayer"
  dzen <- spawnPipe myStatusBar
  spawn myConkyBar
  spawn mySysTray
--  spawn "xcompmgr"

  xmonad $ ewmh defaultConfig {
         modMask = mod4Mask
       , borderWidth = myBorderWidth
       , terminal = "lxterminal"
       , manageHook = manageDocks <+> manageHook defaultConfig <+> myManageHook
       , logHook    = myLogHook dzen >> fadeInactiveLogHook 0xdddddddd
--       , logHook = ewmhDesktopsLogHook >> (dynamicLogWithPP $ myLogHook dzen)
--       , layoutHook = ewmhDesktopsEventHook $ avoidStruts $ myLayout
       , layoutHook = avoidStruts $ myLayout
       , workspaces = ["^ca(1,xdotool key super+1)^fn(OpenLogos-9)Q^fn(Microsoft YaHei-8)transtone^ca()","^ca(1,xdotool key super+2)^fn(OpenLogos-11)P^fn(Microsoft YaHei-8)冲浪^ca()","^ca(1,xdotool key super+3)^fn(OpenLogos-9)U^fn(Microsoft YaHei-8)文档^ca()","^ca(1,xdotool key super+4)^fn(OpenLogos-9)J^fn(Microsoft YaHei-8)虚拟^ca()","^ca(1,xdotool key super+5)^fn(OpenLogos-9)T^fn(Microsoft YaHei-8)游戏^ca()^fn(WenQuanYi Micro Hei-8:bold)"]
      -- key bindings
       , keys               = myKeys
       , mouseBindings      = myMouseBindings
       
       }

