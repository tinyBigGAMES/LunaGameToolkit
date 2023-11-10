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

unit UCommon;

interface

uses
  System.SysUtils,
  LGT;

const
  CZipFilename = 'Data.zip';

  CTitle = 'Luna Game Toolkit';

type

  { TExample }
  TExample = class(TlgGameApp)
  public
    procedure OnDefineSettings(var ASettings: TlgGameAppSettings); override;
  end;


implementation

{ --- TExample -------------------------------------------------------------- }
procedure TExample.OnDefineSettings(var ASettings: TlgGameAppSettings);
begin
  inherited;

  // window
  ASettings.WindowTitle := 'TExample';

  // zipFile
  ASettings.ZipFilename := CZipFilename;
end;

end.
