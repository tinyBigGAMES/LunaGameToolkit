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
          LTexture[I].DrawTiled(LTexPos[I].X, LTexPos[I].Y, LWindow.DEFAULT_WIDTH, LWindow.DEFAULT_HEIGHT);
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
  LMousePos: TlgPoint;
begin
  LZipFile := TlgZipFile.Init(CZipFilename);
  LWindow := TlgWindow.Init('Luna Game Toolkit: Unicode Truetype Fonts', TlgWindow.DEFAULT_WIDTH, TlgWindow.DEFAULT_HEIGHT);

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

      LMousePos := LWindow.GetMousePos();

      // start drawing
      LWindow.StartDrawing();
        LWindow.Clear(DARKSLATEBROWN);
        LPos := Math.Point(3,3);
        LFont[0].DrawText(LWindow, LPos.x, LPos.y, 0, WHITE, haLeft, '%d fps', [Timer.FrameRate()]);
        LFont[0].DrawText(LWindow, LPos.x, LPos.y, 0, GREEN, haLeft, 'ESC - Quit', []);
        LFont[0].DrawText(LWindow, LPos.x, LPos.y, 0, GREEN, haLeft, 'Mouse: (%d, %d)', [Round(LMousePos.x), Round(LMousePos.y)]);
        LFont[1].DrawText(LWindow, LWindow.CENTER_WIDTH, LWindow.CENTER_HEIGHT, YELLOW, haCenter, ' en   zh      ja       ko        de   es   pt     fr      vi    id', []);
        LFont[1].DrawText(LWindow, LWindow.CENTER_WIDTH, LWindow.CENTER_HEIGHT+LFont[1].TextHeight()+3, DARKGREEN, haCenter, 'Hello|你好|こんにちは|안녕하세요|Hallo|Hola|Olá|Bonjour|Xin chào|Halo', []);
        LFont[2].DrawText(LWindow, LWindow.CENTER_WIDTH, 150, GREENYELLOW, haCenter, 'these are truetype fonts', []);

      // end drawing
      LWindow.EndDrawing();

    // end frame
    LWindow.EndFrame();
  end;

  LWindow.SaveToFile('window.png');

  LFont[2].Free();
  LFont[1].Free();
  LFont[0].Free();
  LWindow.Free();
  LZipFile.Free();
end;

procedure RunTests();
begin
  //Test01();
  //Test02();
  //Test03();
  Test04();
  //Test05();
  //Test06();
  Console.Pause();
end;

end.
