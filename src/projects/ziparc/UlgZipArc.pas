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

unit UlgZipArc;

interface

uses
  System.SysUtils,
  System.IOUtils,
  LGT.Core,
  LGT.Game;

type
  { TlgZipArc }
  TlgZipArc = class(TlgGame)
  protected
    procedure ShowHeader;
    procedure ShowUsage;
  public
    procedure Run(); override;
  end;

implementation

{ TlgZipArc }
procedure TlgZipArc.ShowHeader;
begin
  Terminal.PrintLn('');
  Terminal.PrintLn('lgZipArc™ - Archive Utilty v%s', [LGT_VERSION]);
  Terminal.PrintLn('Copyright © 2022-present tinyBigGAMES™ LLC');
  Terminal.PrintLn('All Rights Reserved.');
end;

procedure TlgZipArc.ShowUsage;
begin
  Terminal.PrintLn('');
  Terminal.PrintLn('Usage: lgZipArc archivename[.zip] directoryname [password]' );
  Terminal.PrintLn('  archivename   - compressed archive name');
  Terminal.PrintLn('  directoryname - directory to archive');
  Terminal.PrintLn('  password      - optional password');
end;

procedure TlgZipArc.Run();
var
  LArchiveFilename: string;
  LDirectoryName: string;
  LPassword: string;
begin
  // init local vars
  LArchiveFilename := '';
  LDirectoryName := '';
  LPassword := TlgZipStream.DEFAULT_PASSWORD;

  // display header
  ShowHeader();

  // check for archive directory
  if ParamCount = 2 then
    begin
      LArchiveFilename := ParamStr(1);
      LDirectoryName := ParamStr(2);
      LArchiveFilename := Utils.RemoveQuotes(LArchiveFilename);
      LDirectoryName := Utils.RemoveQuotes(LDirectoryName);
    end
  else
  if ParamCount = 3 then
    begin
      LArchiveFilename := ParamStr(1);
      LDirectoryName := ParamStr(2);
      LPassword := ParamStr(3);
      LArchiveFilename := Utils.RemoveQuotes(LArchiveFilename);
      LDirectoryName := Utils.RemoveQuotes(LDirectoryName);
      LPassword := Utils.RemoveQuotes(LPassword);
    end
  else
    begin
      // show usage
      ShowUsage();
      Exit;
    end;

  // check if directory exist
  if not TDirectory.Exists(LDirectoryName) then
    begin
      Terminal.PrintLn('');
      Terminal.PrintLn('Directory was not found: %s', [LDirectoryName]);
      ShowUsage;
      Exit;
    end;

  // display params
  Terminal.PrintLn('');
  Terminal.PrintLn('Archive  : %s', [LArchiveFilename]);
  Terminal.PrintLn('Directory: %s', [LDirectoryName]);
  Terminal.PrintLn('Password : %s', [LPassword]);

  // try to build archive
  Terminal.PrintLn('');
  Terminal.PrintLn('Building ...', []);

  if TlgZipStream.Build(LArchiveFilename, LDirectoryName, nil, nil, LPassword) then
    Terminal.PrintLn(LF+LF+'Success!', [])
  else
    Terminal.PrintLn(LF+LF+'Failed!', []);
end;

end.
