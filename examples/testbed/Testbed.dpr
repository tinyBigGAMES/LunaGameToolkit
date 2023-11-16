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
  LGT.Core in '..\..\src\LGT.Core.pas',
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
  UActor in 'UActor.pas',
  LGT.StartupDialogForm in '..\..\src\LGT.StartupDialogForm.pas' {lgStartupDialogForm},
  LGT.StartupDialog in '..\..\src\LGT.StartupDialog.pas',
  LGT.SpeechLib in '..\..\src\LGT.SpeechLib.pas',
  LGT.Speech in '..\..\src\LGT.Speech.pas',
  LGT.Actor in '..\..\src\LGT.Actor.pas',
  LGT.Game in '..\..\src\LGT.Game.pas',
  LGT.CloudDb in '..\..\src\LGT.CloudDb.pas';

begin
  try
    RunTests;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
