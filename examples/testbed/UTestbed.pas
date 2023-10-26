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
  Console.PrintLn(LGT_PROJECT+LF);

  Console.PrintLn('Building %s...', [CZipFilename]);

  if TlgZipStream.Build(CZipFilename, 'res', nil, nil) then
    Console.PrintLn(LF+LF+'Success!', [])
  else
    Console.PrintLn(LF+LF+'Failed!', []);
end;

{------------------------------------------------------------------------------
 This example illustrates the procedure for initializing the audio system.
----------------------------------------------------------------------------- }

procedure Test02();
var
  LAudio: TlgAudio;
begin
  Console.PrintLn(LGT_PROJECT+LF);

  LAudio := TlgAudio.Create();
  try
    if LAudio.Open() then
    begin
      Console.PrintLn('Audio device: %s', [LAudio.GetDeviceName()]);
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
  Console.PrintLn(LGT_PROJECT+LF);

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

  Console.PrintLn('Press 1-6 to play sound, ESC to quit...');

  while true do
  begin
    Timer.Start();

    if Console.KeyWasPressed(Ord('1')) then Play(1);
    if Console.KeyWasPressed(Ord('2')) then Play(2);
    if Console.KeyWasPressed(Ord('3')) then Play(3);
    if Console.KeyWasPressed(Ord('4')) then Play(4);
    if Console.KeyWasPressed(Ord('5')) then Play(5);
    if Console.KeyWasPressed(Ord('6')) then Play(6);

    if Console.KeyWasPressed(VK_ESCAPE) then Break;

    Timer.Stop();

    Console.SetTitle('LGT (%d fps)', [Timer.FrameRate()]);
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
  LStream: TlgStream;
  LAudio: TlgAudio;
  LFont: TlgFont;
  LPos: TlgPoint;
begin
  Console.PrintLn(LGT_PROJECT);

  LAudio := TlgAudio.Create();
  LAudio.Open();

  LZipFile := TlgZipFile.Create();
  LZipFile.Open(CZipFilename);

  LWindow := TlgWindow.Create();

  LWindow.Open('Luna Game Toolkit: Video');

  Console.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

  LFont := TlgFont.LoadDefault(LWindow, 10);

  LTexture := TlgTexture.LoadFromZipFile(LZipFile, 'res/images/LGT2.png');
  LTexture.SetPos(LWindow.CENTER_WIDTH, LWindow.CENTER_HEIGHT);
  LTexture.SetScale(0.5);
  LTexture.SetRegion(246, 64, 228, 75);
  LTexture.SetAngle(45);

  LStream := LZipFile.OpenFile('res/videos/LGT.mpg');
  LVideo := TlgVideo.Create();
  LVideo.Load(LStream);
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
  Console.PrintLn(LGT_PROJECT);

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

  Console.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

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
  Console.PrintLn(LGT_PROJECT);

  LZipFile := TlgZipFile.Init(CZipFilename);
  LWindow := TlgWindow.Init('Luna Game Toolkit: Unicode Truetype Fonts', TlgWindow.DEFAULT_WIDTH, TlgWindow.DEFAULT_HEIGHT);

  Console.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

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
  Console.PrintLn(LGT_PROJECT);

  LZipFile := TlgZipFile.Init(CZipFilename);
  LWindow := TlgWindow.Init('Luna Game Toolkit: 2D Camera', TlgWindow.DEFAULT_WIDTH, TlgWindow.DEFAULT_HEIGHT);

  Console.PrintLn('Gamepad: %s', [LWindow.GetGamepadName(GAMEPAD_1)]);

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

procedure RunTests();
begin
  //Test01();
  //Test02();
  //Test03();
  Test04();
  //Test05();
  //Test06();
  //Test07();
  //Test08;
  Console.Pause();
end;

end.
