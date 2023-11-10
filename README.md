![Luna Game Toolkit](media/LGT.png)

[![Chat on Discord](https://img.shields.io/discord/754884471324672040.svg?logo=discord)](https://discord.gg/tPWjMwK) [![Twitter Follow](https://img.shields.io/twitter/follow/tinyBigGAMES?style=social)](https://twitter.com/tinyBigGAMES)
# Luna Game Toolkit
### The easy, fast and fun 2D game development toolkit!

Allows you make games and other multimedia applications in Object Pascal.

### Overview
<img src="media/made-with-delphi.png" alt="Your Logo" width="64" height="64" align="left"  style="padding: 5px;" />
Luna Game Toolkit&trade; (LGT) is a indie game toolkit that allows you to do 2D game development in <a href="https://www.embarcadero.com/products/delphi" target="_blank"> Embarcadero Delphi®</a> for desktop PC's running Microsoft Windows® and uses OpenGL® for hardware accelerated rendering.

It's robust, designed for easy use and suitable for making all types of 2D games and other graphic simulations. You access the features from a simple and intuitive API, to allow you to develop your projects rapidly and efficiently. There is support for textures, audio samples, streaming music, video playback, loading resources directly from a compressed and encrypted archive and much more. It's easy, fast & fun!

<b>*Please star this repo by clicking the Star box in the top right corner and tell others about it if you find it useful!*</b>

if you wish to learn more about the Delphi language visit <a href="https://learndelphi.org/" target="_blank">learndelphi.org</a>.

### Features
- **Free** and open-source with a <a href="https://github.com/tinyBigGAMES/LunaGameToolkit/blob/main/LICENSE" target="_blank">BSD 3-Clause</a> license agreement.
- Written in **Object Pascal**
- Support Windows 64 bit platform
- Hardware accelerated with **OpenGL**
- You interact with the toolkit's classes and routines in the `LGT` unit.
- **Archive** (standard ZIP format, can be password protected)
- **Window** (OpenGL 2.x, vsync, primitives)
- **Texture** (JPG, PNG, TGA, GIF and more, image formats, color key transparency, scaling, rotation, flipped, tiled)
- **Input** (keyboard, mouse and game controller)
- **Video** (play, pause, rewind, MPEG-1 format)
- **Audio** (samples, streams, OGG/Vorbis format)
- **Font** (true type, glyphs are cached for efficiency)
- **Math** (point, vector, rect and other useful routines for 2D graphics)
- **Stream** (memory, file and zip, all resources can be loaded from any valid stream source)
- **Buffer** (virtual memory buffer, ring-buffer)
- **Timer** (deterministic, stop, start)
- **Lists** (double linked list, background task list)
- **Terminal** (routines to printing to and interacting with the app console)
- **Polygon** (local/world coordinates, scale, rotate, control segment visibility)
- **Starfield** (general purpose, 3D starfield)

### Minimum Requirements 
- Should work on Windows 10+ (64 bits)
- Should work on any Delphi version that support generics and can target Win64/Unicode

**NOTE: Made in Delphi 12/Windows 11, tested in Delphi CE, 11-12.**

### How to use in Delphi
- Unzip the archive to a desired location.
- Add `installdir\src`, folder to Delphi's library path so the library source files can be found for any project or for a specific project add to its search path.
- In Delphi, load `DelphiGamekit.groupproj` to load and compile the examples/demos/tools, which will showcase the toolkit features and how to use them.
- See examples in the `installdir\examples` folder for more information about usage.
- The dependencies DLL can be built using the VS2022 solution located in `installdir\src\deps\externs\LGT.Deps`. Build the solution and it will build the DLL, automatically convert it to `LGT.Deps.res` and place it inside `installdir\src`. It will then be linked directly into your project when you reference `LGT.pas`, thus no external DLLs that you have to manage.

### Known Issues
- This project is in active development so changes will be frequent 
- Documentation is WIP. They will continue to evolve
- More examples will continually be added over time

### Minimal Example
```Pascal
var
  LWindow: TlgWindow;
  LFont: TlgFont;
  LHudPos: TlgPoint;
begin
  // show LGT version info
  Console.PrintLn(LGT_PROJECT);

  // init window
  LWindow := TlgWindow.Init('Luna Game Toolkit: Minimal Example', 960, 540);

  // show gamepad info
  Console.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

  // init default font
  LFont := TlgFont.LoadDefault(LWindow, 10);

  // enter game loop
  while not LWindow.ShouldClose() do
  begin
    // start frame
    LWindow.StartFrame();

      // keyboard processing
      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      // mouse processing
      if LWindow.GetMouseButton(MOUSE_BUTTON_LEFT, isWasPressed) then
        LWindow.SetShouldClose(True);

      // gamepad processing
      if LWindow.GetGamepadButton(GAMEPAD_1, GAMEPAD_BUTTON_X, isWasReleased) then
        LWindow.SetShouldClose(True);

      // start drawing
      LWindow.StartDrawing();

        // clear window
        LWindow.Clear(DARKSLATEBROWN);

        // display hud
        LHudPos := Math.Point(3,3);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft,  '%d fps',
          [Timer.FrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'ESC - Quit',
          []);

      // end drawing
      LWindow.EndDrawing();

    // end frame
    LWindow.EndFrame();
  end;

  // free font
  LFont.Free();

  // free window
  LWindow.Free();
end.
```

### Media

### Support
- <a href="https://github.com/tinyBigGAMES/LunaGameToolkit/issues" target="_blank">Issues</a>
- <a href="https://github.com/tinyBigGAMES/LunaGameToolkit/discussions" target="_blank">Discussions</a>
- <a href="https://learndelphi.org/" target="_blank">learndelphi.org</a>

<p align="center">
  <img src="media/techpartner-white.png" alt="Embarcadero Technical Partner Logo" width="200"/>
  <br>
  Proud to be an <strong>Embarcadero Technical Partner</strong>.
</p>
<small>As an Embarcadero Technical Partner, I'm committed to providing high-quality Delphi components and tools that enhance developer productivity and harness the power of Embarcadero's developer tools.</small>


