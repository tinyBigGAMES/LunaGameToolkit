(* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
        .
     .--:         :
    ----        :---:
  .-----         .-.
 .------          .
 -------.
.--------               :
.---------             .:.
 ----------:            .
 :-----------:
  --------------:.         .:.
   :------------------------
    .---------------------.
       :---------------:.
          ..:::::::..
              ...
     _
    | |    _  _  _ _   __ _
    | |__ | || || ' \ / _` |
    |____| \_,_||_||_|\__,_|
         Game Toolkit™

Copyright © 2022-present tinyBigGAMES™ LLC
         All Rights Reserved.

Website: https://tinybiggames.com
Email  : support@tinybiggames.com

See LICENSE for license information
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *)

unit UTestbed;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Math,
  WinApi.Windows,
  LGT.Deps,
  LGT.OGL,
  LGT;

procedure RunTests;

implementation

const
  CZipFilename = 'Data.zip';

{------------------------------------------------------------------------------
 This example illustrates how to build a ZIP file.
----------------------------------------------------------------------------- }

procedure Test01;
begin
  Terminal.PrintLn(LGT_PROJECT+LF);

  Terminal.PrintLn('Building %s...', [CZipFilename]);

  if TlgZipStream.Build(CZipFilename, 'res', nil, nil) then
    Terminal.PrintLn(LF+LF+'Success!', [])
  else
    Terminal.PrintLn(LF+LF+'Failed!', []);
end;

{------------------------------------------------------------------------------
 This example illustrates the procedure for initializing the audio system.
----------------------------------------------------------------------------- }

procedure Test02();
var
  LAudio: TlgAudio;
begin
  Terminal.PrintLn(LGT_PROJECT+LF);

  LAudio := TlgAudio.Create();
  try
    if LAudio.Open() then
    begin
      Terminal.PrintLn('Audio device: %s', [LAudio.GetDeviceName()]);
      LAudio.Close();
    end;
  finally
    LAudio.Free();
  end;

end;

{------------------------------------------------------------------------------
 This example demonstrates the loading and playback of multichannel audio
 from a ZIP file.
----------------------------------------------------------------------------- }
procedure Test03();
var
  LZipFile: TlgZipFile;
  LAudio: TlgAudio;
  LSound: array[0..6] of TlgSound;
  LChan: array[0..15] of TlgSound;
  I: Integer;

  function FindFree(): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := 0 to 15 do
    begin
      if LChan[i].GetStatus = asStopped then
      begin
        Result := I;
        Exit;
      end;
    end;
  end;

  function Play(const Id: Integer): Integer;
  var
    LIndex: Integer;
  begin
    Result := -1;
    if not InRange(Id, 1, 6) then Exit;
    LIndex := FindFree();
    if LIndex = -1 then Exit;
    LChan[LIndex].Copy(LSound[Id], False);
    LChan[LIndex].Play(True);
    Result := LIndex;
  end;

begin
  Terminal.PrintLn(LGT_PROJECT+LF);

  LZipFile := TlgZipFile.Create();
  LZipFile.Open(CZipFilename);

  LAudio := TlgAudio.Create();
  LAudio.Open();

  for I := 0 to 15 do
  begin
    LChan[I] := TlgSound.Create(LAudio);
  end;

  // load music
  LSound[0] := TlgSound.LoadFromZipFile(LAudio, LZipFile, 'res/music/song01.ogg', slStream);
  LSound[0].Play(True);
  LSound[0].SetLooping(True);

  // load sfx
  for I := 1 to 6 do
  begin
    LSound[I] := TlgSound.LoadFromZipFile(LAudio, LZipFile, Format('res/sfx/samp%d.ogg',[I-1]), slMemory);
  end;

  Terminal.PrintLn('Press 1-6 to play sound, ESC to quit...');

  while true do
  begin
    Timer.Start();

    if Terminal.KeyWasPressed(Ord('1')) then Play(1);
    if Terminal.KeyWasPressed(Ord('2')) then Play(2);
    if Terminal.KeyWasPressed(Ord('3')) then Play(3);
    if Terminal.KeyWasPressed(Ord('4')) then Play(4);
    if Terminal.KeyWasPressed(Ord('5')) then Play(5);
    if Terminal.KeyWasPressed(Ord('6')) then Play(6);

    if Terminal.KeyWasPressed(VK_ESCAPE) then Break;

    Timer.Stop();

    Terminal.SetTitle('LGT (%d fps)', [Timer.FrameRate()]);
  end;

  for I := 0 to 2 do
  begin
    LSound[i].Free();
  end;

  for I := 0 to 15 do
  begin
    LChan[I].Free();
  end;

  //NOTE: all sound objects are managed so any sound instances will be
  //      will be released when audio instance is destroyed.
  LAudio.Free();

end;

{------------------------------------------------------------------------------
 This example demonstrates the loading and playback MPG1 video from a ZIP
 file.
----------------------------------------------------------------------------- }
procedure Test04();
var
  LZipFile: TlgZipFile;
  LWindow: TlgWindow;
  LAngle: Single;
  LTexture: TlgTexture;
  LVideo: TlgVideo;
  LAudio: TlgAudio;
  LFont: TlgFont;
  LPos: TlgPoint;
begin
  Terminal.PrintLn(LGT_PROJECT);

  LAudio := TlgAudio.Create();
  LAudio.Open();

  LZipFile := TlgZipFile.Create();
  LZipFile.Open(CZipFilename);

  LWindow := TlgWindow.Create();

  LWindow.Open('Luna Game Toolkit: Video');

  Terminal.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

  LFont := TlgFont.LoadDefault(LWindow, 10);

  LTexture := TlgTexture.LoadFromZipFile(LZipFile, 'res/images/LGT2.png');
  LTexture.SetPos(LWindow.CENTER_WIDTH, LWindow.CENTER_HEIGHT);
  LTexture.SetScale(0.5);
  LTexture.SetRegion(246, 64, 228, 75);
  LTexture.SetAngle(45);

  LVideo := TlgVideo.LoadFromZipFile(LZipFile, 'res/videos/LGT.mpg');
  LVideo.SetPos(0, 0);
  LVideo.SetScale(0.5);
  LVideo.SetLooping(True);

  LVideo.Play(True);

  while not LWindow.ShouldClose() do
  begin
    // start frame
    LWindow.StartFrame();

      // input processing
      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      LAngle := LAngle + 1.0;
      LAngle := Math.ClipValueFloat(LAngle, 0, 360, True);

      LVideo.Update();

      // start drawing
      LWindow.StartDrawing();

        LWindow.Clear(DARKSLATEBROWN);

        LVideo.Draw();

        LWindow.DrawFilledCircle(0, 0, 50, ORANGE);
        LWindow.DrawFilledRect(100, 100, 100, 100, DARKGREEN, LAngle);
        LWindow.DrawRect(200, 200, 100, 100, 2, DARKORCHID, -LAngle);

        LTexture.Draw();

        LPos := Math.Point(3,3);
        LFont.DrawText(LWindow, LPos.x, LPos.y, 0, WHITE, haLeft, '%d fps', [Timer.FrameRate()]);
        LFont.DrawText(LWindow, LPos.x, LPos.y, 0, GREEN, haLeft, 'ESC - Quit', []);

      // end drawing
      LWindow.EndDrawing();

    // end frame
    LWindow.EndFrame();
  end;

  LVideo.Free();
  LTexture.Free();
  LWindow.Close();
  LFont.Free();
  LWindow.Free();
  LZipFile.Free();
  LAudio.Free();
end;

{------------------------------------------------------------------------------
 This example demonstrates loading and rendering parallax tiled textures from
 a ZIP file.
----------------------------------------------------------------------------- }
procedure Test05();
var
  LZipFile: TlgZipFile;
  LWindow: TlgWindow;
  LTexture: array[0..3] of TlgTexture;
  LTexPos: array[0..3] of TlgPoint;
  LSpeed: array[0..3] of Single;
  I: Integer;
  LFont: TlgFont;
  LPos: TlgPoint;
begin
  Terminal.PrintLn(LGT_PROJECT);

  LTexPos[0] := Math.Point(0,0);
  LTexPos[1] := Math.Point(0,0);
  LTexPos[2] := Math.Point(0,0);
  LTexPos[3] := Math.Point(0,0);

  LSpeed[0] := 0.15;
  LSpeed[1] := 0.4;
  LSpeed[2] := 0.6;
  LSpeed[3] := 0.8;

  LZipFile := TlgZipFile.Init(CZipFilename);

  LWindow := TlgWindow.Init('Luna Game Toolkit: Parallax Tiled Texture');

  Terminal.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

  LTexture[0] := TlgTexture.LoadFromZipFile(LZipFile, 'res/backgrounds/space.png', nil);
  LTexture[1] := TlgTexture.LoadFromZipFile(LZipFile, 'res/backgrounds/spacelayer1.png', @BLACK);
  LTexture[2] := TlgTexture.LoadFromZipFile(LZipFile, 'res/backgrounds/spacelayer2.png', @BLACK);
  LTexture[3] := TlgTexture.LoadFromZipFile(LZipFile, 'res/backgrounds/nebula1.png', @BLACK);

  LTexture[0].SetColor(0.3, 0.3, 0.3, 0.3);
  LTexture[0].SetBlend(tbNone);
  LTexture[1].SetBlend(tbAlpha);
  LTexture[2].SetBlend(tbAlpha);
  LTexture[3].SetBlend(tbAdditiveAlpha);

  LFont := TlgFont.LoadDefault(LWindow, 10);

  while not LWindow.ShouldClose() do
  begin
    // start frame
    LWindow.StartFrame();

      // input processing
      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      // update scroll
       for I := 0 to 3 do
       begin
        LTexPos[I].Y := LTexPos[I].Y + LSpeed[I];
       end;

      // start drawing
      LWindow.StartDrawing();

        LWindow.Clear(DARKSLATEBROWN);

        // draw parallax
        for I := 0 to 3 do
        begin
          LTexture[I].DrawTiled(LWindow, LTexPos[I].X, LTexPos[I].Y);
        end;

        LPos := Math.Point(3,3);
        LFont.DrawText(LWindow, LPos.x, LPos.y, 0, WHITE, haLeft, '%d fps', [Timer.FrameRate()]);
        LFont.DrawText(LWindow, LPos.x, LPos.y, 0, GREEN, haLeft, 'ESC - Quit', []);

      // end drawing
      LWindow.EndDrawing();

    // end frame
    LWindow.EndFrame();
  end;

  LFont.Free();

  LTexture[3].Free();
  LTexture[2].Free();
  LTexture[1].Free();
  LTexture[0].Free();

  LWindow.Free();
  LZipFile.Free();
end;

{------------------------------------------------------------------------------
 This example demonstrates laoding and rendering unicode true type fonts from
 a ZIP file.
----------------------------------------------------------------------------- }

procedure Test06;
var
  LZipFile: TlgZipFile;
  LWindow: TlgWindow;
  LFont: array[0..3] of TlgFont;
  LPos: TlgPoint;
begin
  Terminal.PrintLn(LGT_PROJECT);

  LZipFile := TlgZipFile.Init(CZipFilename);
  LWindow := TlgWindow.Init('Luna Game Toolkit: Unicode Truetype Fonts', TlgWindow.DEFAULT_WIDTH, TlgWindow.DEFAULT_HEIGHT);

  Terminal.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

  LFont[0] := TlgFont.LoadDefault(LWindow, 10);
  LFont[1] := TlgFont.LoadFromZipFile(LWindow, LZipFile, 'res/fonts/unifont.ttf', 16, '你好こんにちは안녕하세요');
  LFont[2] := TlgFont.LoadDefault(LWindow, 32);

  while not LWindow.ShouldClose() do
  begin
    // start frame
    LWindow.StartFrame();

      // input processing
      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetGamepadButton(GAMEPAD_1, GAMEPAD_BUTTON_X, isWasReleased) then
        LWindow.SetShouldClose(True);

      // start drawing
      LWindow.StartDrawing();
        LWindow.Clear(DARKSLATEBROWN);

        LPos := Math.Point(3,3);
        LFont[0].DrawText(LWindow, LPos.x, LPos.y, 0, WHITE, haLeft, '%d fps', [Timer.FrameRate()]);
        LFont[0].DrawText(LWindow, LPos.x, LPos.y, 0, GREEN, haLeft, 'ESC - Quit', []);
        LFont[1].DrawText(LWindow, LWindow.CENTER_WIDTH, LWindow.CENTER_HEIGHT, YELLOW, haCenter, ' en   zh      ja       ko        de   es   pt     fr      vi    id', []);
        LFont[1].DrawText(LWindow, LWindow.CENTER_WIDTH, LWindow.CENTER_HEIGHT+LFont[1].TextHeight()+3, DARKGREEN, haCenter, 'Hello|你好|こんにちは|안녕하세요|Hallo|Hola|Olá|Bonjour|Xin chào|Halo', []);
        LFont[2].DrawText(LWindow, LWindow.CENTER_WIDTH, 150, GREENYELLOW, haCenter, 'these are truetype fonts', []);

      // end drawing
      LWindow.EndDrawing();

    // end frame
    LWindow.EndFrame();
  end;


  LFont[2].Free();
  LFont[1].Free();
  LFont[0].Free();
  LWindow.Free();
  LZipFile.Free();
end;

{------------------------------------------------------------------------------
 This example demonstrates setting and using the 2D camera to move, zoom and
 rotate the view.
----------------------------------------------------------------------------- }
procedure Test07;
type
  TObj = record
    X, Y, Size: Single;
    Color: TlgColor;
  end;
var
  LZipFile: TlgZipFile;
  LWindow: TlgWindow;
  LFont: TlgFont;
  LHudPos: TlgPoint;
  LCam: TlgCamera;
  LObj: array[0..1000] of TObj;

  procedure InitObjects();
  var
    I: Integer;
  begin
    for I := Low(LObj) to High(LObj) do
    begin
      LObj[i].X := Math.RandomRange(-10000, 10000);
      LObj[i].Y := Math.RandomRange(-10000, 10000);
      LObj[i].Size := Math.RandomRange(50, 250);
      LObj[i].Color.Red := Math.RandomRange(0, 255)/$FF;
      LObj[i].Color.Green := Math.RandomRange(0, 255)/$FF;
      LObj[i].Color.Blue := Math.RandomRange(0, 255)/$FF;
      LObj[i].Color.Alpha := 1;
    end;
  end;

  procedure DrawObjects();
  var
    I: Integer;
  begin
    for I := Low(LObj) to High(LObj) do
    //for I := 0 to 0 do
    begin
      LWindow.DrawFilledRect(LObj[i].X, LObj[i].Y, LObj[i].Size, Lobj[i].Size, Lobj[i].Color, 0);
    end;
  end;

begin
  Terminal.PrintLn(LGT_PROJECT);

  LZipFile := TlgZipFile.Init(CZipFilename);
  LWindow := TlgWindow.Init('Luna Game Toolkit: 2D Camera', TlgWindow.DEFAULT_WIDTH, TlgWindow.DEFAULT_HEIGHT);

  Terminal.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

  LFont := TlgFont.LoadDefault(LWindow, 10);

  LCam := TlgCamera.Create();
  LCam.X := LWindow.CENTER_WIDTH;
  LCam.Y := LWindow.CENTER_HEIGHT;
  LCam.Rotation := 0;
  LCam.Scale := 0.20;

  InitObjects();

  while not LWindow.ShouldClose() do
  begin
    // start frame
    LWindow.StartFrame();

      // input processing
      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetGamepadButton(GAMEPAD_1, GAMEPAD_BUTTON_X, isWasReleased) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(KEY_DOWN, isPressed) then
        begin
          LCam.Move(0, 10)
        end
      else
      if LWindow.GetKey(KEY_UP, isPressed) then
        begin
          LCam.Move(0, -10)
        end;

      if LWindow.GetKey(KEY_RIGHT, isPressed) then
        begin
          LCam.Move(10, 0)
        end
      else
      if LWindow.GetKey(KEY_LEFT, isPressed) then
        begin
          LCam.Move(-10, 0)
        end;

      if LWindow.GetKey(KEY_A, isPressed) then
        begin
          LCam.Rotate(-2)
        end
      else
      if LWindow.GetKey(KEY_D, isPressed) then
        begin
          LCam.Rotate(3)
        end;


      if LWindow.GetKey(KEY_S, isPressed) then
        begin
          LCam.Zoom(-0.01)
        end
      else
      if LWindow.GetKey(KEY_W, isPressed) then
        begin
          LCam.Zoom(0.01)
        end;

      if LWindow.GetKey(KEY_R, isWasReleased) then
      begin
        LCam.Reset();
        LCam.X := LWindow.CENTER_WIDTH;
        LCam.Y := LWindow.CENTER_HEIGHT;
        LCam.Rotation := 0;
        LCam.Scale := 0.20;
      end;

      if LWindow.GetKey(KEY_SPACE, isWasReleased) then
      begin
        InitObjects()
      end;


      // start drawing
      LWindow.StartDrawing();
        LWindow.Clear(BLACK);

        LCam.Use(LWindow);
        DrawObjects();
        LCam.Use(nil);

        // display hud
        LHudPos := Math.Point(3,3);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft,  '%d fps', [Timer.FrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'ESC        - Quit', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'Space      - Spawn', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'Left/Right - cam move left/right', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'Up/Down    - cam move up/down', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'W/S        - cam zoom up/down', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'A/D        - cam rotate up/down', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'R          - reset cam', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, YELLOW, haLeft, 'Pos        - %03.2f/%03.2f', [LCam.X, LCam.Y]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, YELLOW, haLeft, 'Zoom       - %3.2f', [LCam.Scale]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, YELLOW, haLeft, 'Angle      - %3.2f', [LCam.Rotation]);

      // end drawing
      LWindow.EndDrawing();

    // end frame
    LWindow.EndFrame();
  end;

  LCam.Free();


  LFont.Free();
  LWindow.Free();
  LZipFile.Free();
end;

procedure Test08;
var
  LWindow: TlgWindow;
  LFont: TlgFont;
  LHudPos: TlgPoint;
begin
  // show LGT version info
  Terminal.PrintLn(LGT_PROJECT);

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
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft,  '%d fps', [Timer.FrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'ESC - Quit', []);

      // end drawing
      LWindow.EndDrawing();

    // end frame
    LWindow.EndFrame();
  end;

  // free font
  LFont.Free();

  // free window
  LWindow.Free();
end;

procedure Test09();
type
  TOptions = (EASY, HARD);
var
  LWindow: TlgWindow;
  LFont: TlgFont;
  LHudPos: TlgPoint;
  LGui: TlgGUI;
  LOption: TOptions;
  LProperty: Integer;
begin
  // show LGT version info
  Terminal.PrintLn(LGT_PROJECT);

  // init window
  LWindow := TlgWindow.Init('Luna Game Toolkit: GUI');

  // show gamepad info
  Terminal.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

  // init default font
  LFont := TlgFont.LoadDefault(LWindow, 10);

  // init gui
  LGui := TlgGUI.Init(LWindow);

  // init gui options
  LOption := EASY;
  LProperty := 10;

  // enter game loop
  while not LWindow.ShouldClose() do
  begin
    // start frame
    LWindow.StartFrame();

      // keyboard processing
      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      // gamepad processing
      if LWindow.GetGamepadButton(GAMEPAD_1, GAMEPAD_BUTTON_X, isWasReleased) then
        LWindow.SetShouldClose(True);

      // start new gui frame
      LGUI.NewFrame();

      // start window 1
      if LGUI.BeginWindow('Window 1', 50, 50, 150, 150, GUI_DEFAULT_WINDOW) then
      begin
        LGUI.LayoutRowStatic(30, 80, 1);
        if LGUI.ButtonLabel('Button') then Terminal.PrintLn('Button pressed');

        LGUI.LayoutRowDynamic(30, 2);
        if LGUI.OptionLabel('easy', LOption = EASY) then LOption := EASY;
        if LGUI.OptionLabel('hard', LOption = HARD) then LOption := HARD;

        LGUI.LayoutRowDynamic(25, 1);
        LGUI.PropertyInt('Compression:', @LProperty, 0, 100, 10, 1);
      end;
      // end window 1
      LGUI.EndWindow();

      // start drawing
      LWindow.StartDrawing();

        // clear window
        LWindow.Clear(DARKSLATEBROWN);

        // render gui
        LGUI.Render();

        // display hud
        LHudPos := Math.Point(3,3);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft,  '%d fps', [Timer.FrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'ESC - Quit', []);

      // end drawing
      LWindow.EndDrawing();

    // end frame
    LWindow.EndFrame();
  end;

  // destroy gui
  LGUI.Free();

  // free font
  LFont.Free();

  // free window
  LWindow.Free();
end;

procedure Test10();
var
  LWindow: TlgWindow;
  LFont: TlgFont;
  LHudPos: TlgPoint;
  LPolygon: TlgPolygon;
  LAngle: Single;
  LScale: Single;
begin
  // show LGT version info
  Terminal.PrintLn(LGT_PROJECT);

  // init window
  LWindow := TlgWindow.Init('Luna Game Toolkit: Polygon');

  // show gamepad info
  Terminal.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

  // init default font
  LFont := TlgFont.LoadDefault(LWindow, 10);

  // init polygon
  LPolygon := TlgPolygon.Create();
  LPolygon.AddLocalPoint(-1, -1, True);
  LPolygon.AddLocalPoint(1, -1, True);
  LPolygon.AddLocalPoint(1, 1, True);
  LPolygon.AddLocalPoint(-1, 1, True);
  LPolygon.AddLocalPoint(-1, -1, True);

  LAngle := 0.0;
  LScale := 150.0;

  // enter game loop
  while not LWindow.ShouldClose() do
  begin
    // start frame
    LWindow.StartFrame();

      // keyboard processing
      if LWindow.GetKey(KEY_ESCAPE, isWasPressed) then
        LWindow.SetShouldClose(True);

      if LWindow.GetKey(KEY_UP, isPressed) then
        begin
          LScale := LScale + 1.0;
          Math.ClipValueFloat(LScale, 10, 150, False);
        end
      else
      if LWindow.GetKey(KEY_DOWN, isPressed) then
        begin
          LScale := LScale - 1.0;
          Math.ClipValueFloat(LScale, 10, 150, False);
        end;

      // mouse processing
      if LWindow.GetMouseButton(MOUSE_BUTTON_LEFT, isWasPressed) then
        LWindow.SetShouldClose(True);

      // gamepad processing
      if LWindow.GetGamepadButton(GAMEPAD_1, GAMEPAD_BUTTON_X, isWasReleased) then
        LWindow.SetShouldClose(True);

      // update angle
      LAngle := LAngle + 0.6;
      Math.ClipValueFloat(LAngle, 0, 360, True);

      // start drawing
      LWindow.StartDrawing();

        // clear window
        LWindow.Clear(DARKSLATEBROWN);

        // render polygon
        LPolygon.Render(LWindow, LWindow.CENTER_WIDTH, LWindow.CENTER_HEIGHT, LScale, LAngle, 2, YELLOW, nil, False, False);

        // display hud
        LHudPos := Math.Point(3,3);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, WHITE, haLeft,  '%d fps', [Timer.FrameRate()]);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'ESC  - Quit', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'Up   - Scale up', []);
        LFont.DrawText(LWindow, LHudPos.x, LHudPos.y, 0, GREEN, haLeft,  'Down - Scale down', []);

      // end drawing
      LWindow.EndDrawing();

    // end frame
    LWindow.EndFrame();
  end;

  // free polygon
  LPolygon.Free();

  // free font
  LFont.Free();

  // free window
  LWindow.Free();
end;



procedure RunTests();
begin
  //Test01();
  //Test02();
  //Test03();
  //Test04();
  //Test05();
  //Test06();
  //Test07();
  //Test08();
  //Test09();
  Test10();
  //Test11();
  Terminal.Pause();
end;

end.
