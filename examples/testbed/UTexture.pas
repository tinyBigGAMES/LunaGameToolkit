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

unit UTexture;

interface

uses
  System.SysUtils,
  System.Math,
  LGT,
  UCommon;

type
  { TTextureTiledParallax }
  TTextureTiledParallax = class(TExample)
  private
    FTexture: array[0..3] of TlgTexture;
    FTexPos: array[0..3] of TlgPoint;
    FSpeed: array[0..3] of Single;
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
  end;

  { TTextureCollision }
  TTextureCollision = class(TExample)
  private
    FTexture: array[0..1] of TlgTexture;
    FCollide: Boolean;
    FAngle: Single;
    FCollision: Integer;
    FCollisionStr: array[0..1] of string;
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    procedure OnRenderHud(); override;
  end;

implementation

{ --- TTextureTiledParallax ------------------------------------------------- }
procedure TTextureTiledParallax.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Parallax Tiled Texture';
end;

function  TTextureTiledParallax.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // init textures
  FTexture[0] := TlgTexture.LoadFromZipFile(ZipFile, 'res/backgrounds/space.png', nil);
  FTexture[1] := TlgTexture.LoadFromZipFile(ZipFile, 'res/backgrounds/spacelayer1.png', @BLACK);
  FTexture[2] := TlgTexture.LoadFromZipFile(ZipFile, 'res/backgrounds/spacelayer2.png', @BLACK);
  FTexture[3] := TlgTexture.LoadFromZipFile(ZipFile, 'res/backgrounds/nebula1.png', @BLACK);

  // init texture settings
  FTexture[0].SetColor(0.3, 0.3, 0.3, 0.3);
  FTexture[0].SetBlend(tbNone);
  FTexture[1].SetBlend(tbAlpha);
  FTexture[2].SetBlend(tbAlpha);
  FTexture[3].SetBlend(tbAdditiveAlpha);

  // init texture pos
  FTexPos[0] := Math.Point(0,0);
  FTexPos[1] := Math.Point(0,0);
  FTexPos[2] := Math.Point(0,0);
  FTexPos[3] := Math.Point(0,0);

  // init texture speed
  FSpeed[0] := 0.15;
  FSpeed[1] := 0.1;
  FSpeed[2] := 0.2;
  FSpeed[3] := 0.3;

  Result := True;
end;

procedure TTextureTiledParallax.OnShutdown();
begin
  // free textures
  FTexture[3].Free();
  FTexture[2].Free();
  FTexture[1].Free();
  FTexture[0].Free();

  inherited;
end;

procedure TTextureTiledParallax.OnUpdate();
var
  I: Integer;
begin
  inherited;

  // update scroll
  for I := 0 to 3 do
  begin
    FTexPos[I].Y := FTexPos[I].Y + FSpeed[I];
  end;
end;

procedure TTextureTiledParallax.OnRender();
var
  I: Integer;
begin
  inherited;

  // draw parallax
  for I := 0 to 3 do
  begin
    FTexture[I].DrawTiled(Window, FTexPos[I].X, FTexPos[I].Y);
  end;
end;

{ --- TTextureCollision ----------------------------------------------------- }
procedure TTextureCollision.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Texture Collision';

end;

function  TTextureCollision.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // init textures
  FTexture[0] := TlgTexture.LoadFromZipFile(ZipFile, 'res/sprites/boss.png');
  FTexture[0].SetRegion(0, 0, 128, 128);
  FTexture[0].SetPos(Window.CENTER_WIDTH, Window.CENTER_HEIGHT);

  FTexture[1] := TlgTexture.LoadFromZipFile(ZipFile, 'res/sprites/ship.png');
  FTexture[1].SetRegion(0, 0, 64, 64);
  FTexture[1].SetPos(Window.CENTER_WIDTH, Window.CENTER_HEIGHT);

  FCollisionStr[0] := 'Axis Aligned Bounding Box (AABB)';
  FCollisionStr[1] := 'Oriented Bounding Box (OBB)';
  FCollision := 0;

  Result := True;
end;

procedure TTextureCollision.OnShutdown();
begin
  // free textures
  FTexture[1].Free();
  FTexture[0].Free();

  inherited;
end;

procedure TTextureCollision.OnUpdate();
begin
  inherited;

  // set collision type
  if Window.GetKey(KEY_1, isWasPressed) then
    FCollision := 0
  else
  if Window.GetKey(KEY_2, isWasPressed) then
    FCollision := 1;

  // update textures
  FTexture[1].SetPos(MousePos);

  // check collision
  if FCollision = 0 then // AABB
    begin
      FTexture[1].SetAngle(0);
      FCollide := FTexture[1].CollideAABB(FTexture[0]);
    end
  else
  if FCollision = 1 then // OBB
    begin
      FAngle := FAngle + 0.5;
      Math.ClipValueFloat(FAngle, 0, 360, True);
      FTexture[1].SetAngle(FAngle);
      FCollide := FTexture[1].CollideOBB(FTexture[0]);
    end
end;

procedure TTextureCollision.OnRender();
begin
  inherited;

  // draw textures
  FTexture[0].Draw();
  FTexture[1].Draw();

  // draw collision
  if FCollide then
  begin
    Window.DrawFilledRect(Window.CENTER_WIDTH, Window.CENTER_HEIGHT, 50, 10, RED, 0);
  end;
end;

procedure TTextureCollision.OnRenderHud();
begin
  inherited;

  HudPrint(GREEN, HudTextItem('1', 'AABB collision'), []);
  HudPrint(GREEN, HudTextItem('2', 'OBB collision '), []);
  HudPrint(YELLOW, HudTextItem('Collision', '%s', ' '), [FCollisionStr[FCollision]]);

  DefaultFont.DrawText(Window, Window.CENTER_WIDTH, 180, ORANGE, haCenter, 'move blue ship over green', []);
end;

end.
