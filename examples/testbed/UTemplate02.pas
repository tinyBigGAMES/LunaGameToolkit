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

unit UTemplate02;

interface

uses
  System.SysUtils,
  LGT,
  UCommon;

type

  { Txxx }
  TTemplate02 = class(TExample)
  private
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    procedure OnRenderHud(); override;
  end;

implementation

{ --- Txxx ------------------------------------------------------------------ }
procedure TTemplate02.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Template02';

end;

function  TTemplate02.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  Result := True;
end;

procedure TTemplate02.OnShutdown();
begin
  inherited;
end;

procedure TTemplate02.OnUpdate();
begin
  inherited;
end;

procedure TTemplate02.OnRender();
begin
  inherited;
end;

procedure TTemplate02.OnRenderHud();
begin
  inherited;
end;

end.
