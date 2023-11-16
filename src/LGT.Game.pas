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

unit LGT.Game;

{$I LGT.Defines.inc}

interface

uses
  System.SysUtils,
  LGT.Core,
  LGT.Actor;

type
  { TlgGame }
  TlgGame = class(TlgObject)
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Run(); virtual;
  end;

  { TlgGameClass }
  TlgGameClass = class of TlgGame;

  { TlgBaseGameApp }
  TlgBaseGameApp = class(TlgGame)
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Run(); override;
    function  OnStartup(): Boolean; virtual;
    procedure OnShutdown(); virtual;
    function  OnShouldTerminate(): Boolean; virtual;
    procedure OnUpdate(); virtual;
    procedure OnRender(); virtual;
    procedure OnRenderHud(); virtual;
  end;

  // settings
  PlgGameAppSettings = ^TlgGameAppSettings;
  TlgGameAppSettings = record
    // window
    WindowWidth: Cardinal;
    WindowHeight: Cardinal;
    WindowTitle: string;
    WindowClearColor: TlgColor;

    // default font
    DefaultFontSize: Cardinal;
    DefaultFontGlyphs: string;

    // zipfile
    ZipFilePassword: string;
    ZipFilename: string;

    // hud
    HudPos: TlgPoint;
    HudLinespace: Cardinal;
    HudItemPadWidth: Cardinal;
    HudItemSeperator: string;

    // actor
    ActorSceneCount: Integer;
    ActorSceneAttrs: TlgObjectAttributeSet;
    ActorSceneBefore: TlgActorSceneEvent;
    ActorSceneAfter: TlgActorSceneEvent;
  end;

  { TlgGameApp }
  TlgGameApp = class(TlgBaseGameApp)
  public type
    // hud
    PHud = ^THud;
    THud = record
      Pos: TlgPoint;
      Linespace: Cardinal;
      ItemSeperator: string;
      ItemPadWidth: Cardinal;
    end;
  protected
    FZipFile: TlgZipFile;
    FWindow: TlgWindow;
    FAudio: TlgAudio;
    FScene: TlgActorScene;
    FSprite: TlgSprite;
    FDefaultFont: TlgFont;
    FSettings: TlgGameAppSettings;
    FHudPos: TlgPoint;
    FMousePos: TlgPoint;
    FConfigFile: TlgConfigFile;
  public
    property Window: TlgWindow read FWindow;
    property DefaultFont: TlgFont read FDefaultFont;
    property ZipFile: TlgZipFile read FZipFile;
    property Audio: TlgAudio read FAudio;
    property Scene: TlgActorScene read FScene;
    property Sprite: TlgSprite read FSprite;
    property MousePos: TlgPoint read FMousePos;
    property ConfigFile: TlgConfigFile read FConfigFile;
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Run(); override;
    function  OnStartup(): Boolean; override;
    procedure OnShutdown(); override;
    function  OnShouldTerminate(): Boolean; override;
    procedure OnUpdate(); override;
    procedure OnRender(); override;
    procedure OnRenderHud(); override;
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); virtual;
    function  OnInitSettings(): Boolean; virtual;
    procedure OnQuitSettings(); virtual;
    procedure OnLoadConfig(); virtual;
    procedure OnSaveConfig(); virtual;
    function  Settings: PlgGameAppSettings;
    procedure HudReset();
    procedure HudPrint(const AColor: TlgColor; const AMsg: string; const AArgs: array of const);
    function  HudTextItem(const AKey: string; const AValue: string; const ASeperator: string='-'): string;
end;

{ lgRunGame }
procedure lgRunGame(const AGame: TlgGameClass);

implementation

{ lgRunGame }
procedure lgRunGame(const AGame: TlgGameClass);
var
  LGame: TlgGame;
begin
  LGame := AGame.Create;
  try
    LGame.Run();
  finally
    LGame.Free();
  end;
end;

{ --- TlgGame --------------------------------------------------------------- }
constructor TlgGame.Create();
begin
  inherited;
end;

destructor TlgGame.Destroy();
begin
  inherited;
end;

procedure TlgGame.Run();
begin
end;

{ --- TlgBaseGameApp -------------------------------------------------------- }
constructor TlgBaseGameApp.Create();
begin
  inherited;
end;

destructor TlgBaseGameApp.Destroy();
begin
  inherited;
end;

procedure TlgBaseGameApp.Run();
begin
  try
    if not OnStartup() then Exit;
    while not OnShouldTerminate() do
    begin
      OnUpdate();
      OnRender();
      OnRenderHud();
    end;
  finally
    OnShutdown();
  end;
end;

function  TlgBaseGameApp.OnStartup(): Boolean;
begin
  result := False;
end;

procedure TlgBaseGameApp.OnShutdown();
begin
end;

function  TlgBaseGameApp.OnShouldTerminate(): Boolean;
begin
  Result := True;
end;

procedure TlgBaseGameApp.OnUpdate();
begin
end;

procedure TlgBaseGameApp.OnRender();
begin
end;

procedure TlgBaseGameApp.OnRenderHud();
begin
end;

{ --- TlgGameApp ------------------------------------------------------------ }
constructor TlgGameApp.Create();
begin
  inherited;
end;

destructor TlgGameApp.Destroy();
begin
  inherited;
end;

procedure TlgGameApp.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  // window
  ASettings.WindowWidth := TlgWindow.DEFAULT_WIDTH;
  ASettings.WindowHeight := TlgWindow.DEFAULT_HEIGHT;
  ASettings.WindowTitle := 'Your Game';
  ASettings.WindowClearColor := DARKSLATEBROWN;

  // default font
  ASettings.DefaultFontSize := 10;
  ASettings.DefaultFontGlyphs := '';

  // zipfile
  ASettings.ZipFilePassword := TlgZipStream.DEFAULT_PASSWORD;
  ASettings.ZipFilename := '';

  // hud
  ASettings.HudPos := Math.Point(3, 3);
  ASettings.HudLinespace := 0;
  ASettings.HudItemPadWidth := 20;
  ASettings.HudItemSeperator := '-';

  // actor
  ASettings.ActorSceneCount := 1;
  ASettings.ActorSceneAttrs := [];
  ASettings.ActorSceneBefore := nil;
  ASettings.ActorSceneAfter := nil;
end;

function  TlgGameApp.OnInitSettings(): Boolean;
begin
  Result := False;

  // window
  FWindow := TlgWindow.Init(FSettings.WindowTitle, FSettings.WindowWidth, FSettings.WindowHeight);
  if not Assigned(FWindow) then Exit;

  // default font
  FDefaultFont := TlgFont.LoadDefault(FWindow, FSettings.DefaultFontSize, FSettings.DefaultFontGlyphs);
  if not Assigned(FDefaultFont) then Exit;

  // zipfile
  FZipFile := TlgZipFile.Create();
  FZipFile.Open(FSettings.ZipFilename, FSettings.ZipFilePassword);

  // audio
  FAudio := TlgAudio.Create();
  FAudio.Open();

  // sprite
  FSprite := TlgSprite.Create();

  // actor
  FScene := TlgActorScene.Create();
  FScene.Alloc(FSettings.ActorSceneCount);

  // configfile
  FConfigFile := TlgConfigFile.Create();
  FConfigFile.Open();

  Result := True;
end;

procedure TlgGameApp.OnQuitSettings();
begin
  // configfile
  if Assigned(FConfigFile) then
  begin
    FConfigFile.Free();
    FConfigFile := nil;
  end;

  // actor
  if Assigned(FScene) then
  begin
    FScene.Free();
    FScene := nil;
  end;

  // sprite
  if Assigned(FSprite) then
  begin
    FSprite.Free();
    FSprite := nil;
  end;

  // audio
  if Assigned(FAudio) then
  begin
    FAudio.Free();
    FAudio := nil;
  end;

  // zipFile
  if Assigned(FZipFile) then
  begin
    FZipFile.Free();
    FZipFile := nil;
  end;

  // default font
  if Assigned(FDefaultFont) then
  begin
    FDefaultFont.Free();
    FDefaultFont := nil;
  end;

  // window
  if Assigned(FWindow) then
  begin
    FWindow.Free();
    FWindow := nil;
  end;
end;

procedure TlgGameApp.OnLoadConfig();
begin
end;

procedure TlgGameApp.OnSaveConfig();
begin
end;

function  TlgGameApp.OnStartup(): Boolean;
begin
  Result := True;
end;

procedure TlgGameApp.OnShutdown();
begin
end;

function  TlgGameApp.OnShouldTerminate(): Boolean;
begin
  Result := FWindow.ShouldClose();
end;

procedure TlgGameApp.OnUpdate();
begin
  // quit on escape
  if FWindow.GetKey(KEY_ESCAPE, isWasPressed) then
    FWindow.SetShouldClose(True);

  // get mouse position
  FMousePos := FWindow.GetMousePos();

  // update scene
  FScene.Update(FSettings.ActorSceneAttrs);
end;

procedure TlgGameApp.OnRender();
begin
  // render scene
  FScene.Render(FSettings.ActorSceneAttrs, FSettings.ActorSceneBefore, FSettings.ActorSceneAfter);
end;

procedure TlgGameApp.OnRenderHud();
begin
  // reset hud
  HudReset();

  // default display hud info
  HudPrint(WHITE, '%d fps', [Timer.FrameRate()]);
  HudPrint(GREEN, HudTextItem('ESC', 'Quit'), []);
end;

function  TlgGameApp.Settings: PlgGameAppSettings;
begin
  Result := @FSettings;
end;

procedure TlgGameApp.HudReset();
begin
  FHudPos := FSettings.HudPos;
end;

procedure TlgGameApp.HudPrint(const AColor: TlgColor; const AMsg: string; const AArgs: array of const);
begin
  FDefaultFont.DrawText(FWindow, FHudPos.x, FHudPos.y, FSettings.HudLinespace, AColor, haLeft, AMsg, AArgs);
end;

function  TlgGameApp.HudTextItem(const AKey: string; const AValue: string; const ASeperator: string): string;
begin
  Result := Utils.HudTextItem(AKey, aValue, FSettings.HudItemPadWidth, ASeperator);
end;

procedure TlgGameApp.Run();
begin
  // define settings
  OnDefineSettings(FSettings);

  try
    // init settings
    if not OnInitSettings() then Exit;
    try
      // check if window is open
      if not FWindow.IsOpen then Exit;

      // load config
      OnLoadConfig();

      // process startup
      if not OnStartup() then Exit;

      // reset timer
      Timer.Reset();

      // enter game loop
      while not OnShouldTerminate() do
      begin
        // start frame
        FWindow.StartFrame();

        // process updates
        OnUpdate();

          // start drawing
          FWindow.StartDrawing();

            // clear window
            FWindow.Clear(FSettings.WindowClearColor);

            // render
            OnRender();

            // render hud
            OnRenderHud();

          // end drawing
          FWindow.EndDrawing();

        // end frame
        FWindow.EndFrame();
      end;

    finally
      // process shutdown
      OnShutdown();

      // save config
      OnSaveConfig();
    end;

  finally
    // process quit setting
    OnQuitSettings();
  end;
end;

end.
