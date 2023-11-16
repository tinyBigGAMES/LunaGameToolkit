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

unit LGT.CloudDb;

{$I LGT.Defines.inc}

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.Net.HttpClient,
  System.JSON,
  LGT.Core;

type
  { TlgCloudDb }
  TlgCloudDb = class(TlgObject)
  protected const
    cURL = '/?apikey=%s&keyspace=%s&query=%s';
  protected
    FUrl: string;
    FApiKey: string;
    FDatabase: string;
    FResponseText: string;
    FLastError: string;
    FHttp: THTTPClient;
    FSQL: TStringList;
    FPrepairedSQL: string;
    FJSON: TJSONObject;
    FDataset: TJSONArray;
    FMacros: TDictionary<string, string>;
    FParams: TDictionary<string, string>;
    procedure SetMacroValue(const AName, AValue: string);
    procedure SetParamValue(const AName, AValue: string);
    procedure Prepair;
    function  GetQueryURL(const ASQL: string): string;
    function  GetPrepairedSQL: string;
    function  GetResponseText: string;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Setup(const AURL, AApiKey, ADatabase: string);
    procedure ClearSQLText();
    procedure AddSQLText(const AText: string; const AArgs: array of const);
    function  GetSQLText(): string;
    procedure SetSQLText(const AText: string);
    function  GetMacro(const AName: string): string;
    procedure SetMacro(const AName, AValue: string);
    function  GetParam(const AName: string): string;
    procedure SetParam(const AName, AValue: string);
    function  RecordCount(): Integer;
    function  GetField(const AIndex: Cardinal; const AName: string): string;
    function  Execute(): Boolean;
    function  ExecuteSQL(const ASQL: string): Boolean;
    function  GetLastError(): string;
  end;

implementation

{ TCloudDb }
procedure TlgCloudDb.SetMacroValue(const AName, AValue: string);
begin
  FPrepairedSQL := FPrepairedSQL.Replace('&'+AName, AValue);
end;

procedure TlgCloudDb.SetParamValue(const AName, AValue: string);
begin
  FPrepairedSQL := FPrepairedSQL.Replace(':'+AName, ''''+AValue+'''');
end;

procedure TlgCloudDb.Prepair();
var
  LKey: string;
begin
  FPrepairedSQL := FSQL.Text;

  // substitue macros
  for LKey in FMacros.Keys do
  begin
    SetMacroValue(LKey, FMacros.Items[LKey]);
  end;

  // substitue field params
  for LKey in FParams.Keys do
  begin
    SetParamValue(LKey, FParams.Items[LKey]);
  end;
end;

constructor  TlgCloudDb.Create();
begin
  inherited;
  FSQL := TStringList.Create;
  FHttp := THTTPClient.Create;
  FMacros := TDictionary<string, string>.Create;
  FParams := TDictionary<string, string>.Create;
end;

destructor TlgCloudDb.Destroy();
begin
  if Assigned(FJson) then
  begin
    FJson.Free();
    FJson := nil;
  end;
  FParams.Free();
  FMacros.Free();
  FHttp.Free();
  FSQL.Free();
  inherited;
end;

procedure TlgCloudDb.Setup(const AURL, AApiKey, ADatabase: string);
begin
  FUrl := AURL + cURL;
  FApiKey := AApiKey;
  FDatabase := ADatabase;
end;

procedure TlgCloudDb.ClearSQLText();
begin
  FSQL.Clear();
end;

procedure TlgCloudDb.AddSQLText(const AText: string;
  const AArgs: array of const);
begin
  FSQL.Add(Format(AText, AArgs));
end;

function  TlgCloudDb.GetSQLText: string;
begin
  Result := FSQL.Text;
end;

procedure TlgCloudDb.SetSQLText(const AText: string);
begin
  FSQL.Text := AText;
end;

function  TlgCloudDb.GetMacro(const AName: string): string;
begin
  FMacros.TryGetValue(AName, Result);
end;

procedure TlgCloudDb.SetMacro(const AName, AValue: string);
begin
  FMacros.AddOrSetValue(AName, AValue);
end;

function  TlgCloudDb.GetParam(const AName: string): string;
begin
  FParams.TryGetValue(AName, Result);
end;

procedure TlgCloudDb.SetParam(const AName, AValue: string);
begin
  FParams.AddOrSetValue(AName, AValue);
end;

function  TlgCloudDb.RecordCount(): Integer;
begin
  Result := 0;
  if not Assigned(FDataset) then Exit;
  Result := FDataset.Count;
end;

function  TlgCloudDb.GetField(const AIndex: Cardinal;
  const AName: string): string;
begin
  Result := '';
  if not Assigned(FDataset) then Exit;
  if AIndex > Cardinal(FDataset.Count-1) then Exit;
  Result := FDataset.Items[AIndex].GetValue<string>(AName);
end;

function  TlgCloudDb.GetQueryURL(const ASQL: string): string;
begin
  Result := Format(FUrl, [FApiKey, FDatabase, ASQL]);
end;

function  TlgCloudDb.GetPrepairedSQL: string;
begin
  Result := FPrepairedSQL;
end;

function TlgCloudDb.Execute(): Boolean;
begin
  Prepair;
  Result := ExecuteSQL(FPrepairedSQL);
end;

function  TlgCloudDb.ExecuteSQL(const ASQL: string): Boolean;
var
  LResponse: IHTTPResponse;
begin
  Result := False;
  if ASQL.IsEmpty then Exit;
  LResponse := FHttp.Get(GetQueryURL(ASQL));
  FResponseText := LResponse.ContentAsString;
  if Assigned(FJson) then
  begin
    if Assigned(FJSON) then
    begin
      FJson.Free();
      FJson := nil;
    end;

    FDataset := nil;
  end;
  FJson := TJSONObject.ParseJSONValue(FResponseText) as TJSONObject;
  FLastError := FJson.GetValue('response').Value;
  Result := Boolean(FLastError.IsEmpty or SameText(FLastError, 'true'));
  if FLastError.IsEmpty then
  begin
    if Assigned(FDataset) then
    begin
      FDataset.Free();
      FDataset := nil;
    end;
    FJson.TryGetValue('response', FDataset);
  end;
  if not Assigned(FDataset) then
  begin
    FJson.Free();
    FJson := nil;
  end;
end;

function TlgCloudDb.GetLastError(): string;
begin
  Result := FLastError;
end;

function TlgCloudDb.GetResponseText(): string;
begin
  Result:= FResponseText;
end;

end.
