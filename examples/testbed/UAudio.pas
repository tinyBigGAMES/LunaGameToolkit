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

unit UAudio;

interface

uses
  System.SysUtils,
  System.Math,
  LGT.Core,
  LGT.Game,
  UCommon;

type

  { TAudioInit }
  TAudioInit = class(TlgGame)
  public
    procedure Run(); override;
  end;

  { TAudioMultiChannel }
  TAudioMultiChannel = class(TExample)
  private
    LSound: array[0..6] of TlgSound;
    LChan: array[0..15] of TlgSound;
    function FindFree(): Integer;
    function Play(const Id: Integer): Integer;
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    procedure OnRenderHud(); override;
  end;

implementation

{ --- TAudioInit ------------------------------------------------------------ }
procedure TAudioInit.Run();
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

{ --- TAudioMultiChannel ---------------------------------------------------- }
function TAudioMultiChannel.FindFree(): Integer;
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

function TAudioMultiChannel.Play(const Id: Integer): Integer;
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

procedure TAudioMultiChannel.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Multichannel Audio';

end;

function  TAudioMultiChannel.OnStartup(): Boolean;
var
  I: Integer;
begin
  Result := False;
  if not inherited then Exit;

  for I := 0 to 15 do
  begin
    LChan[I] := TlgSound.Create(Audio);
  end;

  // load music
  LSound[0] := TlgSound.LoadFromZipFile(Audio, ZipFile, 'res/music/song01.ogg', slStream);
  LSound[0].Play(True);
  LSound[0].SetLooping(True);

  // load sfx
  for I := 1 to 6 do
  begin
    LSound[I] := TlgSound.LoadFromZipFile(Audio, ZipFile, Format('res/sfx/samp%d.ogg',[I-1]), slMemory);
  end;

  Result := True;
end;

procedure TAudioMultiChannel.OnShutdown();
var
  I: Integer;
begin
  for I := 0 to 6 do
  begin
    LSound[i].Free();
  end;

  for I := 0 to 15 do
  begin
    LChan[I].Free();
  end;

  inherited;
end;

procedure TAudioMultiChannel.OnUpdate();
begin
  inherited;

  // process keys
  if Window.GetKey(KEY_1, isWasPressed) then Play(1);
  if Window.GetKey(KEY_2, isWasPressed) then Play(2);
  if Window.GetKey(KEY_3, isWasPressed) then Play(3);
  if Window.GetKey(KEY_4, isWasPressed) then Play(4);
  if Window.GetKey(KEY_5, isWasPressed) then Play(5);
  if Window.GetKey(KEY_6, isWasPressed) then Play(6);
end;

procedure TAudioMultiChannel.OnRender();
begin
  inherited;
end;

procedure TAudioMultiChannel.OnRenderHud();
begin
  inherited;

  HudPrint(GREEN, HudTextItem('1-6', 'play sound'), []);
end;


end.
