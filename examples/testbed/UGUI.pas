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

unit UGUI;

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

  { TGUIBasic }
  TGUIBasic = class(TExample)
  private type
    TOptions = (EASY, HARD);
  private
    FGui: TlgGUI;
    FOption: TOptions;
    FProperty: Integer;
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

{ --- TGUIBasic ------------------------------------------------------------- }
procedure TGUIBasic.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': GUI';

end;

function  TGUIBasic.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  // init gui
  FGui := TlgGUI.Init(Window);

  // init gui options
  FOption := EASY;
  FProperty := 10;

  Result := True;
end;

procedure TGUIBasic.OnShutdown();
begin
  // free gui
  FGui.Free();

  inherited;
end;

procedure TGUIBasic.OnUpdate();
begin
  inherited;

  // start new gui frame
  FGui.NewFrame();

  // start window 1
  if FGui.BeginWindow('Window 1', 50, 50, 150, 150, GUI_DEFAULT_WINDOW) then
  begin
    FGui.LayoutRowStatic(30, 80, 1);
    if FGui.ButtonLabel('Button') then Terminal.PrintLn('Button pressed');

    FGui.LayoutRowDynamic(30, 2);
    if FGui.OptionLabel('easy', FOption = EASY) then FOption := EASY;
    if FGui.OptionLabel('hard', FOption = HARD) then FOption := HARD;

    FGui.LayoutRowDynamic(25, 1);
    FGui.PropertyInt('Compression:', @FProperty, 0, 100, 10, 1);
  end;
  // end window 1
  FGui.EndWindow();

end;

procedure TGUIBasic.OnRender();
begin
  inherited;
end;

procedure TGUIBasic.OnRenderHud();
begin
  // render gui
  FGui.Render();

  inherited;
end;

end.
