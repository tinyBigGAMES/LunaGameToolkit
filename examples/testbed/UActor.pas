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

unit UActor;

interface

uses
  System.SysUtils,
  LGT,
  UCommon;

type

  { TMyActor }
  TMyActor = class(TlgActor)
  protected
    FPos: TlgPoint;
    FRange: TlgExtent;
    FSpeed: TlgPoint;
    FColor: TlgColor;
    FSize: Integer;
    FWindow: TlgWindow;
  public
    property Window: TlgWindow read FWindow write FWindow;
    constructor Create; override;
    destructor Destroy; override;
    procedure OnUpdate(); override;
    procedure OnRender; override;
  end;

  { TActorBasic }
  TActorBasic = class(TExample)
  private
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    procedure OnRenderHud(); override;
    procedure Spawn();
  end;

  { TActorCollision }
  TActorEntityCollision = class(TExample)
  private
    LBoss: TlgEntity;
    LPlayer: TlgEntity;
    LCollide: Boolean;
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    procedure OnRenderHud(); override;
  end;

implementation

{ --- TActorBasic ----------------------------------------------------------- }

{ TMyActor }
constructor TMyActor.Create;
var
  LR,LG,LB: Byte;
begin
  inherited;

  FPos := Math.Point(Math.RandomRange(0, FWindow.DEFAULT_WIDTH-1),Math.RandomRange(0, FWindow.DEFAULT_HEIGHT-1));

  FSize := Math.RandomRange(25, 100);

  FRange.MinX := (FSize/2);
  FRange.MinY := (FSize/2);


  FRange.MaxX := (TlgWindow.DEFAULT_WIDTH-1) - (FSize/2);
  FRange.MaxY := (TlgWindow.DEFAULT_HEIGHT-1) - (FSize/2);

  FSpeed.x := Math.RandomRange(1, 7);
  FSpeed.y := Math.RandomRange(1, 7);

  LR := Math.RandomRange(1, 255);
  LG := Math.RandomRange(1, 255);
  LB := Math.RandomRange(1, 255);
  FColor.Red := LR/$FF;
  FColor.Green := LG/$FF;
  FColor.Blue := LB/$FF;
  FColor.Alpha := 1;
end;

destructor TMyActor.Destroy;
begin
  inherited;
end;

procedure TMyActor.OnUpdate();
begin
  // update horizontal movement
  FPos.x := FPos.x + (FSpeed.x);
  if (FPos.x < FRange.MinX) then
    begin
      FPos.x  := FRange.Minx;
      FSpeed.x := -FSpeed.x;
    end
  else if (FPos.x > FRange.Maxx) then
    begin
      FPos.x  := FRange.Maxx;
      FSpeed.x := -FSpeed.x;
    end;

  // update horizontal movement
  FPos.y := FPos.y + (FSpeed.y);
  if (FPos.y < FRange.Miny) then
    begin
      FPos.y  := FRange.Miny;
      FSpeed.y := -FSpeed.y;
    end
  else if (FPos.y > FRange.Maxy) then
    begin
      FPos.y  := FRange.Maxy;
      FSpeed.y := -FSpeed.y;
    end;
end;

procedure TMyActor.OnRender;
begin
  FWindow.DrawFilledRect(FPos.X, FPos.Y, FSize, FSize, FColor, 0);
end;

procedure TActorBasic.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Basic Actor';

end;

function  TActorBasic.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  Spawn();

  Result := True;
end;

procedure TActorBasic.OnShutdown();
begin
  inherited;
end;

procedure TActorBasic.OnUpdate();
begin
  inherited;

  // KEY_SPACE - spawn actors
  if Window.GetKey(KEY_SPACE, isWasPressed) then
    Spawn();
end;

procedure TActorBasic.OnRender();
begin
  inherited;
end;

procedure TActorBasic.OnRenderHud();
begin
  inherited;

  HudPrint(GREEN, HudTextItem('Space', 'spawn actor'), [Scene.Lists[0].Count()]);
  HudPrint(YELLOW, HudTextItem('Count', '%d', ' '), [Scene.Lists[0].Count()]);
end;

procedure TActorBasic.Spawn();
var
  I, LCount: Integer;
  LActor: TMyActor;
begin
  Scene.ClearAll();
  LCount := Math.RandomRange(3, 25);
  for I := 1 to LCount do
  begin
    LActor := TMyActor.Create();
    LActor.Window := Window;
    Scene.Lists[0].Add(LActor);
  end;
end;

{ --- TActorCollision ------------------------------------------------------- }
procedure TActorEntityCollision.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Actor Entity Collision';

end;

function  TActorEntityCollision.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // init boss sprite
  Sprite.LoadPageFromZipFile(ZipFile, 'res/sprites/boss.png', nil); // page #0
  Sprite.AddGroup(); // group #0
  Sprite.AddImageFromGrid(0, 0, 0, 0, 128, 128);
  Sprite.AddImageFromGrid(0, 0, 1, 0, 128, 128);
  Sprite.AddImageFromGrid(0, 0, 0, 1, 128, 128);

  // init ship sprite
  Sprite.LoadPageFromZipFile(ZipFile, 'res/sprites/ship.png', nil); // page #1
  Sprite.AddGroup(); // group #1
  Sprite.AddImageFromGrid(1, 1, 1, 0, 64, 64);
  Sprite.AddImageFromGrid(1, 1, 2, 0, 64, 64);
  Sprite.AddImageFromGrid(1, 1, 3, 0, 64, 64);

  // init boss entity
  LBoss := TlgEntity.New(Sprite, 0);
  LBoss.SetPosAbs(Window.CENTER_WIDTH, Window.CENTER_HEIGHT);
  LBoss.SetFrameSpeed(24);

  // init player entity
  LPlayer := TlgEntity.New(Sprite, 1);
  LPlayer.SetPosAbs(0, 0);
  LPlayer.SetFrameSpeed(24);

  Result := True;
end;

procedure TActorEntityCollision.OnShutdown();
begin
  // free entities
  LPlayer.Free();
  LBoss.Free();

  inherited;
end;

procedure TActorEntityCollision.OnUpdate();
begin
  inherited;

  // update boss
  LBoss.NextFrame();

  // update player
  LPlayer.NextFrame();
  LPlayer.ThrustToPos(40, 40, MousePos.x, MousePos.y, 128, 32, 1, 0.001);
  LCollide := LPlayer.Overlap(LBoss, eoOBB);
end;

procedure TActorEntityCollision.OnRender();
begin
  inherited;

  // render boss
  LBoss.Render();
  if LCollide then
    Window.DrawFilledRect(Window.CENTER_WIDTH, Window.CENTER_HEIGHT-64, 64, 10, RED, 0);

  // render player
  LPlayer.Render();
end;

procedure TActorEntityCollision.OnRenderHud();
begin
  inherited;

  DefaultFont.DrawText(Window, Window.CENTER_WIDTH, 150, YELLOW, haCenter, 'move blue ship over green ship', []);
end;

end.
