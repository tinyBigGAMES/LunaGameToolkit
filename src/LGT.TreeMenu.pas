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

unit LGT.TreeMenu;

{$I LGT.Defines.inc}

interface

uses
  System.SysUtils,
  System.Math,
  VCL.ComCtrls,
  LGT,
  LGT.TreeMenuForm;

const
  { TreeMenu }
  TREEMENU_NONE = -1;
  TREEMENU_QUIT = -2;

type
  { TlgTreeMenu }
  TlgTreeMenu = class(TlgObject)
  protected
    FForm: TlgTreeMenuForm;
    FLastSelectedId: Integer;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure SetTitle(const aTitle: string);
    procedure SetStatus(const aTitle: string);
    procedure Clear();
    function  First(const AParent: Pointer): Integer;
    function  AddItem(const AParent: Pointer; const AName: string; const AId: Integer; const AEnabled: Boolean): Pointer;
    function  InsertItem(const ASibling: Pointer; const AName: string; const AId: Integer; const AEnabled: Boolean): Pointer;
    procedure Sort(const AParent: Pointer);
    procedure SelItem(const AId: Integer);
    procedure BoldItemId(const AId: Integer; const AValue: Boolean);
    procedure BoldItem(const AItem: string; const AValue: Boolean);
    function  Show(const AId: Integer): Integer;
    function  GetCount(): Integer;
    function  GetLastSelectedId(): Integer;
    function  GetSelectableCount(): Integer;
  end;

implementation

{ TTreeMenu }
constructor TlgTreeMenu.Create;
begin
  inherited;
  FForm := TlgTreeMenuForm.Create(nil);
  FForm.StatusBar.SimplePanel := True;
end;

destructor TlgTreeMenu.Destroy;
begin
  if Assigned(FForm) then
  begin
    FForm.Free();
    FForm := nil;
  end;
  inherited;
end;

procedure TlgTreeMenu.SetTitle(const aTitle: string);
begin
  FForm.Caption := aTitle;
end;

procedure TlgTreeMenu.SetStatus(const aTitle: string);
begin
  FForm.StatusBar.SimpleText := aTitle;
end;

procedure TlgTreeMenu.Clear;
begin
  FForm.TreeView.Items.Clear;
end;

function  TlgTreeMenu.First(const AParent: Pointer): Integer;
var
  LNode: TTreeNode;
begin
  Result := TREEMENU_NONE;
  if AParent = nil then
    LNode := FForm.TreeView.Items.GetFirstNode
  else
    LNode := TTreeNode(AParent);

  if LNode.Count > 0 then
  begin
    Result := LNode.getFirstChild.SelectedIndex;
  end;
end;

function  TlgTreeMenu.AddItem(const AParent: Pointer; const AName: string; const AId: Integer; const AEnabled: Boolean): Pointer;
var
  LNode: TTreeNode;
begin
  LNode := FForm.TreeView.Items.AddChild(TTreeNode(AParent), AName);
  LNode.SelectedIndex := AId;
  if AId = TREEMENU_NONE then BoldItem(AName, True);
  LNode.Enabled := AEnabled;
  Result := Pointer(LNode);
end;

function  TlgTreeMenu.InsertItem(const ASibling: Pointer; const AName: string; const AId: Integer; const AEnabled: Boolean): Pointer;
var
  LNode: TTreeNode;
begin
  LNode := FForm.TreeView.Items.Insert(TTreeNode(ASibling), AName);
  LNode.SelectedIndex := AId;
  if AId = TREEMENU_NONE then BoldItem(AName, True);
  LNode.Enabled := AEnabled;
  Result := Pointer(LNode);
end;

procedure TlgTreeMenu.Sort(const AParent: Pointer);
var
  LNode: TTreeNode;
begin
  LNode := TTreeNode(AParent);
  if LNode = nil then
    FForm.TreeView.AlphaSort(True)
  else
    LNode.CustomSort(nil, 0, False);
end;

procedure TlgTreeMenu.SelItem(const AId: Integer);
begin
  FForm.SelMenu(AId);
end;

procedure TlgTreeMenu.BoldItemId(const AId: Integer; const AValue: Boolean);
begin
  FForm.BoldItemId(AId, AValue);
end;

procedure TlgTreeMenu.BoldItem(const AItem: string; const AValue: Boolean);
begin
  FForm.BoldItem(AItem, AValue);
end;

function TlgTreeMenu.Show(const AId: Integer): Integer;
begin
  if FForm.TreeView.Items.Count <= 0 then
  begin
    AddItem(nil, 'You must add at lest one item', 0, False);
  end;

  FForm.SelMenu(AId);
  FForm.ShowModal;
  Result := FForm.SelId;
end;

function TlgTreeMenu.GetCount(): Integer;
begin
  Result := FForm.TreeView.Items.Count;
  if Result < 0 then Result := 0;
end;

function  TlgTreeMenu.GetLastSelectedId(): Integer;
begin
  Result := FForm.LastSelId;
end;

function  TlgTreeMenu.GetSelectableCount(): Integer;
begin
  Result := FForm.Count;
end;

end.
