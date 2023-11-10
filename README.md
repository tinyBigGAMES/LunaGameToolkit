![Luna Game Toolkit](media/LGT.png)

[![Chat on Discord](https://img.shields.io/discord/754884471324672040.svg?logo=discord)](https://discord.gg/tPWjMwK) [![Twitter Follow](https://img.shields.io/twitter/follow/tinyBigGAMES?style=social)](https://twitter.com/tinyBigGAMES)
# Luna Game Toolkit
### The easy, fast and fun 2D game development toolkit!

Allows you make games and other multimedia applications in Object Pascal.

### Overview
<img src="media/made-with-delphi.png" alt="Your Logo" width="64" height="64" align="left"  style="padding: 5px;" />The Luna Game Toolkit&trade; (LGT) represents a premier independent toolkit tailored for the creation of 2D games utilizing <a href="https://www.embarcadero.com/products/delphi" target="_blank">Embarcadero Delphi®</a>, optimized for desktop PCs operating on Microsoft Windows® and leveraging OpenGL® for enhanced hardware-accelerated rendering.

Crafted for robust performance and user-friendly operation, LGT is versatile enough to facilitate the development of a wide array of 2D gaming genres and graphical simulations. It offers a straightforward and intuitive API, enabling rapid and efficient project development. The toolkit encompasses comprehensive support for textures, audio sampling, music streaming, video playback, and the capability to load resources seamlessly from compressed and encrypted archives, among other features. With LGT, the experience of game development is streamlined, swift, and enjoyable.

<b>*Please star this repo by clicking the Star box in the top right corner and tell others about it if you find it useful!*</b>

if you wish to learn more about the Delphi language visit <a href="https://learndelphi.org/" target="_blank">learndelphi.org</a>.

### Downloads
<a href="https://github.com/tinyBigGAMES/LunaGameToolkit/archive/refs/heads/main.zip" target="_blank">**Development**</a> - This build represents the most recent development state an as such may or may not be as stable as the official release versions. If you like living on the bleeding edge, it's updated frequently (often daily) and will contain bug fixes and new features.

<a href="https://github.com/tinyBigGAMES/LunaGameToolkit/releases" target="_blank">**Releases**</a> - These are the official release versions and deemed to be the most stable.

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
- **Timer** (deterministic, start, stop, check elapsed time)
- **Lists** (double linked list, background task list)
- **Terminal** (routines to printing to and interacting with the app console)
- **Polygon** (local/world coordinates, scale, rotate, control segment visibility)
- **Starfield** (general purpose, 3D starfield)
- **Actor** (Actor, ActorList, ActorScene and EntityActor, allows object and scene management )

### Minimum Requirements 
- Should work on Windows 10+ (64 bits)
- Should work on any Delphi version that support generics and can target Win64/Unicode

**NOTE: Made in Delphi 12/Windows 11, tested in Delphi CE, 11-12.**

### How to use in Delphi
- Please extract the contents of the archive to your preferred directory.
- Incorporate the `installdir\src` directory into Delphi’s library path to ensure the library's source files are discoverable for any project. For project-specific access, append the same to the project's search path.
- Proceed to open `DelphiGamekit.groupproj` in Delphi to compile and execute the examples, demonstrations, and tools. This will provide a comprehensive display of the toolkit's capabilities and its application methodology.
- For further insights into utilization, refer to the samples provided within the `installdir\examples` directory. To observe the Luna Game Toolkit features in action, compile and execute the `Testbed` application. It is imperative to construct the `Data.zip` archive since it is a prerequisite for most examples. To assemble the archive, initiate `Testbed`, and navigate to `Misc->Build Zip Archive`.
- Should there be a necessity to reconstruct the dependency DLLs, they can be generated using the Visual Studio 2022 solution found at `installdir\src\deps\externs\LGT.Deps`. Compiling this solution will produce the dependency DLL, which is then automatically transformed into `LGT.Deps.res` and placed in the `installdir\src` directory. Consequently, it will be embedded directly into your project upon referencing `LGT.pas`, obviating the need to handle external DLLs manually.

### Known Issues
- This project is currently undergoing active development, and as such, frequent updates can be expected. The primary repository will be consistently updated with the latest features and bug fixes. Although this version is less stable, it is generally secure to use as we diligently strive to maintain its stability and currency.
- The project's documentation is a work in progress, reflecting the ongoing evolution of the project itself. It will be refined and expanded to ensure clarity and comprehensiveness.
- Additionally, we will be progressively augmenting our repository with a broader range of examples to facilitate a deeper understanding and more extensive utilization of the toolkit.

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
Our development motto: 
- We will not release products that are buggy, incomplete, adding new features over not fixing underlying issues.
- We will strive to fix issues found with our products in a timely manner.
- We will maintain an attitude of quality over quantity for our products.
- We will establish a great rapport with users/customers, with communication, transparency and respect, always encouragingng feedback to help shape the direction of our products.
- We will be decent, fair, remain humble and committed to the craft.

### Links
- <a href="https://github.com/tinyBigGAMES/LunaGameToolkit/issues" target="_blank">Issues</a>
- <a href="https://github.com/tinyBigGAMES/LunaGameToolkit/discussions" target="_blank">Discussions</a>
- <a href="https://learndelphi.org/" target="_blank">learndelphi.org</a>

<p align="center">
  <img src="media/techpartner-white.png" alt="Embarcadero Technical Partner Logo" width="200"/>
  <br>
  Proud to be an <strong>Embarcadero Technical Partner</strong>.
</p>
<sub>As an Embarcadero Technical Partner, I'm committed to providing high-quality Delphi components and tools that enhance developer productivity and harness the power of Embarcadero's developer tools.</sub>


