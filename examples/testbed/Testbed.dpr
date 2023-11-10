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

program Testbed;

{$APPTYPE CONSOLE}

{$R *.res}





{$R *.dres}

uses
  System.SysUtils,
  LGT in '..\..\src\LGT.pas',
  LGT.Deps in '..\..\src\LGT.Deps.pas',
  LGT.OGL in '..\..\src\LGT.OGL.pas',
  LGT.TreeMenuForm in '..\..\src\LGT.TreeMenuForm.pas' {lgTreeMenuForm},
  LGT.TreeMenu in '..\..\src\LGT.TreeMenu.pas',
  UTestbed in 'UTestbed.pas',
  UCommon in 'UCommon.pas',
  UMisc in 'UMisc.pas',
  UAudio in 'UAudio.pas',
  UVideo in 'UVideo.pas',
  UTexture in 'UTexture.pas',
  UFont in 'UFont.pas',
  UGUI in 'UGUI.pas',
  UWindow in 'UWindow.pas',
  UActor in 'UActor.pas';

begin
  try
    RunTests;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
