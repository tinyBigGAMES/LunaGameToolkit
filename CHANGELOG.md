### >>> CHANGELOG <<<

### Version 0.3.0:
- Added startup dialog to Testbed app
- Added [res] folder,  [startupdialog] folder with banner.png, README.rtf and LICENSE.rtf
- Added TlgStartupDialog
- Added methods to TlgUtils: GotoURL, GetComputerName, GetLoggedUserName, GetOSVersion, GetNow, GetDiskFreeSpace, GetMemoryFree, GetVideoCardName, GetAppName, GetAppPath, GetCPUCount, GetAppVersionStr, GetAppVersionFullStr, GetModuleVersionFullStr, GetModuleVersionFullStr
- Added Make, Fade and Equal methods to TlgColor record
- Added more CriticalSection guards around audio routines to fix intermittent memory leaks 

### Version 0.2.0:
- Update Testbed to use TlgTreeMenu and TlgGameApp class
- Added TlgTreeMenu
- Update TlgGame, added TlgBaseGame, TlgGameApp
- Added TlgActor, TlgActorList, TlgActorScene, TlgEntityActor and example
- Added lgInit, lgIsInit and lgQuit for manual control of toolkit init/shutdown
- Added TlgSprite, TlgEntity classes and example
- Add TlgTimer record and example
- Fix TlgMath.ClipValueInt/ClipValueFloat/ClipValueDouble not return the proper range when using Wrap mode
- Replaced pocketlang with LuaJIT integration 
- Added TlgTexture.CollideAABB/CollideOBB collision detection and example
- Added TlgStarfield class and example
- Fixed Math.RandomRange(..): Double to return correct range of values
- Added TlgPolygon class and example
- Update TlgWindow to manage window size/dpi change on multimon
- Added TlgVideo.LoadFromFile/LoadFromZipFile
- Added TlgGame class, lgRunGame routine
- Renamed TlgConsole to TlgTerminal
- Added TlgTexture.Lock/Unlock/GetPixel/SetPixel()
- Added TlgWindow.GetPixel/SetPixel()
- Added pocketlang scripting
- Added first draft docs (LGT.chm, LGT.pdf)
- Add a Sleep(0) to the while loop in TlgTaskList.Start()
- Update TlgTexture.DrawTiled(), replace  AViewportWidth, AViewportHeight with AWindow: TlgWindow and get the viewport from
  the active window

### Version 0.1.0:
- Initial Release