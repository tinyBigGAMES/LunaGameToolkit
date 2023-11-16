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

unit UFont;

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

  { TFontUnicode }
  TFontUnicode = class(TExample)
  private
    FFont: array[0..1] of TlgFont;
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

{ --- TFontUnicode ---------------------------------------------------------- }
procedure TFontUnicode.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := CTitle + ': Unicode Font';

end;

function  TFontUnicode.OnStartup(): Boolean;
begin
  Result := False;
  if not inherited then Exit;

  FFont[0] := TlgFont.LoadFromZipFile(Window, ZipFile, 'res/fonts/unifont.ttf', 16, '你好こんにちは안녕하세요');
  FFont[1] := TlgFont.LoadDefault(Window, 32);

  Result := True;
end;

procedure TFontUnicode.OnShutdown();
begin
  FFont[1].Free();
  FFont[0].Free();

  inherited;
end;

procedure TFontUnicode.OnUpdate();
begin
  inherited;
end;

procedure TFontUnicode.OnRender();
begin
  inherited;
end;

procedure TFontUnicode.OnRenderHud();
begin
  inherited;

  FFont[0].DrawText(Window, Window.CENTER_WIDTH, Window.CENTER_HEIGHT, YELLOW, haCenter, ' en   zh      ja       ko        de   es   pt     fr      vi    id', []);
  FFont[0].DrawText(Window, Window.CENTER_WIDTH, Window.CENTER_HEIGHT+FFont[0].TextHeight()+3, DARKGREEN, haCenter, 'Hello|你好|こんにちは|안녕하세요|Hallo|Hola|Olá|Bonjour|Xin chào|Halo', []);
  FFont[1].DrawText(Window, Window.CENTER_WIDTH, 150, GREENYELLOW, haCenter, 'these are truetype fonts', []);
end;

end.
