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
  System.Math,
  WinApi.Windows,
  LGT.Deps,
  LGT.Lib;

procedure RunTests;

implementation

const
  CZipFilename = 'Data.zip';

{------------------------------------------------------------------------------
 This example illustrates how to build a ZIP file.
----------------------------------------------------------------------------- }

procedure Test01;
begin
  Console.PrintLn('Building %s...', [CZipFilename]);

  if TlgZipStream.Build(CZipFilename, 'res', nil, nil) then
    Console.PrintLn(#10#10+'Success!', [])
  else
    Console.PrintLn(#10#10+'Failed!', []);
end;

{------------------------------------------------------------------------------
 This example illustrates the procedure for initializing the audio system.
----------------------------------------------------------------------------- }

procedure Test02();
var
  LAudio: TlgAudio;
begin

  LAudio := TlgAudio.Create();
  try
    if LAudio.Open() then
    begin
      WriteLn(LAudio.GetDeviceName());
      LAudio.Close();
    end;
  finally
    LAudio.Free();
  end;

end;

{------------------------------------------------------------------------------
 This example demonstrates the loading and playback of multichannel audio
 from a ZIP stream.
----------------------------------------------------------------------------- }
procedure Test03();
var
  LAudio: TlgAudio;
  LSound: array[0..6] of TlgSound;
  LChan: array[0..15] of TlgSound;
  LStream: TlgStream;
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

  LAudio := TlgAudio.Create();
  LAudio.Open();

  for I := 0 to 15 do
  begin
    LChan[I] := TlgSound.Create(LAudio);
  end;

  // load music
  LSound[0] := TlgSound.Create(LAudio);
  LStream := TlgZipStream.Open(CZipFilename, 'res/music/song01.ogg');
  LSound[0].Load(LStream, slStream);
  LSound[0].Play(True);
  LSound[0].SetLooping(True);

  // load sfx
  for I := 1 to 6 do
  begin
    LSound[I] := TlgSound.Create(LAudio);
    LStream := TlgZipStream.Open(CZipFilename, Format('res/sfx/samp%d.ogg',[I-1]));
    LSound[I].Load(LStream, slMemory);
    LStream.Free();
  end;

  Console.PrintLn('Press 1-6 to play sound, ESC to quit...');

  while true do
  begin
    Timer.Start();
    LAudio.Update();

    if Console.WasKeyPressed(Ord('1')) then Play(1);
    if Console.WasKeyPressed(Ord('2')) then Play(2);
    if Console.WasKeyPressed(Ord('3')) then Play(3);
    if Console.WasKeyPressed(Ord('4')) then Play(4);
    if Console.WasKeyPressed(Ord('5')) then Play(5);
    if Console.WasKeyPressed(Ord('6')) then Play(6);

    if Console.WasKeyPressed(VK_ESCAPE) then Break;

    Timer.Stop();

    Console.SetTitle('LGT (%d fps)', [Timer.TargetFrameRate()]);
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

procedure RunTests();
begin
  //Test01();
  //Test02();
  Test03();
  Console.Pause();
end;

end.
