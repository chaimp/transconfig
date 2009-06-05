import XMonad

import XMonad.Actions.CycleWS
import XMonad.Actions.SwapWorkspaces
import XMonad.Actions.Submap
import XMonad.Actions.WindowGo

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog

import XMonad.Util.Run(spawnPipe)

import XMonad.Layout.TwoPane
import XMonad.Layout.MosaicAlt
import XMonad.Layout.Combo
import XMonad.Layout.WindowNavigation
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders

import qualified XMonad.StackSet as W 
import qualified System.IO.UTF8 as U

import Data.Bits ((.|.))
import qualified Data.Map as M

import System.Exit
import System.IO
 
--statusBarCmd= "dzen2 -bg '#324c80' -fg '#adbadd' -e 'button1=exec:roxterm' -ta l -w 400 -fn '-misc-fixed-medium-r-normal-*-14-*-*-*-*-*-*-*'"

main = do
    xmproc <- spawnPipe "xmobar"
    panel <- spawnPipe "xfce4-panel"
    --din <- spawnPipe statusBarCmd
    xmonad $ defaultConfig
            { borderWidth		= 1
            , focusedBorderColor 	= "#324c80"
            , normalBorderColor 	= "#2222aa"
            , manageHook   	= manageHook defaultConfig <+>  myManageHook <+> manageDocks
            , terminal		= "lxterminal"
            , modMask      	= mod4Mask
            , workspaces = map show ["1-www", "2-kvm", "3-video", "4-learn", "5-game" ]
            , startupHook  	= myStartupHook
            , layoutHook  	= windowNavigation $ avoidStruts $ smartBorders $ layoutHook defaultConfig
            , logHook = dynamicLogWithPP $ xmobarPP { 
                          ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "liteskyblue" "" . shorten 50
                        }
            -- ,logHook         = dynamicLogWithPP $ dzenPP { ppOutput = hPutStrLn din -}
            -- , logHook    = ewmhDesktopsLogHook
            -- , layoutHook = ewmhDesktopsLayout $ avoidStruts $ layoutHook defaultConfig
            -- , manageHook = manageHook defaultConfig <+> manageDocks

            , keys 			= \c -> myKeys c `M.union` keys defaultConfig c
            }
	where 
        myStartupHook :: X ()
        myStartupHook = do
          spawn "tilda"
          --                    spawn "/home/zhou/kvm.sh"

        myManageHook :: ManageHook
        myManageHook = composeAll
            [(role =? "gimp-toolbox" <||> role =? "gimp-image-window") --> (ask >>= doF . W.sink)
            ,(className =? "Firefox" <&&> resource =? "Dialog") --> doFloat
            ,(className =? "Gimp")  --> doFloat
            ,(className =? "Emenese")  --> doFloat
            ,(className =? "Vncviewer")  --> doFloat
            ,(className =? "Thunderbird-bin") --> doShift "3"
            ]
           where role = stringProperty "WM_WINDOW_ROLE"
           
        myKeys (XConfig {modMask = modm}) = M.fromList $
            -- Apps and tools
            [ ((modm, xK_r), spawn "dmenu_run")
            , ((modm, xK_p), runOrRaise "thunar" (className =?"Thunar"))
            , ((modm, xK_s), spawn "sleep 0.2; scrot -s")
            , ((modm .|. shiftMask, xK_s), spawn "scrot '/tmp/%Y-%m-%d_%H:%M:%S_$wx$h_scrot.png' -e 'mv $f ~'")
            , ((modm, xK_b), runOrRaise "firefox"  (className =?"Firefox"))
            , ((modm, xK_e), runOrRaise "emacsclient -c"  (className =?"Emacs"))

            -- Mosaic 
            --, ((modm, xK_KP_Add), withFocused (sendMessage . expandWindowAlt))
            --, ((modm, xK_KP_Subtract), withFocused (sendMessage . shrinkWindowAlt))
            --, ((modm .|. controlMask, xK_space), sendMessage resetAlt)

            -- Window Navigation
            -- select...
            , ((modm, xK_Right), sendMessage $ Go R)
            , ((modm, xK_Left ), sendMessage $ Go L)
            , ((modm, xK_Up   ), sendMessage $ Go U)
            , ((modm, xK_Down ), sendMessage $ Go D)

            -- swap...
            , ((modm .|. controlMask, xK_Right), sendMessage $ Swap R)
            , ((modm .|. controlMask, xK_Left ), sendMessage $ Swap L)
            , ((modm .|. controlMask, xK_Up   ), sendMessage $ Swap U)
            , ((modm .|. controlMask, xK_Down ), sendMessage $ Swap D)

            -- audio
            , ((0, 0x1008ff13), spawn "amixer -q sset PCM 2dB+") -- raise volume
            , ((0, 0x1008ff11), spawn "amixer -q sset PCM 2dB-") -- lower volume

            -- function keys
            
            ]
