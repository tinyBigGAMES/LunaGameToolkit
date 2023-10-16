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

unit LGT.Lib;

{$I LGT.Defines.inc}

interface

uses
  System.Types,
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  WinApi.Windows,
  LGT.Deps;

implementation

{============================================================================ }

{$R LGT.Deps.res}

var
  InputCodePage: Cardinal;
  OutputCodePage: Cardinal;
  DepsDLLHandle: THandle = 0;
  DepsDLLFilename: string = '';

procedure AbortDepsDLL;
begin
  if DepsDLLHandle <> 0 then
  begin
    FreeLibrary(DepsDLLHandle);
    DepsDLLHandle := 0;
  end;

  if TFile.Exists(DepsDLLFilename) then
    TFile.Delete(DepsDLLFilename);

  Halt;
end;

procedure LoadDepsDLL;
var
  LResStream: TResourceStream;

  function GetResName: string;
  const
    CValue = 'c88fbfa8003a41cb85730c70fdc9ad27';
  begin
    Result := CValue;
  end;

begin
  if DepsDLLHandle <> 0 then Exit;
  if not Boolean((FindResource(HInstance, PChar(GetResName), RT_RCDATA) <> 0)) then AbortDepsDLL;
  LResStream := TResourceStream.Create(HInstance, GetResName, RT_RCDATA);
  try
    LResStream.Position := 0;
    DepsDLLFilename := TPath.Combine(TPath.GetTempPath,
      TPath.ChangeExtension(TPath.GetGUIDFileName.ToLower, 'dat'));
    LResStream.SaveToFile(DepsDLLFilename);
    if not TFile.Exists(DepsDLLFilename) then AbortDepsDLL;
    DepsDLLHandle := LoadLibrary(PChar(DepsDLLFilename));
    if DepsDLLHandle = 0 then AbortDepsDLL;
  finally
    LResStream.Free;
  end;

  GetExports(DepsDLLHandle);
end;

procedure UnloadDepsDLL;
begin
  if DepsDLLHandle = 0 then Exit;
  FreeLibrary(DepsDLLHandle);
  TFile.Delete(DepsDLLFilename);
  DepsDLLHandle := 0
end;

initialization
begin
  // turn on memory leak detection
  ReportMemoryLeaksOnShutdown := True;

  // save current console codepage
  InputCodePage := GetConsoleCP;
  OutputCodePage := GetConsoleOutputCP;

  // set code page to UTF8
  SetConsoleCP(CP_UTF8);
  SetConsoleOutputCP(CP_UTF8);

  // load deps dll
  LoadDepsDLL;
end;

finalization
begin
  // unload deps dll
  UnloadDepsDLL;

  // restore code page
  SetConsoleCP(InputCodePage);
  SetConsoleOutputCP(OutputCodePage);
end;

end.
