import XMonad
import XMonad.Actions.Volume
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import System.IO
import Solarized

{- TODO-}
{- - Lock screen with control-shift-backspace-}

myManageHook = composeAll
    [ className =? "Dialog" --> doFloat
    , className =? ".blueman-manager-wrapped" --> doCenterFloat
    , className =? "Nm-connection-editor" --> doFloat
    , className =? "Xmessage" --> doCenterFloat
    ]

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ docks defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = smartBorders $ avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppCurrent = xmobarColor Solarized.base1 "" . wrap "[" "]"
            , ppTitle = xmobarColor Solarized.base1 "" . shorten 50
            }
        , borderWidth = 1
        , terminal = "st"
        , normalBorderColor = Solarized.base02
        , focusedBorderColor = Solarized.blue
        , modMask = mod4Mask    -- Super
        } `additionalKeysP`
        [ ("M-p", spawn "dmenu_run -fn cherry:pixelsize=13")
        , ("C-S-<Backspace>", spawn "slock")
        , ("M-b", sendMessage ToggleStruts)
        , ("<XF86AudioMute>", toggleMute >> return())
        , ("<XF86AudioLowerVolume>", lowerVolume 3 >> return())
        , ("<XF86AudioRaiseVolume>", raiseVolume 3 >> return())
        , ("<XF86AudioPrev>", spawn "playerctl --player=playerctld previous")
        , ("<XF86AudioPlay>", spawn "playerctl --player=playerctld play-pause")
        , ("<XF86AudioNext>", spawn "playerctl --player=playerctld next")
        ]
