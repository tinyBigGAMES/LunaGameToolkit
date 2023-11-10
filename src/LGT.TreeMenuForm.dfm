object lgTreeMenuForm: TlgTreeMenuForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tree Menu'
  ClientHeight = 404
  ClientWidth = 389
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 144
  TextHeight = 23
  object TreeView: TTreeView
    Left = 12
    Top = 12
    Width = 362
    Height = 281
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Indent = 29
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    OnChange = TreeViewChange
    OnChanging = TreeViewChanging
    OnClick = TreeViewClick
    OnDblClick = TreeViewDblClick
  end
  object OkButton: TButton
    Left = 77
    Top = 315
    Width = 112
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = OkButtonClick
  end
  object QuitButton: TButton
    Left = 198
    Top = 315
    Width = 113
    Height = 38
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Quit'
    TabOrder = 2
    OnClick = QuitButtonClick
  end
  object StatusBar: TStatusBar
    AlignWithMargins = True
    Left = 5
    Top = 371
    Width = 379
    Height = 28
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    DoubleBuffered = True
    Panels = <>
    ParentDoubleBuffered = False
  end
end