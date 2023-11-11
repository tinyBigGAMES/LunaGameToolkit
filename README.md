![Luna Game Toolkit](media/LGT.png)

[![Chat on Discord](https://img.shields.io/discord/754884471324672040.svg?logo=discord)](https://discord.gg/tPWjMwK) [![Twitter Follow](https://img.shields.io/twitter/follow/tinyBigGAMES?style=social)](https://twitter.com/tinyBigGAMES)
# Luna Game Toolkit
### The easy, fast and fun 2D game development framework!

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
LGT offers an extensive suite of features:
- It is distributed freely as an open-source solution, under the permissive <a href="https://github.com/tinyBigGAMES/LunaGameToolkit/blob/main/LICENSE" target="_blank">BSD 3-Clause</a> License.
- The toolkit is developed in Object Pascal, ensuring a high level of performance and reliability.
- Exclusively supports the Windows 64-bit platform, providing a focused and optimized development environment.
- Incorporates hardware acceleration through OpenGL, ensuring optimal rendering performance.
- Facilitates interaction with a comprehensive set of classes and routines encapsulated within the LGT unit.
- Features an archive system compatible with standard ZIP format, including support for password protection.
- Provides a windowing system with OpenGL 2.x support, vertical synchronization, and primitive shapes.
- Offers a texture management system, supporting a variety of image formats (JPG, PNG, TGA, GIF, etc.), with capabilities such as color key transparency, scaling, rotation, and tiling.
- Includes input handling for keyboards, mice, and game controllers.
- Video support encompasses playback controls and compatibility with MPEG-1 format.
- Audio functionalities include sample playback, streaming capabilities, and support for OGG/Vorbis format.
- Font rendering is efficient, with true type font support and glyph caching.
- A math library is available for points, vectors, rectangles, and other utilities essential for 2D graphics.
- Streams for memory, files, and zip archives allow for resource loading from any valid stream source.
- Implements buffer management, including a virtual memory buffer and ring-buffer.
- Features a precise timer system for event management, with deterministic operations to start, stop, and check elapsed time.
- Incorporates list management, including double-linked lists and background task lists.
- Terminal utilities for outputting to and interacting with the application console are provided.
- Polygon manipulation is detailed, with support for local/world coordinates, scaling, rotating, and segment visibility control.
- Actor management is robust, featuring Actor, ActorList, ActorScene, and EntityActor for comprehensive object and scene management.
- The toolkit encompasses a versatile 3D starfield module, alongside an array of readily-integrable classes, designed to accelerate the development process.

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
  Terminal.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

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


