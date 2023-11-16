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

unit UWindow;

interface

uses
  System.SysUtils,
  LGT.Core,
  LGT.Game,
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

  { TPolygon }
  TPolygon = class(TExample)
  private
    FPolygon: TlgPolygon;
    FAngle: Single;
    FScale: Single;
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    procedure OnRenderHud(); override;
  end;

  { TStarfield }
  TStarfield = class(TExample)
  private
    FStarfield: TlgStarfield;
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

{ --- TPolygon -------------------------------------------------------------- }
procedure TPolygon.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Polygon';

end;

function  TPolygon.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // init polygon
  FPolygon := TlgPolygon.Create();
  FPolygon.AddLocalPoint(-1, -1, True);
  FPolygon.AddLocalPoint(1, -1, True);
  FPolygon.AddLocalPoint(1, 1, True);
  FPolygon.AddLocalPoint(-1, 1, True);
  FPolygon.AddLocalPoint(-1, -1, True);

  FAngle := 0.0;
  FScale := 150.0;

  Result := True;
end;

procedure TPolygon.OnShutdown();
begin
  // free polygon
  FPolygon.Free();

  inherited;
end;

procedure TPolygon.OnUpdate();
begin
  inherited;

  // update scale
  if Window.GetKey(KEY_UP, isPressed) then
    begin
      FScale := FScale + 1.0;
      Math.ClipValueFloat(FScale, 10, 150, False);
    end
  else
  if Window.GetKey(KEY_DOWN, isPressed) then
    begin
      FScale := FScale - 1.0;
      Math.ClipValueFloat(FScale, 10, 150, False);
    end;

  // update angle
  FAngle := FAngle + 0.6;
  Math.ClipValueFloat(FAngle, 0, 360, True);
end;

procedure TPolygon.OnRender();
begin
  inherited;

  // render polygon
  FPolygon.Render(Window, Window.CENTER_WIDTH, Window.CENTER_HEIGHT, FScale, FAngle, 2, YELLOW, nil, False, False);

end;

procedure TPolygon.OnRenderHud();
begin
  inherited;

  HudPrint(YELLOW, HudTextItem('Up', 'Scale up'), []);
  HudPrint(YELLOW, HudTextItem('Down', 'Scale down'), []);
end;

{ --- TStarfield ------------------------------------------------------------ }
procedure TStarfield.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Starfield';
  ASettings.WindowClearColor := BLACK;

end;

function  TStarfield.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // init starfield
  FStarfield := TlgStarfield.New(Window);

  Result := True;
end;

procedure TStarfield.OnShutdown();
begin
  // free starfield
  FStarfield.Free();

  inherited;
end;

procedure TStarfield.OnUpdate();
begin
  inherited;

  // update starfield
  if Window.GetKey(KEY_1, isWasPressed) then
  begin
    FStarfield.SetXSpeed(6);
    FStarfield.SetYSpeed(0);
    FStarfield.SetZSpeed(-5);
    FStarfield.SetVirtualPos(0, 0);
  end;

  if Window.GetKey(KEY_2, isWasPressed) then
  begin
    FStarfield.SetXSpeed(0);
    FStarfield.SetYSpeed(-6);
    FStarfield.SetZSpeed(-6);
    FStarfield.SetVirtualPos(0, 0);
  end;

  if Window.GetKey(KEY_3, isWasPressed) then
  begin
    FStarfield.SetXSpeed(-6);
    FStarfield.SetYSpeed(0);
    FStarfield.SetZSpeed(-6);
    FStarfield.SetVirtualPos(0, 0);
  end;

  if Window.GetKey(KEY_4, isWasPressed) then
  begin
    FStarfield.SetXSpeed(0);
    FStarfield.SetYSpeed(6);
    FStarfield.SetZSpeed(-6);
    FStarfield.SetVirtualPos(0, 0);
  end;

  if Window.GetKey(KEY_5, isWasPressed) then
  begin
    FStarfield.SetXSpeed(0);
    FStarfield.SetYSpeed(0);
    FStarfield.SetZSpeed(6);
    FStarfield.SetVirtualPos(0, 0);
  end;

  if Window.GetKey(KEY_6, isWasPressed) then
  begin
    FStarfield.Init(Window, 250, -1000, -1000, 10, 1000, 1000, 1000, 160);
    FStarfield.SetZSpeed(0);
    FStarfield.SetYSpeed(6);
  end;

  if Window.GEtKey(KEY_7, isWasPressed) then
  begin
    FStarfield.Init(Window, 250, -1000, -1000, 10, 1000, 1000, 1000, 80);
    FStarfield.SetXSpeed(0);
    FStarfield.SetYSpeed(0);
    FStarfield.SetZSpeed(-3);
    FStarfield.SetVirtualPos(0, 0);
  end;

  FStarfield.Update();
end;

procedure TStarfield.OnRender();
begin
  inherited;

  // render starfield
  FStarfield.Render(Window);
end;

procedure TStarfield.OnRenderHud();
begin
  inherited;

  HudPrint(YELLOW, HudTextItem('1-7', 'Change starfield'), []);
end;

end.
