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

unit LGT.Speech;

{$I LGT.Defines.inc}

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  System.Classes,
  System.Math,
  LGT.Core,
  LGT.SpeechLib;

type
  { TlgSpeechVoiceAttribute }
  TlgSpeechVoiceAttribute = (vaDescription, vaName, vaVendor, vaAge, vaGender, vaLanguage, vaId);

  { TlgSpeechSpeechWordEvent }
  TlgSpeechSpeechWordEvent = procedure(const AWord: string; const AText: string) of object;

  { TlgSpeech }
  TlgSpeech = class(TlgObject)
  protected
    FSpVoice: TSpVoice;
    FVoiceList: TInterfaceList;
    FVoiceDescList: TStringList;
    FPaused: Boolean;
    FText: string;
    FWord: string;
    FVoice: Integer;
    FSubList: TDictionary<string, string>;
    FOnWord: TlgSpeechSpeechWordEvent;
    FVolume: Single;
    procedure DoOnWord(ASender: TObject; AStreamNumber: Integer; AStreamPosition: OleVariant; ACharacterPosition, ALength: Integer);
    procedure DoSpeak(AText: string; AFlags: Integer);
    procedure EnumVoices();
    procedure FreeVoices();
  public
    constructor Create(); override;
    destructor Destroy(); override;
  public
    property OnWord: TlgSpeechSpeechWordEvent read FOnWord write FOnWord;
    function  GetVoiceCount(): Integer;
    function  GetVoiceAttribute(const AIndex: Integer; const AAttribute: TlgSpeechVoiceAttribute): string;
    procedure ChangeVoice(const AIndex: Integer);
    function  GetVoice(): Integer;
    procedure SetVolume(const AVolume: Single);
    function  GetVolume(): Single;
    procedure SetRate(const ARate: Single);
    function  GetRate(): Single;
    procedure Clear();
    procedure Say(const AText: string; const APurge: Boolean);
    procedure SayXML(const AText: string; const APurge: Boolean);
    function  Active(): Boolean;
    procedure Pause();
    procedure Resume();
    procedure Reset();
    procedure SubstituteWord(const AWord: string; const ASubstituteWord: string);
  end;

implementation

{  TlgSpeech }
procedure TlgSpeech.DoOnWord(ASender: TObject; AStreamNumber: Integer; AStreamPosition: OleVariant; ACharacterPosition, ALength: Integer);
var
  LWord: string;
begin
  if FText.IsEmpty then Exit;
  LWord := FText.Substring(ACharacterPosition, ALength);
  if not FSubList.TryGetValue(LWord, FWord) then
    FWord := LWord;
  if Assigned(FOnWord) then
  begin
    FOnWord(FWord, FText);
  end;
end;

//procedure Speech.OnStartStream(aSender: TObject; aStreamNumber: Integer; aStreamPosition: OleVariant);
//begin
//end;

procedure TlgSpeech.DoSpeak(AText: string; AFlags: Integer);
begin
  if FSpVoice = nil then Exit;
  if AText.IsEmpty then Exit;
  if FPaused then Resume;
  FSpVoice.Speak(AText, AFlags);
  FText := AText;
end;

procedure TlgSpeech.EnumVoices;
var
  LI: Integer;
  LSOToken: ISpeechObjectToken;
  LSOTokens: ISpeechObjectTokens;
begin
  FVoiceList := TInterfaceList.Create;
  FVoiceDescList := TStringList.Create;
  LSOTokens := FSpVoice.GetVoices('', '');
  for LI := 0 to LSOTokens.Count - 1 do
  begin
    LSOToken := LSOTokens.Item(LI);
    FVoiceDescList.Add(LSOToken.GetDescription(0));
    FVoiceList.Add(LSOToken);
  end;
end;

procedure TlgSpeech.FreeVoices;
begin
  FreeAndNil(FVoiceDescList);
  FreeAndNil(FVoiceList);
end;

constructor TlgSpeech.Create;
begin
  inherited;
  FPaused := False;
  FText := '';
  FWord := '';
  FVoice := 0;
  FSpVoice := TSpVoice.Create(nil);
  FSpVoice.EventInterests := SVEAllEvents;
  EnumVoices;
  //FSpVoice.OnStartStream := OnStartStream;
  FSpVoice.OnWord := DoOnWord;
  FSubList := TDictionary<string, string>.Create;
  FVolume := 1;
end;

destructor TlgSpeech.Destroy;
begin
  FreeAndNil(FSubList);
  FreeVoices;
  FSpVoice.OnWord := nil;
  FSpVoice.Free;
  inherited;
end;

function TlgSpeech.GetVoiceCount: Integer;
begin
  Result := FVoiceList.Count;
end;

function TlgSpeech.GetVoiceAttribute(const AIndex: Integer; const AAttribute: TlgSpeechVoiceAttribute): string;
var
  LSOToken: ISpeechObjectToken;

  function GetAttr(const aItem: string): string;
  begin
    if aItem = 'Id' then
      Result := LSOToken.Id
    else
      Result := LSOToken.GetAttribute(aItem);
  end;

begin
  Result := '';
  if (AIndex < 0) or (AIndex > FVoiceList.Count - 1) then
    Exit;
  LSOToken := ISpeechObjectToken(FVoiceList.Items[AIndex]);
  case AAttribute of
    vaDescription:
      Result := FVoiceDescList[AIndex];
    vaName:
      Result := GetAttr('Name');
    vaVendor:
      Result := GetAttr('Vendor');
    vaAge:
      Result := GetAttr('Age');
    vaGender:
      Result := GetAttr('Gender');
    vaLanguage:
      Result := GetAttr('Language');
    vaId:
      Result := GetAttr('Id');
  end;
end;

procedure TlgSpeech.ChangeVoice(const AIndex: Integer);
var
  LSOToken: ISpeechObjectToken;
begin
  if (AIndex < 0) or (AIndex > FVoiceList.Count - 1) then Exit;
  if AIndex = FVoice then Exit;
  LSOToken := ISpeechObjectToken(FVoiceList.Items[AIndex]);
  FSpVoice.Voice := LSOToken;
  FVoice := AIndex;
end;

function TlgSpeech.GetVoice: Integer;
begin
  Result := FVoice;
end;

procedure TlgSpeech.SetVolume(const AVolume: Single);
begin
  if FSpVoice = nil then   Exit;
  FVolume := EnsureRange(AVolume, 0, 1);
  FSpVoice.Volume := Round(Math.UnitToScalarValue(FVolume, 100));
end;

function TlgSpeech.GetVolume: Single;
begin
  Result := 0;
  if FSpVoice = nil then Exit;
  Result := FVolume;
end;

procedure TlgSpeech.SetRate(const ARate: Single);
var
  LVolume: Integer;
  LRate: Single;
begin
  if FSpVoice = nil then Exit;

  LRate := EnsureRange(ARate, 0, 1);

  LVolume := Round(20.0 * LRate) - 10;

  if LVolume < -10 then
    LVolume := -10
  else if LVolume > 10 then
    LVolume := 10;

  FSpVoice.Rate := LVolume;
end;

function TlgSpeech.GetRate: Single;
begin
  Result := 0;
  if FSpVoice = nil then Exit;
  Result := (FSpVoice.Rate + 10.0) / 20.0;
end;

procedure TlgSpeech.Say(const AText: string; const APurge: Boolean);
var
  LFlag: Integer;
  LText: string;
begin
  LFlag := SVSFlagsAsync;
  LText := AText;
  if APurge then
    LFlag := LFlag or SVSFPurgeBeforeSpeak;
  DoSpeak(LText, LFlag);
end;

procedure TlgSpeech.SayXML(const AText: string; const APurge: Boolean);
var
  LFlag: Integer;
  LText: string;
begin
  LFlag := SVSFlagsAsync or SVSFIsXML;
  if APurge then
    LFlag := LFlag or SVSFPurgeBeforeSpeak;
  LText := AText;
  DoSpeak(AText, LFlag);
end;

procedure TlgSpeech.Clear();
begin
  if FSpVoice = nil then Exit;
  if Active then
  begin
    FSpVoice.Skip('Sentence', MaxInt);
    Say(' ', True);
  end;
  FText := '';
end;

function TlgSpeech.Active(): Boolean;
begin
  Result := False;
  if FSpVoice = nil then Exit;
  Result := Boolean(FSpVoice.Status.RunningState <> SRSEDone);
end;

procedure TlgSpeech.Pause();
begin
  if FSpVoice = nil then Exit;
  FSpVoice.Pause;
  FPaused := True;
end;

procedure TlgSpeech.Resume();
begin
  if FSpVoice = nil then Exit;
  FSpVoice.Resume;
  FPaused := False;
end;

procedure TlgSpeech.Reset();
begin
  Clear;
  FreeAndNil(FSpVoice);
  FPaused := False;
  FText := '';
  FWord := '';
  FSpVoice := TSpVoice.Create(nil);
  FSpVoice.EventInterests := SVEAllEvents;
  EnumVoices;
  //FSpVoice.OnStartStream := OnStartStream;
  FSpVoice.OnWord := DoOnWord;
end;

procedure TlgSpeech.SubstituteWord(const AWord: string; const ASubstituteWord: string);
var
  LWord: string;
  LSubstituteWord: string;
begin
  LWord := AWord;
  LSubstituteWord := ASubstituteWord;
  if LWord.IsEmpty then Exit;
  if LSubstituteWord.IsEmpty then Exit;
  FSubList.TryAdd(LWord, LSubstituteWord);
end;

end.
