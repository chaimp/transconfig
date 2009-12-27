import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.EZConfig
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
import XMonad.Actions.SinkAll
import XMonad.Actions.CycleWS
import XMonad.Actions.NoBorders
import Data.List
import Data.Ratio ((%))
import qualified System.IO.UTF8 as U
import qualified XMonad.StackSet as W
import qualified XMonad.Actions.FlexibleResize as Flex
import qualified Data.Map        as M

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False
myBorderWidth   = 0
myNormalBorderColor  = "#729fcf"
myFocusedBorderColor = "#7292cf"


myFont               = "xft:WenQuanYi Micro Hei:pixelsize=8"
-- dzen settings:
dzFont             = "WenQuanYi Micro Hei-8:Bold"
--dzFont             = "OpenLogos-8"
dzFgColor          = "#2e3436"
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
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
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
    ]
    where
    myFloats      = ["Gpick", "Gimp", "MPlayer", "Smplayer", "Realplay", "Lxrandr", "Audacious2", "VirtualBox"]
    myTitleFloats = ["Downloads", "Preferences", "Save As..."]
    myIgnores     = ["trayer", "dzen", "stalonetray"]

-- Dzen+stalonetray > *
myStatusBar :: String
myStatusBar = "dzen2 -fg '" ++ dzFgColor ++ "' -bg '" ++ dzBgColor ++ "' -h '20' -fn '" ++ dzFont ++ "' -sa c -ta l"
myConkyBar :: String
--myConkyBar = "conky | dzen2 -fg '" ++ dzFgColor ++ "' -bg '" ++ dzBgColor ++ "' -x '700' -h '20' -fn '" ++ dzFont ++ "' -sa c -ta r"
myConkyBar = "sleep 1; conky | dzen2 -e '' -h '20' -x '750' -w '600' -ta r -fg '" ++ dzFgColor ++ "' -bg '" ++dzBgColor ++ "' -fn '" ++ dzFont ++ "'"
mySysTray :: String
mySysTray = "trayer --expand true  --alpha 255 --edge top --align right --expand true --SetDockType true --SetPartialStrut true --widthtype request --width 16 --tint 0x191970 --height 20 --margin 5"
--mySysTray = "stalonetray -i 18 --max-width 20 --icon-gravity N --geometry 18x18-0+17 -bg '#000000' --sticky --skip-taskbar --window-type dock -w"



myLogHook h = dynamicLogWithPP $ defaultPP

      { ppCurrent     = dzenColor "#2e3436" "#e2eeea" . pad
        , ppVisible     = dzenColor "white" "" . pad
        , ppHidden      = dzenColor "white" "" . pad
        , ppHiddenNoWindows = dzenColor "#444444"  "" . pad
        , ppUrgent      = dzenColor "#2e3436" "#fce94f"
        , ppWsSep    = ""
        , ppSep      = "|"
        , ppLayout   = dzenColor "white" "" .
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
myTabConfig = defaultTheme {
            activeColor           = "#333399"
            , activeBorderColor   = "#888888"
            , activeTextColor     = "#FFFFFF"
            , inactiveColor       = "#333344"
            , inactiveBorderColor = "#888888"
            , inactiveTextColor   = "#FFFFFF"
            , decoHeight          = 18
            , fontName            = myFont
            }
tabbedLayout = tabbedBottom shrinkText myTabConfig

genericLayout = tiled
            ||| Mirror tiled
            ||| Full
            ||| Grid
            ||| Accordion
            ||| simpleFloat
            ||| tabbedLayout
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
--  spawn "killall dzen2 trayer"
  workspaceBarPipe <- spawnPipe myStatusBar
  spawn myConkyBar
  spawn mySysTray
--  spawn "xcompmgr"

  xmonad $ withUrgencyHook NoUrgencyHook defaultConfig {
         modMask = mod4Mask
       , borderWidth = myBorderWidth
       , terminal = "lxterminal"
       , manageHook = manageDocks <+> manageHook defaultConfig <+> myManageHook
       , logHook    = myLogHook workspaceBarPipe >> fadeInactiveLogHook 0xdddddddd
       , layoutHook = avoidStruts $ myLayout
       , workspaces = ["编辑", "冲浪", "文档", "游戏", "虚拟"]
      -- key bindings
       , keys               = myKeys
       , mouseBindings      = myMouseBindings
       
       }

