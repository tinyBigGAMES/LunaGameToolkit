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

unit LGT.Actor;

{$I LGT.Defines.inc}

interface

uses
  System.SysUtils,
  System.Math,
  LGT.Core;

type
  // class forwards
  TlgActorList = class;

  { TlgActorMessage }
  PlgActorMessage = ^TlgActorMessage;
  TlgActorMessage = record
    Id: Integer;
    Data: Pointer;
    DataSize: Cardinal;
  end;

  { TlgActor }
  TlgActor = class(TlgObject)
  protected
    FOwner: TlgActor;
    FTerminated: Boolean;
    FActorList: TlgActorList;
    FCanCollide: Boolean;
    FChildren: TlgActorList;
  public
    property Terminated: Boolean read FTerminated write FTerminated;
    property Children: TlgActorList read FChildren write FChildren;
    property ActorList: TlgActorList read FActorList write FActorList;
    property CanCollide: Boolean read FCanCollide write FCanCollide;
    constructor Create(); override;
    destructor Destroy(); override;
    procedure OnVisit(const ASender: TlgActor; const AEventId: Integer; var ADone: Boolean); reintroduce; overload; virtual;
    procedure OnUpdate(); virtual;
    procedure OnRender(); virtual;
    function  OnMessage(const AMsg: PlgActorMessage): TlgActor; virtual;
    procedure OnCollide(const AActor: TlgActor); virtual;
    function  Overlap(const X, Y, ARadius, AShrinkFactor: Single): Boolean; overload; virtual;
    function  Overlap(const AActor: TlgActor): Boolean; overload; virtual;
  end;

  { TlgActorList }
  TlgActorList = class(TlgObject)
  protected
    FList: TlgObjectList;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Clean();
    procedure Add(aActor: TlgActor);
    function  Count(): Integer;
    procedure Remove(const AActor: TlgActor; const ADispose: Boolean);
    procedure Clear(const AAttrs: TlgObjectAttributeSet);
    procedure ForEach(const ASender: TlgActor; const AAttrs: TlgObjectAttributeSet; const AEventId: Integer; var ADone: Boolean);
    procedure Update(const AAttrs: TlgObjectAttributeSet);
    procedure Render(const AAttrs: TlgObjectAttributeSet);
    function  SendMessage(const AAttrs: TlgObjectAttributeSet; const AMsg: PlgActorMessage; const ABroadcast: Boolean): TlgActor;
    procedure CheckCollision(const AAttrs: TlgObjectAttributeSet; AActor: TlgActor);
  end;

  { TlgActorSceneEvent }
  TlgActorSceneEvent = procedure(ASceneNum: Integer) of object;

  { TlgActorScene }
  TlgActorScene = class(TlgObject)
  protected
    FLists: array of TlgActorList;
    FCount: Integer;
    function GetList(AIndex: Integer): TlgActorList;
    function GetCount(): Integer;
  public
    property Lists[AIndex: Integer]: TlgActorList read GetList; default;
    property Count: Integer read GetCount;
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Alloc(const ANum: Integer);
    procedure Dealloc();
    procedure Clean(const AIndex: Integer);
    procedure Clear(const AIndex: Integer; const AAttrs: TlgObjectAttributeSet);
    procedure ClearAll();
    procedure Update(const AAttrs: TlgObjectAttributeSet);
    procedure Render(const AAttrs: TlgObjectAttributeSet; const aBefore, aAfter: TlgActorSceneEvent);
    function  SendMessage(const AAttrs: TlgObjectAttributeSet; const AMsg: PlgActorMessage; const ABroadcast: Boolean): TlgActor;
  end;

  { TlgEntityActor }
  TlgEntityActor = class(TlgActor)
  protected
    FEntity: TlgEntity;
    FEntityOverlap: TEntityOverlap;
  public
    property Entity: TlgEntity read FEntity write FEntity;
    property EntityOverlap: TEntityOverlap read FEntityOverlap write FEntityOverlap;
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Init(const ASprite: TlgSprite; const AGroup: Integer); virtual;
    function Overlap(const X, Y, ARadius, AShrinkFactor: Single): Boolean; override;
    function Overlap(const AActor: TlgActor): Boolean; override;
    procedure OnRender(); override;
    class function New(ASprite: TlgSprite; AGroup: Integer): TlgEntityActor;
  end;

implementation

{ --- TlgActor -------------------------------------------------------------- }
constructor TlgActor.Create();
begin
  inherited;
  FCanCollide := False;
  FChildren := TlgActorList.Create;
end;

destructor TlgActor.Destroy();
begin
  if Assigned(FChildren) then
  begin
    FChildren.Free();
    FChildren := nil;
  end;
  inherited;
end;

procedure TlgActor.OnVisit(const ASender: TlgActor; const AEventId: Integer; var ADone: Boolean);
begin
  ADone := False;
end;

procedure TlgActor.OnUpdate();
begin
  // update all children by default
  FChildren.Update([]);
end;

procedure TlgActor.OnRender();
begin
  // render all children by default
  FChildren.Render([]);
end;

function TlgActor.OnMessage(const AMsg: PlgActorMessage): TlgActor;
begin
  Result := nil;
end;

procedure TlgActor.OnCollide(const AActor: TlgActor);
begin
end;

function TlgActor.Overlap(const X, Y, ARadius, AShrinkFactor: Single): Boolean;
begin
  Result := False;
end;

function TlgActor.Overlap(const AActor: TlgActor): Boolean;
begin
  Result := False;
end;


{ --- TlgActorList ---------------------------------------------------------- }
constructor TlgActorList.Create();
begin
  inherited;
  FList := TlgObjectList.Create();
end;

destructor TlgActorList.Destroy();
begin
  if Assigned(FList) then
  begin
    Clear([]);
    FList.Free();
    FList := nil;
  end;
  inherited;
end;

procedure TlgActorList.Clean();
var
  LPtr: TlgActor;
  LNext: TlgActor;
begin
  // get pointer to head
  LPtr := TlgActor(FList.Head);

  // exit if list is empty
  if LPtr = nil then
    Exit;

  repeat
    // save pointer to next object
    LNext := TlgActor(LPtr.Next);

    if LPtr.Terminated then
    begin
      Remove(LPtr, True);
    end;

    // get pointer to next object
    LPtr := LNext;

  until LPtr = nil;
end;

procedure TlgActorList.Add(aActor: TlgActor);
begin
  FList.Add(AActor);
end;

function  TlgActorList.Count(): Integer;
begin
  Result := FList.Count;
end;

procedure TlgActorList.Remove(const AActor: TlgActor; const ADispose: Boolean);
begin
  FList.Remove(AActor, ADispose);
end;

procedure TlgActorList.Clear(const AAttrs: TlgObjectAttributeSet);
begin
  FList.Clear(AAttrs);
end;

procedure TlgActorList.ForEach(const ASender: TlgActor; const AAttrs: TlgObjectAttributeSet; const AEventId: Integer; var ADone: Boolean);
var
  LPtr: TlgActor;
  LNext: TlgActor;
  LNoAttrs: Boolean;
begin
  Utils.EnterCriticalSection();
  try
    // get pointer to head
    LPtr := TlgActor(FList.Head);

    // exit if list is empty
    if LPtr = nil then
      Exit;

    // check if we should check for attrs
    LNoAttrs := Boolean(AAttrs = []);

    repeat
      // save pointer to next actor
      LNext := TlgActor(LPtr.Next);

      // destroy actor if not terminated
      if not LPtr.Terminated then
      begin
        // no attributes specified so update this actor
        if LNoAttrs then
        begin
          ADone := False;
          LPtr.OnVisit(ASender, AEventId, ADone);
          if ADone then
          begin
            Exit;
          end;
        end
        else
        begin
          // update this actor if it has specified attribute
          if LPtr.AttributesAreSet(AAttrs) then
          begin
            ADone := False;
            LPtr.OnVisit(ASender, AEventId, ADone);
            if ADone then
            begin
              Exit;
            end;
          end;
        end;
      end;

      // get pointer to next actor
      LPtr := LNext;

    until LPtr = nil;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgActorList.Update(const AAttrs: TlgObjectAttributeSet);
var
  LPtr: TlgActor;
  LNext: TlgActor;
  LNoAttrs: Boolean;
begin
  Utils.EnterCriticalSection();
  try
    // get pointer to head
    LPtr := TlgActor(FList.Head);

    // exit if list is empty
    if LPtr = nil then  Exit;

    // check if we should check for attrs
    LNoAttrs := Boolean(AAttrs = []);

    repeat
      // save pointer to next actor
      LNext := TlgActor(LPtr.Next);

      // destroy actor if not terminated
      if not LPtr.Terminated then
      begin
        // no attributes specified so update this actor
        if LNoAttrs then
        begin
          // call actor's OnUpdate method
          LPtr.OnUpdate();
        end
        else
        begin
          // update this actor if it has specified attribute
          if LPtr.AttributesAreSet(AAttrs) then
          begin
            // call actor's OnUpdate method
            LPtr.OnUpdate();
          end;
        end;
      end;

      // get pointer to next actor
      LPtr := LNext;

    until LPtr = nil;

    // perform garbage collection
    Clean();
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgActorList.Render(const AAttrs: TlgObjectAttributeSet);
var
  LPtr: TlgActor;
  LNext: TlgActor;
  LNoAttrs: Boolean;
begin
  Utils.EnterCriticalSection();
  try
    // get pointer to head
    LPtr := TlgActor(FList.Head);

    // exit if list is empty
    if LPtr = nil then Exit;

    // check if we should check for attrs
    LNoAttrs := Boolean(AAttrs = []);

    repeat
      // save pointer to next actor
      LNext := TlgActor(LPtr.Next);

      // destroy actor if not terminated
      if not LPtr.Terminated then
      begin
        // no attributes specified so update this actor
        if LNoAttrs then
        begin
          // call actor's OnRender method
          LPtr.OnRender;
        end
        else
        begin
          // update this actor if it has specified attribute
          if LPtr.AttributesAreSet(AAttrs) then
          begin
            // call actor's OnRender method
            LPtr.OnRender;
          end;
        end;
      end;

      // get pointer to next actor
      LPtr := LNext;

    until LPtr = nil;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

function  TlgActorList.SendMessage(const AAttrs: TlgObjectAttributeSet; const AMsg: PlgActorMessage; const ABroadcast: Boolean): TlgActor;
var
  LPtr: TlgActor;
  LNext: TlgActor;
  LNoAttrs: Boolean;
begin
  Utils.EnterCriticalSection();
  try
    Result := nil;

    // get pointer to head
    LPtr := TlgActor(FList.Head);

    // exit if list is empty
    if LPtr = nil then Exit;

    // check if we should check for attrs
    LNoAttrs := Boolean(AAttrs = []);

    repeat
      // save pointer to next actor
      LNext := TlgActor(LPtr.Next);

      // destroy actor if not terminated
      if not LPtr.Terminated then
      begin
        // no attributes specified so update this actor
        if LNoAttrs then
        begin
          // send message to object
          Result := LPtr.OnMessage(AMsg);
          if not ABroadcast then
          begin
            if Result <> nil then
            begin
              Exit;
            end;
          end;
        end
        else
        begin
          // update this actor if it has specified attribute
          if LPtr.AttributesAreSet(AAttrs) then
          begin
            // send message to object
            Result := LPtr.OnMessage(AMsg);
            if not ABroadcast then
            begin
              if Result <> nil then
              begin
                Exit;
              end;
            end;

          end;
        end;
      end;

      // get pointer to next actor
      LPtr := LNext;

    until LPtr = nil;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgActorList.CheckCollision(const AAttrs: TlgObjectAttributeSet; AActor: TlgActor);
var
  LPtr: TlgActor;
  LNext: TlgActor;
  LNoAttrs: Boolean;
begin
  Utils.EnterCriticalSection();
  try
    // check if terminated
    if AActor.Terminated then Exit;

    // check if can collide
    if not AActor.CanCollide then Exit;

    // get pointer to head
    LPtr := TlgActor(FList.Head);

    // exit if list is empty
    if LPtr = nil then Exit;

    // check if we should check for attrs
    LNoAttrs := Boolean(AAttrs = []);

    repeat
      // save pointer to next actor
      LNext := TlgActor(LPtr.Next);

      // destroy actor if not terminated
      if not LPtr.Terminated then
      begin
        // no attributes specified so check collision with this actor
        if LNoAttrs then
        begin

          if LPtr.CanCollide then
          begin
            if AActor.Overlap(LPtr) then
            begin
              LPtr.OnCollide(AActor);
              AActor.OnCollide(LPtr);
              // Exit;
            end;
          end;

        end
        else
        begin
          // check collision with this actor if it has specified attribute
          if LPtr.AttributesAreSet(AAttrs) then
          begin
            if LPtr.CanCollide then
            begin
              if AActor.Overlap(LPtr) then
              begin
                LPtr.OnCollide(AActor);
                AActor.OnCollide(LPtr);
                // Exit;
              end;
            end;

          end;
        end;
      end;

      // get pointer to next actor
      LPtr := LNext;

    until LPtr = nil;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

{ --- TlgActorScene ---------------------------------------------------------- }
function TlgActorScene.GetList(AIndex: Integer): TlgActorList;
begin
  Result := FLists[AIndex];
end;

function TlgActorScene.GetCount(): Integer;
begin
  Result := FCount;
end;

constructor TlgActorScene.Create();
begin
  inherited;
  FLists := nil;
  FCount := 0;
end;

destructor TlgActorScene.Destroy();
begin
  Dealloc();
  inherited;
end;

procedure TlgActorScene.Alloc(const ANum: Integer);
var
  I: Integer;
begin
  Dealloc;
  FCount := ANum;
  SetLength(FLists, FCount);
  for I := 0 to FCount - 1 do
  begin
    FLists[I] := TlgActorList.Create;
  end;
end;

procedure TlgActorScene.Dealloc();
var
  I: Integer;
begin
  ClearAll;
  for I := 0 to FCount - 1 do
  begin
    FLists[I].Free();
  end;
  FLists := nil;
  FCount := 0;
end;

procedure TlgActorScene.Clean(const AIndex: Integer);
begin
  if not InRange(AIndex, 0, FCount-1) then Exit;
  FLists[AIndex].Clean();
end;

procedure TlgActorScene.Clear(const AIndex: Integer; const AAttrs: TlgObjectAttributeSet);
begin
  if not InRange(AIndex, 0, FCount-1) then Exit;
  FLists[AIndex].Clear(AAttrs);
end;

procedure TlgActorScene.ClearAll();
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
  begin
    FLists[I].Clear([]);
  end;
end;

procedure TlgActorScene.Update(const AAttrs: TlgObjectAttributeSet);
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
  begin
    FLists[I].Update(AAttrs);
  end;
end;

procedure TlgActorScene.Render(const AAttrs: TlgObjectAttributeSet; const aBefore, aAfter: TlgActorSceneEvent);
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
  begin
    if Assigned(aBefore) then aBefore(I);
    FLists[I].Render(AAttrs);
    if Assigned(aAfter) then aAfter(I);
  end;
end;

function TlgActorScene.SendMessage(const AAttrs: TlgObjectAttributeSet; const AMsg: PlgActorMessage; const ABroadcast: Boolean): TlgActor;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FCount - 1 do
  begin
    Result := FLists[I].SendMessage(AAttrs, AMsg, ABroadcast);
    if not ABroadcast then
    begin
      if Result <> nil then
      begin
        Exit;
      end;
    end;
  end;
end;

{ --- TlgEntityActor -------------------------------------------------------- }
constructor TlgEntityActor.Create();
begin
  inherited;
  FEntity := nil;
end;

destructor TlgEntityActor.Destroy();
begin
  if Assigned(FEntity) then
  begin
    FEntity.Free();
    FEntity := nil;
  end;
  inherited;
end;

procedure TlgEntityActor.Init(const ASprite: TlgSprite; const AGroup: Integer);
begin
  if Assigned(FEntity) then Exit;
  FEntity := TlgEntity.New(ASprite, AGroup);
  FEntityOverlap := eoOBB;
end;

function TlgEntityActor.Overlap(const X, Y, ARadius, AShrinkFactor: Single): Boolean;
begin
  Result := FAlse;
  if not Assigned(FEntity) then Exit;
  Result := FEntity.Overlap(X, Y, ARadius, AShrinkFactor);
end;

function TlgEntityActor.Overlap(const AActor: TlgActor): Boolean;
begin
  Result := False;
  if not Assigned(FEntity)then Exit;
  if AActor is TlgEntityActor then
  begin
    Result := FEntity.Overlap(TlgEntityActor(AActor).Entity, FEntityOverlap);
  end
end;

procedure TlgEntityActor.OnRender();
begin
  if not Assigned(FEntity) then Exit;
  FEntity.Render();
end;

class function TlgEntityActor.New(ASprite: TlgSprite; AGroup: Integer): TlgEntityActor;
begin
  Result := TlgEntityActor.Create();
  Result.Init(ASprite, AGroup);
end;

end.
