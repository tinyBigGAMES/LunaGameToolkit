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

unit LGT.StartupDialog;

{$I LGT.Defines.inc}

interface

uses
  System.SysUtils,
  System.Classes,
  LGT.StartupDialogForm,
  LGT;

type

  { TlgStartupDialog }
  TlgStartupDialog = class(TlgObject)
  protected
    FDialog: TlgStartupDialogForm;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure SetCaption(const ACaption: string);
    procedure SetLogo(const AZipFile: TlgZipFile; const AFilename: string);
    procedure SetLogoClickUrl(const AURL: string);
    procedure SetReadme(const AZipFile: TlgZipFile; const AFilename: string);
    procedure SetReadmeText(const AText: string);
    procedure SetLicense(const AZipFile: TlgZipFile; const AFilename: string);
    procedure SetLicenseText(const AText: string);
    procedure SetReleaseInfo(const AReleaseInfo: string);
    procedure SetWordWrap(const AWrap: Boolean);
    function  Show(): TlgStartupDialogState;
    procedure Hide();
  end;

implementation

{ TlgStartupDialog }
constructor TlgStartupDialog.Create;
begin
  inherited;
  FDialog := TlgStartupDialogForm.Create(nil);
  FDialog.Enabled := True;
end;

destructor TlgStartupDialog.Destroy;
begin
  if Assigned(FDialog) then
  begin
    FDialog.Free();
    FDialog := nil;
  end;

  inherited;
end;

procedure TlgStartupDialog.SetCaption(const ACaption: string);
begin
  if FDialog = nil then Exit;
  FDialog.SetCaption(ACaption);
end;

procedure TlgStartupDialog.SetLogo(const AZipFile: TlgZipFile; const AFilename: string);
var
  LStream: TStream;
begin
  if FDialog = nil then Exit;
  if not Assigned(AZipFile) then Exit;
  if not AZipFile.IsOpen then Exit;

  LStream := AZipFile.OpenFileToStream(AFilename);
  try
    if not Assigned(LStream) then Exit;
    FDialog.SetLogo(LStream);
  finally
    if Assigned(LStream) then
      LStream.Free();
  end;
end;

procedure TlgStartupDialog.SetLogoClickUrl(const AURL: string);
begin
  if FDialog = nil then Exit;
  FDialog.SetLogoClickUrl(AURL);
end;

procedure TlgStartupDialog.SetReadme(const AZipFile: TlgZipFile; const AFilename: string);
var
  LStream: TStream;
begin
  if FDialog = nil then Exit;
  if not Assigned(AZipFile) then Exit;
  if not AZipFile.IsOpen then Exit;

  LStream := AZipFile.OpenFileToStream(AFilename);
  try
    if not Assigned(LStream) then Exit;
    FDialog.SetReadme(LStream);
  finally
    if Assigned(LStream) then
      LStream.Free();
  end;
end;

procedure TlgStartupDialog.SetReadmeText(const AText: string);
begin
  if FDialog = nil then Exit;
  FDialog.SetReadmeText(AText);
end;

procedure TlgStartupDialog.SetLicense(const AZipFile: TlgZipFile; const AFilename: string);
var
  LStream: TStream;
begin
  if FDialog = nil then Exit;
  if not Assigned(AZipFile) then Exit;
  if not AZipFile.IsOpen then Exit;

  LStream := AZipFile.OpenFileToStream(AFilename);
  try
    if not Assigned(LStream) then Exit;
    FDialog.SetLicense(LStream);
  finally
    if Assigned(LStream) then
      LStream.Free();
  end;
end;

procedure TlgStartupDialog.SetLicenseText(const AText: string);
begin
  if FDialog = nil then Exit;
  FDialog.SetLicenseText(AText);
end;

procedure TlgStartupDialog.SetReleaseInfo(const AReleaseInfo: string);
begin
  if FDialog = nil then Exit;
  FDialog.SetReleaseInfo(AReleaseInfo);
end;

procedure TlgStartupDialog.SetWordWrap(const AWrap: Boolean);
begin
  if FDialog = nil then Exit;
  FDialog.SetWordWrap(AWrap);
end;

function TlgStartupDialog.Show(): TlgStartupDialogState;
begin
  Result := sdsQuit;
  if FDialog = nil then Exit;
  FDialog.State := sdsQuit;

  FDialog.PageControl.ActivePageIndex := 0;
  FDialog.ShowModal;
  try
    Result := FDialog.State;
  finally
    FDialog.Hide;
  end;
end;

procedure TlgStartupDialog.Hide();
begin
  if FDialog = nil then Exit;
  FDialog.Hide();
end;

end.
