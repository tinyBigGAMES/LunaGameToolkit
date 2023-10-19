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

unit LGT.Lib;

{$I LGT.Defines.inc}

interface

uses
  System.Types,
  System.Generics.Collections,
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.SyncObjs,
  System.Math,
  WinApi.Windows,
  LGT.Deps;

{ === MISC ================================================================== }
type
  { TlgSeekMode }
  TlgSeekMode = (smStart, smCurrent, smEnd);

{ === BASE ================================================================== }
type
  { TlgBaseObject }
  TlgBaseObject = class
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

{ === MATH ================================================================== }
type
  { TlgPos }
  PlgPos = ^TlgPos;
  TlgPos = record
    x,y: Single;
  end;

  { TlgVec }
  PlgVec = ^TlgVec;
  TlgVec = record
    x,y: Single;
    constructor Create(const X, Y: Single); overload;
    procedure Assign(const X, Y: Single); overload;
    procedure Assign(const AVec: TlgVec); overload;
    procedure Clear();
    procedure Add(const AVec: TlgVec);
    procedure Subtract(const AVec: TlgVec);
    procedure Multiply(const AVec: TlgVec);
    procedure Divide(const AVec: TlgVec);
    function  Magnitude(): Single;
    function  MagnitudeTruncate(const AMaxMagitude: Single): TlgVec;
    function  Distance(const aVector: TlgVec): Single;
    procedure Normalize();
    function  Angle(const AVec: TlgVec): Single;
    procedure Thrust(const AAngle, ASpeed: Single);
    function  MagnitudeSquared(): Single;
    function  DotProduct(const AVec: TlgVec): Single;
    procedure Scale(const AValue: Single);
    procedure DivideBy(const AValue: Single);
    function  Project(const AVec: TlgVec): TlgVec;
    procedure Negate;
    class function Vec(const X, Y: Single): TlgVec; static;
  end;

  { TlgSize }
  PlgSize = ^TlgSize;
  TlgSize = record
    Width, Height: Single;
  end;

  { TlgRect }
  PlgRect = ^TlgRect;
  TlgRect = record
    X,Y,Width,Height: Single;
  end;

  { TlgExtent }
  PlgExtent = ^TlgExtent;
  TlgExtent = record
    MinX,MinY,MaxX,MaxY: Single;
  end;

  { TlgLineIntersection }
  TlgLineIntersection = (liNone, liTrue, liParallel);

  { TEaseType }
  TlgEase = (eaLinearTween, eaInQuad, eaOutQuad, eaInOutQuad, eaInCubic,
    eaOutCubic, eaInOutCubic, eaInQuart, eaOutQuart, eaInOutQuart, eaInQuint,
    eaOutQuint, eaInOutQuint, eaInSine, eaOutSine, eaInOutSine, eaInExpo,
    eaOutExpo, eaInOutExpo, eaInCircle, eaOutCircle, eaInOutCircle);

  { TlgMath }
  TlgMath = class
  protected class var
    FSinTable: array[0..360] of Single;
    FCosTable: array[0..360] of Single;
  protected
    class constructor Create;
    class destructor Destroy;
  public const
    RAD2DEG = 180.0 / PI;
    DEG2RAD = PI / 180.0;
    EPSILON  = 0.00001;
    NAN      =  0.0 / 0.0;
  public
    class function  Pos(const X, Y: Single): TlgPos;
    class function  Vec(const X, Y: Single): TlgVec;
    class function  Size(const AWidth, AHeight: Single): TlgSize;
    class function  Rect(const X, Y, AWidth, AHeight: Single): TlgRect;
    class function  Extent(const AMinX, AMinY, AMaxX, AMaxY: Single): TlgExtent;
    class function  AngleSin(const AAngle: Cardinal): Single;
    class function  AngleCos(const AAngle: Cardinal): Single;
    class function  RandomRange(const AFrom, ATo: Int64): Int64; overload;
    class function  RandomRange(const AFrom, ATo: Double): Double; overload;
    class function  RandomBool(): Boolean;
    class function  UnitToScalarValue(const AValue, AMaxValue: Double): Double;
    class function  AngleDifference(const ASrcAngle, ADestAngle: Single): Single;
    class procedure AngleRotatePos(const AAngle: Single; var X: Single; var Y: Single);
    class function  ClipValueFloat(var AValue: Single; const AMin, AMax: Single; const AWrap: Boolean): Single;
    class function  ClipValueDouble(var AValue: Double; const AMin, AMax: Double; const AWrap: Boolean): Single;
    class function  ClipValueInt(var AValue: Integer; const AMin, AMax: Integer; const AWrap: Boolean): Integer;
    class function  SameSignInt(const A, B: Integer): Boolean;
    class function  SameSignFloat(const A, B: Single): Boolean;
    class function  SameValueExt(const A, B: Double; const AEpsilon: Double = 0): Boolean;
    class procedure SmoothMove(var AValue: Single; const AAmount, AMax, aDrag: Single);
    class function  Lerp(const AFrom, ATo, ATime: Double): Double;
    class function  PointInRectangle(const APoint: TlgVec; const ARect: TlgRect): Boolean;
    class function  PointInCircle(const APoint, ACenter: TlgVec; const ARadius: Single): Boolean;
    class function  PointInTriangle(const APoint, P1, P2, P3: TlgVec): Boolean;
    class function  CirclesOverlap(const ACenter1: TlgVec; const ARadius1: Single; const ACenter2: TlgVec; const ARadius2: Single): Boolean;
    class function  CircleInRectangle(const ACenter: TlgVec; const ARadius: Single; const ARect: TlgRect): Boolean;
    class function  RectanglesOverlap(const ARect1, ARect2: TlgRect): Boolean;
    class function  RectangleIntersection(const ARect1, ARect2: TlgRect): TlgRect;
    class function  LineIntersection(const X1, Y1, X2, Y2, X3, AY3, AX4, AY4: Integer; var X: Integer; var Y: Integer): TlgLineIntersection;
    class function  RadiusOverlap(const ARadius1, X1, Y1, ARadius2, X2, Y2, AShrinkFactor: Single): Boolean;
    class function  EaseValue(ACurrentTime: Double; const AStartValue, AChangeInValue, ADuration: Double; AEase: TlgEase): Double;
    class function  EasePosition(const AStartPos, AEndPos, ACurrentPos: Double; AEase: TlgEase): Double;
  end;

{ === LINKLIST ============================================================== }
type
  TlgLinkListNode<T: class> = class
  private
    FValue: T;
    FPrev: TlgLinkListNode<T>;
    FNext: TlgLinkListNode<T>;
  public
    constructor Create(const AValue: T);
    property Value: T read FValue write FValue;
    property Prev: TlgLinkListNode<T> read FPrev write FPrev;
    property Next: TlgLinkListNode<T> read FNext write FNext;
  end;

  TlgLinkedList<T: class> = class(TlgBaseObject)
  private
    FHead: TlgLinkListNode<T>;
    FTail: TlgLinkListNode<T>;
    FCurrent: TlgLinkListNode<T>;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Add(const AValue: T);
    procedure Remove(const AValue: T);
    function Find(const AValue: T): TlgLinkListNode<T>;
    function MoveNext(): Boolean;
    function GetCurrent(): T;
    property Current: T read GetCurrent;
    procedure Reset();
    procedure Clear(const ADispose: Boolean);
  end;

{ === CONSOLE =============================================================== }
type
  { TlgConsole }
  TlgConsole = class
  protected class var
    FKeyState: array [0..1, 0..255] of Boolean;
  protected
    class constructor Create;
    class destructor Destroy;
  public
    class function  HasOutput(): Boolean;
    class function  WasRunFrom(): Boolean;
    class function  IsStartedFromDelphiIDE(): Boolean;
    class procedure SetTitle(const AMsg: string; const AArgs: array of const);
    class procedure Print(const AMsg: string; const AArgs: array of const); overload;
    class procedure Print(const AMsg: string); overload;
    class procedure PrintLn(const AMsg: string; const AArgs: array of const); overload;
    class procedure PrintLn(const AMsg: string); overload;
    class procedure Pause(const AMsg: string; const AArgs: array of const); overload;
    class procedure Pause(const AMsg: string=''); overload;
    class procedure ClearKeyboardBuffer();
    class procedure WaitForAnyKey();
    class function  AnyKeyPressed(): Boolean;
    class procedure ClearKeyStates();
    class function  IsKeyPressed(AKey: Byte): Boolean;
    class function  WasKeyPressed(AKey: Byte): Boolean;
    class function  WasKeyReleased(AKey: Byte): Boolean;
  end;

{ === TIMING ================================================================ }
type

  { TlgDeterministicTimer }
  TlgDeterministicTimer = class
  protected class var
    FLastTime: Double;
    FTargetTime: Double;
    FCurrentTime: Double;
    FElapsedTime: Double;
    FRemainingTime: Double;
    FLastFPSTime: Double;
    FEndtime: double;
    FFrameCount: Cardinal;
    FFramerate: Cardinal;
    FTargetFrameRate: Cardinal;
  protected
    class constructor Create;
    class destructor Destroy;
  public const
    DEFAULT_FPS = 60;
  public
    class procedure Init(const ATargetFrameRate: Cardinal=DEFAULT_FPS);
    class function  TargetFrameRate: Cardinal;
    class function  TargetTime: Double;
    class procedure Reset();
    class procedure Start();
    class procedure Stop();
    class function  FrameRate(): Cardinal;
  end;

{ === STREAM ================================================================ }
type
  { TlgStream }
  TlgStream = class(TlgBaseObject)
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Close(); virtual;
    function  Size(): Int64; virtual;
    function  Seek(const AOffset: Int64; const ASeek: TlgSeekMode): Int64; virtual;
    function  Read(const AData: Pointer; const ASize: Int64): Int64; virtual;
    function  Write(const AData: Pointer; const ASize: Int64): Int64; virtual;
    function  Tell(): Int64; virtual;
    function  Eos(): Boolean; virtual;
  end;

  { TlgMemoryStream }
  TlgMemoryStream = class(TlgStream)
  protected
    FHandle: TMemoryStream;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  Duplicate(): TlgStream; virtual;
    procedure Close(); override;
    function  Size(): Int64; override;
    function  Seek(const AOffset: Int64; const ASeek: TlgSeekMode): Int64; override;
    function  Read(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Write(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Tell(): Int64; override;
    function  Eos(): Boolean; override;
    function  Memory(): Pointer; virtual;
    class function Open(const ASize: Int64): TlgMemoryStream; overload;
    class function Open(const AFilename: string): TlgMemoryStream; overload;
  end;

  { TlgZipFileStreamBuildProgress }
  TlgZipFileStreamBuildProgress = procedure(const ASender: Pointer; const AFilename: string; const AProgress: Integer; const ANewFile: Boolean);

  { TlgZipStream }
  TlgZipStream = class(TlgStream)
  protected
    FHandle: unzFile;
    FPassword: AnsiString;
    FFilename: AnsiString;
    function DoOpen(const AZipFilename, AFilename: string; const APassword: string): Boolean;
  public const
    DEFAULT_PASSWORD = 'N^TpjE5/*czG,<ns>$}w;?x_uBm9[JSr{(+FRv7ZW@C-gd3D!PRUgWE4P2/wpm9-dt^Y?e)Az+xsMb@jH"!X`B3ar(yq=nZ_~85<';
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Close(); override;
    function  Size(): Int64; override;
    function  Seek(const AOffset: Int64; const ASeek: TlgSeekMode): Int64; override;
    function  Read(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Write(const AData: Pointer; const ASize: Int64): Int64; override;
    function  Tell(): Int64; override;
    function  Eos(): Boolean; override;
    class function Open(const AZipFilename, AFilename: string; const APassword: string=DEFAULT_PASSWORD): TlgZipStream;
    class function Build(const AZipFilename, ADirectoryName: string; const ASender: Pointer; const AHandler: TlgZipFileStreamBuildProgress; const APassword: string=DEFAULT_PASSWORD): Boolean;
  end;

{ === AUDIO ================================================================= }

type
  TlgSound = class;

  { TlgAudioStatus }
  TlgAudioStatus = (asStopped, asPlaying, asPaused);

  TlgAudio = class(TlgBaseObject)
  protected const
    BUFFER_CHUCK = 1024*2;
    BUFFER_SIZE = BUFFER_CHUCK*2*sizeof(smallint);
  protected
    FDevice: PALCdevice;
    FContext: PALCcontext;
    FError: string;
    FPCM: array[0..BUFFER_SIZE] of byte;
    FSounds: TlgLinkedList<TlgSound>;
    FOneShotSounds: TList<TlgSound>;
    procedure CheckErrors();
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function Open(): Boolean;
    function IsOpen(): Boolean;
    procedure Close();
    procedure Reset();
    function GetDeviceName(): string;
    function GetError(): string;
    function GetPCMBufferSize(): Integer;
    function GetPCMBuffer(): PByte;
    procedure Update();
  end;

  { TlgSoundLoad }
  TlgSoundLoad = (slMemory, slStream);

  { TlgSound }
  TlgSound = class(TlgBaseObject)
  protected const
    NUM_BUFFERS = 2;
  protected
    FSource: ALuint;
    FBuffers: array[0..NUM_BUFFERS-1] of ALuint;
    FStream: TlgStream;
    FVorbisFile: OggVorbis_File;
    FVorbisCallbacks: ov_callbacks;
    FFormat: ALenum;
    FFreq: ALsizei;
    FChans: Integer;
    FStatus: TlgAudioStatus;
    FLoop: Boolean;
    FVolume: Single;
    FLoad: TlgSoundLoad;
    FAudio: TlgAudio;
    FOneShot: Boolean;

    procedure Update(); virtual;
  public
    constructor Create(const AAudio: TlgAudio); reintroduce;
    destructor Destroy(); override;
    function  Duplicate(const AOneShot: Boolean): TlgSound; virtual;
    function  Copy(const ASound: TlgSound; const AOneShot: Boolean): Boolean; virtual;
    function  Load(var AStream: TlgStream; const ALoad: TlgSoundLoad; const AOneShot: Boolean=False): Boolean; virtual;
    function  IsLoaded: Boolean; virtual;
    procedure Unload(); virtual;
    procedure Play(const APlay: Boolean); virtual;
    function  GetStatus(): TlgAudioStatus;
    procedure Rewind(); virtual;
    procedure Pause(const APause: Boolean); virtual;
    function  GetVolume(): Single; virtual;
    procedure SetVolume(const AVolume: Single); virtual;
    function  IsLooping(): Boolean; virtual;
    procedure SetLooping(const ALooping: Boolean); virtual;
    function  GetPan(): Single; virtual;
    procedure SetPan(const APan: Single); virtual;
    function  GetChans(): Integer; virtual;
    function  GetFreq(): Integer; virtual;
  end;

var
  Math: TlgMath = nil;
  Console: TlgConsole = nil;
  Timer: TlgDeterministicTimer = nil;

implementation

const
  CStaticBufferSize = 1024*4;

var
  CriticalSection: TCriticalSection = nil;
  StaticBuffer: array[0..CStaticBufferSize-1] of Byte;

{ === BASE ================================================================== }
constructor TlgBaseObject.Create();
begin
  inherited;
end;

destructor TlgBaseObject.Destroy();
begin
  inherited;
end;

{ === MATH ================================================================== }

{ --- TlgVec ---------------------------------------------------------------- }
constructor TlgVec.Create(const X, Y: Single);
begin
  Self.X := X;
  Self.Y := Y;
end;

procedure TlgVec.Assign(const X, Y: Single);
begin
  Self.X := X;
  Self.Y := Y;
end;

procedure TlgVec.Assign(const AVec: TlgVec);
begin
  X := AVec.x;
  Y := AVec.y
end;

procedure TlgVec.Clear;
begin
  X := 0;
  Y := 0;
end;

procedure TlgVec.Add(const AVec: TlgVec);
begin
  X := X + AVec.X;
  Y := Y + AVec.Y;
end;

procedure TlgVec.Subtract(const AVec: TlgVec);
begin
  X := X - AVec.X;
  Y := Y - AVec.Y;
end;

procedure TlgVec.Multiply(const AVec: TlgVec);
begin
  X := X * AVec.X;
  Y := Y * AVec.Y;
end;

procedure TlgVec.Divide(const AVec: TlgVec);
begin
  X := X / AVec.X;
  Y := Y / AVec.Y;
end;

function  TlgVec.Magnitude: Single;
begin
  Result := Sqrt((X * X) + (Y * Y));
end;

function  TlgVec.MagnitudeTruncate(const AMaxMagitude: Single): TlgVec;
var
  LMaxMagSqrd: Single;
  LVecMagSqrd: Single;
  LTruc: Single;
begin
  Result.Assign(X, Y);
  LMaxMagSqrd := AMaxMagitude * AMaxMagitude;
  LVecMagSqrd := Result.Magnitude;
  if LVecMagSqrd > LMaxMagSqrd then
  begin
    LTruc := (AMaxMagitude / Sqrt(LVecMagSqrd));
    Result.X := Result.X * LTruc;
    Result.Y := Result.Y * LTruc;
  end;
end;

function  TlgVec.Distance(const aVector: TlgVec): Single;
var
  LDirVec: TlgVec;
begin
  LDirVec.X := X - aVector.X;
  LDirVec.Y := Y - aVector.Y;
  Result := LDirVec.Magnitude;
end;

procedure TlgVec.Normalize;
var
  LLen, LOOL: Single;
begin
  LLen := self.Magnitude;
  if LLen <> 0 then
  begin
    LOOL := 1.0 / LLen;
    X := X * LOOL;
    Y := Y * LOOL;
  end;
end;

function  TlgVec.Angle(const AVec: TlgVec): Single;
var
  LXOY: Single;
  LR: TlgVec;
begin
  LR.Assign(self);
  LR.Subtract(AVec);
  LR.Normalize;

  if LR.Y = 0 then
  begin
    LR.Y := 0.001;
  end;

  LXOY := LR.X / LR.Y;

  Result := ArcTan(LXOY) * TlgMath.RAD2DEG;
  if LR.Y < 0 then
    Result := Result + 180.0;
end;

procedure TlgVec.Thrust(const AAngle, ASpeed: Single);
var
  LA: Single;

begin
  LA := AAngle + 90.0;
  TlgMath.ClipValueFloat(LA, 0, 360, True);
  X := X + TlgMath.AngleCos(Round(LA)) * -(ASpeed);
  Y := Y + TlgMath.AngleSin(Round(LA)) * -(ASpeed);
end;

function  TlgVec.MagnitudeSquared(): Single;
begin
  Result := (X * X) + (Y * Y);
end;

function  TlgVec.DotProduct(const AVec: TlgVec): Single;
begin
  Result := (X * AVec.X) + (Y * AVec.Y);
end;

procedure TlgVec.Scale(const aValue: Single);
begin
  X := X * aValue;
  Y := Y * aValue;
end;

procedure TlgVec.DivideBy(const aValue: Single);
begin
  X := X / aValue;
  Y := Y / aValue;
end;

function  TlgVec.Project(const AVec: TlgVec): TlgVec;
var
  LDP: Single;
begin
  LDP := DotProduct(AVec);
  Result.X := (LDP / (AVec.X * AVec.X + AVec.Y * AVec.Y)) * AVec.X;
  Result.Y := (LDP / (AVec.X * AVec.X + AVec.Y * AVec.Y)) * AVec.Y;
end;

procedure TlgVec.Negate();
begin
  X := -X;
  Y := -Y;
end;

class function TlgVec.Vec(const X, Y: Single): TlgVec;
begin
  Result.X := X;
  Result.Y := Y;
end;

{ --- TlgMath --------------------------------------------------------------- }
class constructor TlgMath.Create;
var
  I: Integer;
begin
  System.Randomize();
  for I := 0 to 360 do
  begin
    FCosTable[I] := cos((I * PI / 180.0));
    FSinTable[I] := sin((I * PI / 180.0));
  end;
end;

class destructor TlgMath.Destroy;
begin
end;

class function  TlgMath.Pos(const X, Y: Single): TlgPos;
begin
  Result.X := X;
  Result.Y := Y;
end;

class function  TlgMath.Vec(const X, Y: Single): TlgVec;
begin
  Result.X := X;
  Result.Y := Y;
end;

class function  TlgMath.Size(const AWidth, AHeight: Single): TlgSize;
begin
  Result.Width := AWidth;
  Result.Height := AHeight;
end;

class function  TlgMath.Rect(const X, Y, AWidth, AHeight: Single): TlgRect;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Width := AWidth;
  Result.Height := AHeight;
end;

class function  TlgMath.Extent(const AMinX, AMinY, AMaxX, AMaxY: Single): TlgExtent;
begin
  Result.MinX := AMinX;
  Result.MinY := AMinY;
  Result.MaxX := AMaxX;
  Result.MaxY := AMaxY;
end;

class function  TlgMath.AngleSin(const AAngle: Cardinal): Single;
begin
  Result := FSinTable[EnsureRange(aAngle, 0, 360)];
end;

class function  TlgMath.AngleCos(const AAngle: Cardinal): Single;
begin
  Result := FCosTable[EnsureRange(aAngle, 0, 360)];
end;

class function  TlgMath.RandomRange(const AFrom, ATo: Int64): Int64;
begin
  Result := AFrom + Random(ATo - AFrom + 1);
end;

class function  TlgMath.RandomRange(const AFrom, ATo: Double): Double;
var
  LNum: Single;
begin
  LNum := RandomRange(0, MaxInt) / MaxInt;
  Result := aFrom + (LNum * (aTo - aFrom));
end;

class function  TlgMath.RandomBool(): Boolean;
begin
  Result := Boolean(RandomRange(0, 2) = 1);
end;

class function  TlgMath.UnitToScalarValue(const AValue, AMaxValue: Double): Double;
var
  LGain: Double;
  LFactor: Double;
  LVolume: Double;
begin
  LGain := (EnsureRange(AValue, 0.0, 1.0) * 50) - 50;
  LFactor := Power(10, LGain * 0.05);
  LVolume := EnsureRange(AMaxValue * LFactor, 0, AMaxValue);
  Result := LVolume;
end;

class function  TlgMath.AngleDifference(const ASrcAngle, ADestAngle: Single): Single;
var
  LC: Single;
begin
  LC := ADestAngle - ASrcAngle -
    (floor((ADestAngle - ASrcAngle) / 360.0) * 360.0);

  if LC >= (360.0 / 2) then
  begin
    LC := LC - 360.0;
  end;
  Result := LC;
end;

class procedure TlgMath.AngleRotatePos(const AAngle: Single; var X: Single; var Y: Single);
var
  LNX, LNY: Single;
  LIA: Integer;
  LAngle: Single;
begin
  LAngle := AAngle;
  ClipValueFloat(LAngle, 0, 359, True);

  LIA := Round(LAngle);

  LNX := X * FCosTable[LIA] - Y * FSinTable[LIA];
  LNY := Y * FCosTable[LIA] + X * FSinTable[LIA];

  X := LNX;
  Y := LNY;
end;

class function  TlgMath.ClipValueFloat(var AValue: Single; const AMin, AMax: Single; const AWrap: Boolean): Single;
begin
  if AWrap then
    begin
      if (AValue > AMax) then
      begin
        AValue := AMin + Abs(AValue - AMax);
        if AValue > AMax then
          AValue := AMax;
      end
      else if (AValue < AMin) then
      begin
        AValue := AMax - Abs(AValue - AMin);
        if AValue < AMin then
          AValue := AMin;
      end
    end
  else
    begin
      if AValue < AMin then
        AValue := AMin
      else if AValue > AMax then
        AValue := AMax;
    end;

  Result := AValue;

end;

class function  TlgMath.ClipValueDouble(var AValue: Double; const AMin, AMax: Double; const AWrap: Boolean): Single;
begin
  if AWrap then
    begin
      if (AValue > AMax) then
      begin
        AValue := AMin + Abs(AValue - AMax);
        if AValue > AMax then
          AValue := AMax;
      end
      else if (AValue < AMin) then
      begin
        AValue := AMax - Abs(AValue - AMin);
        if AValue < AMin then
          AValue := AMin;
      end
    end
  else
    begin
      if AValue < AMin then
        AValue := AMin
      else if AValue > AMax then
        AValue := AMax;
    end;

  Result := AValue;

end;

class function  TlgMath.ClipValueInt(var AValue: Integer; const AMin, AMax: Integer; const AWrap: Boolean): Integer;
begin
  if AWrap then
    begin
      if (AValue > AMax) then
      begin
        AValue := AMin + Abs(AValue - AMax);
        if AValue > AMax then
          AValue := AMax;
      end
      else if (AValue < AMin) then
      begin
        AValue := AMax - Abs(AValue - AMin);
        if AValue < AMin then
          AValue := AMin;
      end
    end
  else
    begin
      if AValue < AMin then
        AValue := AMin
      else if AValue > AMax then
        AValue := AMax;
    end;

  Result := AValue;
end;

class function  TlgMath.SameSignInt(const A, B: Integer): Boolean;
begin
  if Sign(A) = Sign(B) then
    Result := True
  else
    Result := False;
end;

class function  TlgMath.SameSignFloat(const A, B: Single): Boolean;
begin
  if Sign(A) = Sign(B) then
    Result := True
  else
    Result := False;
end;

class function  TlgMath.SameValueExt(const A, B: Double; const AEpsilon: Double): Boolean;
begin
  Result := System.Math.SameValue(A, B, AEpsilon);
end;

class procedure TlgMath.SmoothMove(var AValue: Single; const AAmount, AMax, aDrag: Single);
var
  LAmt: Single;
begin
  LAmt := AAmount;

  if LAmt > 0 then
  begin
    AValue := AValue + LAmt;
    if AValue > AMax then
      AValue := AMax;
  end else if LAmt < 0 then
  begin
    AValue := AValue + LAmt;
    if AValue < -AMax then
      AValue := -AMax;
  end else
  begin
    if AValue > 0 then
    begin
      AValue := AValue - aDrag;
      if AValue < 0 then
        AValue := 0;
    end else if AValue < 0 then
    begin
      AValue := AValue + aDrag;
      if AValue > 0 then
        AValue := 0;
    end;
  end;
end;

class function  TlgMath.Lerp(const AFrom, ATo, ATime: Double): Double;
begin
  if ATime <= 0.5 then
    Result := AFrom + (ATo - AFrom) * ATime
  else
    Result := ATo - (ATo - AFrom) * (1.0 - ATime);
end;

class function  TlgMath.PointInRectangle(const APoint: TlgVec; const ARect: TlgRect): Boolean;
begin
  if ((APoint.x >= ARect.X) and (APoint.x <= (ARect.X + ARect.Width)) and
    (APoint.y >= ARect.Y) and (APoint.y <= (ARect.Y + ARect.Height))) then
    Result := True
  else
    Result := False;
end;

class function  TlgMath.PointInCircle(const APoint, ACenter: TlgVec; const ARadius: Single): Boolean;
begin
  Result := CirclesOverlap(APoint, 0, ACenter, ARadius);
end;

class function  TlgMath.PointInTriangle(const APoint, P1, P2, P3: TlgVec): Boolean;
var
  LAlpha, LBeta, LGamma: Single;
begin
  LAlpha := ((P2.y - P3.y) * (APoint.x - P3.x) + (P3.x - P2.x) *
    (APoint.y - P3.y)) / ((P2.y - P3.y) * (P1.x - P3.x) + (P3.x - P2.x) *
    (P1.y - P3.y));

  LBeta := ((P3.y - P1.y) * (APoint.x - P3.x) + (P1.x - P3.x) *
    (APoint.y - P3.y)) / ((P2.y - P3.y) * (P1.x - P3.x) + (P3.x - P2.x) *
    (P1.y - P3.y));

  LGamma := 1.0 - LAlpha - LBeta;

  if ((LAlpha > 0) and (LBeta > 0) and (LGamma > 0)) then
    Result := True
  else
    Result := False;
end;

class function  TlgMath.CirclesOverlap(const ACenter1: TlgVec; const ARadius1: Single; const ACenter2: TlgVec; const ARadius2: Single): Boolean;
var
  LDX, LDY, LDistance: Single;
begin
  LDX := ACenter2.x - ACenter1.x; // X distance between centers
  LDY := ACenter2.y - ACenter1.y; // Y distance between centers

  LDistance := sqrt(LDX * LDX + LDY * LDY); // Distance between centers

  if (LDistance <= (ARadius1 + ARadius2)) then
    Result := True
  else
    Result := False;
end;

class function  TlgMath.CircleInRectangle(const ACenter: TlgVec; const ARadius: Single; const ARect: TlgRect): Boolean;
var
  LDX, LDY: Single;
  LCornerDistanceSq: Single;
  LRecCenterX: Integer;
  LRecCenterY: Integer;
begin
  LRecCenterX := Round(ARect.X + ARect.Width / 2);
  LRecCenterY := Round(ARect.Y + ARect.Height / 2);

  LDX := abs(ACenter.x - LRecCenterX);
  LDY := abs(ACenter.y - LRecCenterY);

  if (LDX > (ARect.Width / 2.0 + ARadius)) then
  begin
    Result := False;
    Exit;
  end;

  if (LDY > (ARect.Height / 2.0 + ARadius)) then
  begin
    Result := False;
    Exit;
  end;

  if (LDX <= (ARect.Width / 2.0)) then
  begin
    Result := True;
    Exit;
  end;
  if (LDY <= (ARect.Height / 2.0)) then
  begin
    Result := True;
    Exit;
  end;

  LCornerDistanceSq := (LDX - ARect.Width / 2.0) * (LDX - ARect.Width / 2.0) +
    (LDY - ARect.Height / 2.0) * (LDY - ARect.Height / 2.0);

  Result := Boolean(LCornerDistanceSq <= (ARadius * ARadius));
end;

class function  TlgMath.RectanglesOverlap(const ARect1, ARect2: TlgRect): Boolean;
var
  LDX, LDY: Single;
begin
  LDX := abs((ARect1.X + ARect1.Width / 2) - (ARect2.X + ARect2.Width / 2));
  LDY := abs((ARect1.Y + ARect1.Height / 2) - (ARect2.Y + ARect2.Height / 2));

  if ((LDX <= (ARect1.Width / 2 + ARect2.Width / 2)) and
    ((LDY <= (ARect1.Height / 2 + ARect2.Height / 2)))) then
    Result := True
  else
    Result := False;
end;

class function  TlgMath.RectangleIntersection(const ARect1, ARect2: TlgRect): TlgRect;
var
  LDXX, LDYY: Single;
begin
  Result  := Rect(0, 0, 0, 0);

  if RectanglesOverlap(ARect1, ARect2) then
  begin
    LDXX := abs(ARect1.X - ARect2.X);
    LDYY := abs(ARect1.Y - ARect2.Y);

    if (ARect1.X <= ARect2.X) then
    begin
      if (ARect1.Y <= ARect2.Y) then
      begin
        Result.X := ARect2.X;
        Result.Y := ARect2.Y;
        Result.Width := ARect1.Width - LDXX;
        Result.Height := ARect1.Height - LDYY;
      end
      else
      begin
        Result.X := ARect2.X;
        Result.Y := ARect1.Y;
        Result.Width := ARect1.Width - LDXX;
        Result.Height := ARect2.Height - LDYY;
      end
    end
    else
    begin
      if (ARect1.Y <= ARect2.Y) then
      begin
        Result.X := ARect1.X;
        Result.Y := ARect2.Y;
        Result.Width := ARect2.Width - LDXX;
        Result.Height := ARect1.Height - LDYY;
      end
      else
      begin
        Result.X := ARect1.X;
        Result.Y := ARect1.Y;
        Result.Width := ARect2.Width - LDXX;
        Result.Height := ARect2.Height - LDYY;
      end
    end;

    if (ARect1.Width > ARect2.Width) then
    begin
      if (Result.Width >= ARect2.Width) then
        Result.Width := ARect2.Width;
    end
    else
    begin
      if (Result.Width >= ARect1.Width) then
        Result.Width := ARect1.Width;
    end;

    if (ARect1.Height > ARect2.Height) then
    begin
      if (Result.Height >= ARect2.Height) then
        Result.Height := ARect2.Height;
    end
    else
    begin
      if (Result.Height >= ARect1.Height) then
        Result.Height := ARect1.Height;
    end
  end;
end;

class function  TlgMath.LineIntersection(const X1, Y1, X2, Y2, X3, AY3, AX4, AY4: Integer; var X: Integer; var Y: Integer): TlgLineIntersection;
var
  LAX, LBX, LCX, LAY, LBY, LCY, LD, LE, LF, LNum: Integer;
  LOffset: Integer;
  LX1Lo, LX1Hi, LY1Lo, LY1Hi: Integer;
begin
  Result := liNone;

  LAX := X2 - X1;
  LBX := X3 - AX4;

  if (LAX < 0) then // X bound box test
  begin
    LX1Lo := X2;
    LX1Hi := X1;
  end
  else
  begin
    LX1Hi := X2;
    LX1Lo := X1;
  end;

  if (LBX > 0) then
  begin
    if (LX1Hi < AX4) or (X3 < LX1Lo) then
      Exit;
  end
  else
  begin
    if (LX1Hi < X3) or (AX4 < LX1Lo) then
      Exit;
  end;

  LAY := Y2 - Y1;
  LBY := AY3 - AY4;

  if (LAY < 0) then // Y bound box test
  begin
    LY1Lo := Y2;
    LY1Hi := Y1;
  end
  else
  begin
    LY1Hi := Y2;
    LY1Lo := Y1;
  end;

  if (LBY > 0) then
  begin
    if (LY1Hi < AY4) or (AY3 < LY1Lo) then
      Exit;
  end
  else
  begin
    if (LY1Hi < AY3) or (AY4 < LY1Lo) then
      Exit;
  end;

  LCX := X1 - X3;
  LCY := Y1 - AY3;
  LD := LBY * LCX - LBX * LCY; // alpha numerator
  LF := LAY * LBX - LAX * LBY; // both denominator

  if (LF > 0) then // alpha tests
  begin
    if (LD < 0) or (LD > LF) then
      Exit;
  end
  else
  begin
    if (LD > 0) or (LD < LF) then
      Exit
  end;

  LE := LAX * LCY - LAY * LCX; // beta numerator
  if (LF > 0) then // beta tests
  begin
    if (LE < 0) or (LE > LF) then
      Exit;
  end
  else
  begin
    if (LE > 0) or (LE < LF) then
      Exit;
  end;

  // compute intersection coordinates

  if (LF = 0) then
  begin
    Result := liParallel;
    Exit;
  end;

  LNum := LD * LAX; // numerator
  // if SameSigni(num, f) then
  if Sign(LNum) = Sign(LF) then

    LOffset := LF div 2
  else
    LOffset := -LF div 2;
  X := X1 + (LNum + LOffset) div LF; // intersection x

  LNum := LD * LAY;
  // if SameSigni(num, f) then
  if Sign(LNum) = Sign(LF) then
    LOffset := LF div 2
  else
    LOffset := -LF div 2;

  Y := Y1 + (LNum + LOffset) div LF; // intersection y

  Result := liTrue;
end;

class function  TlgMath.RadiusOverlap(const ARadius1, X1, Y1, ARadius2, X2, Y2, AShrinkFactor: Single): Boolean;
var
  LDist: Single;
  LR1, LR2: Single;
  LV1, LV2: TlgVec;
begin
  LR1 := ARadius1 * AShrinkFactor;
  LR2 := ARadius2 * AShrinkFactor;

  LV1.x := X1;
  LV1.y := Y1;
  LV2.x := X2;
  LV2.y := Y2;

  LDist := LV1.distance(LV2);

  if (LDist < LR1) or (LDist < LR2) then
    Result := True
  else
    Result := False;
end;

class function  TlgMath.EaseValue(ACurrentTime: Double; const AStartValue, AChangeInValue, ADuration: Double; AEase: TlgEase): Double;
begin
  Result := 0;
  case AEase of
    eaLinearTween:
      begin
        Result := AChangeInValue * ACurrentTime / ADuration + AStartValue;
      end;

    eaInQuad:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime + AStartValue;
      end;

    eaOutQuad:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := -AChangeInValue * ACurrentTime * (ACurrentTime-2) + AStartValue;
      end;

    eaInOutQuad:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 1;
          Result := -AChangeInValue / 2 * (ACurrentTime * (ACurrentTime - 2) - 1) + AStartValue;
        end;
      end;

    eaInCubic:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue;
      end;

    eaOutCubic:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := AChangeInValue * ( ACurrentTime * ACurrentTime * ACurrentTime + 1) + AStartValue;
      end;

    eaInOutCubic:
      begin
        ACurrentTime := ACurrentTime / (ADuration/2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := AChangeInValue / 2 * (ACurrentTime * ACurrentTime * ACurrentTime + 2) + AStartValue;
        end;
      end;

    eaInQuart:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue;
      end;

    eaOutQuart:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := -AChangeInValue * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime - 1) + AStartValue;
      end;

    eaInOutQuart:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := -AChangeInValue / 2 * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime - 2) + AStartValue;
        end;
      end;

    eaInQuint:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := AChangeInValue * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue;
      end;

    eaOutQuint:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := AChangeInValue * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + 1) + AStartValue;
      end;

    eaInOutQuint:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := AChangeInValue / 2 * (ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime * ACurrentTime + 2) + AStartValue;
        end;
      end;

    eaInSine:
      begin
        Result := -AChangeInValue * Cos(ACurrentTime / ADuration * (PI / 2)) + AChangeInValue + AStartValue;
      end;

    eaOutSine:
      begin
        Result := AChangeInValue * Sin(ACurrentTime / ADuration * (PI / 2)) + AStartValue;
      end;

    eaInOutSine:
      begin
        Result := -AChangeInValue / 2 * (Cos(PI * ACurrentTime / ADuration) - 1) + AStartValue;
      end;

    eaInExpo:
      begin
        Result := AChangeInValue * Power(2, 10 * (ACurrentTime/ADuration - 1) ) + AStartValue;
      end;

    eaOutExpo:
      begin
        Result := AChangeInValue * (-Power(2, -10 * ACurrentTime / ADuration ) + 1 ) + AStartValue;
      end;

    eaInOutExpo:
      begin
        ACurrentTime := ACurrentTime / (ADuration/2);
        if ACurrentTime < 1 then
          Result := AChangeInValue / 2 * Power(2, 10 * (ACurrentTime - 1) ) + AStartValue
        else
         begin
           ACurrentTime := ACurrentTime - 1;
           Result := AChangeInValue / 2 * (-Power(2, -10 * ACurrentTime) + 2 ) + AStartValue;
         end;
      end;

    eaInCircle:
      begin
        ACurrentTime := ACurrentTime / ADuration;
        Result := -AChangeInValue * (Sqrt(1 - ACurrentTime * ACurrentTime) - 1) + AStartValue;
      end;

    eaOutCircle:
      begin
        ACurrentTime := (ACurrentTime / ADuration) - 1;
        Result := AChangeInValue * Sqrt(1 - ACurrentTime * ACurrentTime) + AStartValue;
      end;

    eaInOutCircle:
      begin
        ACurrentTime := ACurrentTime / (ADuration / 2);
        if ACurrentTime < 1 then
          Result := -AChangeInValue / 2 * (Sqrt(1 - ACurrentTime * ACurrentTime) - 1) + AStartValue
        else
        begin
          ACurrentTime := ACurrentTime - 2;
          Result := AChangeInValue / 2 * (Sqrt(1 - ACurrentTime * ACurrentTime) + 1) + AStartValue;
        end;
      end;
  end;
end;

class function  TlgMath.EasePosition(const AStartPos, AEndPos, ACurrentPos: Double; AEase: TlgEase): Double;
var
  LT, LB, LC, LD: Double;
begin
  LC := AEndPos - AStartPos;
  LD := 100;
  LT := ACurrentPos;
  LB := AStartPos;
  Result := EaseValue(LT, LB, LC, LD, AEase);
  if Result > 100 then
    Result := 100;
end;

{ === LINKLIST ============================================================== }

{ --- TlgLinkListNode<T> ---------------------------------------------------- }
constructor TlgLinkListNode<T>.Create(const AValue: T);
begin
  FValue := AValue;
end;

{ ---TlgLinkedList<T> ------------------------------------------------------- }
constructor TlgLinkedList<T>.Create();
begin
  inherited;
end;

destructor TlgLinkedList<T>.Destroy();
begin
  Clear(True);
  inherited;
end;

procedure TlgLinkedList<T>.Add(const AValue: T);
var
  LNode: TlgLinkListNode<T>;
begin
  LNode := TlgLinkListNode<T>.Create(AValue);
  if not Assigned(FHead) then
    begin
      FHead := LNode;
      FTail := LNode;
    end
  else
    begin
      FTail.Next := LNode;
      LNode.Prev := FTail;
      FTail := LNode;
    end;
end;

procedure TlgLinkedList<T>.Remove(const AValue: T);
var
  LNode, LTemp: TlgLinkListNode<T>;
begin
  LNode := Find(AValue);
  if Assigned(LNode) then
  begin
    if Assigned(LNode.Prev) then
      LNode.Prev.Next := LNode.Next
    else
      FHead := LNode.Next;

    if Assigned(LNode.Next) then
      LNode.Next.Prev := LNode.Prev
    else
      FTail := LNode.Prev;

    LNode.Free;
  end;
end;

function TlgLinkedList<T>.Find(const AValue: T): TlgLinkListNode<T>;
var
  LTemp: TlgLinkListNode<T>;
begin
  Result := nil;
  LTemp := FHead;
  while Assigned(LTemp) do
  begin
    if LTemp.Value = AValue then
    begin
      Result := LTemp;
      Break;
    end;
    LTemp := LTemp.Next;
  end;
end;

function TlgLinkedList<T>.MoveNext(): Boolean;
begin
  if Assigned(FCurrent) then
    FCurrent := FCurrent.Next;
  Result := Assigned(FCurrent);
end;

function TlgLinkedList<T>.GetCurrent: T;
begin
  if Assigned(FCurrent) then
    Result := FCurrent.Value
  else
    Result := nil;
end;

procedure TlgLinkedList<T>.Reset();
begin
  FCurrent := FHead;
end;

procedure TlgLinkedList<T>.Clear(const ADispose: Boolean);
var
  LTemp, LNode: TlgLinkListNode<T>;
  LDisposeList: TList<T>;
  LItem: T;
begin
  // create a dispose list
  if ADispose then
    LDisposelist := TList<T>.Create;

  LNode := FHead;
  while Assigned(LNode) do
  begin
    LTemp := LNode;
    LNode := LNode.Next;
    if ADispose then
    begin
      // if dispose, then add value to list
      if Assigned(LTemp.FValue) then
      begin
        LDisposeList.Add(LTemp.FValue);
      end;
    end;
    LTemp.Free();
  end;
  FHead := nil;
  FTail := nil;
  FCurrent := nil;

  if ADispose then
  begin
    // if there any items on dispose list, free them
    for LItem in LDisposeList do
    begin
      LItem.Free();
    end;

    // free dispose list
    LDisposelist.Free();
  end;
end;

{ === CONSOLE =============================================================== }
class constructor TlgConsole.Create();
begin
end;

class destructor TlgConsole.Destroy();
begin
end;

class function  TlgConsole.HasOutput(): Boolean;
var
  LStdOut: THandle;
  LMode: DWORD;
begin
  LStdOut := GetStdHandle(STD_OUTPUT_HANDLE);
  Result := (LStdOut <> INVALID_HANDLE_VALUE) and
            GetConsoleMode(LStdOut, LMode);
end;

class function  TlgConsole.WasRunFrom(): Boolean;
var
  LStartupInfo: TStartupInfo;
begin
  LStartupInfo.cb := SizeOf(TStartupInfo);
  GetStartupInfo(LStartupInfo);
  Result := ((LStartupInfo.dwFlags and STARTF_USESHOWWINDOW) = 0);
end;

class function  TlgConsole.IsStartedFromDelphiIDE(): Boolean;
begin
  // Check if the IDE environment variable is present
  Result := (GetEnvironmentVariable('BDS') <> '');
end;

class procedure TlgConsole.SetTitle(const AMsg: string; const AArgs: array of const);
var
  LTitle: string;
begin
  LTitle := Format(AMsg, AArgs);
  WinApi.Windows.SetConsoleTitle(PChar(LTitle));
end;

class procedure TlgConsole.Print(const AMsg: string; const AArgs: array of const);
begin
  if not HasOutput then Exit;
  Write(Format(aMsg, aArgs));
end;

class procedure TlgConsole.Print(const AMsg: string);
begin
  Print(AMsg, []);
end;

class procedure TlgConsole.PrintLn(const AMsg: string; const AArgs: array of const);
begin
  if not HasOutput then Exit;
  WriteLn(Format(aMsg, aArgs));
end;

class procedure TlgConsole.PrintLn(const AMsg: string);
begin
  PrintLn(AMsg, []);
end;

class procedure TlgConsole.Pause(const AMsg: string; const AArgs: array of const);
var
  LDoPause: Boolean;
begin
  if not HasOutput then Exit;

  ClearKeyStates();
  ClearKeyboardBuffer();

  LDoPause := True;
  if WasRunFrom then LDoPause := False;
  if IsStartedFromDelphiIDE then LDoPause := True;
  if not LDoPause then Exit;

  WriteLn;
  if aMsg.IsEmpty then
    Write('Press any key to continue... ')
  else
    Print(AMsg, AArgs);
  WaitForAnyKey;
  WriteLn;
end;

class procedure TlgConsole.Pause(const AMsg: string='');
begin
  Pause(AMsg, []);
end;

class procedure TlgConsole.ClearKeyboardBuffer();
var
  LInputRecord: TInputRecord;
  LEventsRead: DWORD;
begin
  // Flush the keyboard buffer by reading all pending input events
  while PeekConsoleInput(GetStdHandle(STD_INPUT_HANDLE), LInputRecord, 1,
    LEventsRead) and (LEventsRead > 0) do
  begin
    ReadConsoleInput(GetStdHandle(STD_INPUT_HANDLE), LInputRecord, 1,
      LEventsRead);
    // Optionally, you can process the input events if needed
  end;
end;

class procedure TlgConsole.WaitForAnyKey();
var
  LInputRec: TInputRecord;
  LNumRead: Cardinal;
  LOldMode: DWORD;
  LStdIn: THandle;
begin
  LStdIn := GetStdHandle(STD_INPUT_HANDLE);
  GetConsoleMode(LStdIn, LOldMode);
  SetConsoleMode(LStdIn, 0);
  repeat
    Sleep(1); // prevent tight loop, allowing background task to run
    ReadConsoleInput(LStdIn, LInputRec, 1, LNumRead);
  until (LInputRec.EventType and KEY_EVENT <> 0) and
    LInputRec.Event.KeyEvent.bKeyDown;
  SetConsoleMode(LStdIn, LOldMode);
end;

class function  TlgConsole.AnyKeyPressed(): Boolean;
var
  LNumEvents: DWORD;
  LBuffer: TInputRecord;
  LNumEventsRead: DWORD;
  LStdHandle: THandle;
begin
  Result := False;
  ClearKeyboardBuffer;

  //get the console handle
  LStdHandle := GetStdHandle(STD_INPUT_HANDLE);
  LNumEvents:=0;

  //get the number of events
  GetNumberOfConsoleInputEvents(LStdHandle,LNumEvents);
  if LNumEvents<> 0 then
  begin
    //retrieve the event
    PeekConsoleInput(LStdHandle,LBuffer,1,LNumEventsRead);
    if LNumEventsRead <> 0 then
    begin
      if LBuffer.EventType = KEY_EVENT then //is a Keyboard event?
        begin
          if LBuffer.Event.KeyEvent.bKeyDown then //the key was pressed?
            Result:=true
          else
            FlushConsoleInputBuffer(LStdHandle); //flush the buffer
        end
      else
        FlushConsoleInputBuffer(LStdHandle);//flush the buffer
    end;
  end;
end;

class procedure TlgConsole.ClearKeyStates();
begin
  FillChar(FKeyState, SizeOf(FKeyState), 0);
  ClearKeyboardBuffer;
end;

class function  TlgConsole.IsKeyPressed(AKey: Byte): Boolean;
begin
  Result := (GetAsyncKeyState(AKey) and $8000) <> 0;
end;

class function  TlgConsole.WasKeyPressed(AKey: Byte): Boolean;
begin
  Result := False;
  if IsKeyPressed(AKey) and (not FKeyState[1, AKey]) then
  begin
    FKeyState[1, AKey] := True;
    Result := True;
  end
  else if (not IsKeyPressed(AKey)) and (FKeyState[1, AKey]) then
  begin
    FKeyState[1, AKey] := False;
    Result := False;
  end;
end;

class function  TlgConsole.WasKeyReleased(AKey: Byte): Boolean;
begin
  Result := False;
  if IsKeyPressed(AKey) and (not FKeyState[1, AKey]) then
  begin
    FKeyState[1, AKey] := True;
    Result := False;
  end
  else if (not IsKeyPressed(AKey)) and (FKeyState[1, AKey]) then
  begin
    FKeyState[1, AKey] := False;
    Result := True;
  end;
end;

{ === TIMING ================================================================ }
  { TlgDeterministicTimer }
class constructor TlgDeterministicTimer.Create();
begin
end;

class destructor TlgDeterministicTimer.Destroy();
begin
end;

class  procedure TlgDeterministicTimer.Init(const ATargetFrameRate: Cardinal);
begin
  FLastTime := glfwGetTime();
  FLastFPSTime := FLastTime;
  FTargetFrameRate := ATargetFrameRate;
  FTargetTime := 1.0 / FTargetFrameRate;
  FFrameCount := 0;
  FFramerate :=0;
  FEndtime := 0;
end;

class function  TlgDeterministicTimer.TargetFrameRate(): Cardinal;
begin
  Result := FTargetFrameRate;
end;

class function  TlgDeterministicTimer.TargetTime: Double;
begin
  Result := FTargetTime;
end;

class procedure TlgDeterministicTimer.Reset();
begin
  FLastTime := glfwGetTime();
  FLastFPSTime := FLastTime;
  FTargetTime := 1.0 / FTargetFrameRate;
  FFrameCount := 0;
  FFramerate :=0;
  FEndtime := 0;
end;

class procedure TlgDeterministicTimer.Start();
begin
  FCurrentTime := glfwGetTime();
  FElapsedTime := FCurrentTime - FLastTime;
end;

class procedure TlgDeterministicTimer.Stop();
begin
  Inc(FFrameCount);
  if (FCurrentTime - FLastFPSTime >= 1.0) then
  begin
    FFramerate := FFrameCount;
    FLastFPSTime := FCurrentTime;
    FFrameCount := 0;
  end;
  FLastTime := FCurrentTime;
  FRemainingTime := FTargetTime - (FCurrentTime - FLastTime);
  if (FRemainingTime > 0) then
   begin
      FEndtime := FCurrentTime + FRemainingTime;
      while glfwGetTime() < FEndtime do
      begin
        // Busy-wait for the remaining time
        //ProcessMessages;
        Sleep(1);
      end;
    end;
end;

class function  TlgDeterministicTimer.FrameRate(): Cardinal;
begin
  Result := FFramerate;
end;


{ === STREAM ================================================================ }

{ --- TlgStream ------------------------------------------------------------- }
constructor TlgStream.Create();
begin
  inherited;
end;

destructor TlgStream.Destroy();
begin
  inherited;
end;

procedure TlgStream.Close();
begin
end;

function  TlgStream.Size(): Int64;
begin
  Result := -1;
end;

function  TlgStream.Seek(const AOffset: Int64; const ASeek: TlgSeekMode): Int64;
begin
  Result := -1;
end;

function  TlgStream.Read(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
end;

function  TlgStream.Write(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
end;

function  TlgStream.Tell(): Int64;
begin
  Result := -1;
end;

function  TlgStream.Eos(): Boolean;
begin
  Result := False;
end;

{ --- TlgMemoryStream ------------------------------------------------------- }
constructor TlgMemoryStream.Create();
begin
  inherited;
  FHandle := TMemoryStream.Create();
end;

destructor TlgMemoryStream.Destroy();
begin
  Close();
  inherited;
end;

function  TlgMemoryStream.Duplicate(): TlgStream;
var
  LStream: TlgMemoryStream;
begin
  LStream := TlgMemoryStream.Create;
  LStream.FHandle.CopyFrom(Self.FHandle);
  LStream.Seek(0, smStart);
  Result := LStream;
end;

procedure TlgMemoryStream.Close();
begin
  if not Assigned(FHandle) then Exit;
  FHandle.Free();
  FHandle := nil;
end;

function  TlgMemoryStream.Size(): Int64;
begin
  Result := FHandle.Size;
end;

function  TlgMemoryStream.Seek(const AOffset: Int64; const ASeek: TlgSeekMode): Int64;
begin
  Result := FHandle.Seek(AOffset, Ord(ASeek));
end;

function  TlgMemoryStream.Read(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := FHandle.Read(AData^, ASize);
end;

function  TlgMemoryStream.Write(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := FHandle.Write(AData^, ASize);
end;

function  TlgMemoryStream.Tell(): Int64;
begin
  Result := FHandle.Position;
end;

function  TlgMemoryStream.Eos(): Boolean;
begin
  Result := Boolean(Tell() >= Size());
end;

function  TlgMemoryStream.Memory(): Pointer;
begin
  Result := FHandle.Memory;
end;

class function TlgMemoryStream.Open(const ASize: Int64): TlgMemoryStream;
begin
  Result := TlgMemoryStream.Create();
  Result.FHandle.SetSize(ASize);
end;

class function TlgMemoryStream.Open(const AFilename: string): TlgMemoryStream;
begin
  Result := TlgMemoryStream.Create();
  Result.FHandle.LoadFromFile(AFilename);
end;

{ --- TlgZipStream ---------------------------------------------------------- }
constructor TlgZipStream.Create();
begin
  inherited;
end;

destructor TlgZipStream.Destroy();
begin
  Close();
  inherited;
end;

procedure TlgZipStream.Close();
begin
  if Assigned(FHandle) then
  begin
    Assert(unzCloseCurrentFile(FHandle) = UNZ_OK);
    Assert(unzClose(FHandle) = UNZ_OK);
  end;
  FHandle := nil;
  FPassword := '';
  FFilename := '';
end;

function  TlgZipStream.Size(): Int64;
var
  LInfo: unz_file_info64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;
  unzGetCurrentFileInfo64(FHandle, @LInfo, nil, 0, nil, 0, nil, 0);
  Result := LInfo.uncompressed_size;
end;

function  TlgZipStream.Seek(const AOffset: Int64; const ASeek: TlgSeekMode): Int64;
var
  LFileInfo: unz_file_info64;
  LCurrentOffset, LBytesToRead: UInt64;
  LOffset: Int64;

  procedure SeekToLoc;
  begin
    LBytesToRead := UInt64(LOffset) - unztell64(FHandle);
    while LBytesToRead > 0 do
    begin
      if LBytesToRead > CStaticBufferSize then
        unzReadCurrentFile(FHandle, @StaticBuffer[0], CStaticBufferSize)
      else
        unzReadCurrentFile(FHandle, @StaticBuffer[0], LBytesToRead);

      LBytesToRead := UInt64(LOffset) - unztell64(FHandle);
    end;
  end;

begin
  Result := -1;

  if (FHandle = nil) or (unzGetCurrentFileInfo64(FHandle, @LFileInfo, nil, 0, nil, 0, nil, 0) <> UNZ_OK) then Exit;

  LOffset := AOffset;

  LCurrentOffset := unztell64(FHandle);
  if LCurrentOffset = -1 then Exit;

  case ASeek of
    // offset is already relative to the start of the file
    smStart: ;

    // offset is relative to current position
    smCurrent: Inc(LOffset, LCurrentOffset);

    // offset is relative to end of the file
    smEnd: Inc(LOffset, LFileInfo.uncompressed_size);
  else
    Exit;
  end;

  if LOffset < 0 then
    Exit
  else if AOffset > LCurrentOffset then
  begin
    SeekToLoc;
  end
  else // offset < current_offset
  begin
    unzCloseCurrentFile(FHandle);
    unzLocateFile(FHandle, PAnsiChar(FFilename), 0);
    unzOpenCurrentFilePassword(FHandle, PAnsiChar(FPassword));
    SeekToLoc;
  end;

  Result := unztell64(FHandle);
end;

function  TlgZipStream.Read(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;
  Result := unzReadCurrentFile(FHandle, AData, ASize);
end;

function  TlgZipStream.Write(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := -1;
end;

function  TlgZipStream.Tell(): Int64;
begin
  Result := -1;
  if not Assigned(FHandle) then Exit;
  Result := unztell64(FHandle);
end;

function  TlgZipStream.Eos(): Boolean;
begin
  Result := False;
  if not Assigned(FHandle) then Exit;
  Result := Boolean(Tell() >= Size());
end;

function TlgZipStream.DoOpen(const AZipFilename, AFilename: string; const APassword: string): Boolean;
var
  LPassword: PAnsiChar;
  LZipFilename: PAnsiChar;
  LFilename: PAnsiChar;
  LFile: unzFile;
begin
  Result := False;

  LPassword := PAnsiChar(AnsiString(APassword));
  LZipFilename := PAnsiChar(AnsiString(StringReplace(string(AZipFilename), '/', '\', [rfReplaceAll])));
  LFilename := PAnsiChar(AnsiString(StringReplace(string(AFilename), '/', '\', [rfReplaceAll])));

  LFile := unzOpen64(LZipFilename);
  if not Assigned(LFile) then Exit;

  if unzLocateFile(LFile, LFilename, 0) <> UNZ_OK then
  begin
    unzClose(LFile);
    Exit;
  end;

  if unzOpenCurrentFilePassword(LFile, LPassword) <> UNZ_OK then
  begin
    unzClose(LFile);
    Exit;
  end;

  Close();

  FHandle := LFile;
  FPassword := LPassword;
  FFilename := LFilename;

  Result := True;
end;

class function TlgZipStream.Open(const AZipFilename, AFilename: string; const APassword: string): TlgZipStream;
begin
  Result := TlgZipStream.Create();
  if not Result.DoOpen(AZipFilename, AFilename, APassword) then
  begin
    Result.Free();
    Result := nil;
  end;
end;

procedure TlgZipStream_BuildProgress(const ASender: Pointer; const AFilename: string; const AProgress: Integer; const ANewFile: Boolean);
begin
  if aNewFile then Console.PrintLn('');
  Console.Print(#13+'Adding %s(%d%s)...', [ExtractFileName(string(aFilename)), aProgress, '%']);
end;

class function TlgZipStream.Build(const AZipFilename, ADirectoryName: string; const ASender: Pointer; const AHandler: TlgZipFileStreamBuildProgress; const APassword: string): Boolean;
var
  LFileList: TStringDynArray;
  LArchive: PAnsiChar;
  LFilename: string;
  LFilename2: PAnsiChar;
  LPassword: PAnsiChar;
  LZipFile: zipFile;
  LZipFileInfo: zip_fileinfo;
  LFile: System.Classes.TStream;
  LCrc: Cardinal;
  LBytesRead: Integer;
  LFileSize: Int64;
  LProgress: Single;
  LNewFile: Boolean;
  LHandler: TlgZipFileStreamBuildProgress;
  LSender: Pointer;

  function GetCRC32(aStream: System.Classes.TStream): Cardinal;
  var
    LBytesRead: Integer;
    LBuffer: array of Byte;
  begin
    Result := crc32(0, nil, 0);
    repeat
      LBytesRead := AStream.Read(StaticBuffer, CStaticBufferSize);
      Result := crc32(Result, PBytef(@StaticBuffer[0]), LBytesRead);
    until LBytesRead = 0;

    LBuffer := nil;
  end;

begin
  Result := False;

  // check if directory exists
  if not TDirectory.Exists(ADirectoryName) then Exit;

  // init variabls
  FillChar(LZipFileInfo, SizeOf(LZipFileInfo), 0);

  // scan folder and build file list
  LFileList := TDirectory.GetFiles(ADirectoryName, '*',
    TSearchOption.soAllDirectories);

  LArchive := PAnsiChar(AnsiString(AZipFilename));
  LPassword := PAnsiChar(AnsiString(APassword));

  // create a zip file
  LZipFile := zipOpen64(LArchive, APPEND_STATUS_CREATE);

  // init handler
  LHandler := AHandler;
  LSender := ASender;

  if not Assigned(LHandler) then
    LHandler := TlgZipStream_BuildProgress;

  // process zip file
  if LZipFile <> nil then
  begin
    // loop through all files in list
    for LFilename in LFileList do
    begin
      // open file
      LFile := TFile.OpenRead(LFilename);

      // get file size
      LFileSize := LFile.Size;

      // get file crc
      LCrc := GetCRC32(LFile);

      // open new file in zip
      LFilename2 := PAnsiChar(AnsiString(LFilename));
      if ZipOpenNewFileInZip3_64(LZipFile, LFilename2, @LZipFileInfo, nil, 0,
        nil, 0, '',  Z_DEFLATED, 9, 0, 15, 9, Z_DEFAULT_STRATEGY,
        LPassword, LCrc, 1) = Z_OK then
      begin
        // make sure we start at star of stream
        LFile.Position := 0;

        LNewFile := True;

        // read through file
        repeat
          // read in a buffer length of file
          LBytesRead := LFile.Read(StaticBuffer, CStaticBufferSize);

          // write buffer out to zip file
          zipWriteInFileInZip(LZipFile, @StaticBuffer[0], LBytesRead);

          // calc file progress percentage
          LProgress := 100.0 * (LFile.Position / LFileSize);

          // show progress
          if Assigned(LHandler) then
          begin
            LHandler(LSender, PWideChar(LFilename), Round(LProgress), LNewFile);
          end;

          LNewFile := False;

        until LBytesRead = 0;

        // close file in zip
        zipCloseFileInZip(LZipFile);

        // free file stream
        LFile.Free;
      end;
    end;

    // close zip file
    zipClose(LZipFile, '');
  end;

  // return true if new zip file exits
  Result := TFile.Exists(LFilename);
end;


{ === AUDIO ================================================================= }

{ --- TlgAudio -------------------------------------------------------------- }
procedure TlgAudio.CheckErrors();
var
  ErrCode: ALenum;
begin
  ErrCode := alGetError;
  if ErrCode <> AL_NO_ERROR then
    FError := string(alGetString(ErrCode))
  else
    FError := 'No error';
end;

constructor TlgAudio.Create();
begin
  inherited;
  FSounds := TlgLinkedList<TlgSound>.Create();
  FOneShotSounds := TList<TlgSound>.Create();
end;

destructor TlgAudio.Destroy();
begin
  Close();
  FOneShotSounds.Free();
  FSounds.Free();
  inherited;
end;

function TlgAudio.Open(): Boolean;
begin
  Result := False;
  if IsOpen then Exit;

  FDevice := alcOpenDevice(nil); CheckErrors();
  if not Assigned(FDevice) then Exit;
  FContext := alcCreateContext(FDevice, nil); CheckErrors();
  if not Assigned(FContext) then
  begin
    Close();
    Exit;
  end;

  alcMakeContextCurrent(FContext); CheckErrors();

  // reset to "known" default state
  Reset();

  Result := IsOpen();
end;

function TlgAudio.IsOpen(): Boolean;
begin
  Result := Boolean(alcGetCurrentContext <> nil);
end;

procedure TlgAudio.Close();
begin
  if not IsOpen then Exit;

  // free any dangling sounds
  FSounds.Clear(True);

  if Assigned(FContext) then
  begin
    alcMakeContextCurrent(nil); CheckErrors();
    alcDestroyContext(FContext); CheckErrors();
    FContext := nil;
  end;

  if Assigned(FDevice) then
  begin
    alcCloseDevice(FDevice); CheckErrors();
    FDevice := nil;
  end;
end;

procedure TlgAudio.Reset();
const
  LListenerOri: array [0..5] of ALfloat= ( 0.0, 0.0, 1.0, 0.0, 1.0, 0.0);
begin
  if not IsOpen() then Exit;

  // free any dangling sounds
  FSounds.Clear(True);
  FOneShotSounds.Clear();

  // set default 2d orientation
  alListener3f(AL_POSITION, 0, 0, 1.0); CheckErrors();
  alListener3f(AL_VELOCITY, 0, 0, 0); CheckErrors();
  alListenerfv(AL_ORIENTATION, @LListenerOri); CheckErrors();
end;

function TlgAudio.GetDeviceName(): string;
begin
  Result := '';
  if not IsOpen then Exit;
  Result := string(alcGetString(FDevice, ALC_ALL_DEVICES_SPECIFIER));
end;

function TlgAudio.GetError: string;
begin
  Result := FError;
end;

function TlgAudio.GetPCMBufferSize(): Integer;
begin
  Result := BUFFER_SIZE;
end;

function TlgAudio.GetPCMBuffer(): PByte;
begin
  Result := @FPCM[0];
end;

procedure TlgAudio.Update();
var
  LSound: TlgSound;
begin
  if not IsOpen() then Exit;

  // clear oneshot sound list
  FOneShotSounds.Clear();

  // reset to start of sound list
  FSounds.Reset();
  repeat
    // check of valid sound
    if Assigned(FSounds.GetCurrent()) then
    begin
      // update this sound
      FSounds.GetCurrent().Update();

      // process oneshot sounds
      if FSounds.GetCurrent().FOneShot then
      begin
        // check if sound has stopped
        if FSounds.GetCurrent().GetStatus() = asStopped then
        begin
          // add to oneshot sound list
          FOneShotSounds.Add(FSounds.GetCurrent());
        end;
      end;
    end;
  until not FSounds.MoveNext();

  // remove all ones shot sounds
  for LSound in FOneShotSounds do
  begin
    LSound.Free();
  end;

  // clear oneshot sound list
  FOneShotSounds.Clear();
end;

{ --- TlgSound -------------------------------------------------------------- }
function Vorbis_Read(AData: Pointer; ASize: NativeUInt; ANmemb: NativeUInt; ADataSource: Pointer): NativeUInt; cdecl;
var
  LStream: TlgStream;
begin
  LStream := ADataSource;
  Result := LStream.Read(AData, ASize * ANmemb);
end;

function Vorbis_Seek(ADataSource: Pointer; AOffset: ogg_int64_t; AWhence: Integer): Integer; cdecl;
var
  LStream: TlgStream;
begin
  LStream := ADataSource;
  if LStream = nil then
    Result := -1
  else
    Result := LStream.Seek(AOffset, TlgSeekMode(AWhence));

  if Result < 0 then
    Result := -1;
end;

function Vorbis_Close(ADataSource: Pointer): Integer; cdecl;
var
  LStream: TlgStream;
begin
  LStream := ADataSource;
  LStream.Close();
  LStream.Free();
  Result := 0;
end;

function Vorbis_Tell(ADataSource: Pointer): Integer; cdecl;
var
  LStream: TlgStream;
begin
  LStream := ADataSource;
  Result := LStream.Tell();
end;


{ TlgSound }
constructor TlgSound.Create(const AAudio: TlgAudio);
begin
  inherited Create;
  if not Assigned(AAudio) then
    raise Exception.Create('Audio object was nil');
  FAudio := AAudio;

  // add self to audio sounds list
  FAudio.FSounds.Add(Self);
end;

destructor TlgSound.Destroy();
begin
  // remove self from audio sounds list
  FAudio.FSounds.Remove(Self);
  Unload();
  inherited;
end;

function  TlgSound.Duplicate(const AOneShot: Boolean): TlgSound;
begin
  Result := nil;
  if not FAudio.IsOpen() then Exit;
  if not IsLoaded() then Exit;

  Result := TlgSound.Create(FAudio);

  if not Result.Copy(Self, AOneShot) then
  begin
    Result.Free();
    Result := nil;
  end;
end;

function  TlgSound.Copy(const ASound: TlgSound; const AOneShot: Boolean): Boolean;
var
  LStream: TlgStream;
begin
  Result := False;
  if not FAudio.IsOpen() then Exit;
  if ASound.FLoad <> slMemory then Exit;

  LStream := TlgMemoryStream(ASound.FStream).Duplicate();
  Result := Load(LStream, slMemory, AOneShot);
  LStream.Free();
end;

function  TlgSound.Load(var AStream: TlgStream; const ALoad: TlgSoundLoad; const AOneShot: Boolean): Boolean;
var
  I: Integer;
  LDataSoFar: integer;
  LBytesRead: Longint;
begin
  Result := False;

  if not FAudio.IsOpen() then Exit;
  if not Assigned(AStream) then Exit;

  Unload();

  case ALoad of
    slMemory:
    begin
      FStream := TlgMemoryStream.Create();
      AStream.Seek(0, smStart);
      while not AStream.Eos() do
      begin
        AStream.Read(@StaticBuffer[0], CStaticBufferSize);
        FStream.Write(@StaticBuffer[0], CStaticBufferSize);
      end;
      FStream.Seek(0, smStart);
    end;

    slStream:
    begin
      FStream := AStream;
      FStream.Seek(0, smStart);
      AStream := nil;
    end;
  end;
  FLoad := ALoad;

  FVorbisCallbacks.read_func := Vorbis_Read;
  FVorbisCallbacks.seek_func := Vorbis_Seek;
  FVorbisCallbacks.close_func := Vorbis_Close;
  FVorbisCallbacks.tell_func := Vorbis_Tell;

  if ov_open_callbacks(FStream, @FVorbisFile, nil, 0, FVorbisCallbacks) <> 0 then
  begin
    if FLoad = slMemory then
      FStream.Free;
    Exit;
  end;

  alGenSources(1, @FSource); FAudio.CheckErrors();
  alGenBuffers(NUM_BUFFERS, @FBuffers); FAudio.CheckErrors();

  // Determine the audio format and frequency
  if FVorbisFile.vi.channels = 1 then
    FFormat := AL_FORMAT_MONO16
  else
    FFormat := AL_FORMAT_STEREO16;
  FFreq := FVorbisFile.vi.rate;
  FChans := FVorbisFile.vi.channels;

  // Initial buffer fill
  for I := 0 to NUM_BUFFERS - 1 do
  begin
    LDataSoFar := 0;
    while(LDataSoFar < FAudio.GetPCMBufferSize()) do
    begin
      LBytesRead := ov_read(@FVorbisFile,  PAnsiChar(FAudio.GetPCMBuffer()+LDataSoFar), FAudio.GetPCMBufferSize() - LDataSoFar, 0, 2, 1, nil);
      if LBytesRead = 0 then
      begin
        //TODO: review this to make sure error conditions are handled properly
        Break;
      end;
      Inc(LDataSoFar, LBytesRead);
    end;
    alBufferData(FBuffers[i], FFormat, FAudio.GetPCMBuffer(), LDataSoFar, FFreq); FAudio.CheckErrors();
  end;
  alSourceQueueBuffers(FSource, NUM_BUFFERS, @FBuffers[0]); FAudio.CheckErrors();

  alSource3f(FSource, AL_POSITION, 0, 0, 0); FAudio.CheckErrors();
  alSource3f(FSource, AL_VELOCITY, 0, 0, 0); FAudio.CheckErrors();

  FStatus := asStopped;

  SetVolume(1);
  SetPan(0.0);
  SetLooping(False);

  FOneShot := AOneShot;
  Result := True;
end;

function  TlgSound.IsLoaded(): Boolean;
begin
  Result := Boolean(FSource  <> 0);
end;

procedure TlgSound.Unload();
begin
  if not FAudio.IsOpen() then Exit;
  if not IsLoaded() then Exit;
  if FSource = 0 then Exit;

  FStatus := asStopped;
  alSourceStop(FSource);
  alDeleteSources(1, @FSource);
  FSource := 0;
  alDeleteBuffers(NUM_BUFFERS, @FBuffers);
  ov_clear(@FVorbisFile);
  FStream := nil;
end;

procedure TlgSound.Play(const APlay: Boolean);
begin
  if not FAudio.IsOpen() then Exit;
  if not IsLoaded() then Exit;

  if APlay then
    begin
      alSourcePlay(FSource);
      FStatus := asPlaying;
    end
  else
    begin
      alSourceStop(FSource);
      FStatus := asStopped;
    end;
end;

function  TlgSound.GetStatus(): TlgAudioStatus;
begin
  Result := FStatus;
end;

procedure TlgSound.Rewind();
begin
  if not FAudio.IsOpen() then Exit;
  if not IsLoaded() then Exit;

  ov_raw_seek(@FVorbisFile, 0);
end;

procedure TlgSound.Pause(const APause: Boolean);
begin
  if not FAudio.IsOpen() then Exit;
  if not IsLoaded() then Exit;

  if APause then
    begin
      alSourcePlay(FSource);
      FStatus := asPlaying;
    end
  else
    begin
      alSourceStop(FSource);
      FStatus := asPaused;
    end;
end;

function  TlgSound.GetVolume(): Single;
begin
  Result := FVolume;
end;

procedure TlgSound.SetVolume(const AVolume: Single);
begin
  if not FAudio.IsOpen() then Exit;
  if not IsLoaded() then Exit;

  FVolume := AVolume;
  alSourcef(FSource, AL_GAIN, TlgMath.UnitToScalarValue(FVolume, 1)); FAudio.CheckErrors();
end;

function  TlgSound.IsLooping(): Boolean;
begin
  Result := FLoop;
end;

procedure TlgSound.SetLooping(const ALooping: Boolean);
begin
  FLoop := ALooping;
end;

function  TlgSound.GetPan(): Single;
begin
  Result := 0;
  if not FAudio.IsOpen() then Exit;
  if not IsLoaded() then Exit;

  alGetSource3f(FSource, AL_POSITION, @Result, nil, nil); FAudio.CheckErrors();
end;

procedure TlgSound.SetPan(const APan: Single);
begin
  if not FAudio.IsOpen() then Exit;
  if not IsLoaded() then Exit;

  alSource3f(FSource, AL_POSITION, EnsureRange(-APan, -1.0, 1.0), 0, 0); FAudio.CheckErrors();
end;

function  TlgSound.GetChans(): Integer;
begin
  Result := FChans;
end;

function  TlgSound.GetFreq(): Integer;
begin
  Result := FFreq;
end;

procedure TlgSound.Update();
var
  LProcessed: ALint;
  LWhich: integer;
  LSizeRead: integer;
  LBytesRead: Longint;
begin
  if not FAudio.IsOpen() then Exit;
  if FStatus <> asPlaying then Exit;

  alGetSourcei(FSource, AL_BUFFERS_PROCESSED, @LProcessed); FAudio.CheckErrors();

  while LProcessed > 0 do
  begin
    alSourceUnqueueBuffers(FSource, 1, @LWhich); FAudio.CheckErrors();

    LSizeRead := 0;
    while(LSizeRead < FAudio.GetPCMBufferSize()) do
    begin
      LBytesRead := ov_read(@FVorbisFile, PAnsiChar(FAudio.GetPCMBuffer()+LSizeRead), FAudio.GetPCMBufferSize() - LSizeRead, 0, 2, 1, nil);
      if LBytesRead = 0 then
      begin
        if not FLoop then
          begin
            FStatus := asStopped;
            Break;
          end
        else
          begin
            ov_raw_seek(@FVorbisFile, 0);
          end;
       end;
      inc(LSizeRead, LBytesRead);
    end;

    if LSizeRead > 0 then
    begin
      alBufferData(LWhich, FFormat, FAudio.GetPCMBuffer(), LSizeRead, FFreq); FAudio.CheckErrors();
      alSourceQueueBuffers(FSource, 1, @LWhich); FAudio.CheckErrors();
    end;

    Dec(LProcessed);
  end;
end;

{============================================================================ }

{$R LGT.Deps.res}

var
  InputCodePage: Cardinal;
  OutputCodePage: Cardinal;
  DepsDLLHandle: THandle = 0;
  DepsDLLFilename: string = '';

procedure AbortDepsDLL();
begin
  if DepsDLLHandle <> 0 then
  begin
    FreeLibrary(DepsDLLHandle);
    DepsDLLHandle := 0;
  end;

  if TFile.Exists(DepsDLLFilename) then
    TFile.Delete(DepsDLLFilename);

  Halt;
end;

procedure LoadDepsDLL();
var
  LResStream: TResourceStream;

  function GetResName: string;
  const
    CValue = 'c88fbfa8003a41cb85730c70fdc9ad27';
  begin
    Result := CValue;
  end;

begin
  if DepsDLLHandle <> 0 then Exit;
  if not Boolean((FindResource(HInstance, PChar(GetResName), RT_RCDATA) <> 0)) then AbortDepsDLL;
  LResStream := TResourceStream.Create(HInstance, GetResName, RT_RCDATA);
  try
    LResStream.Position := 0;
    DepsDLLFilename := TPath.Combine(TPath.GetTempPath,
      TPath.ChangeExtension(TPath.GetGUIDFileName.ToLower, 'dat'));
    LResStream.SaveToFile(DepsDLLFilename);
    if not TFile.Exists(DepsDLLFilename) then AbortDepsDLL;
    DepsDLLHandle := LoadLibrary(PChar(DepsDLLFilename));
    if DepsDLLHandle = 0 then AbortDepsDLL();
  finally
    LResStream.Free();
  end;

  GetExports(DepsDLLHandle);
end;

procedure UnloadDepsDLL();
begin
  if DepsDLLHandle = 0 then Exit;
  FreeLibrary(DepsDLLHandle);
  TFile.Delete(DepsDLLFilename);
  DepsDLLHandle := 0
end;

initialization
begin
  // turn on memory leak detection
  ReportMemoryLeaksOnShutdown := True;

  // save current console codepage
  InputCodePage := GetConsoleCP();
  OutputCodePage := GetConsoleOutputCP();

  // set code page to UTF8
  SetConsoleCP(CP_UTF8);
  SetConsoleOutputCP(CP_UTF8);

  // init console
  Console := TlgConsole.Create();

  // load deps dll
  LoadDepsDLL();

  // misc
  if glfwInit() <> GLFW_TRUE then AbortDepsDLL();
  CriticalSection := TCriticalSection.Create();
  Math := TlgMath.Create();
  Timer := TlgDeterministicTimer.Create();
  Timer.Init();
end;

finalization
begin
  // misc
  Timer.Free();
  Math.Free();
  glfwTerminate();
  CriticalSection.Free();

  // unload deps dll
  UnloadDepsDLL();

  // release console
  Console.Free();

  // restore code page
  SetConsoleCP(InputCodePage);
  SetConsoleOutputCP(OutputCodePage);
end;

end.
