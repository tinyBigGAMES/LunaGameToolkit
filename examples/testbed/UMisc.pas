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

unit UMisc;

interface

uses
  System.SysUtils,
  LGT,
  UCommon;

type

  { TMinimalExample }
  TMinimalExample = class(TlgGame)
  public
    procedure Run(); override;
  end;

  { TBuildZipFile }
  TBuildZipFile = class(TlgGame)
  public
    procedure Run(); override;
  end;

  { TCamera2D }
  TCamera2D = class(TExample)
  private type
    TObj = record
      X, Y, Size: Single;
      Color: TlgColor;
    end;
  private
    FCam: TlgCamera;
    FObj: array[0..1000] of TObj;
    procedure InitObjects();
    procedure DrawObjects();
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    procedure OnRenderHud(); override;
  end;

  { TTimer}
  TTimer = class(TExample)
  private
    LTimer: TlgTimer;
    LCount: Integer;
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    procedure OnRenderHud(); override;
  end;

implementation

{ --- TMinimalExample ------------------------------------------------------- }
procedure TMinimalExample.Run();
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

  // reset timing
  Timer.Reset();

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

{ --- TBuildZipFile --------------------------------------------------------- }
procedure TBuildZipFile.Run();
begin
  Terminal.PrintLn(LGT_PROJECT+LF);

  Terminal.PrintLn('Building %s...', [CZipFilename]);

  if TlgZipStream.Build(CZipFilename, 'res', nil, nil) then
    Terminal.PrintLn(LF+LF+'Success!', [])
  else
    Terminal.PrintLn(LF+LF+'Failed!', []);
end;

{ --- TCamera2D ------------------------------------------------------------- }
procedure TCamera2D.InitObjects();
var
  I: Integer;
begin
  for I := Low(FObj) to High(FObj) do
  begin
    FObj[i].X := Math.RandomRange(-10000, 10000);
    FObj[i].Y := Math.RandomRange(-10000, 10000);
    FObj[i].Size := Math.RandomRange(50, 250);
    FObj[i].Color.Red := Math.RandomRange(0, 255)/$FF;
    FObj[i].Color.Green := Math.RandomRange(0, 255)/$FF;
    FObj[i].Color.Blue := Math.RandomRange(0, 255)/$FF;
    FObj[i].Color.Alpha := 1;
  end;
end;

procedure TCamera2D.DrawObjects();
var
  I: Integer;
begin
  for I := Low(FObj) to High(FObj) do
  //for I := 0 to 0 do
  begin
    Window.DrawFilledRect(FObj[i].X, FObj[i].Y, FObj[i].Size, FObj[i].Size, FObj[i].Color, 0);
  end;
end;

procedure TCamera2D.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': 2D Camera';
  ASettings.WindowClearColor := BLACK;

end;

function  TCamera2D.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // init camera
  FCam := TlgCamera.Create();
  FCam.X := Window.CENTER_WIDTH;
  FCam.Y := Window.CENTER_HEIGHT;
  FCam.Rotation := 0;
  FCam.Scale := 0.20;

  InitObjects();

  Result := True;
end;

procedure TCamera2D.OnShutdown();
begin
  // free camera
  FCam.Free();

  inherited;
end;

procedure TCamera2D.OnUpdate();
begin
  inherited;

  if Window.GetKey(KEY_DOWN, isPressed) then
    begin
      FCam.Move(0, 10)
    end
  else
  if Window.GetKey(KEY_UP, isPressed) then
    begin
      FCam.Move(0, -10)
    end;

  if Window.GetKey(KEY_RIGHT, isPressed) then
    begin
      FCam.Move(10, 0)
    end
  else
  if Window.GetKey(KEY_LEFT, isPressed) then
    begin
      FCam.Move(-10, 0)
    end;

  if Window.GetKey(KEY_A, isPressed) then
    begin
      FCam.Rotate(-2)
    end
  else
  if Window.GetKey(KEY_D, isPressed) then
    begin
      FCam.Rotate(3)
    end;


  if Window.GetKey(KEY_S, isPressed) then
    begin
      FCam.Zoom(-0.01)
    end
  else
  if Window.GetKey(KEY_W, isPressed) then
    begin
      FCam.Zoom(0.01)
    end;

  if Window.GetKey(KEY_R, isWasReleased) then
  begin
    FCam.Reset();
    FCam.X := Window.CENTER_WIDTH;
    FCam.Y := Window.CENTER_HEIGHT;
    FCam.Rotation := 0;
    FCam.Scale := 0.20;
  end;

  if Window.GetKey(KEY_SPACE, isWasReleased) then
  begin
    InitObjects()
  end;

end;

procedure TCamera2D.OnRender();
begin
  inherited;

  FCam.Use(Window);
  DrawObjects();
  FCam.Use(nil);
end;

procedure TCamera2D.OnRenderHud();
begin
  inherited;

  HudPrint(GREEN, HudTextItem('Space', 'Spawn'), []);
  HudPrint(GREEN, HudTextItem('Left/Right', 'cam move left/right'), []);
  HudPrint(GREEN, HudTextItem('Up/Down', 'cam move up/down'), []);
  HudPrint(GREEN, HudTextItem('W/S', 'cam zoom up/down'), []);
  HudPrint(GREEN, HudTextItem('A/D', 'cam rotate up/down'), []);
  HudPrint(GREEN, HudTextItem('R', 'reset cam'), []);
  HudPrint(YELLOW, HudTextItem('Pos', '%03.2f/%03.2f', ' '), [FCam.X, FCam.Y]);
  HudPrint(YELLOW, HudTextItem('Zoom', '%3.2f', ' '), [FCam.Scale]);
  HudPrint(YELLOW, HudTextItem('Angle', '%3.2f', ' '), [FCam.Rotation]);
end;

{ --- TTimer ---------------------------------------------------------------- }
procedure TTimer.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Timer';

end;

function  TTimer.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // init timer
  LTimer.InitFPS(8);
  LCount := 0;

  Result := True;
end;

procedure TTimer.OnShutdown();
begin
  inherited;
end;

procedure TTimer.OnUpdate();
begin
  inherited;

  // process timing
  if LTimer.Check() then
  begin
    Inc(LCount);
    LCount := Math.ClipValueInt(LCount, 0, 3, True);
  end;
end;

procedure TTimer.OnRender();
begin
  inherited;

  // display color animated block
  case LCount of
    0: Window.DrawFilledRect(Window.CENTER_WIDTH, Window.CENTER_HEIGHT, 50, 50, DARKSEAGREEN, 0);
    1: Window.DrawFilledRect(Window.CENTER_WIDTH, Window.CENTER_HEIGHT, 50, 50, FORESTGREEN, 0);
    2: Window.DrawFilledRect(Window.CENTER_WIDTH, Window.CENTER_HEIGHT, 50, 50, GREEN, 0);
    3: Window.DrawFilledRect(Window.CENTER_WIDTH, Window.CENTER_HEIGHT, 50, 50, DARKGREEN, 0);
  end;
end;

procedure TTimer.OnRenderHud();
begin
  inherited;
end;

end.
