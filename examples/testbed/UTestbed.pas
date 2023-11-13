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

unit UTestbed;

interface

uses
  System.SysUtils,
  Vcl.Themes,
  Vcl.Styles,
  WinApi.Windows,
  LGT,
  LGT.TreeMenu,
  LGT.StartupDialog,
  UCommon,
  UMisc,
  UAudio,
  UVideo,
  UTexture,
  UFont,
  UGUI,
  UWindow,
  uActor;

procedure RunTests;

implementation

procedure StartupDialogMore();
begin
  MessageBox(0, 'You can process additional custom dialog operations here', 'StartupDialog MORE', MB_OK);
end;

procedure StartupDialogRun();
type
  TMenuItem = (
    // audio
    miAudio_Init,
    miAudio_MultiChannel,

    // window
    miWindow_Starfield,
    miWindow_Polygon,

    // texture
    miTexture_TiledParallax,
    miTexture_Collision,

    // actor
    miActor_Basic,
    miActor_EntityCollision,

    // gui
    miGui_Basic,

    // misc
    miMisc_MinimalExample,
    miMisc_BuildZipFile,
    miMisc_2DCamera,
    miMisc_Timer,

    // video
    miVideo_Playback,
    miVideo_ChainedPlayback,

    // font
    miFont_Unicode,

    miLast
  );
var
  LTreeMenu: TlgTreeMenu;
  LAudioMenu: Pointer;
  LWindowMenu: Pointer;
  LMiscMenu: Pointer;
  LVideoMenu: Pointer;
  LTextureMenu: Pointer;
  LFontMenu: Pointer;
  LGuiMenu: Pointer;
  LActorMenu: Pointer;
  LSelItem: Integer;
begin
  LTreeMenu := TlgTreeMenu.Create();
  try
    LTreeMenu.SetTitle('Example Menu');
    //LTreeMenu.SetStatus('v'+LGT_VERSION+' ('+LGT_CODENAME+')');

    // audio
    LAudioMenu := LTreeMenu.AddItem(nil, 'Audio', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LAudioMenu, 'Init', Ord(miAudio_Init), True);
      LTreeMenu.AddItem(LAudioMenu, 'Multichannel', Ord(miAudio_MultiChannel), True);
    LTreeMenu.Sort(LAudioMenu);

    // window
    LWindowMenu := LTreeMenu.AddItem(nil, 'Window', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LWindowMenu, 'Polygon', Ord(miWindow_Polygon), True);
      LTreeMenu.AddItem(LWindowMenu, 'Starfield', Ord(miWindow_Starfield), True);
    LTreeMenu.Sort(LWindowMenu);

    // video
    LVideoMenu := LTreeMenu.AddItem(nil, 'Video', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LVideoMenu, 'Playback', Ord(miVideo_Playback), True);
      LTreeMenu.AddItem(LVideoMenu, 'Chained Playback', Ord(miVideo_ChainedPlayback), True);
    LTreeMenu.Sort(LVideoMenu);

    // texture
    LTextureMenu := LTreeMenu.AddItem(nil, 'Texture', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LTextureMenu, 'Tiled Parallax', Ord(miTexture_TiledParallax), True);
      LTreeMenu.AddItem(LTextureMenu, 'Collision', Ord(miTexture_Collision), True);
    LTreeMenu.Sort(LTextureMenu);

    // font
    LFontMenu := LTreeMenu.AddItem(nil, 'Font', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LFontMenu, 'Unicode', Ord(miFont_Unicode), True);
    LTreeMenu.Sort(LFontMenu);

    // gui
    LGuiMenu := LTreeMenu.AddItem(nil, 'GUI', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LGuiMenu, 'Basic', Ord(miGui_Basic), True);
    LTreeMenu.Sort(LGuiMenu);

    // actor
    LActorMenu := LTreeMenu.AddItem(nil, 'Actor', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LActorMenu, 'Basic', Ord(miActor_Basic), True);
      LTreeMenu.AddItem(LActorMenu, 'Entity Collision', Ord(miActor_EntityCollision), True);
    LTreeMenu.Sort(LActorMenu);


    // sort whole menu
    LTreeMenu.Sort(nil);

    // misc
    LMiscMenu := LTreeMenu.AddItem(nil, 'Misc', TREEMENU_NONE, True);
      LTreeMenu.AddItem(LMiscMenu, 'Minimal Example', Ord(miMisc_MinimalExample), True);
      LTreeMenu.AddItem(LMiscMenu, 'Build ZipFile', Ord(miMisc_BuildZipFile), True);
      LTreeMenu.AddItem(LMiscMenu, '2D Camera', Ord(miMisc_2DCamera), True);
      LTreeMenu.AddItem(LMiscMenu, 'Timer', Ord(miMisc_Timer), True);
    LTreeMenu.Sort(LMiscMenu);

    // menu loop
    LSelItem := -1;
    while true do
    begin
      LSelItem := LTreeMenu.Show(LSelItem);
      if (LSelItem = TREEMENU_QUIT) then
        Break;
      case TMenuItem(LSelItem) of
        // misc
        miMisc_MinimalExample    : lgRunGame(TMinimalExample);
        miMisc_BuildZipFile      : lgRunGame(TBuildZipFile);
        miMisc_2DCamera          : lgRunGame(TCamera2D);
        miMisc_Timer             : lgRunGame(TTimer);

        // audio
        miAudio_Init             : lgRunGame(TAudioInit);
        miAudio_MultiChannel     : lgRunGame(TAudioMultiChannel);

        // video
        miVideo_Playback         : lgRunGame(TVideoPlay);
        miVideo_ChainedPlayback  : lgRunGame(TVideoPlayChained);

        // texture
        miTexture_TiledParallax  : lgRunGame(TTextureTiledParallax);
        miTexture_Collision      : lgRunGame(TTextureCollision);

        // font
        miFont_Unicode           : lgRunGame(TFontUnicode);

        // gui
        miGui_Basic              : lgRunGame(TGUIBasic);

        // window
        miWindow_Polygon         : lgRunGame(TPolygon);
        miWindow_Starfield       : lgRunGame(TStarfield);

        // actor
        miActor_Basic            : lgRunGame(TActorBasic);
        miActor_EntityCollision  : lgRunGame(TActorEntityCollision);
      end;
    end;
  finally
    LTreeMenu.Free();
  end;
end;

procedure RunTests;
var
  LZipFile: TlgZipFile;
  LStartupDialog: TlgStartupDialog;
  LState: TlgStartupDialogState;
begin
  // set custom style
  TStyleManager.TrySetStyle('Aqua Light Slate');

  // init toolkit
  lgInit();
  if not lgIsInit() then Exit;

  // init zipfile
  LZipFile := TlgZipFile.Init(CZipFilename);

  LStartupDialog := TlgStartupDialog.Create();
  try
    LStartupDialog.SetCaption('Luna Game Toolkit: Testbed');
    LStartupDialog.SetLogo(LZipFile, 'res/startupdialog/banner.png');
    LStartupDialog.SetLogoClickUrl('https://github.com/tinyBigGAMES/LunaGameToolkit');
    LStartupDialog.SetReadme(LZipFile, 'res/startupdialog/readme.rtf');
    LStartupDialog.SetLicense(LZipFile, 'res/startupdialog/license.rtf');
    LStartupDialog.SetReleaseInfo('v'+LGT_VERSION+' ('+LGT_CODENAME+')');

    // process startupdialog
    repeat
      LState := LStartupDialog.Show();
      case LState of
        sdsMore: StartupDialogMore();
        sdsRun : StartupDialogRun();
        sdsQuit: ;
      end;
    until LState = sdsQuit;

  finally
    LStartupDialog.Free();
  end;

  // free zipfile
  LZipFile.Free();

  // shutdown toolkit
  lgQuit();
end;

end.
