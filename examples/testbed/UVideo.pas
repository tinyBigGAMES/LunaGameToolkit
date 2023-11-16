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

unit UVideo;

interface

uses
  System.SysUtils,
  LGT.Core,
  LGT.Game,
  UCommon;

type

  { TVideoPlay }
  TVideoPlay = class(TExample)
  private
    FVideo: TlgVideo;
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
  end;

  { TVideoPlayChained }
  TVideoPlayChained = class(TExample)
  private
    FVideo: TlgVideo;
    FFilename: string;
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    function  LoadPlay(const AFilename: string): Boolean;
  end;


implementation

{ --- TVideoPlay ------------------------------------------------------------ }
procedure TVideoPlay.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Video Playback';

end;

function  TVideoPlay.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // init video
  FVideo := TlgVideo.LoadFromZipFile(ZipFile, 'res/videos/LGT.mpg');
  FVideo.SetVolume(0.5);
  FVideo.SetPos(0, 0);
  FVideo.SetScale(0.5);
  FVideo.SetLooping(True);
  FVideo.Play(True);

  Result := True;
end;

procedure TVideoPlay.OnShutdown();
begin
  // free video
  FVideo.Free();

  inherited;
end;

procedure TVideoPlay.OnUpdate();
begin
  inherited;

  // update video
  FVideo.Update();
end;

procedure TVideoPlay.OnRender();
begin
  // draw video frame
  FVideo.Draw();

  inherited;
end;

{ --- TVideoPlayChained ----------------------------------------------------- }
procedure TVideoPlayChained.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Chained Video Playback';

end;

function  TVideoPlayChained.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // load and play video
  LoadPlay('res/videos/LGT.mpg');

  Result := True;
end;

procedure TVideoPlayChained.OnShutdown();
begin
  // free video
  FVideo.Free();

  inherited;
end;

procedure TVideoPlayChained.OnUpdate();
begin
  inherited;

  // update video
  FVideo.Update();

  // check status and chain next video
  if FVideo.GetStatus() = vsStopped then
  begin
    if FFilename = 'res/videos/LGT.mpg' then
        LoadPlay('res/videos/tinyBigGAMES.mpg')
    else
    if FFilename = 'res/videos/tinyBigGAMES.mpg' then
        LoadPlay('res/videos/LGT.mpg');
  end;
end;

procedure TVideoPlayChained.OnRender();
begin
  // draw video frame
  FVideo.Draw();

  inherited;
end;

function  TVideoPlayChained.LoadPlay(const AFilename: string): Boolean;
begin
  Result := False;

  if Assigned(FVideo) then
  begin
    FVideo.Free();
    FVideo := nil;
  end;
  FVideo := TlgVideo.LoadFromZipFile(ZipFile, AFilename);
  if not Assigned(FVideo) then Exit;
  FVideo.SetVolume(0.5);
  FVideo.SetPos(0, 0);
  FVideo.SetScale(0.5);
  FVideo.SetLooping(False);
  FVideo.Play(True);
  FFilename := AFilename;
  Result := True;
end;

end.
