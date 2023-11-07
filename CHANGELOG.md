### >>> CHANGELOG <<<

### Version 0.2.0:
- Added lgActor, lgActorList, lgActorScene, lgEntityActor and example
- Added lgInit, lgIsInit and lgQuit for manual control of toolkit init/shutdown
- Added TlgSprite, TlgEntity classes and example
- Add TlgTimer record and example
- Fix TlgMath.ClipValueInt/ClipValueFloat/ClipValueDouble not return the proper range when usnig Wrap mode
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