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

unit LGT;

{$I LGT.Defines.inc}

interface

uses
  System.TypInfo,
  System.Types,
  System.Rtti,
  System.Generics.Collections,
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.SyncObjs,
  System.Math,
  WinApi.Windows,
  WinApi.Messages,
  LGT.Deps,
  LGT.OGL;

{ === MISC ================================================================== }
const
  LGT_NAME          = 'Luna Game Toolkit™';
  LGT_CODENAME      = 'Aurora';
  LGT_MAJOR_VERSION = '0';
  LGT_MINOR_VERSION = '2';
  LGT_PATCH_VERSION = '0';
  LGT_VERSION       = LGT_MAJOR_VERSION+'.'+LGT_MINOR_VERSION+'.'+LGT_PATCH_VERSION;
  LGT_PROJECT       = LGT_NAME+' ('+LGT_CODENAME+') v'+LGT_MAJOR_VERSION+'.'+LGT_MINOR_VERSION+'.'+LGT_PATCH_VERSION;

  LF   = #10;
  CR   = #13;
  CRLF = LF+CR;

type
  { TlgSeekMode }
  TlgSeekMode = (smStart, smCurrent, smEnd);

  { TlgHAlign }
  THAlign = (haLeft, haCenter, haRight);

  { TlgVAlign }
  TVAlign = (vaTop, vaCenter, vaBottom);

{ === OBJECT ================================================================ }
type
  { TlgObjectAttributeSet }
  TlgObjectAttributeSet = set of Byte;

  { TlgObjectList }
  TlgObjectList = class;

  { TlgObject }
  TlgObject = class
  protected
    FOwner: TlgObjectList;
    FPrev: TlgObject;
    FNext: TlgObject;
    FAttributes: TlgObjectAttributeSet;
    function GetAttribute(aIndex: Byte): Boolean;
    procedure SetAttribute(aIndex: Byte; aValue: Boolean);
    function GetAttributes: TlgObjectAttributeSet;
    procedure SetAttributes(aValue: TlgObjectAttributeSet);
  public
    property Owner: TlgObjectList read FOwner write FOwner;
    property Prev: TlgObject read FPrev write FPrev;
    property Next: TlgObject read FNext write FNext;
    property Attribute[aIndex: Byte]: Boolean read GetAttribute write SetAttribute;
    property Attributes: TlgObjectAttributeSet read GetAttributes  write SetAttributes;
    constructor Create(); virtual;
    destructor Destroy(); override;
    function AttributesAreSet(aAttrs: TlgObjectAttributeSet): Boolean;
    procedure OnVisit(); virtual;
  end;

  { TlgObjectList }
  TlgObjectList = class
  protected
    FHead: TlgObject;
    FTail: TlgObject;
    FCount: Integer;
  public
    property Count: Integer read FCount;
    constructor Create(); virtual;
    destructor Destroy(); override;
    procedure Add(aObject: TlgObject);
    procedure Remove(aObject: TlgObject; aDispose: Boolean);
    procedure Clean(); virtual;
    procedure Clear(aAttrs: TlgObjectAttributeSet);
    procedure Visit(aAttrs: TlgObjectAttributeSet);
  end;

{ === TASKLIST ============================================================== }
type
  { TlgTaskID }
  TlgTaskID = class(TlgObject)
  protected
    FTask: TProc;
  public
    property Task: TProc read FTask write FTask;
    procedure OnVisit(); override;
  end;

  { TlgTaskList }
  TlgTaskList = class(TlgObject)
  protected
    FHandle: TlgObjectList;
    FTerminated: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Add(const ATask: TProc): TlgTaskID;
    procedure Remove(const ATaskItem: TlgTaskID);
    function  Count(): Integer;
    procedure Clear();
    procedure Start();
    procedure Stop();
    procedure Exec(AAttrs: TlgObjectAttributeSet);
  end;

{ === UTILS ================================================================= }
type
  { TlgUtils }
  TlgUtils = class
  protected const
    CStaticBufferSize = 8192;
  protected class var
    FCriticalSection: TCriticalSection;
    FStaticBuffer: array[0..CStaticBufferSize-1] of Byte;
    FMarshal: TMarshaller;
  protected
    class constructor Create();
    class destructor Destroy();
  public
    class property  Marshal: TMarshaller read FMarshal;
    class function  GetStaticBufferSize(): Int64;
    class function  GetStaticBuffer(): PByte;
    class procedure ClearStaticBuffer();
    class procedure EnterCriticalSection();
    class procedure LeaveCriticalSection();
    class procedure SetDefaultIcon(AWindow: HWND); overload;
    class procedure SetDefaultIcon(AWindow: PGLFWwindow); overload;
    class function  RemoveDuplicates(const aText: string): string;
    class function  ResourceExists(aInstance: THandle; const aResName: string): Boolean;
  end;

{ === MATH ================================================================== }
type
  { TlgPos }
  PlgPoint = ^TlgPoint;
  TlgPoint = record
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

  { TlgOBB }
  TlgOBB = record
    Center: TlgPoint;
    Extents: TlgPoint;
    Rotation: Single;
  end;

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
    class function  Point(const X, Y: Single): TlgPoint;
    class function  Vec(const X, Y: Single): TlgVec;
    class function  Size(const AWidth, AHeight: Single): TlgSize;
    class function  Rect(const X, Y, AWidth, AHeight: Single): TlgRect;
    class function  Extent(const AMinX, AMinY, AMaxX, AMaxY: Single): TlgExtent;
    class function  AngleSin(const AAngle: Cardinal): Single;
    class function  AngleCos(const AAngle: Cardinal): Single;
    class function  RandomRange(const AFrom, ATo: Integer): Integer; overload;
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
    class function  OBBIntersect(const AObbA, AObbB: TlgOBB): Boolean;
  end;

{ === BUFFER ================================================================ }
type
  { TlgVirtualBuffer }
  TlgVirtualBuffer = class(TCustomMemoryStream)
  protected
    FHandle: THandle;
    FName: string;
    procedure Clear;
  public
    constructor Create(aSize: Cardinal);
    destructor Destroy; override;
    function Write(const aBuffer; aCount: Longint): Longint; override;
    function Write(const aBuffer: TBytes; aOffset, aCount: Longint): Longint; override;
    procedure SaveToFile(aFilename: string);
    property Name: string read FName;
    function  Eof: Boolean;
    function  ReadString: WideString;
    class function LoadFromFile(const aFilename: string): TlgVirtualBuffer;
  end;

  { TlgRingBuffer }
  TlgRingBuffer<T> = class
  private type
    PType = ^T;
  private
    FBuffer: array of T;
    FReadIndex, FWriteIndex, FCapacity: Integer;
  public
    constructor Create(ACapacity: Integer);
    function Write(const AData: array of T; ACount: Integer): Integer;
    function Read(var AData: array of T; ACount: Integer): Integer;
    function DirectReadPointer(ACount: Integer): Pointer;
    function AvailableBytes: Integer;
    procedure Clear;
  end;

{ === TERMINAL ============================================================== }
type
  { TlgTerminal }
  TlgTerminal = class
  protected class var
    FKeyState: array [0..0, 0..255] of Boolean;
  protected
    class constructor Create;
    class destructor Destroy;
  public
    class function  HasConsoleOutput(): Boolean;
    class function  WasRunFromConsole(): Boolean;
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
    class function  KeyWasPressed(AKey: Byte): Boolean;
    class function  KeyWasReleased(AKey: Byte): Boolean;
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

  { TlgTimer }
  TlgTimer = record
  private
    FLastTime: Double;
    FInterval: Double;
    FSpeed: Double;
  public
    procedure InitMS(const AValue: Double);
    procedure InitFPS(const AValue: Double);
    function Check(): Boolean;
    procedure Reset();
    function  Speed(): Double;
  end;

{ === STREAM ================================================================ }
type
  TlgStreamMode = (smRead, smWrite);

  { TlgStream }
  TlgStream = class(TlgObject)
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
    class function Open(const AData: Pointer; ASize: Int64): TlgMemoryStream; overload;
  end;

  { TlgFileStream }
  TlgFileStream = class(TlgStream)
  protected
    FHandle: TFileStream;
    FMode: TlgStreamMode;
    function DoOpen(const AFilename: string; const AMode: TlgStreamMode): Boolean;
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
    class function Open(const AFilename: string; const AMode: TlgStreamMode): TlgFileStream;
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

{ === ZIPFILE =============================================================== }
type
  TlgZipFile = class(TlgObject)
  protected
    FZipFilename: string;
    FPassword: string;
    FIsOpen: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    function  Open(const AZipFilename: string; const APassword: string=TlgZipStream.DEFAULT_PASSWORD): Boolean;
    function  IsOpen(): Boolean;
    procedure Close();
    function  OpenFile(const AFilename: string): TlgZipStream;
    class function Init(const AZipFilename: string; const APassword: string=TlgZipStream.DEFAULT_PASSWORD): TlgZipFile;
  end;

{ === AUDIO ================================================================= }

type
  TlgSound = class;

  { TlgAudioStatus }
  TlgAudioStatus = (asStopped, asPlaying, asPaused);


  TlgAudio = class(TlgObject)
  protected const
    BUFFER_CHUCK = 1024*2;
    BUFFER_SIZE = BUFFER_CHUCK*2*sizeof(smallint);
  protected
    FDevice: PALCdevice;
    FContext: PALCcontext;
    FError: string;
    FPCM: array[0..BUFFER_SIZE] of byte;
    FSoundList: TlgObjectList;
    FTaskID: TlgTaskID;
    procedure CheckErrors();
    procedure Update();
  public const
    ATTR_ONESHOT = 0;
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
  end;

  { TlgSoundLoad }
  TlgSoundLoad = (slMemory, slStream);

  { TlgSound }
  TlgSound = class(TlgObject)
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
    procedure OnVisit(); override;
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
    class function LoadFromFile(const AAudio: TlgAudio; const AFilename: string; const ALoad: TlgSoundLoad; const AOneShot: Boolean=False): TlgSound;
    class function LoadFromZipFile(const AAudio: TlgAudio; const AZipFile: TlgZipFile; const AFilename: string; const ALoad: TlgSoundLoad; const AOneShot: Boolean=False): TlgSound;

  end;

{ === COLOR ================================================================= }
type
  PlgColor = ^TlgColor;
  TlgColor = record
    Red,Green,Blue,Alpha: Single;
  end;

{$REGION 'Common Colors'}
const
  ALICEBLUE           : TlgColor = (Red:$F0/$FF; Green:$F8/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  ANTIQUEWHITE        : TlgColor = (Red:$FA/$FF; Green:$EB/$FF; Blue:$D7/$FF; Alpha:$FF/$FF);
  AQUA                : TlgColor = (Red:$00/$FF; Green:$FF/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  AQUAMARINE          : TlgColor = (Red:$7F/$FF; Green:$FF/$FF; Blue:$D4/$FF; Alpha:$FF/$FF);
  AZURE               : TlgColor = (Red:$F0/$FF; Green:$FF/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  BEIGE               : TlgColor = (Red:$F5/$FF; Green:$F5/$FF; Blue:$DC/$FF; Alpha:$FF/$FF);
  BISQUE              : TlgColor = (Red:$FF/$FF; Green:$E4/$FF; Blue:$C4/$FF; Alpha:$FF/$FF);
  BLACK               : TlgColor = (Red:$00/$FF; Green:$00/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  BLANCHEDALMOND      : TlgColor = (Red:$FF/$FF; Green:$EB/$FF; Blue:$CD/$FF; Alpha:$FF/$FF);
  BLUE                : TlgColor = (Red:$00/$FF; Green:$00/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  BLUEVIOLET          : TlgColor = (Red:$8A/$FF; Green:$2B/$FF; Blue:$E2/$FF; Alpha:$FF/$FF);
  BROWN               : TlgColor = (Red:$A5/$FF; Green:$2A/$FF; Blue:$2A/$FF; Alpha:$FF/$FF);
  BURLYWOOD           : TlgColor = (Red:$DE/$FF; Green:$B8/$FF; Blue:$87/$FF; Alpha:$FF/$FF);
  CADETBLUE           : TlgColor = (Red:$5F/$FF; Green:$9E/$FF; Blue:$A0/$FF; Alpha:$FF/$FF);
  CHARTREUSE          : TlgColor = (Red:$7F/$FF; Green:$FF/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  CHOCOLATE           : TlgColor = (Red:$D2/$FF; Green:$69/$FF; Blue:$1E/$FF; Alpha:$FF/$FF);
  CORAL               : TlgColor = (Red:$FF/$FF; Green:$7F/$FF; Blue:$50/$FF; Alpha:$FF/$FF);
  CORNFLOWERBLUE      : TlgColor = (Red:$64/$FF; Green:$95/$FF; Blue:$ED/$FF; Alpha:$FF/$FF);
  CORNSILK            : TlgColor = (Red:$FF/$FF; Green:$F8/$FF; Blue:$DC/$FF; Alpha:$FF/$FF);
  CRIMSON             : TlgColor = (Red:$DC/$FF; Green:$14/$FF; Blue:$3C/$FF; Alpha:$FF/$FF);
  CYAN                : TlgColor = (Red:$00/$FF; Green:$FF/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  DARKBLUE            : TlgColor = (Red:$00/$FF; Green:$00/$FF; Blue:$8B/$FF; Alpha:$FF/$FF);
  DARKCYAN            : TlgColor = (Red:$00/$FF; Green:$8B/$FF; Blue:$8B/$FF; Alpha:$FF/$FF);
  DARKGOLDENROD       : TlgColor = (Red:$B8/$FF; Green:$86/$FF; Blue:$0B/$FF; Alpha:$FF/$FF);
  DARKGRAY            : TlgColor = (Red:$A9/$FF; Green:$A9/$FF; Blue:$A9/$FF; Alpha:$FF/$FF);
  DARKGREEN           : TlgColor = (Red:$00/$FF; Green:$64/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  DARKGREY            : TlgColor = (Red:$A9/$FF; Green:$A9/$FF; Blue:$A9/$FF; Alpha:$FF/$FF);
  DARKKHAKI           : TlgColor = (Red:$BD/$FF; Green:$B7/$FF; Blue:$6B/$FF; Alpha:$FF/$FF);
  DARKMAGENTA         : TlgColor = (Red:$8B/$FF; Green:$00/$FF; Blue:$8B/$FF; Alpha:$FF/$FF);
  DARKOLIVEGREEN      : TlgColor = (Red:$55/$FF; Green:$6B/$FF; Blue:$2F/$FF; Alpha:$FF/$FF);
  DARKORANGE          : TlgColor = (Red:$FF/$FF; Green:$8C/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  DARKORCHID          : TlgColor = (Red:$99/$FF; Green:$32/$FF; Blue:$CC/$FF; Alpha:$FF/$FF);
  DARKRED             : TlgColor = (Red:$8B/$FF; Green:$00/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  DARKSALMON          : TlgColor = (Red:$E9/$FF; Green:$96/$FF; Blue:$7A/$FF; Alpha:$FF/$FF);
  DARKSEAGREEN        : TlgColor = (Red:$8F/$FF; Green:$BC/$FF; Blue:$8F/$FF; Alpha:$FF/$FF);
  DARKSLATEBLUE       : TlgColor = (Red:$48/$FF; Green:$3D/$FF; Blue:$8B/$FF; Alpha:$FF/$FF);
  DARKSLATEGRAY       : TlgColor = (Red:$2F/$FF; Green:$4F/$FF; Blue:$4F/$FF; Alpha:$FF/$FF);
  DARKSLATEGREY       : TlgColor = (Red:$2F/$FF; Green:$4F/$FF; Blue:$4F/$FF; Alpha:$FF/$FF);
  DARKTURQUOISE       : TlgColor = (Red:$00/$FF; Green:$CE/$FF; Blue:$D1/$FF; Alpha:$FF/$FF);
  DARKVIOLET          : TlgColor = (Red:$94/$FF; Green:$00/$FF; Blue:$D3/$FF; Alpha:$FF/$FF);
  DEEPPINK            : TlgColor = (Red:$FF/$FF; Green:$14/$FF; Blue:$93/$FF; Alpha:$FF/$FF);
  DEEPSKYBLUE         : TlgColor = (Red:$00/$FF; Green:$BF/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  DIMGRAY             : TlgColor = (Red:$69/$FF; Green:$69/$FF; Blue:$69/$FF; Alpha:$FF/$FF);
  DIMGREY             : TlgColor = (Red:$69/$FF; Green:$69/$FF; Blue:$69/$FF; Alpha:$FF/$FF);
  DODGERBLUE          : TlgColor = (Red:$1E/$FF; Green:$90/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  FIREBRICK           : TlgColor = (Red:$B2/$FF; Green:$22/$FF; Blue:$22/$FF; Alpha:$FF/$FF);
  FLORALWHITE         : TlgColor = (Red:$FF/$FF; Green:$FA/$FF; Blue:$F0/$FF; Alpha:$FF/$FF);
  FORESTGREEN         : TlgColor = (Red:$22/$FF; Green:$8B/$FF; Blue:$22/$FF; Alpha:$FF/$FF);
  FUCHSIA             : TlgColor = (Red:$FF/$FF; Green:$00/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  GAINSBORO           : TlgColor = (Red:$DC/$FF; Green:$DC/$FF; Blue:$DC/$FF; Alpha:$FF/$FF);
  GHOSTWHITE          : TlgColor = (Red:$F8/$FF; Green:$F8/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  GOLD                : TlgColor = (Red:$FF/$FF; Green:$D7/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  GOLDENROD           : TlgColor = (Red:$DA/$FF; Green:$A5/$FF; Blue:$20/$FF; Alpha:$FF/$FF);
  GRAY                : TlgColor = (Red:$80/$FF; Green:$80/$FF; Blue:$80/$FF; Alpha:$FF/$FF);
  GREEN               : TlgColor = (Red:$00/$FF; Green:$80/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  GREENYELLOW         : TlgColor = (Red:$AD/$FF; Green:$FF/$FF; Blue:$2F/$FF; Alpha:$FF/$FF);
  GREY                : TlgColor = (Red:$80/$FF; Green:$80/$FF; Blue:$80/$FF; Alpha:$FF/$FF);
  HONEYDEW            : TlgColor = (Red:$F0/$FF; Green:$FF/$FF; Blue:$F0/$FF; Alpha:$FF/$FF);
  HOTPINK             : TlgColor = (Red:$FF/$FF; Green:$69/$FF; Blue:$B4/$FF; Alpha:$FF/$FF);
  INDIANRED           : TlgColor = (Red:$CD/$FF; Green:$5C/$FF; Blue:$5C/$FF; Alpha:$FF/$FF);
  INDIGO              : TlgColor = (Red:$4B/$FF; Green:$00/$FF; Blue:$82/$FF; Alpha:$FF/$FF);
  IVORY               : TlgColor = (Red:$FF/$FF; Green:$FF/$FF; Blue:$F0/$FF; Alpha:$FF/$FF);
  KHAKI               : TlgColor = (Red:$F0/$FF; Green:$E6/$FF; Blue:$8C/$FF; Alpha:$FF/$FF);
  LAVENDER            : TlgColor = (Red:$E6/$FF; Green:$E6/$FF; Blue:$FA/$FF; Alpha:$FF/$FF);
  LAVENDERBLUSH       : TlgColor = (Red:$FF/$FF; Green:$F0/$FF; Blue:$F5/$FF; Alpha:$FF/$FF);
  LAWNGREEN           : TlgColor = (Red:$7C/$FF; Green:$FC/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  LEMONCHIFFON        : TlgColor = (Red:$FF/$FF; Green:$FA/$FF; Blue:$CD/$FF; Alpha:$FF/$FF);
  LIGHTBLUE           : TlgColor = (Red:$AD/$FF; Green:$D8/$FF; Blue:$E6/$FF; Alpha:$FF/$FF);
  LIGHTCORAL          : TlgColor = (Red:$F0/$FF; Green:$80/$FF; Blue:$80/$FF; Alpha:$FF/$FF);
  LIGHTCYAN           : TlgColor = (Red:$E0/$FF; Green:$FF/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  LIGHTGOLDENRODYELLOW: TlgColor = (Red:$FA/$FF; Green:$FA/$FF; Blue:$D2/$FF; Alpha:$FF/$FF);
  LIGHTGRAY           : TlgColor = (Red:$D3/$FF; Green:$D3/$FF; Blue:$D3/$FF; Alpha:$FF/$FF);
  LIGHTGREEN          : TlgColor = (Red:$90/$FF; Green:$EE/$FF; Blue:$90/$FF; Alpha:$FF/$FF);
  LIGHTGREY           : TlgColor = (Red:$D3/$FF; Green:$D3/$FF; Blue:$D3/$FF; Alpha:$FF/$FF);
  LIGHTPINK           : TlgColor = (Red:$FF/$FF; Green:$B6/$FF; Blue:$C1/$FF; Alpha:$FF/$FF);
  LIGHTSALMON         : TlgColor = (Red:$FF/$FF; Green:$A0/$FF; Blue:$7A/$FF; Alpha:$FF/$FF);
  LIGHTSEAGREEN       : TlgColor = (Red:$20/$FF; Green:$B2/$FF; Blue:$AA/$FF; Alpha:$FF/$FF);
  LIGHTSKYBLUE        : TlgColor = (Red:$87/$FF; Green:$CE/$FF; Blue:$FA/$FF; Alpha:$FF/$FF);
  LIGHTSLATEGRAY      : TlgColor = (Red:$77/$FF; Green:$88/$FF; Blue:$99/$FF; Alpha:$FF/$FF);
  LIGHTSLATEGREY      : TlgColor = (Red:$77/$FF; Green:$88/$FF; Blue:$99/$FF; Alpha:$FF/$FF);
  LIGHTSTEELBLUE      : TlgColor = (Red:$B0/$FF; Green:$C4/$FF; Blue:$DE/$FF; Alpha:$FF/$FF);
  LIGHTYELLOW         : TlgColor = (Red:$FF/$FF; Green:$FF/$FF; Blue:$E0/$FF; Alpha:$FF/$FF);
  LIME                : TlgColor = (Red:$00/$FF; Green:$FF/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  LIMEGREEN           : TlgColor = (Red:$32/$FF; Green:$CD/$FF; Blue:$32/$FF; Alpha:$FF/$FF);
  LINEN               : TlgColor = (Red:$FA/$FF; Green:$F0/$FF; Blue:$E6/$FF; Alpha:$FF/$FF);
  MAGENTA             : TlgColor = (Red:$FF/$FF; Green:$00/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  MAROON              : TlgColor = (Red:$80/$FF; Green:$00/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  MEDIUMAQUAMARINE    : TlgColor = (Red:$66/$FF; Green:$CD/$FF; Blue:$AA/$FF; Alpha:$FF/$FF);
  MEDIUMBLUE          : TlgColor = (Red:$00/$FF; Green:$00/$FF; Blue:$CD/$FF; Alpha:$FF/$FF);
  MEDIUMORCHID        : TlgColor = (Red:$BA/$FF; Green:$55/$FF; Blue:$D3/$FF; Alpha:$FF/$FF);
  MEDIUMPURPLE        : TlgColor = (Red:$93/$FF; Green:$70/$FF; Blue:$DB/$FF; Alpha:$FF/$FF);
  MEDIUMSEAGREEN      : TlgColor = (Red:$3C/$FF; Green:$B3/$FF; Blue:$71/$FF; Alpha:$FF/$FF);
  MEDIUMSLATEBLUE     : TlgColor = (Red:$7B/$FF; Green:$68/$FF; Blue:$EE/$FF; Alpha:$FF/$FF);
  MEDIUMSPRINGGREEN   : TlgColor = (Red:$00/$FF; Green:$FA/$FF; Blue:$9A/$FF; Alpha:$FF/$FF);
  MEDIUMTURQUOISE     : TlgColor = (Red:$48/$FF; Green:$D1/$FF; Blue:$CC/$FF; Alpha:$FF/$FF);
  MEDIUMVIOLETRED     : TlgColor = (Red:$C7/$FF; Green:$15/$FF; Blue:$85/$FF; Alpha:$FF/$FF);
  MIDNIGHTBLUE        : TlgColor = (Red:$19/$FF; Green:$19/$FF; Blue:$70/$FF; Alpha:$FF/$FF);
  MINTCREAM           : TlgColor = (Red:$F5/$FF; Green:$FF/$FF; Blue:$FA/$FF; Alpha:$FF/$FF);
  MISTYROSE           : TlgColor = (Red:$FF/$FF; Green:$E4/$FF; Blue:$E1/$FF; Alpha:$FF/$FF);
  MOCCASIN            : TlgColor = (Red:$FF/$FF; Green:$E4/$FF; Blue:$B5/$FF; Alpha:$FF/$FF);
  NAVAJOWHITE         : TlgColor = (Red:$FF/$FF; Green:$DE/$FF; Blue:$AD/$FF; Alpha:$FF/$FF);
  NAVY                : TlgColor = (Red:$00/$FF; Green:$00/$FF; Blue:$80/$FF; Alpha:$FF/$FF);
  OLDLACE             : TlgColor = (Red:$FD/$FF; Green:$F5/$FF; Blue:$E6/$FF; Alpha:$FF/$FF);
  OLIVE               : TlgColor = (Red:$80/$FF; Green:$80/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  OLIVEDRAB           : TlgColor = (Red:$6B/$FF; Green:$8E/$FF; Blue:$23/$FF; Alpha:$FF/$FF);
  ORANGE              : TlgColor = (Red:$FF/$FF; Green:$A5/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  ORANGERED           : TlgColor = (Red:$FF/$FF; Green:$45/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  ORCHID              : TlgColor = (Red:$DA/$FF; Green:$70/$FF; Blue:$D6/$FF; Alpha:$FF/$FF);
  PALEGOLDENROD       : TlgColor = (Red:$EE/$FF; Green:$E8/$FF; Blue:$AA/$FF; Alpha:$FF/$FF);
  PALEGREEN           : TlgColor = (Red:$98/$FF; Green:$FB/$FF; Blue:$98/$FF; Alpha:$FF/$FF);
  PALETURQUOISE       : TlgColor = (Red:$AF/$FF; Green:$EE/$FF; Blue:$EE/$FF; Alpha:$FF/$FF);
  PALEVIOLETRED       : TlgColor = (Red:$DB/$FF; Green:$70/$FF; Blue:$93/$FF; Alpha:$FF/$FF);
  PAPAYAWHIP          : TlgColor = (Red:$FF/$FF; Green:$EF/$FF; Blue:$D5/$FF; Alpha:$FF/$FF);
  PEACHPUFF           : TlgColor = (Red:$FF/$FF; Green:$DA/$FF; Blue:$B9/$FF; Alpha:$FF/$FF);
  PERU                : TlgColor = (Red:$CD/$FF; Green:$85/$FF; Blue:$3F/$FF; Alpha:$FF/$FF);
  PINK                : TlgColor = (Red:$FF/$FF; Green:$C0/$FF; Blue:$CB/$FF; Alpha:$FF/$FF);
  PLUM                : TlgColor = (Red:$DD/$FF; Green:$A0/$FF; Blue:$DD/$FF; Alpha:$FF/$FF);
  POWDERBLUE          : TlgColor = (Red:$B0/$FF; Green:$E0/$FF; Blue:$E6/$FF; Alpha:$FF/$FF);
  PURPLE              : TlgColor = (Red:$80/$FF; Green:$00/$FF; Blue:$80/$FF; Alpha:$FF/$FF);
  REBECCAPURPLE       : TlgColor = (Red:$66/$FF; Green:$33/$FF; Blue:$99/$FF; Alpha:$FF/$FF);
  RED                 : TlgColor = (Red:$FF/$FF; Green:$00/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  ROSYBROWN           : TlgColor = (Red:$BC/$FF; Green:$8F/$FF; Blue:$8F/$FF; Alpha:$FF/$FF);
  ROYALBLUE           : TlgColor = (Red:$41/$FF; Green:$69/$FF; Blue:$E1/$FF; Alpha:$FF/$FF);
  SADDLEBROWN         : TlgColor = (Red:$8B/$FF; Green:$45/$FF; Blue:$13/$FF; Alpha:$FF/$FF);
  SALMON              : TlgColor = (Red:$FA/$FF; Green:$80/$FF; Blue:$72/$FF; Alpha:$FF/$FF);
  SANDYBROWN          : TlgColor = (Red:$F4/$FF; Green:$A4/$FF; Blue:$60/$FF; Alpha:$FF/$FF);
  SEAGREEN            : TlgColor = (Red:$2E/$FF; Green:$8B/$FF; Blue:$57/$FF; Alpha:$FF/$FF);
  SEASHELL            : TlgColor = (Red:$FF/$FF; Green:$F5/$FF; Blue:$EE/$FF; Alpha:$FF/$FF);
  SIENNA              : TlgColor = (Red:$A0/$FF; Green:$52/$FF; Blue:$2D/$FF; Alpha:$FF/$FF);
  SILVER              : TlgColor = (Red:$C0/$FF; Green:$C0/$FF; Blue:$C0/$FF; Alpha:$FF/$FF);
  SKYBLUE             : TlgColor = (Red:$87/$FF; Green:$CE/$FF; Blue:$EB/$FF; Alpha:$FF/$FF);
  SLATEBLUE           : TlgColor = (Red:$6A/$FF; Green:$5A/$FF; Blue:$CD/$FF; Alpha:$FF/$FF);
  SLATEGRAY           : TlgColor = (Red:$70/$FF; Green:$80/$FF; Blue:$90/$FF; Alpha:$FF/$FF);
  SLATEGREY           : TlgColor = (Red:$70/$FF; Green:$80/$FF; Blue:$90/$FF; Alpha:$FF/$FF);
  SNOW                : TlgColor = (Red:$FF/$FF; Green:$FA/$FF; Blue:$FA/$FF; Alpha:$FF/$FF);
  SPRINGGREEN         : TlgColor = (Red:$00/$FF; Green:$FF/$FF; Blue:$7F/$FF; Alpha:$FF/$FF);
  STEELBLUE           : TlgColor = (Red:$46/$FF; Green:$82/$FF; Blue:$B4/$FF; Alpha:$FF/$FF);
  TAN                 : TlgColor = (Red:$D2/$FF; Green:$B4/$FF; Blue:$8C/$FF; Alpha:$FF/$FF);
  TEAL                : TlgColor = (Red:$00/$FF; Green:$80/$FF; Blue:$80/$FF; Alpha:$FF/$FF);
  THISTLE             : TlgColor = (Red:$D8/$FF; Green:$BF/$FF; Blue:$D8/$FF; Alpha:$FF/$FF);
  TOMATO              : TlgColor = (Red:$FF/$FF; Green:$63/$FF; Blue:$47/$FF; Alpha:$FF/$FF);
  TURQUOISE           : TlgColor = (Red:$40/$FF; Green:$E0/$FF; Blue:$D0/$FF; Alpha:$FF/$FF);
  VIOLET              : TlgColor = (Red:$EE/$FF; Green:$82/$FF; Blue:$EE/$FF; Alpha:$FF/$FF);
  WHEAT               : TlgColor = (Red:$F5/$FF; Green:$DE/$FF; Blue:$B3/$FF; Alpha:$FF/$FF);
  WHITE               : TlgColor = (Red:$FF/$FF; Green:$FF/$FF; Blue:$FF/$FF; Alpha:$FF/$FF);
  WHITESMOKE          : TlgColor = (Red:$F5/$FF; Green:$F5/$FF; Blue:$F5/$FF; Alpha:$FF/$FF);
  YELLOW              : TlgColor = (Red:$FF/$FF; Green:$FF/$FF; Blue:$00/$FF; Alpha:$FF/$FF);
  YELLOWGREEN         : TlgColor = (Red:$9A/$FF; Green:$CD/$FF; Blue:$32/$FF; Alpha:$FF/$FF);
  BLANK               : TlgColor = (Red:$00;     Green:$00;     Blue:$00;     Alpha:$00);
  WHITE2              : TlgColor = (Red:$F5/$FF; Green:$F5/$FF; Blue:$F5/$FF; Alpha:$FF/$FF);
  RED22               : TlgColor = (Red:$7E/$FF; Green:$32/$FF; Blue:$3F/$FF; Alpha:255/$FF);
  COLORKEY            : TlgColor = (Red:$FF/$FF; Green:$00;     Blue:$FF/$FF; Alpha:$FF/$FF);
  OVERLAY1            : TlgColor = (Red:$00/$FF; Green:$20/$FF; Blue:$29/$FF; Alpha:$B4/$FF);
  OVERLAY2            : TlgColor = (Red:$01/$FF; Green:$1B/$FF; Blue:$01/$FF; Alpha:255/$FF);
  DIMWHITE            : TlgColor = (Red:$10/$FF; Green:$10/$FF; Blue:$10/$FF; Alpha:$10/$FF);
  DARKSLATEBROWN      : TlgColor = (Red:30/255; Green:31/255; Blue:30/255; Alpha:1/255);
{$ENDREGION}

{ === WINDOW ================================================================ }

{$REGION ' Key Codes '}
const
  KEY_UNKNOWN = -1;
  KEY_SPACE = 32;
  KEY_APOSTROPHE = 39;
  KEY_COMMA = 44;
  KEY_MINUS = 45;
  KEY_PERIOD = 46;
  KEY_SLASH = 47;
  KEY_0 = 48;
  KEY_1 = 49;
  KEY_2 = 50;
  KEY_3 = 51;
  KEY_4 = 52;
  KEY_5 = 53;
  KEY_6 = 54;
  KEY_7 = 55;
  KEY_8 = 56;
  KEY_9 = 57;
  KEY_SEMICOLON = 59;
  KEY_EQUAL = 61;
  KEY_A = 65;
  KEY_B = 66;
  KEY_C = 67;
  KEY_D = 68;
  KEY_E = 69;
  KEY_F = 70;
  KEY_G = 71;
  KEY_H = 72;
  KEY_I = 73;
  KEY_J = 74;
  KEY_K = 75;
  KEY_L = 76;
  KEY_M = 77;
  KEY_N = 78;
  KEY_O = 79;
  KEY_P = 80;
  KEY_Q = 81;
  KEY_R = 82;
  KEY_S = 83;
  KEY_T = 84;
  KEY_U = 85;
  KEY_V = 86;
  KEY_W = 87;
  KEY_X = 88;
  KEY_Y = 89;
  KEY_Z = 90;
  KEY_LEFT_BRACKET = 91;
  KEY_BACKSLASH = 92;
  KEY_RIGHT_BRACKET = 93;
  KEY_GRAVE_ACCENT = 96;
  KEY_WORLD_1 = 161;
  KEY_WORLD_2 = 162;
  KEY_ESCAPE = 256;
  KEY_ENTER = 257;
  KEY_TAB = 258;
  KEY_BACKSPACE = 259;
  KEY_INSERT = 260;
  KEY_DELETE = 261;
  KEY_RIGHT = 262;
  KEY_LEFT = 263;
  KEY_DOWN = 264;
  KEY_UP = 265;
  KEY_PAGE_UP = 266;
  KEY_PAGE_DOWN = 267;
  KEY_HOME = 268;
  KEY_END = 269;
  KEY_CAPS_LOCK = 280;
  KEY_SCROLL_LOCK = 281;
  KEY_NUM_LOCK = 282;
  KEY_PRINT_SCREEN = 283;
  KEY_PAUSE = 284;
  KEY_F1 = 290;
  KEY_F2 = 291;
  KEY_F3 = 292;
  KEY_F4 = 293;
  KEY_F5 = 294;
  KEY_F6 = 295;
  KEY_F7 = 296;
  KEY_F8 = 297;
  KEY_F9 = 298;
  KEY_F10 = 299;
  KEY_F11 = 300;
  KEY_F12 = 301;
  KEY_F13 = 302;
  KEY_F14 = 303;
  KEY_F15 = 304;
  KEY_F16 = 305;
  KEY_F17 = 306;
  KEY_F18 = 307;
  KEY_F19 = 308;
  KEY_F20 = 309;
  KEY_F21 = 310;
  KEY_F22 = 311;
  KEY_F23 = 312;
  KEY_F24 = 313;
  KEY_F25 = 314;
  KEY_KP_0 = 320;
  KEY_KP_1 = 321;
  KEY_KP_2 = 322;
  KEY_KP_3 = 323;
  KEY_KP_4 = 324;
  KEY_KP_5 = 325;
  KEY_KP_6 = 326;
  KEY_KP_7 = 327;
  KEY_KP_8 = 328;
  KEY_KP_9 = 329;
  KEY_KP_DECIMAL = 330;
  KEY_KP_DIVIDE = 331;
  KEY_KP_MULTIPLY = 332;
  KEY_KP_SUBTRACT = 333;
  KEY_KP_ADD = 334;
  KEY_KP_ENTER = 335;
  KEY_KP_EQUAL = 336;
  KEY_LEFT_SHIFT = 340;
  KEY_LEFT_CONTROL = 341;
  KEY_LEFT_ALT = 342;
  KEY_LEFT_SUPER = 343;
  KEY_RIGHT_SHIFT = 344;
  KEY_RIGHT_CONTROL = 345;
  KEY_RIGHT_ALT = 346;
  KEY_RIGHT_SUPER = 347;
  KEY_MENU = 348;
  KEY_LAST = KEY_MENU;
{$ENDREGION}

{$REGION ' Mouse Buttons '}
const
  MOUSE_BUTTON_1 = 0;
  MOUSE_BUTTON_2 = 1;
  MOUSE_BUTTON_3 = 2;
  MOUSE_BUTTON_4 = 3;
  MOUSE_BUTTON_5 = 4;
  MOUSE_BUTTON_6 = 5;
  MOUSE_BUTTON_7 = 6;
  MOUSE_BUTTON_8 = 7;
  MOUSE_BUTTON_LAST = GLFW_MOUSE_BUTTON_8;
  MOUSE_BUTTON_LEFT = GLFW_MOUSE_BUTTON_1;
  MOUSE_BUTTON_RIGHT = GLFW_MOUSE_BUTTON_2;
  MOUSE_BUTTON_MIDDLE = GLFW_MOUSE_BUTTON_3;
{$ENDREGION}

{$REGION ' Gamepads '}
const
  GAMEPAD_1 = 0;
  GAMEPAD_2 = 1;
  GAMEPAD_3 = 2;
  GAMEPAD_4 = 3;
  GAMEPAD_5 = 4;
  GAMEPAD_6 = 5;
  GAMEPAD_7 = 6;
  GAMEPAD_8 = 7;
  GAMEPAD_9 = 8;
  GAMEPAD_10 = 9;
  GAMEPAD_11 = 10;
  GAMEPAD_12 = 11;
  GAMEPAD_13 = 12;
  GAMEPAD_14 = 13;
  GAMEPAD_15 = 14;
  GAMEPAD_16 = 15;
  GAMEPAD_LAST = GAMEPAD_16;
{$ENDREGION}

{$REGION ' Gamepad Buttons '}
const
  GAMEPAD_BUTTON_A = 0;
  GAMEPAD_BUTTON_B = 1;
  GAMEPAD_BUTTON_X = 2;
  GAMEPAD_BUTTON_Y = 3;
  GAMEPAD_BUTTON_LEFT_BUMPER = 4;
  GAMEPAD_BUTTON_RIGHT_BUMPER = 5;
  GAMEPAD_BUTTON_BACK = 6;
  GAMEPAD_BUTTON_START = 7;
  GAMEPAD_BUTTON_GUIDE = 8;
  GAMEPAD_BUTTON_LEFT_THUMB = 9;
  GAMEPAD_BUTTON_RIGHT_THUMB = 10;
  GAMEPAD_BUTTON_DPAD_UP = 11;
  GAMEPAD_BUTTON_DPAD_RIGHT = 12;
  GAMEPAD_BUTTON_DPAD_DOWN = 13;
  GAMEPAD_BUTTON_DPAD_LEFT = 14;
  GAMEPAD_BUTTON_LAST = GAMEPAD_BUTTON_DPAD_LEFT;
  GAMEPAD_BUTTON_CROSS = GAMEPAD_BUTTON_A;
  GAMEPAD_BUTTON_CIRCLE = GAMEPAD_BUTTON_B;
  GAMEPAD_BUTTON_SQUARE = GAMEPAD_BUTTON_X;
  GAMEPAD_BUTTON_TRIANGLE = GAMEPAD_BUTTON_Y;
{$ENDREGION}

{$REGiON ' Gamepad Axis '}
const
  GAMEPAD_AXIS_LEFT_X = 0;
  GAMEPAD_AXIS_LEFT_Y = 1;
  GAMEPAD_AXIS_RIGHT_X = 2;
  GAMEPAD_AXIS_RIGHT_Y = 3;
  GAMEPAD_AXIS_LEFT_TRIGGER = 4;
  GAMEPAD_AXIS_RIGHT_TRIGGER = 5;
  GAMEPAD_AXIS_LAST = GAMEPAD_AXIS_RIGHT_TRIGGER;
{$ENDREGiON}

type
  { TlgInputState }
  TlgInputState = (isPressed, isWasPressed, isWasReleased);

  { TlgWindow }
  TlgWindow = class(TlgObject)
  protected
    FHandle: PGLFWwindow;
    FSize: TlgSize;
    FScaledSize: TlgSize;
    FScale: TlgPoint;
    FMaxTextureSize: GLint;
    FKeyState: array [0..0, KEY_SPACE..KEY_LAST] of Boolean;
    FMouseButtonState: array [0..0, MOUSE_BUTTON_1..MOUSE_BUTTON_MIDDLE] of Boolean;
    FGamepadButtonState: array[0..0, GAMEPAD_BUTTON_A..GAMEPAD_BUTTON_LAST] of Boolean;
    FVsync: Boolean;
  public const
    DEFAULT_WIDTH = 1920 div 2;
    DEFAULT_HEIGHT = 1080 div 2;
    CENTER_WIDTH = DEFAULT_WIDTH div 2;
    CENTER_HEIGHT = DEFAULT_HEIGHT div 2;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  Open(const aTitle: string; const AWidth: Integer=DEFAULT_WIDTH; const AHeight: Integer=DEFAULT_HEIGHT; const AEnableVSync: Boolean=False): Boolean;
    function  IsOpen(): Boolean;
    procedure Close();
    function  Ready(): Boolean;
    function  GetHandle(): PGLFWwindow;
    function  GetVSync(): Boolean;
    procedure SetVSync(const AEnable: Boolean);
    function  GetMaxTextureSize(): Integer;
    function  GetTitle(): string;
    procedure SetTitle(const ATitle: string);
    function  ShouldClose(): Boolean;
    procedure SetShouldClose(const AValue: Boolean);
    procedure GetSize(var ASize: TlgSize);
    procedure GetScaledSize(var ASize: TlgSize);
    procedure GetScale(var AScale: TlgPoint);
    procedure GetViewport(var AViewport: TlgRect); overload;
    procedure GetViewport(X, Y, AWidth, AHeight: PSingle); overload;
    procedure Clear(const AColor: TlgColor); overload;
    procedure Clear(const ARed, AGreen, ABlue, AAlpha: Single); overload;
    procedure StartFrame();
    procedure EndFrame();
    procedure StartDrawing();
    procedure EndDrawing();
    procedure DrawLine(const X1, Y1, X2, Y2: Single; const AColor: TlgColor; const AThickness: Single);
    procedure DrawRect(const X, Y, AWidth, AHeight, AThickness: Single; const AColor: TlgColor; const AAngle: Single);
    procedure DrawFilledRect(const X, Y, AWidth, AHeight: Single; const AColor: TlgColor; const AAngle: Single);
    procedure DrawCircle(const X, Y, ARadius, AThickness: Single; const AColor: TlgColor);
    procedure DrawFilledCircle(const X, Y, ARadius: Single; const AColor: TlgColor);
    procedure DrawTriangle(const X1, Y1, X2, Y2, X3, Y3, AThickness: Single; const AColor: TlgColor);
    procedure DrawFilledTriangle(const X1, Y1, X2, Y2, X3, Y3: Single; const AColor: TlgColor);
    procedure DrawPolygon(const APoints: array of TlgPoint; const AThickness: Single; const AColor: TlgColor);
    procedure DrawFilledPolygon(const APoints: array of TlgPoint; const AColor: TlgColor);
    procedure DrawPolyline(const APoints: array of TlgPoint; const AThickness: Single; const AColor: TlgColor);
    procedure ClearInput();
    function  GetKey(const AKey: Integer; const AState: TlgInputState): Boolean;
    function  GetMouseButton(const AButton: Byte; const AState: TlgInputState): Boolean;
    procedure GetMousePos(const X, Y: PSingle); overload;
    function  GetMousePos(): TlgPoint; overload;
    procedure SetMousePos(const X, Y: Single);
    function  GamepadPresent(const AGamepad: Byte): Boolean;
    function  GetGamepadName(const AGamepad: Byte): string;
    function  GetGamepadButton(const AGamepad, AButton: Byte; const AState: TlgInputState): Boolean;
    function  GetGamepadAxisValue(const AGamepad, AAxis: Byte): Single;
    function  SaveToFile(const AFilename: string): Boolean;
    function  GetPixel(const X, Y: Single): TlgColor;
    procedure SetPixel(const X, Y: Single; const AColor: TlgColor); overload;
    procedure SetPixel(const X, Y: Single; const ARed, AGreen, ABlue, AAlpha: Byte); overload;
    class function Init(const aTitle: string; const AWidth: Integer=DEFAULT_WIDTH; const AHeight: Integer=DEFAULT_HEIGHT): TlgWindow;
  end;

{ === TEXTURE =============================================================== }
  TlgTextureBlend = (tbNone, tbAlpha, tbAdditiveAlpha);

  { TglTexture }
  TlgTexture = class(TlgObject)
  protected
    FHandle: Cardinal;
    FChannels: Integer;
    FSize: TlgSize;
    FPivot: TlgPoint;
    FAnchor: TlgPoint;
    FBlend: TlgTextureBlend;
    FPos: TlgPoint;
    FScale: Single;
    FColor: TlgColor;
    FAngle: Single;
    FHFlip: Boolean;
    FVFlip: Boolean;
    FRegion: TlgRect;
    FLock: PByte;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function   Allocate(const AWidth, AHeight: Integer): Boolean;
    procedure  Fill(const AColor: TlgColor);
    function   Load(const ARGBData: Pointer; const AWidth, AHeight: Integer): Boolean; overload;
    function   Load(const AStream: TlgStream; const AColorKey: PlgColor=nil): Boolean; overload;
    procedure  Unload();
    function   GetChannels(): Integer;
    function   GetSize(): TlgSize;
    function   GetPivot(): TlgPoint;
    procedure  SetPivot(const APoint: TlgPoint); overload;
    procedure  SetPivot(const X, Y: Single); overload;
    function   GetAnchor(): TlgPoint;
    procedure  SetAnchor(const APoint: TlgPoint); overload;
    procedure  SetAnchor(const X, Y: Single); overload;
    function   GetBlend: TlgTextureBlend;
    procedure  SetBlend(const AValue: TlgTextureBlend);
    function   GetPos(): TlgPoint;
    procedure  SetPos(const APos: TlgPoint); overload;
    procedure  SetPos(const X, Y: Single); overload;
    function   GetScale(): Single;
    procedure  SetScale(const AScale: Single);
    function   GetColor(): TlgColor;
    procedure  SetColor(const AColor: TlgColor); overload;
    procedure  SetColor(const ARed, AGreen, ABlue, AAlpha: Single); overload;
    function   GetAngle(): Single;
    procedure  SetAngle(const AAngle: Single);
    function   GetHFlip: Boolean;
    procedure  SetHFlip(const AFlip: Boolean);
    function   GetVFlip: Boolean;
    procedure  SetVFlip(const AFlip: Boolean);
    function   GetRegion(): TlgRect;
    procedure  SetRegion(const ARegion: TlgRect); overload;
    procedure  SetRegion(const X, Y, AWidth, AHeight: Single); overload;
    procedure  ResetRegion();
    procedure  Draw();
    procedure  DrawTiled(const AWindow: TlgWindow; const ADeltaX, ADeltaY: Single);
    function   SaveToFile(const AFilename: string): Boolean;
    function   Lock(): Boolean;
    procedure  Unlock();
    function   GetPixel(const X, Y: Single): TlgColor;
    procedure  SetPixel(const X, Y: Single; const AColor: TlgColor); overload;
    procedure  SetPixel(const X, Y: Single; const ARed, AGreen, ABlue, AAlpha: Byte); overload;
    function   CollideAABB(const ATexture: TlgTexture): Boolean;
    function   CollideOBB(const ATexture: TlgTexture): Boolean;
    class function LoadFromFile(const AFilename: string; const AColorKey: PlgColor=nil): TlgTexture;
    class function LoadFromZipFile(const AZipFile: TlgZipFile; const AFilename: string; const AColorKey: PlgColor=nil): TlgTexture;
  end;

{ === FONT ================================================================== }
type
  TlgFont = class(TlgObject)
  public const
    DEFAULT_GLYPHS = ' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~™©';
  protected type
    PGlyph = ^TGlyph;
    TGlyph = record
      SrcRect: TlgRect;
      DstRect: TlgRect;
      XAdvance: Single;
    end;
  protected
    FAtlasSize: Integer;
    FAtlas: TlgTexture;
    FBaseLine: Single;
    FGlyph: TDictionary<Integer, TGlyph>;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  Load(const AWindow: TlgWindow; const AStream: TlgStream; const ASize: Cardinal; const AGlyphs: string=''): Boolean;
    procedure Unload();
    procedure DrawText(const AWindow: TlgWindow; const aX, aY: Single; const aColor: TlgColor; aHAlign: THAlign; const aMsg: string; const aArgs: array of const); overload;
    procedure DrawText(const AWindow: TlgWindow; const aX: Single; var aY: Single; const aLineSpace: Single; const aColor: TlgColor; aHAlign: THAlign; const aMsg: string; const aArgs: array of const); overload;
    function  TextLength(const aMsg: string; const aArgs: array of const): Single;
    function  TextHeight(): Single;
    function  SaveTexture(const AFilename: string): Boolean;
    class function LoadFromFile(const AWindow: TlgWindow; const AFilename: string; const ASize: Cardinal; const AGlyphs: string=''): TlgFont;
    class function LoadFromZipFile(const AWindow: TlgWindow; const AZipFile: TlgZipFile; const AFilename: string; const ASize: Cardinal; const AGlyphs: string=''): TlgFont;
    class function LoadDefault(const AWindow: TlgWindow; const aSize: Cardinal; const aGlyphs: string=''): TlgFont;
  end;

{ === VIDEO ================================================================= }
type
  { TlgVideoStatus }
  TlgVideoStatus = (vsStopped, vsPaused, vsPlaying);

  { TlgVideo }
  TlgVideo = class(TlgObject)
  protected const
    NUM_BUFFERS = 2;
    SAMEPLE_SIZE = 2304;
    AUDIO_CHANES = 2;
    RGBBUFFER_SIZE = 1024*8;
  protected
    FSource: ALuint;
    FBuffers: array[0..NUM_BUFFERS-1] of ALuint;
    FSampleRate: Integer;
    FFrameTime: Double;
    FRingBuffer: TlgRingBuffer<Byte>;
    FAudioDecodeBuffer: array[0..(SAMEPLE_SIZE*sizeof(smallint))] of Byte;
    FStaticPlmBuffer: array[0..RGBBUFFER_SIZE] of byte;
    FVolume: Single;
    FLooping: Boolean;
    FStatus: TlgVideoStatus;
    FRGBABuffer: array of uint8;
    FTexture: TlgTexture;
    FStream: TlgStream;
    FPlm: Pplm_t;
    FTaskID: TlgTaskID;
    procedure UpdateAudio();
  public const
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  Load(var AStream: TlgStream): Boolean;
    function  IsLoaded(): Boolean;
    procedure Unload();
    procedure Play(const APlay: Boolean);
    function  GetPos(): TlgPoint;
    procedure SetPos(const APos: TlgPoint); overload;
    procedure SetPos(const X, Y: Single); overload;
    function  GetVolume: Single;
    procedure SetVolume(const AVolume: Single);
    function  GetScale(): Single;
    procedure SetScale(const AScale: Single);
    function  IsLooping(): Boolean;
    procedure SetLooping(const ALoop: Boolean);
    procedure Update();
    function  GetStatus(): TlgVideoStatus;
    procedure Draw();
    class function LoadFromFile(const AFilename: string): TlgVideo;
    class function LoadFromZipFile(const AZipFile: TlgZipFile; const AFilename: string): TlgVideo;
  end;

{ === CAMERA ================================================================ }
type
  TlgCamera = class(TlgObject)
  protected
    FX, FY: Single;
    FRotation: Single;
    FScale: Single;
    FWindow: TlgWindow;
    procedure SetRotation(const AValue: Single);
  public
    property X: Single read FX write FX;
    property Y: Single read FY write FY;
    property Rotation: Single read FRotation write SetRotation;
    property Scale: Single read FScale write FScale;
    constructor Create; override;
    destructor Destroy; override;
    procedure Move(const X, Y: Single);
    procedure Zoom(const AScale: Single);
    procedure Rotate(const ARotation: Single);
    procedure Use(const AWindow: TlgWindow);
    procedure Reset();
  end;

{ === GUI =================================================================== }
const
  GUI_WINDOW_BORDER = 1;
  GUI_WINDOW_MOVABLE = 2;
  GUI_WINDOW_SCALABLE = 4;
  GUI_WINDOW_CLOSABLE = 8;
  GUI_WINDOW_MINIMIZABLE = 16;
  GUI_WINDOW_NO_SCROLLBAR = 32;
  GUI_WINDOW_TITLE = 64;
  GUI_WINDOW_SCROLL_AUTO_HIDE = 128;
  GUI_WINDOW_BACKGROUND = 256;
  GUI_WINDOW_SCALE_LEFT = 512;
  GUI_WINDOW_NO_INPUT = 1024;

  GUI_TEXT_ALIGN_LEFT = 1;
  GUI_TEXT_ALIGN_CENTERED = 2;
  GUI_TEXT_ALIGN_RIGHT = 4;
  GUI_TEXT_ALIGN_TOP = 8;
  GUI_TEXT_ALIGN_MIDDLE = 16;
  GUI_TEXT_ALIGN_BOTTOM = 32;

  GUI_TEXT_LEFT = 17;
  GUI_TEXT_CENTERED = 18;
  GUI_TEXT_RIGHT = 20;

  GUI_EDIT_DEFAULT = 0;
  GUI_EDIT_READ_ONLY = 1;
  GUI_EDIT_AUTO_SELECT = 2;
  GUI_EDIT_SIG_ENTER = 4;
  GUI_EDIT_ALLOW_TAB = 8;
  GUI_EDIT_NO_CURSOR = 16;
  GUI_EDIT_SELECTABLE = 32;
  GUI_EDIT_CLIPBOARD = 64;
  GUI_EDIT_CTRL_ENTER_NEWLINE = 128;
  GUI_EDIT_NO_HORIZONTAL_SCROLL = 256;
  GUI_EDIT_ALWAYS_INSERT_MODE = 512;
  GUI_EDIT_MULTILINE = 1024;
  GUI_EDIT_GOTO_END_ON_ACTIVATE = 2048;

  GUI_EDIT_SIMPLE = 512;
  GUI_EDIT_FIELD = 608;
  GUI_EDIT_BOX = 1640;
  GUI_EDIT_EDITOR = 1128;

  GUI_EDIT_ACTIVE = 1;
  GUI_EDIT_INACTIVE = 2;
  GUI_EDIT_ACTIVATED = 4;
  GUI_EDIT_DEACTIVATED = 8;
  GUI_EDIT_COMMITED = 16;

  GUI_DEFAULT_WINDOW = GUI_WINDOW_TITLE or GUI_WINDOW_BORDER or
    GUI_WINDOW_MOVABLE or GUI_WINDOW_BACKGROUND or GUI_WINDOW_SCALABLE or
    GUI_WINDOW_MINIMIZABLE;

type
  { TlgGUI }
  TlgGUI = class(TlgObject)
  protected
    FCtx: Pnk_context;
  public
    // init
    constructor Create; override;
    destructor Destroy; override;
    function  Setup(const AWindow: TlgWindow): Boolean;

    // frame
    procedure NewFrame();
    procedure Render();

    // window
    function  BeginWindow(const ATitle: string; const X, Y, AWidth, AHeight: Single; const AFlags: Cardinal): Boolean;
    procedure EndWindow();

    // layout
    procedure LayoutRowDynamic(const AHeight: Single; const AColumns: Integer);
    procedure LayoutRowStatic(const AHeight: Single; const AItemWidth, AColumns: Integer);

    // button
    function  ButtonLabel(const ATitle: string): Boolean;

    // option
    function  OptionLabel(const ATitle: string; const AActive: Boolean): Boolean;

    // property
    procedure PropertyInt(const AName: string; const AValue: PInteger; const AMin, AMax, AStep: Integer; const AIncPerPixel: Single);

    // class methods
    class function Init(const AWindow: TlgWindow): TlgGUI;
  end;

{ === POLYGON =============================================================== }
type
  { TlgPolygon }
  TlgPolygon = class(TlgObject)
  protected type
    TSegment = record
      Point: TlgPoint;
      Visible: Boolean;
    end;
  protected
    FSegment: array of TSegment;
    FWorldPoint: array of TlgPoint;
    FItemCount: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Save(const AFilename: string);
    procedure Load(const AStream: TlgStream; const AFilename: string);
    procedure CopyFrom(APolygon: TlgPolygon);
    procedure Clear();
    procedure AddLocalPoint(AX, AY: Single; AVisible: Boolean);
    function  Transform(AX, AY, AScale, AAngle: Single; AOrigin: PlgPoint; AHFlip, AVFlip: Boolean): Boolean;
    procedure Render(const AWindow: TlgWindow; const AX, AY, AScale, AAngle: Single; AThickness: Integer; AColor: TlgColor; AOrigin: PlgPoint; AHFlip, AVFlip: Boolean);
    procedure SetSegmentVisible(AIndex: Integer; AVisible: Boolean);
    function  IsSegmentVisible(AIndex: Integer): Boolean;
    function  PointCount(): Integer;
    function  WorldPoint(AIndex: Integer): PlgPoint;
    function  LocalPoint(AIndex: Integer): PlgPoint;
  end;

{ === STARTFIELD ============================================================ }
type
  { TlgStarfield }
  TlgStarfield = class(TlgObject)
  protected type
    TStar = record
      X, Y, Z: Single;
      Speed: Single;
    end;
    TPoint = record
      X,Y,Z: Single;
    end;
  protected
    FCenter: TPoint;
    FMin: TPoint;
    FMax: TPoint;
    FViewScaleRatio: Single;
    FViewScale: Single;
    FStarCount: Cardinal;
    FStar: array of TStar;
    FSpeed: TPoint;
    FVirtualPos: TlgPoint;
    procedure TransformDrawPoint(const X, Y, Z: Single; const AWindow: TlgWindow);
    procedure Done();
  public
    constructor Create(); override;
    destructor Destroy(); override;
  public
    procedure Init(const AWindow: TlgWindow; const aStarCount: Cardinal; const AMinX, AMinY, AMinZ, AMaxX, AMaxY, AMaxZ, AViewScale: Single);
    procedure SetVirtualPos(const X, Y: Single);
    procedure GetVirtualPos(var X: Single; var Y: Single);
    procedure SetXSpeed(const ASpeed: Single);
    procedure SetYSpeed(const ASpeed: Single);
    procedure SetZSpeed(const ASpeed: Single);
    procedure Update();
    procedure Render(const AWindow: TlgWindow);
    class function New(const AWindow: TlgWindow): TlgStarfield;
  end;

{ === LUA =================================================================== }
type
  { TlgLuaType }
  TlgLuaType = (ltNone = -1, ltNil = 0, ltBoolean = 1, ltLightUserData = 2,
    ltNumber = 3, ltString = 4, ltTable = 5, ltFunction = 6, ltUserData = 7,
    ltThread = 8);

  { TlgLuaTable }
  TlgLuaTable = (LuaTable);

  { TlgLuaValueType }
  TlgLuaValueType = (vtInteger, vtDouble, vtString, vtTable, vtPointer,
    vtBoolean);

  { TlgLuaValue }
  TlgLuaValue = record
    AsType: TlgLuaValueType;
    class operator Implicit(const AValue: Integer): TlgLuaValue;
    class operator Implicit(AValue: Double): TlgLuaValue;
    class operator Implicit(AValue: System.PChar): TlgLuaValue;
    class operator Implicit(AValue: TlgLuaTable): TlgLuaValue;
    class operator Implicit(AValue: Pointer): TlgLuaValue;
    class operator Implicit(AValue: Boolean): TlgLuaValue;

    class operator Implicit(AValue: TlgLuaValue): Integer;
    class operator Implicit(AValue: TlgLuaValue): Double;
    class operator Implicit(AValue: TlgLuaValue): System.PChar;
    class operator Implicit(AValue: TlgLuaValue): Pointer;
    class operator Implicit(AValue: TlgLuaValue): Boolean;

    case Integer of
      0: (AsInteger: Integer);
      1: (AsNumber: Double);
      2: (AsString: System.PChar);
      3: (AsTable: TlgLuaTable);
      4: (AsPointer: Pointer);
      5: (AsBoolean: Boolean);
  end;

  { IlgLuaContext }
  IlgLuaContext = interface
    ['{6AEC306C-45BC-4C65-A0E1-044739DED1EB}']
    function  ArgCount(): Integer;
    function  PushCount(): Integer;
    procedure ClearStack();
    procedure PopStack(aCount: Integer);
    function  GetStackType(aIndex: Integer): TlgLuaType;
    function  GetValue(aType: TlgLuaValueType; aIndex: Integer): TlgLuaValue;
    procedure PushValue(aValue: TlgLuaValue);
    procedure SetTableFieldValue(const AName: string; AValue: TlgLuaValue; AIndex: Integer); overload;
    function  GetTableFieldValue(const AName: string; AType: TlgLuaValueType; AIndex: Integer): TlgLuaValue; overload;
    procedure SetTableIndexValue(const AName: string; AValue: TlgLuaValue; AIndex: Integer; AKey: Integer);
    function  GetTableIndexValue(const aName: string; AType: TlgLuaValueType; AIndex: Integer; AKey: Integer): TlgLuaValue;
  end;

  { TlgLuaFunction }
  TlgLuaFunction = procedure(ALua: IlgLuaContext) of object;

  { IlgLua }
  IlgLua = interface
    ['{671FAB20-00F2-4C81-96A6-6F675A37D00B}']
    procedure Reset();
    procedure LoadStream(AStream: TStream; ASize: NativeUInt = 0; AAutoRun: Boolean = True);
    function  LoadFile(const AFilename: string; AAutoRun: Boolean = True): Boolean;
    procedure LoadString(const AData: string; AAutoRun: Boolean = True);
    procedure LoadBuffer(AData: Pointer; ASize: NativeUInt; AAutoRun: Boolean = True);
    procedure Run();
    function  RoutineExist(const AName: string): Boolean;
    function  Call(const AName: string; const AParams: array of TlgLuaValue): TlgLuaValue; overload;
    function  PrepCall(const AName: string): Boolean;
    function  Call(aParamCount: Integer): TlgLuaValue; overload;
    function  VariableExist(const AName: string): Boolean;
    procedure SetVariable(const AName: string; AValue: TlgLuaValue);
    function  GetVariable(const AName: string; AType: TlgLuaValueType): TlgLuaValue;
    procedure RegisterRoutine(const AName: string; AData: Pointer; aCode: Pointer); overload;
    procedure RegisterRoutine(const AName: string; aRoutine: TlgLuaFunction); overload;
    procedure RegisterRoutines(AClass: TClass); overload;
    procedure RegisterRoutines(AObject: TObject); overload;
    procedure RegisterRoutines(const ATables: string; AClass: TClass; const ATableName: string = ''); overload;
    procedure RegisterRoutines(const ATables: string; AObject: TObject; const ATableName: string = ''); overload;
  end;

  { Forwards }
  TlgLua = class;
  TlgLuaContext = class;

  { ElgLuaException }
  ElgLuaException = class(Exception);

  { ElgLuaRuntimeException }
  ElgLuaRuntimeException = class(Exception);

  { ElgLuaSyntaxError }
  ElgLuaSyntaxError = class(Exception);

  { TlgLuaContext }
  TlgLuaContext = class(TNoRefCountObject, IlgLuaContext)
  protected
    FLua: TlgLua;
    FPushCount: Integer;
    FPushFlag: Boolean;
    procedure Setup();
    procedure Check();
    procedure IncStackPushCount();
    procedure Cleanup();
    function PushTableForSet(AName: array of string; AIndex: Integer; var AStackIndex: Integer; var AFieldNameIndex: Integer): Boolean;
    function PushTableForGet(AName: array of string; AIndex: Integer; var AStackIndex: Integer; var AFieldNameIndex: Integer): Boolean;
  public
    constructor Create(ALua: TlgLua);
    destructor Destroy(); override;
    function ArgCount(): Integer;
    function PushCount(): Integer;
    procedure ClearStack();
    procedure PopStack(ACount: Integer);
    function  GetStackType(AIndex: Integer): TlgLuaType;
    function  GetValue(AType: TlgLuaValueType; AIndex: Integer): TlgLuaValue; overload;
    procedure PushValue(AValue: TlgLuaValue); overload;
    procedure SetTableFieldValue(const AName: string; AValue: TlgLuaValue; AIndex: Integer); overload;
    function  GetTableFieldValue(const AName: string; AType: TlgLuaValueType; AIndex: Integer): TlgLuaValue; overload;
    procedure SetTableIndexValue(const AName: string; AValue: TlgLuaValue; AIndex: Integer; AKey: Integer);
    function  GetTableIndexValue(const AName: string; AType: TlgLuaValueType; AIndex: Integer; AKey: Integer): TlgLuaValue;
  end;

  { TlgLua }
  TlgLua = class(TNoRefCountObject, IlgLua)
  protected
    FState: Pointer;
    FContext: TlgLuaContext;
    FGCStep: Integer;
    procedure Open();
    procedure Close();
    procedure CheckLuaError(const aError: Integer);
    function  PushGlobalTableForSet(aName: array of string; var aIndex: Integer): Boolean;
    function  PushGlobalTableForGet(aName: array of string; var aIndex: Integer): Boolean;
    procedure PushTValue(aValue: TValue);
    function  CallFunction(const aParams: array of TValue): TValue;
    procedure SaveByteCode(aStream: TStream);
    procedure LoadByteCode(aStream: TStream; aName: string; aAutoRun: Boolean = True);
    procedure Bundle(aInFilename: string; aOutFilename: string);
    procedure PushLuaValue(aValue: TlgLuaValue);
    function  GetLuaValue(aIndex: Integer): TlgLuaValue;
    function  DoCall(const aParams: array of TlgLuaValue): TlgLuaValue; overload;
    function  DoCall(aParamCount: Integer): TlgLuaValue; overload;
    procedure CleanStack();
    property  State: Pointer read FState;
    property  Context: TlgLuaContext read FContext;
  public
    constructor Create(); virtual;
    destructor Destroy(); override;

    // misc
    procedure Reset;

    // loading
    procedure LoadStream(aStream: TStream; aSize: NativeUInt = 0; aAutoRun: Boolean = True);
    function  LoadFile(const aFilename: string; aAutoRun: Boolean = True): Boolean;
    procedure LoadString(const aData: string; aAutoRun: Boolean = True);
    procedure LoadBuffer(aData: Pointer; aSize: NativeUInt; aAutoRun: Boolean = True);

    // execution
    function  Call(const aName: string; const aParams: array of TlgLuaValue): TlgLuaValue; overload;
    function  PrepCall(const aName: string): Boolean;
    function  Call(aParamCount: Integer): TlgLuaValue; overload;
    procedure Run();

    // routine/variable exists
    function  RoutineExist(const aName: string): Boolean;
    function  VariableExist(const aName: string): Boolean;

    // global variables
    procedure SetVariable(const aName: string; aValue: TlgLuaValue);
    function  GetVariable(const aName: string; aType: TlgLuaValueType): TlgLuaValue;

    // register routine
    procedure RegisterRoutine(const aName: string; aData: Pointer; aCode: Pointer); overload;
    procedure RegisterRoutine(const aName: string; aRoutine: TlgLuaFunction); overload;

    // auto-register routines
    procedure RegisterRoutines(aClass: TClass); overload;
    procedure RegisterRoutines(aObject: TObject); overload;
    procedure RegisterRoutines(const aTables: string; aClass: TClass; const aTableName: string = ''); overload;
    procedure RegisterRoutines(const aTables: string; aObject: TObject; const aTableName: string = ''); overload;

    // garbage collection
    procedure SetGCStepSize(aStep: Integer);
    function  GetGCStepSize(): Integer;
    function  GetGCMemoryUsed(): Integer;
    procedure CollectGarbage();

    // compilation
    procedure CompileToStream(aFilename: string; aStream: TStream; aCleanOutput: Boolean);
  end;

{ === SPRITE ================================================================ }
type
  TlgSprite = class(TlgObject)
  protected type
    { TImageRegion }
    PImageRegion = ^TImageRegion;
    TImageRegion = record
      Rect: TlgRect;
      Page: Integer;
    end;
    { TGroup }
    PGroup = ^TGroup;
    TGroup = record
      Image: array of TImageRegion;
      Count: Integer;
    end;
  protected
    FTextures: array of TlgTexture;
    FGroups: array of TGroup;
    FPageCount: Integer;
    FGroupCount: Integer;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    procedure Clear();
    function LoadPageFromFile(const AFilename: string; AColorKey: PlgColor): Integer;
    function LoadPageFromZipFile(const AZipFile: TlgZipFile; const AFilename: string; AColorKey: PlgColor): Integer;
    function AddGroup(): Integer;
    function GetGroupCount(): Integer;
    function AddImageFromRect(const APage, AGroup: Integer; const ARect: TlgRect; const AXOffset: Integer=0; const AYOffset: Integer=0): Integer;
    function AddImageFromGrid(const APage, AGroup, AGridX, AGridY, AGridWidth, AGridHeight: Integer; const AXOffset: Integer=0; const AYOffset: Integer=0): Integer;
    function AddImages(const APage, AGroup, AColCount, ARowCount, AImageWidth, AImageHeight: Integer; const AXOffset: Integer=0; const AYOffset: Integer=0): Boolean;
    function GetImageCount(const AGroup: Integer): Integer;
    function GetImageWidth(const ANum, AGroup: Integer): Single;
    function GetImageHeight(const ANum, AGroup: Integer): Single;
    function GetImageTexture(const ANum, AGroup: Integer): TlgTexture;
    function GetImageRegion(const ANum, AGroup: Integer): TlgRect;
  end;

{ === ENTITY ================================================================ }
type
  { TEntityOverlap }
  TEntityOverlap = (eoAABB, eoOBB);

  { TlgEntity }
  TlgEntity = class(TlgObject)
  protected
    FSprite: TlgSprite;
    FGroup: Integer;
    FFrame: Integer;
    FFrameSpeed: Single;
    FPos: TlgVec;
    FDir: TlgVec;
    FScale: Single;
    FAngle: Single;
    FAngleOffset : Single;
    FColor: TlgColor;
    FHFlip: Boolean;
    FVFlip: Boolean;
    FLoopFrame: Boolean;
    FWidth: Single;
    FHeight: Single;
    FRadius: Single;
    FFirstFrame: Integer;
    FLastFrame: Integer;
    FShrinkFactor: Single;
    FPivot: TlgPoint;
    FAnchor: TlgPoint;
    FBlend: TlgTextureBlend;
    FFrameTimer: TlgTimer;
  public
    constructor Create(); override;
    destructor Destroy(); override;
    function  Init(const ASprite: TlgSprite; const AGroup: Integer): Boolean;
    function  GetPivot(): TlgPoint;
    procedure SetPivot(const APoint: TlgPoint); overload;
    procedure SetPivot(const X, Y: Single); overload;
    function  GetAnchor(): TlgPoint;
    procedure SetAnchor(const APoint: TlgPoint); overload;
    procedure SetAnchor(const X, Y: Single); overload;
    procedure SetFrameRange(const aFirst, aLast: Integer);
    function  NextFrame(): Boolean;
    function  PrevFrame(): Boolean;
    function  GetFrame(): Integer;
    procedure SetFrame(const AFrame: Integer);
    function  GetFrameSpeed(): Single;
    procedure SetFrameSpeed(const AFrameSpeed: Single);
    function  GetFirstFrame(): Integer;
    function  GetLastFrame(): Integer;
    procedure SetPosAbs(const X, Y: Single);
    procedure SetPosRel(const X, Y: Single);
    function  GetPos(): TlgVec;
    function  GetDir(): TlgVec;
    procedure SetScaleAbs(const AScale: Single);
    procedure SetScaleRel(const AScale: Single);
    function  GetAngle(): Single;
    function  GetAngleOffset(): Single;
    procedure SetAngleOffset(const AAngle: Single);
    procedure RotateAbs(const AAngle: Single);
    procedure RotateRel(const AAngle: Single);
    function  RotateToAngle(const AAngle, ASpeed: Single): Boolean;
    function  RotateToPos(const X, Y, ASpeed: Single): Boolean;
    function  RotateToPosAt(const aSrcX, aSrcY, ADestX, ADestY, ASpeed: Single): Boolean;
    procedure Thrust(const ASpeed: Single);
    procedure ThrustAngle(const AAngle, ASpeed: Single);
    function  ThrustToPos(const aThrustSpeed, ARotSpeed, ADestX, ADestY, ASlowdownDist, AStopDist, AStopSpeed, AStopSpeedEpsilon: Single): Boolean;
    function  IsVisible(const AWindow: TlgWindow): Boolean;
    function  IsFullyVisible(const AWindow: TlgWindow): Boolean;
    function  Overlap(const X, Y, aRadius, aShrinkFactor: Single): Boolean; overload;
    function  Overlap(const AEntity: TlgEntity; const AType: TEntityOverlap=eoAABB): Boolean; overload;
    procedure Render();
    procedure RenderAt(const X, Y: Single);
    function  GetSprite(): TlgSprite;
    function  GetGroup(): Integer;
    function  GetScale(): Single;
    function  GetColor(): TlgColor;
    procedure SetColor(const AColor: TlgColor);
    function  GetBlend(): TlgTextureBlend;
    procedure SetBlend(const AValue: TlgTextureBlend);
    function  GetHFlip(): Boolean;
    procedure SetHFlip(const AFlip: Boolean);
    function  GetVFlip: Boolean;
    procedure SetVFlip(const AFlip: Boolean);
    function  GetLoopFrame(): Boolean;
    procedure SetLoopFrame(const aLoop: Boolean);
    function  GetWidth(): Single;
    function  GetHeight(): Single;
    function  GetRadius(): Single;
    class function New(const ASprite: TlgSprite; const aGroup: Integer): TlgEntity;
  end;

{ === GAME ================================================================== }
type
  { TlgGame }
  TlgGame = class(TlgObject)
  public type
    // hud
    PHud = ^THud;
    THud = record
      Pos: TlgPoint;
      Linespace: Cardinal;
    end;

    // settings
    PSettings = ^TSettings;
    TSettings = record
      // window
      WindowWidth: Cardinal;
      WindowHeight: Cardinal;
      WindowTitle: string;
      WindowClearColor: TlgColor;

      // default font
      DefaultFontSize: Cardinal;
      DefaultFontGlyphs: string;

      // zipfile
      ZipFilePassword: string;
      ZipFilename: string;

      // hud
      HudPos: TlgPoint;
      HudLinespace: Cardinal;
    end;
  protected
    FZipFile: TlgZipFile;
    FWindow: TlgWindow;
    FDefaultFont: TlgFont;
    FSettings: TSettings;
    FHud: THud;
  public
    property Window: TlgWindow read FWindow;
    property DefaultFont: TlgFont read FDefaultFont;
    property ZipFile: TlgZipFile read FZipFile;
    constructor Create(); override;
    destructor Destroy(); override;
    procedure OnDefineSettings(var ASettings: TSettings); virtual;
    function  OnInitSettings(): Boolean; virtual;
    procedure OnQuitSettings(); virtual;
    function  OnStartup(): Boolean; virtual;
    procedure OnShutdown(); virtual;
    procedure OnUpdate(); virtual;
    procedure OnRender(); virtual;
    procedure OnRenderHud(); virtual;
    function  Settings: PSettings;
    function  Hud: PHud;
    procedure HudReset();
    procedure HudPrint(const AColor: TlgColor; const AMsg: string; const AArgs: array of const);
    procedure Run(); virtual;
  end;

  { TlgGameClass }
  TlgGameClass = class of TlgGame;

var
  { Game }
  Game: TlgGame = nil;

{ lgRunGame }
procedure lgRunGame(const AGame: TlgGameClass);

{ =========================================================================== }
var
  Utils: TlgUtils = nil;
  Math: TlgMath = nil;
  Terminal: TlgTerminal = nil;
  Timer: TlgDeterministicTimer = nil;
  TaskList: TlgTaskList = nil;

implementation

{ =========================================================================== }
const
  CDefaultFontResName = '4deb5a2026b646fb9d07983723e66174';

type
  PRGBA = ^TRGBA;
  TRGBA = packed record
    R, G, B, A: Byte;
  end;

procedure ConvertMaskToAlpha(Data: Pointer; Width, Height: Integer; MaskColor: TlgColor);
var
  i: Integer;
  PixelPtr: PRGBA;
begin
  PixelPtr := PRGBA(Data);

  for i := 0 to Width * Height - 1 do
  begin
    if (PixelPtr^.R = Round(MaskColor.Red * 256)) and
       (PixelPtr^.G = Round(MaskColor.Green * 256)) and
       (PixelPtr^.B = Round(MaskColor.Blue * 256)) then
      PixelPtr^.A := 0
    else
      PixelPtr^.A := 255;

    Inc(PixelPtr);
  end;
end;

{ === OBJECT ================================================================ }

{ --- TlgObject ------------------------------------------------------------- }
function TlgObject.GetAttribute(aIndex: Byte): Boolean;
begin
  Result := Boolean(aIndex in FAttributes);
end;

procedure TlgObject.SetAttribute(aIndex: Byte; aValue: Boolean);
begin
  if aValue then
    Include(FAttributes, aIndex)
  else
    Exclude(FAttributes, aIndex);
end;

function TlgObject.GetAttributes: TlgObjectAttributeSet;
begin
  Result := FAttributes;
end;

procedure TlgObject.SetAttributes(aValue: TlgObjectAttributeSet);
begin
  FAttributes := aValue;
end;

constructor TlgObject.Create();
begin
  inherited;
  FOwner := nil;
  FPrev := nil;
  FNext := nil;
  FAttributes := [];
end;

destructor TlgObject.Destroy();
begin
  if Assigned(FOwner) then
  begin
    FOwner.Remove(Self, False);
  end;

  inherited;
end;

function TlgObject.AttributesAreSet(aAttrs: TlgObjectAttributeSet): Boolean;
var
  LAttr: Byte;
begin
  Result := False;
  for LAttr in aAttrs do
  begin
    if LAttr in FAttributes then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TlgObject.OnVisit();
begin
end;

{ --- TlgObjectList --------------------------------------------------------- }
constructor TlgObjectList.Create();
begin
  inherited;
  FHead := nil;
  FTail := nil;
  FCount := 0;
end;

destructor TlgObjectList.Destroy();
begin
  Clean;
  inherited;
end;

procedure TlgObjectList.Add(aObject: TlgObject);
begin
  Utils.EnterCriticalSection();
  try
    if aObject = nil then Exit;

    // check if already on this list
    if aObject.Owner = Self then Exit;

    // remove if on another list
    if aObject.Owner <> nil then
    begin
      aObject.Owner.Remove(aObject, False);
    end;

    aObject.Prev := FTail;
    aObject.Next := nil;
    aObject.Owner := Self;

    if FHead = nil then
      begin
        FHead := aObject;
        FTail := aObject;
      end
    else
      begin
        FTail.Next := aObject;
        FTail := aObject;
      end;

    Inc(FCount);
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgObjectList.Remove(aObject: TlgObject; aDispose: Boolean);
var
  LFlag: Boolean;
begin
  Utils.EnterCriticalSection();
  try
    if aObject = nil then Exit;

    LFlag := False;

    if aObject.Next <> nil then
    begin
      aObject.Next.Prev := aObject.Prev;
      LFlag := True;
    end;

    if aObject.Prev <> nil then
    begin
      aObject.Prev.Next := aObject.Next;
      LFlag := True;
    end;

    if FTail = aObject then
    begin
      FTail := FTail.Prev;
      LFlag := True;
    end;

    if FHead = aObject then
    begin
      FHead := FHead.Next;
      LFlag := True;
    end;

    if LFlag = True then
    begin
      aObject.Owner := nil;
      Dec(FCount);
      if aDispose then
      begin
        aObject.Free;
      end;
    end;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgObjectList.Clean();
var
  LPrev: TlgObject;
  LNext: TlgObject;
begin
  Utils.EnterCriticalSection();
  try
    // get pointer to head
    LPrev := FHead;

    // exit if list is empty
    if LPrev = nil then
      Exit;

    repeat
      // save pointer to next object
      LNext := LPrev.Next;

      Remove(LPrev, True);

      // get pointer to next object
      LPrev := LNext;

    until LPrev = nil;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgObjectList.Clear(aAttrs: TlgObjectAttributeSet);
var
  LPrev: TlgObject;
  LNext: TlgObject;
  LNoAttrs: Boolean;
begin
  Utils.EnterCriticalSection();
  try
    // get pointer to head
    LPrev := FHead;

    // exit if list is empty
    if LPrev = nil then Exit;

    // check if we should check for attrs
    LNoAttrs := Boolean(aAttrs = []);

    repeat
      // save pointer to next object
      LNext := LPrev.Next;

      if LNoAttrs then
        begin
          Remove(LPrev, True);
        end
      else
        begin
          if LPrev.AttributesAreSet(aAttrs) then
          begin
            Remove(LPrev, True);
          end;
        end;

      // get pointer to next object
      LPrev := LNext;

    until LPrev = nil;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgObjectList.Visit(aAttrs: TlgObjectAttributeSet);
var
  LPrev: TlgObject;
  LNext: TlgObject;
  LNoAttrs: Boolean;
begin
  Utils.EnterCriticalSection();
  try
    // get pointer to head
    LPrev := FHead;

    // exit if list is empty
    if LPrev = nil then Exit;

    // check if we should check for attrs
    LNoAttrs := Boolean(aAttrs = []);

    repeat
      // save pointer to next object
      LNext := LPrev.Next;

      if LNoAttrs then
        begin
          LPrev.OnVisit();
        end
      else
        begin
          if LPrev.AttributesAreSet(aAttrs) then
          begin
            LPrev.OnVisit();
          end;
        end;

      // get pointer to next object
      LPrev := LNext;

    until LPrev = nil;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

{ === TASKLIST ============================================================== }

{ --- TlgTaskID ------------------------------------------------------------- }
procedure TlgTaskID.OnVisit();
begin
  if Assigned(FTask) then
    FTask();
end;

{ --- TlgTaskList ----------------------------------------------------------- }
constructor TlgTaskList.Create();
begin
  inherited;
  FHandle := TlgObjectList.Create();
end;

destructor TlgTaskList.Destroy();
begin
  Stop();
  Clear();
  FHandle.Free();
  inherited;
end;

function TlgTaskList.Add(const ATask: TProc): TlgTaskID;
begin
  Utils.EnterCriticalSection();
  try
    Result := TlgTaskID.Create();
    Result.Task := ATask;
    FHandle.Add(Result);
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgTaskList.Remove(const ATaskItem: TlgTaskID);
begin
  Utils.EnterCriticalSection();
  try
    FHandle.Remove(ATaskItem, True);
  finally
    Utils.LeaveCriticalSection();
  end;
end;

function  TlgTaskList.Count(): Integer;
begin
  Result := FHandle.Count;
end;

procedure TlgTaskList.Clear();
begin
  Utils.EnterCriticalSection();
  try
    FHandle.Clean();
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgTaskList.Start();
var
  LThread: TThread;
begin
  Utils.EnterCriticalSection();
  try
    FTerminated := False;
    LThread := TThread.CreateAnonymousThread(
      procedure
      begin
        while not FTerminated do
        begin
          // run tasks
          Exec([]);

          // allow background threads to run
          Sleep(0);
        end;
      end
    );
    LThread.Priority := tpNormal;
    LThread.Start();
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgTaskList.Stop();
begin
  Utils.EnterCriticalSection();
  try
    FTerminated := True;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

procedure TlgTaskList.Exec(AAttrs: TlgObjectAttributeSet);
begin
  FHandle.Visit(AAttrs);
end;

{ === UTILS ================================================================= }

{ --- TlgUtils -------------------------------------------------------------- }
class constructor TlgUtils.Create();
begin
  FCriticalSection := TCriticalSection.Create();
  FillChar(FStaticBuffer, SizeOf(FStaticBuffer), 0);
end;

class destructor TlgUtils.Destroy();
begin
  FCriticalSection.Free();
end;

class function  TlgUtils.GetStaticBufferSize(): Int64;
begin
  Result := CStaticBufferSize;
end;

class function  TlgUtils.GetStaticBuffer(): PByte;
begin
  Result := @FStaticBuffer[0];
end;

class procedure  TlgUtils.ClearStaticBuffer();
begin
  FillChar(FStaticBuffer, SizeOf(FStaticBuffer), 0);
end;

class procedure TlgUtils.EnterCriticalSection();
begin
  FCriticalSection.Enter();
end;

class procedure TlgUtils.LeaveCriticalSection();
begin
  FCriticalSection.Leave();
end;

class procedure TlgUtils.SetDefaultIcon(AWindow: HWND);
var
  IconHandle: HICON;
begin
  IconHandle := LoadIcon(HInstance, 'MAINICON');
  if IconHandle <> 0 then
  begin
    SendMessage(aWindow, WM_SETICON, ICON_BIG, IconHandle);
  end;
end;

class procedure TlgUtils.SetDefaultIcon(AWindow: PGLFWwindow);
begin
  SetDefaultIcon(glfwGetWin32Window(AWindow))
end;

class function TlgUtils.RemoveDuplicates(const aText: string): string;
var
  i, l: integer;
begin
  Result := '';
  l := Length(aText);
  for i := 1 to l do
  begin
    if (Pos(aText[i], result) = 0) then
    begin
      result := result + aText[i];
    end;
  end;
end;

class function  TlgUtils.ResourceExists(aInstance: THandle; const aResName: string): Boolean;
begin
  Result := Boolean((FindResource(aInstance, PChar(aResName), RT_RCDATA) <> 0));
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

class function  TlgMath.Point(const X, Y: Single): TlgPoint;
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
var
  LAngle: Cardinal;
begin
  LAngle := Cardinal(EnsureRange(AAngle, 0, 360));
  Result := FSinTable[LAngle];
end;

class function  TlgMath.AngleCos(const AAngle: Cardinal): Single;
var
  LAngle: Cardinal;
begin
  LAngle := Cardinal(EnsureRange(AAngle, 0, 360));
  Result := FCosTable[LAngle];
end;

class function  TlgMath.RandomRange(const AFrom, ATo: Integer): Integer;
begin
  Result := System.Math.RandomRange(AFrom, ATo + 1);
end;

class function  TlgMath.RandomRange(const AFrom, ATo: Double): Double;
var
  LNum: Single;
begin
  LNum := RandomRange(0, MaxInt-1) / MaxInt;
  Result := AFrom + (LNum * (ATo - AFrom));
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
  LC := ADestAngle - ASrcAngle - (floor((ADestAngle - ASrcAngle) / 360.0) * 360.0);

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
        AValue := (AMin + Abs(AValue - AMax))-1;
        if AValue > AMax then
          AValue := AMax;
      end
      else if (AValue < AMin) then
      begin
        AValue := (AMax - Abs(AValue - AMin))+1;
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
        AValue := (AMin + Abs(AValue - AMax))-1;
        if AValue > AMax then
          AValue := AMax;
      end
      else if (AValue < AMin) then
      begin
        AValue := (AMax - Abs(AValue - AMin))+1;
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
        AValue := (AMin + Abs(AValue - AMax))-1;
        if AValue > AMax then
          AValue := AMax;
      end
      else if (AValue < AMin) then
      begin
        AValue := (AMax - Abs(AValue - AMin))+1;
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

class function  TlgMath.OBBIntersect(const AObbA, AObbB: TlgOBB): Boolean;
var
  LAxes: array[0..3] of TlgPoint;
  I: Integer;
  LProjA, LProjB: TlgPoint;

  function Dot(const A, B: TlgPoint): Single;
  begin
    Result := A.x * B.x + A.y * B.y;
  end;

  function Rotate(const V: TlgPoint; AAngle: Single): TlgPoint;
  var
    s, c: Single;
  begin
    s := Math.AngleSin(Round(AAngle));
    c := Math.AngleCos(Round(AAngle));
    Result.x := V.x * c - V.y * s;
    Result.y := V.x * s + V.y * c;
  end;

  function Project(const AObb: TlgOBB; const AAxis: TlgPoint): TlgPoint;
  var
    LCorners: array[0..3] of TlgPoint;
    I: Integer;
    LDot: Single;
  begin
    LCorners[0] := Rotate(Math.Point(AObb.Extents.x, AObb.Extents.y), AObb.Rotation);
    LCorners[1] := Rotate(Math.Point(-AObb.Extents.x, AObb.Extents.y), AObb.Rotation);
    LCorners[2] := Rotate(Math.Point(AObb.Extents.x, -AObb.Extents.y), AObb.Rotation);
    LCorners[3] := Rotate(Math.Point(-AObb.Extents.x, -AObb.Extents.y), AObb.Rotation);

    Result.x := Dot(AAxis, Math.Point(AObb.Center.x + LCorners[0].x, AObb.Center.y + LCorners[0].y));
    Result.y := Result.x;

    for I := 1 to 3 do
    begin
      LDot := Dot(AAxis, Math.Point(AObb.Center.x + LCorners[I].x, AObb.Center.y + LCorners[I].y));
      if LDot < Result.x then Result.x := LDot;
      if LDot > Result.y then Result.y := LDot;
    end;
  end;


begin
  LAxes[0] := Rotate(Math.Point(1, 0), AObbA.Rotation);
  LAxes[1] := Rotate(Math.Point(0, 1), AObbA.Rotation);
  LAxes[2] := Rotate(Math.Point(1, 0), AObbB.Rotation);
  LAxes[3] := Rotate(Math.Point(0, 1), AObbB.Rotation);

  for I := 0 to 3 do
  begin
    LProjA := Project(AObbA, LAxes[I]);
    LProjB := Project(AObbB, LAxes[I]);
    if (LProjA.y < LProjB.x) or (LProjB.y < LProjA.x) then Exit(False);
  end;

  Result := True;
end;

{ === BUFFER ================================================================ }

{ --- TlgVirtualBuffer ------------------------------------------------------ }
procedure TlgVirtualBuffer.Clear;
begin
  if (Memory <> nil) then
  begin
    if not UnmapViewOfFile(Memory) then
      raise Exception.Create('Error deallocating mapped memory');
  end;

  if (FHandle <> 0) then
  begin
    if not CloseHandle(FHandle) then
      raise Exception.Create('Error freeing memory mapping handle');
  end;
end;

constructor TlgVirtualBuffer.Create(aSize: Cardinal);
var
  P: Pointer;
begin
  inherited Create;
  FName := TPath.GetGUIDFileName;
  FHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, aSize, PChar(FName));
  if FHandle = 0 then
    begin
      Clear;
      raise Exception.Create('Error creating memory mapping');
      FHandle := 0;
    end
  else
    begin
      P := MapViewOfFile(FHandle, FILE_MAP_ALL_ACCESS, 0, 0, 0);
      if P = nil then
        begin
          Clear;
          raise Exception.Create('Error creating memory mapping');
        end
      else
        begin
          Self.SetPointer(P, aSize);
          Position := 0;
        end;
    end;
end;

destructor TlgVirtualBuffer.Destroy;
begin
  Clear;
  inherited;
end;

function TlgVirtualBuffer.Write(const aBuffer; aCount: Longint): Longint;
var
  Pos: Int64;
begin
  if (Position >= 0) and (aCount >= 0) then
  begin
    Pos := Position + aCount;
    if Pos > 0 then
    begin
      if Pos > Size then
      begin
        Result := 0;
        Exit;
      end;
      System.Move(aBuffer, (PByte(Memory) + Position)^, aCount);
      Position := Pos;
      Result := aCount;
      Exit;
    end;
  end;
  Result := 0;
end;

function TlgVirtualBuffer.Write(const aBuffer: TBytes; aOffset, aCount: Longint): Longint;
var
  Pos: Int64;
begin
  if (Position >= 0) and (aCount >= 0) then
  begin
    Pos := Position + aCount;
    if Pos > 0 then
    begin
      if Pos > Size then
      begin
        Result := 0;
        Exit;
      end;
      System.Move(aBuffer[aOffset], (PByte(Memory) + Position)^, aCount);
      Position := Pos;
      Result := aCount;
      Exit;
    end;
  end;
  Result := 0;
end;

procedure TlgVirtualBuffer.SaveToFile(aFilename: string);
var
  LStream: TFileStream;
begin
  LStream := TFile.Create(aFilename);
  try
    LStream.Write(Memory^, Size);
  finally
    LStream.Free;
  end;
end;

class function TlgVirtualBuffer.LoadFromFile(const aFilename: string): TlgVirtualBuffer;
var
  LStream: TStream;
  LBuffer: TlgVirtualBuffer;
begin
  Result := nil;
  if aFilename.IsEmpty then Exit;
  if not TFile.Exists(aFilename) then Exit;
  LStream := TFile.OpenRead(aFilename);
  try
    LBuffer := TlgVirtualBuffer.Create(LStream.Size);
    if LBuffer <> nil then
    begin
      LBuffer.CopyFrom(LStream);
    end;
  finally
    FreeAndNil(LStream);
  end;
  Result := LBuffer;
end;

function  TlgVirtualBuffer.Eof: Boolean;
begin
  Result := Boolean(Position >= Size);
end;

function  TlgVirtualBuffer.ReadString: WideString;
var
  LLength: LongInt;
begin
  Read(LLength, SizeOf(LLength));
  SetLength(Result, LLength);
  if LLength > 0 then Read(Result[1], LLength * SizeOf(Char));
end;

{ --- TlgRingBuffer --------------------------------------------------------- }
constructor TlgRingBuffer<T>.Create(ACapacity: Integer);
begin
  SetLength(FBuffer, ACapacity);
  FReadIndex := 0;
  FWriteIndex := 0;
  FCapacity := ACapacity;
  Clear;
end;

function TlgRingBuffer<T>.Write(const AData: array of T;
  ACount: Integer): Integer;
var
  i, WritePos: Integer;
begin
  Utils.EnterCriticalSection();
  try
    for i := 0 to ACount - 1 do
    begin
      WritePos := (FWriteIndex + i) mod FCapacity;
      FBuffer[WritePos] := AData[i];
    end;
    FWriteIndex := (FWriteIndex + ACount) mod FCapacity;
    Result := ACount;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

function TlgRingBuffer<T>.Read(var AData: array of T; ACount: Integer): Integer;
var
  i, ReadPos: Integer;
begin
  for i := 0 to ACount - 1 do
  begin
    ReadPos := (FReadIndex + i) mod FCapacity;
    AData[i] := FBuffer[ReadPos];
  end;
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
  Result := ACount;
end;

function TlgRingBuffer<T>.DirectReadPointer(ACount: Integer): Pointer;
begin
  Result := @FBuffer[FReadIndex mod FCapacity];
  FReadIndex := (FReadIndex + ACount) mod FCapacity;
end;

function TlgRingBuffer<T>.AvailableBytes: Integer;
begin
  Result := (FCapacity + FWriteIndex - FReadIndex) mod FCapacity;
end;

procedure TlgRingBuffer<T>.Clear;
var
  I: Integer;
begin
  Utils.EnterCriticalSection();
  try
    for I := Low(FBuffer) to High(FBuffer) do
    begin
     FBuffer[i] := Default(T);
    end;

    FReadIndex := 0;
    FWriteIndex := 0;
  finally
    Utils.LeaveCriticalSection();
  end;
end;

{ === TERMINAL ============================================================== }
class constructor TlgTerminal.Create();
begin
end;

class destructor TlgTerminal.Destroy();
begin
end;

class function  TlgTerminal.HasConsoleOutput(): Boolean;
var
  LStdOut: THandle;
  LMode: DWORD;
begin
  LStdOut := GetStdHandle(STD_OUTPUT_HANDLE);
  Result := (LStdOut <> INVALID_HANDLE_VALUE) and
            GetConsoleMode(LStdOut, LMode);
end;

class function  TlgTerminal.WasRunFromConsole(): Boolean;
var
  LStartupInfo: TStartupInfo;
begin
  LStartupInfo.cb := SizeOf(TStartupInfo);
  GetStartupInfo(LStartupInfo);
  Result := ((LStartupInfo.dwFlags and STARTF_USESHOWWINDOW) = 0);
end;

class function  TlgTerminal.IsStartedFromDelphiIDE(): Boolean;
begin
  // Check if the IDE environment variable is present
  Result := (GetEnvironmentVariable('BDS') <> '');
end;

class procedure TlgTerminal.SetTitle(const AMsg: string; const AArgs: array of const);
var
  LTitle: string;
begin
  LTitle := Format(AMsg, AArgs);
  WinApi.Windows.SetConsoleTitle(PChar(LTitle));
end;

class procedure TlgTerminal.Print(const AMsg: string; const AArgs: array of const);
begin
  if not HasConsoleOutput then Exit;
  Write(Format(aMsg, aArgs));
end;

class procedure TlgTerminal.Print(const AMsg: string);
begin
  Print(AMsg, []);
end;

class procedure TlgTerminal.PrintLn(const AMsg: string; const AArgs: array of const);
begin
  if not HasConsoleOutput then Exit;
  WriteLn(Format(aMsg, aArgs));
end;

class procedure TlgTerminal.PrintLn(const AMsg: string);
begin
  PrintLn(AMsg, []);
end;

class procedure TlgTerminal.Pause(const AMsg: string; const AArgs: array of const);
var
  LDoPause: Boolean;
begin
  if not HasConsoleOutput then Exit;

  ClearKeyStates();
  ClearKeyboardBuffer();

  LDoPause := True;
  if WasRunFromConsole then LDoPause := False;
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

class procedure TlgTerminal.Pause(const AMsg: string='');
begin
  Pause(AMsg, []);
end;

class procedure TlgTerminal.ClearKeyboardBuffer();
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

class procedure TlgTerminal.WaitForAnyKey();
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

class function  TlgTerminal.AnyKeyPressed(): Boolean;
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

class procedure TlgTerminal.ClearKeyStates();
begin
  FillChar(FKeyState, SizeOf(FKeyState), 0);
  ClearKeyboardBuffer;
end;

class function  TlgTerminal.IsKeyPressed(AKey: Byte): Boolean;
begin
  Result := (GetAsyncKeyState(AKey) and $8000) <> 0;
end;

class function  TlgTerminal.KeyWasPressed(AKey: Byte): Boolean;
begin
  Result := False;
  if IsKeyPressed(AKey) and (not FKeyState[0, AKey]) then
  begin
    FKeyState[0, AKey] := True;
    Result := True;
  end
  else if (not IsKeyPressed(AKey)) and (FKeyState[0, AKey]) then
  begin
    FKeyState[0, AKey] := False;
    Result := False;
  end;
end;

class function  TlgTerminal.KeyWasReleased(AKey: Byte): Boolean;
begin
  Result := False;
  if IsKeyPressed(AKey) and (not FKeyState[0, AKey]) then
  begin
    FKeyState[0, AKey] := True;
    Result := False;
  end
  else if (not IsKeyPressed(AKey)) and (FKeyState[0, AKey]) then
  begin
    FKeyState[0, AKey] := False;
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
        Sleep(0);
      end;
    end;
end;

class function  TlgDeterministicTimer.FrameRate(): Cardinal;
begin
  Result := FFramerate;
end;

{ --- TlgTimer -------------------------------------------------------------- }
procedure TlgTimer.InitMS(const AValue: Double);
begin
  FInterval := AValue / 1000.0; // convert milliseconds to seconds
  FLastTime := glfwGetTime;
  FSpeed := AValue;
end;

procedure TlgTimer.InitFPS(const AValue: Double);
begin
  if AValue > 0 then
    FInterval := 1.0 / AValue
  else
    FInterval := 0; // Prevent division by zero if FPS is not positive
  FLastTime := glfwGetTime;
  FSpeed := AValue;
end;

function TlgTimer.Check(): Boolean;
begin
  Result := (glfwGetTime - FLastTime) >= FInterval;
  if Result then
    FLastTime := glfwGetTime; // Auto-reset on check
end;

procedure TlgTimer.Reset();
begin
  FLastTime := glfwGetTime;
end;

function  TlgTimer.Speed(): Double;
begin
  Result := FSpeed;
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

class function TlgMemoryStream.Open(const AData: Pointer; ASize: Int64): TlgMemoryStream;
begin
  Result := nil;
  if not Assigned(AData) then Exit;
  if ASize <= 0 then Exit;

  Result := TlgMemoryStream.Create();
  Result.FHandle.Write(AData^, ASize);
  Result.FHandle.Position := 0;
end;

{ --- TlgFileStream --------------------------------------------------------- }
constructor TlgFileStream.Create();
begin
  inherited;
end;

destructor TlgFileStream.Destroy();
begin
  Close();
  inherited;
end;

procedure TlgFileStream.Close();
begin
  if not Assigned(FHandle) then Exit;
  FHandle.Free();
  FHandle := nil;
end;

function  TlgFileStream.Size(): Int64;
begin
  Result := FHandle.Size;
end;

function  TlgFileStream.Seek(const AOffset: Int64; const ASeek: TlgSeekMode): Int64;
begin
  Result := FHandle.Seek(AOffset, Ord(ASeek));
end;

function  TlgFileStream.Read(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := FHandle.Read(AData^, ASize);
end;

function  TlgFileStream.Write(const AData: Pointer; const ASize: Int64): Int64;
begin
  Result := FHandle.Write(AData^, ASize);
end;

function  TlgFileStream.Tell(): Int64;
begin
  Result := FHandle.Position;
end;

function  TlgFileStream.Eos(): Boolean;
begin
  Result := Boolean(Tell() >= Size());
end;

function TlgFileStream.DoOpen(const AFilename: string; const AMode: TlgStreamMode): Boolean;
begin
  Result := False;
  if AFilename.IsEmpty then Exit;

  try
    case AMode of
      smRead:
      begin
        FHandle := TFile.OpenRead(AFilename);
        FMode := AMode;
      end;

      smWrite:
      begin
        FHandle := TFile.OpenWrite(AFilename);
        FMode := AMode;
      end;
    end;
  except
    FHandle := nil;
  end;

  Result := True;
end;

class function TlgFileStream.Open(const AFilename: string; const AMode: TlgStreamMode): TlgFileStream;
begin
  Result := TlgFileStream.Create();
  if not Result.DoOpen(AFilename, AMode) then
  begin
    Result.Free();
    Result := nil;
  end;
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
      if LBytesToRead > Utils.GetStaticBufferSize() then
        unzReadCurrentFile(FHandle, Utils.GetStaticBuffer(), Utils.GetStaticBufferSize())
      else
        unzReadCurrentFile(FHandle, Utils.GetStaticBuffer(), LBytesToRead);

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
  if aNewFile then Terminal.PrintLn('');
  Terminal.Print(#13+'Adding %s(%d%s)...', [ExtractFileName(string(aFilename)), aProgress, '%']);
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
      LBytesRead := AStream.Read(Utils.GetStaticBuffer()^, Utils.GetStaticBufferSize());
      Result := crc32(Result, PBytef(Utils.GetStaticBuffer()), LBytesRead);
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
          LBytesRead := LFile.Read(Utils.GetStaticBuffer()^, Utils.GetStaticBufferSize());

          // write buffer out to zip file
          zipWriteInFileInZip(LZipFile, Utils.GetStaticBuffer(), LBytesRead);

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

{ === ZIPFILE =============================================================== }
constructor TlgZipFile.Create();
begin
  inherited;
end;

destructor TlgZipFile.Destroy();
begin
  Close();
  inherited;
end;

function  TlgZipFile.Open(const AZipFilename: string; const APassword: string=TlgZipStream.DEFAULT_PASSWORD): Boolean;
var
  LZipFilename: PAnsiChar;
  LFile: unzFile;
begin
  Result := False;

  if FIsOpen then Exit;

  LZipFilename := PAnsiChar(AnsiString(StringReplace(string(AZipFilename), '/', '\', [rfReplaceAll])));

  LFile := unzOpen64(LZipFilename);
  if not Assigned(LFile) then Exit;

  unzClose(LFile);

  FZipFilename := AZipFilename;
  FPassword := APassword;
  FIsOpen := True;

  Result := True;
end;

function  TlgZipFile.IsOpen(): Boolean;
begin
  Result := FIsOpen;
end;

procedure TlgZipFile.Close();
begin
  FZipFilename := '';
  FPassword := '';
  FIsOpen := False;
end;

function  TlgZipFile.OpenFile(const AFilename: string): TlgZipStream;
begin
  Result := TlgZipStream.Open(FZipFilename, AFilename, FPassword);
end;

class function TlgZipFile.Init(const AZipFilename: string; const APassword: string=TlgZipStream.DEFAULT_PASSWORD): TlgZipFile;
begin
  Result := TlgZipFile.Create();
  if not Result.Open(AZipFilename, APassword) then
  begin
    Result.Free();
    Result := nil;
  end;
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
  //FSounds := TlgLinkedList<TlgSound>.Create();
  //FOneShotSounds := TList<TlgSound>.Create();
  FSoundList := TlgObjectList.Create();
end;

destructor TlgAudio.Destroy();
begin
  Close();
  FSoundList.Free();
  //FOneShotSounds.Free();
  //FSounds.Free();
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

  FTaskID := TaskList.Add(
    procedure
    begin
      Update();
    end
  );

  Result := IsOpen();
end;

function TlgAudio.IsOpen(): Boolean;
begin
  Result := Boolean(alcGetCurrentContext <> nil);
end;

procedure TlgAudio.Close();
begin
  if not IsOpen then Exit;

  TaskList.Remove(FTaskID);

  // free any dangling sounds
  //FSounds.Clear(True);
  FSoundList.Clean();

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
  //FSounds.Clear(True);
  //FOneShotSounds.Clear();
  FSoundList.Clean();

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

(*
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
*)

procedure TlgAudio.Update();
begin
  if not IsOpen() then Exit;

  FSoundList.Visit([]);
  FSoundList.Clear([ATTR_ONESHOT])
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
  //FAudio.FSounds.Add(Self);
  FAudio.FSoundList.Add(Self);
end;

destructor TlgSound.Destroy();
begin
  // remove self from audio sounds list
  FAudio.FSoundList.Remove(Self, False);
  //FAudio.FSounds.Remove(Self);
  Unload();
  inherited;
end;

procedure TlgSound.OnVisit();
begin
  Update();
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
        AStream.Read(Utils.GetStaticBuffer(), Utils.GetStaticBufferSize());
        FStream.Write(Utils.GetStaticBuffer(), Utils.GetStaticBufferSize());
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
  if FOneShot then Self.SetAttribute(FAudio.ATTR_ONESHOT, True);

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

class function TlgSound.LoadFromFile(const AAudio: TlgAudio; const AFilename: string; const ALoad: TlgSoundLoad; const AOneShot: Boolean=False): TlgSound;
var
  LStream: TlgStream;
begin
  Result := nil;
  if not Assigned(AAudio) then Exit;
  if AFilename.IsEmpty then Exit;

  Result := TlgSound.Create(AAudio);
  LStream := TlgFileStream.Open(AFilename, smRead);
  if not Assigned(LStream) then
  begin
    Result.Free();
    Exit;
  end;

  if not Result.Load(LStream, ALoad, AOneShot) then
  begin
    LStream.Free();
    Result.Free();
    Result := nil;
    Exit;
  end;
  if ALoad = slMemory then
    LStream.Free();
end;

class function TlgSound.LoadFromZipFile(const AAudio: TlgAudio; const AZipFile: TlgZipFile; const AFilename: string; const ALoad: TlgSoundLoad; const AOneShot: Boolean=False): TlgSound;
var
  LStream: TlgStream;
begin
  Result := nil;
  if not Assigned(AAudio) then Exit;
  if not Assigned(AZipFile) then Exit;
  if not AZipFile.IsOpen() then Exit;
  if AFilename.IsEmpty then Exit;

  if AFilename.IsEmpty then Exit;

  Result := TlgSound.Create(AAudio);
  LStream := AZipFile.OpenFile(AFilename);
  if not Assigned(LStream) then
  begin
    Result.Free();
    Exit;
  end;

  if not Result.Load(LStream, ALoad, AOneShot) then
  begin
    LStream.Free();
    Result.Free();
    Result := nil;
    Exit;
  end;
  if ALoad = slMemory then
    LStream.Free();
end;

{ === WINDOW ================================================================ }

{ --- TlgWindow ------------------------------------------------------------- }
procedure  TlgWindow_OnSize(AWindow: PGLFWwindow; AWidth: Integer; AHeight: Integer); cdecl;
var
  LWindow: TlgWindow;
begin
  LWindow := glfwGetWindowUserPointer(AWindow);
  LWindow.FScaledSize.Width := AWidth;
  LWindow.FScaledSize.Height := AHeight;
end;

procedure TlgWindow_OnContentScale(AWindow: PGLFWwindow; AXScale: Single; AYScale: Single); cdecl;
var
  LWindow: TlgWindow;
begin
  LWindow := glfwGetWindowUserPointer(AWindow);
  LWindow.FScale.x := AXScale;
  LWindow.FScale.y := AXScale;
end;

constructor TlgWindow.Create();
begin
  inherited;
end;

destructor TlgWindow.Destroy();
begin
  Close();
  inherited;
end;

function  TlgWindow.Open(const aTitle: string; const AWidth: Integer; const AHeight: Integer; const AEnableVSync: Boolean): Boolean;
var
  VideoMode: PGLFWvidmode;
  LWidth, LHeight: Integer;
begin
  Result := False;

  if Assigned(FHandle) then Exit;

  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1);
  glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);
  glfwWindowHint(GLFW_SCALE_TO_MONITOR, GLFW_TRUE);

  glfwWindowHint(GLFW_SAMPLES, 4);

  FHandle := glfwCreateWindow(AWidth, AHeight, Utils.Marshal.AsUtf8(ATitle).ToPointer, nil, nil);
  if not Assigned(FHandle) then Exit;
  glfwSetWindowUserPointer(FHandle, Self);
  glfwSetWindowSizeCallback(FHandle, TlgWindow_OnSize);
  glfwSetWindowContentScaleCallback(FHandle,TlgWindow_OnContentScale);
  Utils.SetDefaultIcon(FHandle);
  VideoMode := glfwGetVideoMode(glfwGetPrimaryMonitor);
  glfwGetWindowSize(FHandle, @LWidth, @LHeight);
  glfwSetWindowPos(FHandle, (VideoMode.width - LWidth) div 2, (VideoMode.height - LHeight) div 2);
  glfwMakeContextCurrent(FHandle);

  SetVSync(AEnableVSync);

  if not LoadOpenGL then
  begin
    glfwDestroyWindow(FHandle);
    FHandle := nil;
    Exit;
  end;

  // Enable Line Smoothing
  glEnable(GL_LINE_SMOOTH);
  glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);

  // Enable Polygon Smoothing
  glEnable(GL_POLYGON_SMOOTH);
  glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);

  // Enable Point Smoothing
  glEnable(GL_POINT_SMOOTH);
  glHint(GL_POINT_SMOOTH_HINT, GL_NICEST);

  // Enable Multisampling for anti-aliasing (if supported)
  glEnable(GL_MULTISAMPLE);

  FSize.Width := AWidth;
  FSize.Height := AHeight;

  FScaledSize.Width := LWidth;
  FScaledSize.Height := LHeight;

  glfwGetWindowContentScale(FHandle, @FScale.X, @FScale.Y);

  glGetIntegerv(GL_MAX_TEXTURE_SIZE, @FMaxTextureSize);

  glfwSetInputMode(FHandle, GLFW_STICKY_KEYS, GLFW_TRUE);
  glfwSetInputMode(FHandle, GLFW_STICKY_MOUSE_BUTTONS, GLFW_TRUE);

  SetMousePos(0,0);

  Self.ClearInput();

  Result := True;
end;

function  TlgWindow.IsOpen(): Boolean;
begin
  Result := False;
  if not Assigned(FHandle) then Exit;
  if glfwGetCurrentContext() <> FHandle then Exit;
  Result := True;
end;

procedure TlgWindow.Close();
begin
  if Assigned(FHandle) then
  begin
    glfwMakeContextCurrent(nil);
    glfwDestroyWindow(FHandle);
    FHandle := nil;
  end;
  FSize := Math.Size(0, 0);
  FScaledSize := Math.Size(0, 0);
  FScale := Math.Point(0,0);
end;

function  TlgWindow.Ready(): Boolean;
begin
  Result := False;
  if not IsOpen then Exit;
  Result := True;
end;

function  TlgWindow.GetVSync(): Boolean;
begin
  Result := FVsync;
end;

procedure TlgWindow.SetVSync(const AEnable: Boolean);
begin
  if AEnable then
    glfwSwapInterval(1)
  else
    glfwSwapInterval(0);
  FVSync := AEnable;
end;

function  TlgWindow.GetHandle(): PGLFWwindow;
begin
  Result := FHandle;
end;

function  TlgWindow.GetMaxTextureSize(): Integer;
begin
  Result := FMaxTextureSize;
end;

function  TlgWindow.GetTitle(): string;
var
  LHwnd: HWND;
  LLen: Integer;
  LTitle: PChar;
begin
  Result := '';
  if not IsOpen then Exit;
  LHwnd := glfwGetWin32Window(FHandle);
  LLen := GetWindowTextLength(LHwnd);
  GetMem(LTitle, LLen + 1);
  try
    GetWindowText(LHwnd, LTitle, LLen + 1);
    Result := StrPas(LTitle);
  finally
    FreeMem(LTitle);
  end;
end;

procedure TlgWindow.SetTitle(const ATitle: string);
begin
  if not IsOpen then Exit;
  SetWindowText(glfwGetWin32Window(FHandle), ATitle);
end;

function  TlgWindow.ShouldClose(): Boolean;
begin
  Result := True;
  if not IsOpen then Exit;
  Result := Boolean(glfwWindowShouldClose(FHandle));
end;

procedure TlgWindow.SetShouldClose(const AValue: Boolean);
begin
  glfwSetWindowShouldClose(FHandle, Ord(AValue));
end;

procedure TlgWindow.GetSize(var ASize: TlgSize);
begin
  ASize := FSize;
end;

procedure TlgWindow.GetScaledSize(var ASize: TlgSize);
begin
  ASize := FScaledSize;
end;

procedure TlgWindow.GetScale(var AScale: TlgPoint);
begin
  AScale := FScale;
end;

procedure TlgWindow.GetViewport(var AViewport: TlgRect);
begin
  AViewport.X := 0;
  AViewport.Y := 0;
  AViewport.Width := Self.FSize.Width;
  AViewport.Height := Self.FSize.Height;
  //AViewport.Width := Self.FScaledSize.Width;
  //AViewport.Height := Self.FScaledSize.Height;
end;

procedure TlgWindow.GetViewport(X, Y, AWidth, AHeight: PSingle);
var
  LViewport: TlgRect;
begin
  GetViewport(LViewport);
  if Assigned(X) then X^ := LViewport.X;
  if Assigned(Y) then Y^ := LViewport.Y;
  if Assigned(AWidth) then AWidth^ := LViewport.Width;
  if Assigned(AHeight) then AHeight^ := LViewport.Height;
end;

procedure TlgWindow.Clear(const AColor: TlgColor);
begin
  Clear(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);
end;

procedure TlgWindow.Clear(const ARed, AGreen, ABlue, AAlpha: Single);
begin
  if not IsOpen then Exit;
 glClearColor(ARed, AGreen, ABlue, AAlpha);
end;

procedure TlgWindow.StartFrame();
begin
  Timer.Start();
end;

procedure TlgWindow.EndFrame();
begin
  Timer.Stop();
end;

procedure TlgWindow.StartDrawing();
begin
  if not IsOpen then Exit;

  glViewport(0, 0, Round(FScaledSize.Width), Round(FScaledSize.Height));
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glOrtho(0, FScaledSize.Width, FScaledSize.Height, 0, -1, 1);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glScalef(FScale.X, FScale.Y, 1.0);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
end;

procedure TlgWindow.EndDrawing();
begin
  if not IsOpen then Exit;

  glfwSwapBuffers(FHandle);
  glfwPollEvents;
end;

procedure TlgWindow.DrawLine(const X1, Y1, X2, Y2: Single; const AColor: TlgColor; const AThickness: Single);
begin
  if not IsOpen then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);
  glBegin(GL_LINES);
    glVertex2f(X1, Y1);
    glVertex2f(X2, Y2);
  glEnd;
end;

procedure TlgWindow.DrawRect(const X, Y, AWidth, AHeight, AThickness: Single; const AColor: TlgColor; const AAngle: Single);
var
  HalfWidth, HalfHeight: Single;
begin
  if not IsOpen then Exit;

  HalfWidth := AWidth / 2;
  HalfHeight := AHeight / 2;

  glLineWidth(AThickness);
  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);

  glPushMatrix;  // Save the current matrix

  // Translate to the center point
  glTranslatef(X, Y, 0);

  // Rotate around the center
  glRotatef(AAngle, 0, 0, 1);

  glBegin(GL_LINE_LOOP);
    glVertex2f(-HalfWidth, -HalfHeight);      // Bottom-left corner
    glVertex2f(HalfWidth, -HalfHeight);       // Bottom-right corner
    glVertex2f(HalfWidth, HalfHeight);        // Top-right corner
    glVertex2f(-HalfWidth, HalfHeight);       // Top-left corner
  glEnd;

  glPopMatrix;  // Restore the original matrix
end;

procedure TlgWindow.DrawFilledRect(const X, Y, AWidth, AHeight: Single; const AColor: TlgColor; const AAngle: Single);
var
  HalfWidth, HalfHeight: Single;
begin
  if not IsOpen then Exit;

  HalfWidth := AWidth / 2;
  HalfHeight := AHeight / 2;

  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);

  glPushMatrix;  // Save the current matrix

  // Translate to the center point
  glTranslatef(X, Y, 0);

  // Rotate around the center
  glRotatef(AAngle, 0, 0, 1);

  glBegin(GL_QUADS);
    glVertex2f(-HalfWidth, -HalfHeight);      // Bottom-left corner
    glVertex2f(HalfWidth, -HalfHeight);       // Bottom-right corner
    glVertex2f(HalfWidth, HalfHeight);        // Top-right corner
    glVertex2f(-HalfWidth, HalfHeight);       // Top-left corner
  glEnd;

  glPopMatrix;  // Restore the original matrix
end;


procedure TlgWindow.DrawCircle(const X, Y, ARadius, AThickness: Single; const AColor: TlgColor);
var
  I: Integer;
  LX, LY: Single;
begin
  if not IsOpen then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);
  glBegin(GL_LINE_LOOP);
    LX := X{ + ARadius};
    LY := Y{ + ARadius};
    for I := 0 to 360 do
    begin
      glVertex2f(LX + ARadius * Math.AngleCos(I), LY - ARadius * Math.AngleSin(I));
    end;
  glEnd;
end;

procedure TlgWindow.DrawFilledCircle(const X, Y, ARadius: Single; const AColor: TlgColor);
var
  I: Integer;
  LX, LY: Single;
begin
  if not IsOpen then Exit;

  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);
  glBegin(GL_TRIANGLE_FAN);
    LX := X{ + ARadius};
    LY := Y{ + ARadius};
    glVertex2f(LX, LY);
    for i := 0 to 360 do
    begin
      glVertex2f(LX + ARadius * Math.AngleCos(i), LY + ARadius * Math.AngleSin(i));
    end;
  glEnd;
end;

procedure TlgWindow.DrawTriangle(const X1, Y1, X2, Y2, X3, Y3, AThickness: Single; const AColor: TlgColor);
begin
  if not IsOpen then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);
  glBegin(GL_LINE_LOOP);
    glVertex2f(X1, Y1);
    glVertex2f(X2, Y2);
    glVertex2f(X3, Y3);
  glEnd;
end;

procedure TlgWindow.DrawFilledTriangle(const X1, Y1, X2, Y2, X3, Y3: Single; const AColor: TlgColor);
begin
  if not IsOpen then Exit;

  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);
  glBegin(GL_TRIANGLES);
    glVertex2f(X1, Y1);
    glVertex2f(X2, Y2);
    glVertex2f(X3, Y3);
  glEnd;
end;

procedure TlgWindow.DrawPolygon(const APoints: array of TlgPoint; const AThickness: Single; const AColor: TlgColor);
var
  I: Integer;
begin
  if not IsOpen then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);
  glBegin(GL_LINE_LOOP);
    for i := Low(APoints) to High(APoints) do
    begin
      glVertex2f(APoints[i].X, APoints[i].Y);
    end;
  glEnd;
end;

procedure TlgWindow.DrawFilledPolygon(const APoints: array of TlgPoint; const AColor: TlgColor);
var
  I: Integer;
begin
  if not IsOpen then Exit;

  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);
  glBegin(GL_POLYGON);
  for I := Low(APoints) to High(APoints) do
    begin
      glVertex2f(APoints[i].X, APoints[i].Y);
    end;
  glEnd;
end;

procedure TlgWindow.DrawPolyline(const APoints: array of TlgPoint; const AThickness: Single; const AColor: TlgColor);
var
  I: Integer;
begin
  if not IsOpen then Exit;

  glLineWidth(AThickness);
  glColor4f(AColor.Red, AColor.Green, AColor.Blue, AColor.Alpha);
  glBegin(GL_LINE_STRIP);
    for I := Low(APoints) to High(APoints) do
    begin
      glVertex2f(APoints[i].X, APoints[i].Y);
    end;
  glEnd;
end;

procedure TlgWindow.ClearInput();
begin
  FillChar(FKeyState, SizeOf(FKeyState), 0);
  FillChar(FMouseButtonState, SizeOf(FMouseButtonState), 0);
  FillChar(FGamepadButtonState, SizeOf(FGamepadButtonState), 0);
end;

function  TlgWindow.GetKey(const AKey: Integer; const AState: TlgInputState): Boolean;

  function IsKeyPressed(const AKey: Integer): Boolean;
  begin
    Result :=  Boolean(glfwGetKey(FHandle, AKey) = GLFW_PRESS);
  end;

begin
  Result := False;
  if not InRange(AKey,  KEY_SPACE, KEY_LAST) then Exit;

  case AState of
    isPressed:
    begin
      Result :=  IsKeyPressed(AKey);
    end;

    isWasPressed:
    begin
      if IsKeyPressed(AKey) and (not FKeyState[0, AKey]) then
      begin
        FKeyState[0, AKey] := True;
        Result := True;
      end
      else if (not IsKeyPressed(AKey)) and (FKeyState[0, AKey]) then
      begin
        FKeyState[0, AKey] := False;
        Result := False;
      end;
    end;

    isWasReleased:
    begin
      if IsKeyPressed(AKey) and (not FKeyState[0, AKey]) then
      begin
        FKeyState[0, AKey] := True;
        Result := False;
      end
      else if (not IsKeyPressed(AKey)) and (FKeyState[0, AKey]) then
      begin
        FKeyState[0, AKey] := False;
        Result := True;
      end;
    end;
  end;
end;

function  TlgWindow.GetMouseButton(const AButton: Byte; const AState: TlgInputState): Boolean;

  function IsButtonPressed(const AKey: Integer): Boolean;
  begin
    Result :=  Boolean(glfwGetMouseButton(FHandle, AButton) = GLFW_PRESS);
  end;

begin
  Result := False;
  if not InRange(AButton,  MOUSE_BUTTON_1, MOUSE_BUTTON_MIDDLE) then Exit;

  case AState of
    isPressed:
    begin
      Result :=  IsButtonPressed(AButton);
    end;

    isWasPressed:
    begin
      if IsButtonPressed(AButton) and (not FMouseButtonState[0, AButton]) then
      begin
        FMouseButtonState[0, AButton] := True;
        Result := True;
      end
      else if (not IsButtonPressed(AButton)) and (FMouseButtonState[0, AButton]) then
      begin
        FMouseButtonState[0, AButton] := False;
        Result := False;
      end;
    end;

    isWasReleased:
    begin
      if IsButtonPressed(AButton) and (not FMouseButtonState[0, AButton]) then
      begin
        FMouseButtonState[0, AButton] := True;
        Result := False;
      end
      else if (not IsButtonPressed(AButton)) and (FMouseButtonState[0, AButton]) then
      begin
        FMouseButtonState[0, AButton] := False;
        Result := True;
      end;
    end;
  end;
end;

procedure TlgWindow.GetMousePos(const X, Y: PSingle);
var
  LX, LY: Double;
begin
  glfwGetCursorPos(FHandle, @LX, @LY);
  if Assigned(X) then X^ := LX;
  if Assigned(Y) then Y^ := LY;
end;

function  TlgWindow.GetMousePos(): TlgPoint;
begin
  GetMousePos(@Result.x, @Result.y);
  Result.x := Result.x/FScale.x;
  Result.y := Result.y/FScale.y;
end;

procedure TlgWindow.SetMousePos(const X, Y: Single);
begin
  glfwSetCursorPos(FHandle, X*FScale.x, Y*FScale.y);
end;

function  TlgWindow.GamepadPresent(const AGamepad: Byte): Boolean;
begin
  Result := Boolean(glfwJoystickIsGamepad(EnsureRange(Agamepad, GAMEPAD_1, GAMEPAD_LAST)));
end;

function  TlgWindow.GetGamepadName(const AGamepad: Byte): string;
begin
  Result := 'Not present';
  if not GamepadPresent(AGamepad) then Exit;
  Result := string(glfwGetGamepadName(AGamepad));
end;

function  TlgWindow.GetGamepadButton(const AGamepad, AButton: Byte; const AState: TlgInputState): Boolean;
var
  LState: GLFWgamepadstate;

  function IsButtonPressed(const AButton: Byte): Boolean;
  begin
    Result :=  Boolean(LState.buttons[AButton]);
  end;

begin
  Result := False;

  if not Boolean(glfwGetGamepadState(EnsureRange(AGamepad, GAMEPAD_1, GAMEPAD_LAST), @LState)) then Exit;

  case AState of
    isPressed:
    begin
      Result :=  IsButtonPressed(AButton);
    end;

    isWasPressed:
    begin
      if IsButtonPressed(AButton) and (not FGamepadButtonState[0, AButton]) then
      begin
        FGamepadButtonState[0, AButton] := True;
        Result := True;
      end
      else if (not IsButtonPressed(AButton)) and (FGamepadButtonState[0, AButton]) then
      begin
        FGamepadButtonState[0, AButton] := False;
        Result := False;
      end;
    end;

    isWasReleased:
    begin
      if IsButtonPressed(AButton) and (not FGamepadButtonState[0, AButton]) then
      begin
        FGamepadButtonState[0, AButton] := True;
        Result := False;
      end
      else if (not IsButtonPressed(AButton)) and (FGamepadButtonState[0, AButton]) then
      begin
        FGamepadButtonState[0, AButton] := False;
        Result := True;
      end;
    end;
  end;
end;

function  TlgWindow.GetGamepadAxisValue(const AGamepad, AAxis: Byte): Single;
var
  LState: GLFWgamepadstate;
begin
  Result := 0;
  if not Boolean(glfwGetGamepadState(EnsureRange(AGamepad, GAMEPAD_1, GAMEPAD_LAST), @LState)) then Exit;
  Result := LState.axes[EnsureRange(AAxis, GAMEPAD_AXIS_LEFT_X, GLFW_GAMEPAD_AXIS_LAST)];
end;

function  TlgWindow.SaveToFile(const AFilename: string): Boolean;
var
  LBuffer: TlgVirtualBuffer;
  LWidth,LHeight, LRow, LCol: Integer;
  LTempByte: Byte;
  LFilename: string;
begin
  Result := False;
  if AFilename.IsEmpty then Exit;

  LWidth := Round(FScaledSize.Width);
  LHeight := Round(FScaledSize.Height);
  LFilename := TPath.ChangeExtension(AFilename, 'png');
  LBuffer := TlgVirtualBuffer.Create(LWidth * LHeight * 3);
  try
    glReadPixels(0, 0, LWidth, LHeight, GL_RGB, GL_UNSIGNED_BYTE, LBuffer.Memory);

    for LRow := 0 to LHeight div 2 - 1 do
    begin
      for LCol := 0 to LWidth * 3 - 1 do
      begin
        Move((PByte(LBuffer.Memory) + (LRow * LWidth * 3 + LCol))^, LTempByte, 1);
        Move((PByte(LBuffer.Memory) + ((LHeight - LRow - 1) * LWidth * 3 + LCol))^, (PByte(LBuffer.Memory) + (LRow * LWidth * 3 + LCol))^, 1);
        Move(LTempByte, (PByte(LBuffer.Memory) + ((LHeight - LRow - 1) * LWidth * 3 + LCol))^, 1);
      end;
    end;

    Result := Boolean(stbi_write_png(Utils.Marshal.AsUtf8(LFileName).ToPointer, LWidth, LHeight, 3, LBuffer.Memory, LWidth * 3));
  finally
    LBuffer.Free();
  end;
end;

function  TlgWindow.GetPixel(const X, Y: Single): TlgColor;
var
  LPixel: array[0..3] of GLubyte;
begin
  glReadPixels(Round(X*FScale.x), Round(Y*FScale.y), 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, @LPixel);
  Result.Red   := LPixel[0] / $FF;
  Result.Green := LPixel[1] / $FF;
  Result.Blue  := LPixel[2] / $FF;
  Result.Alpha := LPixel[3] / $FF;
end;

procedure TlgWindow.SetPixel(const X, Y: Single; const AColor: TlgColor);
begin
  SetPixel(X, Y, Round(AColor.Red * $FF), Round(AColor.Green * $FF), Round(AColor.Blue * $FF), Round(AColor.Alpha * $FF));
end;

procedure TlgWindow.SetPixel(const X, Y: Single; const ARed, AGreen, ABlue, AAlpha: Byte);
var
  LPixel: array[0..3] of GLubyte;
begin
  LPixel[0] := ARed;
  LPixel[1] := AGreen;
  LPixel[2] := ABlue;
  LPixel[3] := AAlpha;
  glRasterPos2f(X, Y);
  glDrawPixels(1, 1, GL_RGBA, GL_UNSIGNED_BYTE, @LPixel);
end;


class function TlgWindow.Init(const aTitle: string; const AWidth: Integer; const AHeight: Integer): TlgWindow;
begin
  Result := TlgWindow.Create();
  if not Result.Open(ATitle, AWidth, AHeight) then
  begin
    Result.Free();
    Result := nil;
  end;
end;

{ === TEXTURE =============================================================== }
{ --- TglTexture ------------------------------------------------------------ }

function  TlgTexture_Read(AUser: Pointer; AData: PUTF8Char;
  ASize: Integer): Integer; cdecl;
var
  LStream: TlgStream;
begin
  LStream := AUser;
  Result := LStream.Read(AData, ASize);
end;

procedure TlgTexture_Skip(AUser: Pointer; AOffset: Integer); cdecl;
var
  LStream: TlgStream;
begin
  LStream := AUser;
  LStream.Seek(AOffset, smCurrent);
end;

function  TlgTexture_Eof(AUser: Pointer): Integer; cdecl;
var
  LStream: TlgStream;
begin
  LStream := AUser;
  Result := Ord(LStream.Eos);
end;

constructor TlgTexture.Create();
begin
  inherited;
end;

destructor TlgTexture.Destroy();
begin
  Unload;
  inherited;
end;

function   TlgTexture.Allocate(const AWidth, AHeight: Integer): Boolean;
var
  Data: array of Byte;
begin
  Result := False;

  if FHandle <> 0 then Exit;

  // init RGBA data
  SetLength(Data, AWidth * AHeight * 4);

  glGenTextures(1, @FHandle);
  glBindTexture(GL_TEXTURE_2D, FHandle);

  // init the texture with transparent pixels
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, AWidth, AHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, @Data[0]);

  // set texture parameters
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  FSize.Width := AWidth;
  FSize.Height := AHeight;
  FChannels := 4;

  SetBlend(tbAlpha);
  SetColor(WHITE);
  SetScale(1.0);
  SetAngle(0.0);
  SetHFlip(False);
  SetVFlip(False);
  SetPivot(0.5, 0.5);
  SetAnchor(0.5, 0.5);
  SetPos(0.0, 0.0);
  ResetRegion();

  glBindTexture(GL_TEXTURE_2D, 0);

  Result := True;
end;

procedure  TlgTexture.Fill(const AColor: TlgColor);
var
  X,Y,LWidth,LHeight: Integer;
begin
  LWidth := Round(FSize.Width);
  LHeight := Round(FSize.Height);

  glBindTexture(GL_TEXTURE_2D, FHandle);

  for X := 0 to LWidth-1 do
  begin
    for Y := 0 to LHeight-1 do
    begin
      glTexSubImage2D(GL_TEXTURE_2D, 0, X, Y, 1, 1, GL_RGBA, GL_FLOAT, @AColor);
    end;
  end;

  glBindTexture(GL_TEXTURE_2D, 0);
end;

function   TlgTexture.Load(const ARGBData: Pointer; const AWidth, AHeight: Integer): Boolean;
begin
  Result := False;
  if FHandle > 0 then Exit;
  if not Allocate(AWidth, AHeight) then Exit;

  glBindTexture(GL_TEXTURE_2D, FHandle);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_ALPHA, AWidth, AHeight, 0, GL_ALPHA, GL_UNSIGNED_BYTE, ARGBData);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
  glBindTexture(GL_TEXTURE_2D, 0);

  Result := True;
end;

function   TlgTexture.Load(const AStream: TlgStream; const AColorKey: PlgColor): Boolean;
var
  LCallbacks: stbi_io_callbacks;
  LData: Pstbi_uc;
  LWidth,LHeight,LChannels: Integer;
begin
  Result := False;
  if FHandle > 0 then Exit;
  if not Assigned(AStream) then Exit;

  LCallbacks.read := TlgTexture_Read;
  LCallbacks.skip := TlgTexture_Skip;
  LCallbacks.eof := TlgTexture_Eof;

  LData := stbi_load_from_callbacks(@LCallbacks, AStream, @LWidth, @LHeight, @LChannels, 4);
  if not Assigned(LData) then Exit;

  if Assigned(AColorKey) then
    ConvertMaskToAlpha(LData, LWidth, LHeight, AColorKey^);

  glGenTextures(1, @FHandle);
  glBindTexture(GL_TEXTURE_2D, FHandle);

  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, LWidth, LHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, LData);

  // Set texture parameters
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

  stbi_image_free(LData);

  FSize.Width := LWidth;
  FSize.Height := LHeight;
  FChannels := LChannels;

  SetBlend(tbAlpha);
  SetColor(WHITE);
  SetScale(1.0);
  SetAngle(0.0);
  SetHFlip(False);
  SetVFlip(False);
  SetPivot(0.5, 0.5);
  SetAnchor(0.5, 0.5);
  SetPos(0.0, 0.0);
  ResetRegion();

  glBindTexture(GL_TEXTURE_2D, 0);

  Result := True;
end;

procedure  TlgTexture.Unload();
begin
  if FHandle = 0 then Exit;

  glDeleteTextures(1, @FHandle);
  FHandle := 0;
  FSize := Default(TlgSize);
  FChannels := 0;
end;

function   TlgTexture.GetChannels(): Integer;
begin
  Result := FChannels;
end;

function   TlgTexture.GetSize(): TlgSize;
begin
  Result := FSize;
end;

function   TlgTexture.GetPivot(): TlgPoint;
begin
  Result := FPivot;
end;

procedure  TlgTexture.SetPivot(const APoint: TlgPoint);
begin
  SetPivot(APoint.x, APoint.y);
end;

procedure  TlgTexture.SetPivot(const X, Y: Single);
begin
  FPivot.x := EnsureRange(X, 0, 1);
  FPivot.y := EnsureRange(Y, 0, 1);
end;

function   TlgTexture.GetAnchor(): TlgPoint;
begin
  Result := FAnchor;
end;

procedure  TlgTexture.SetAnchor(const APoint: TlgPoint);
begin
  SetAnchor(APoint.x, APoint.y);
end;

procedure  TlgTexture.SetAnchor(const X, Y: Single);
begin
  FAnchor.x := EnsureRange(X, 0, 1);
  FAnchor.y := EnsureRange(Y, 0, 1);
end;

function   TlgTexture.GetBlend: TlgTextureBlend;
begin
  Result := FBlend;
end;

procedure  TlgTexture.SetBlend(const AValue: TlgTextureBlend);
begin
  FBlend:= AValue;
end;

function   TlgTexture.GetPos(): TlgPoint;
begin
  Result := FPos;
end;

procedure  TlgTexture.SetPos(const APos: TlgPoint);
begin
  FPos := APos;
end;

procedure  TlgTexture.SetPos(const X, Y: Single);
begin
  FPos.x := X;
  FPos.y := Y;
end;

function   TlgTexture.GetScale(): Single;
begin
  Result := FScale;
end;

procedure  TlgTexture.SetScale(const AScale: Single);
begin
  FScale := AScale;
end;

function   TlgTexture.GetColor(): TlgColor;
begin
  Result := FColor;
end;

procedure  TlgTexture.SetColor(const AColor: TlgColor);
begin
  FColor := AColor;
end;

procedure  TlgTexture.SetColor(const ARed, AGreen, ABlue, AAlpha: Single);
begin
  FColor.Red := EnsureRange(ARed, 0, 1);
  FColor.Green := EnsureRange(AGreen, 0, 1);
  FColor.Blue := EnsureRange(ABlue, 0, 1);
  FColor.Alpha := EnsureRange(AAlpha, 0, 1);
end;

function   TlgTexture.GetAngle(): Single;
begin
  Result := FAngle;
end;

procedure  TlgTexture.SetAngle(const AAngle: Single);
begin
  FAngle := AAngle;
  Math.ClipValueFloat(FAngle, 0, 360, True);
end;

function   TlgTexture.GetHFlip(): Boolean;
begin
  Result := FHFlip;
end;

procedure  TlgTexture.SetHFlip(const AFlip: Boolean);
begin
  FHFlip := AFlip;
end;

function   TlgTexture.GetVFlip(): Boolean;
begin
  Result := FVFlip;
end;

procedure  TlgTexture.SetVFlip(const AFlip: Boolean);
begin
  FVFlip := AFlip;
end;

function   TlgTexture.GetRegion(): TlgRect;
begin
  Result := FRegion;
end;

procedure  TlgTexture.SetRegion(const ARegion: TlgRect);
begin
  SetRegion(ARegion.X, ARegion.Y, ARegion.Width, ARegion.Height);
end;

procedure  TlgTexture.SetRegion(const X, Y, AWidth, AHeight: Single);
begin
  FRegion.X := X;
  FRegion.Y := Y;
  FRegion.Width := AWidth;
  FRegion.Height := AHeight;
end;

procedure  TlgTexture.ResetRegion();
begin
  FRegion.X := 0;
  FRegion.Y := 0;
  FRegion.Width := FSize.Width;
  FRegion.Height := FSize.Height;
end;

procedure  TlgTexture.Draw();
var
  FlipX, FlipY: Single;
begin
  if FHandle = 0 then Exit;

  glBindTexture(GL_TEXTURE_2D, FHandle);
  glEnable(GL_TEXTURE_2D);

  glPushMatrix();

  // Set the color
  glColor4f(FColor.Red, FColor.Green, FColor.Blue, FColor.Alpha);

  // set blending
  case FBlend of
    tbNone: // no blending
    begin
      glDisable(GL_BLEND);
      glBlendFunc(GL_ONE, GL_ZERO);
    end;

    tbAlpha: // alpha blending
    begin
      glEnable(GL_BLEND);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    end;

    tbAdditiveAlpha: // addeditve blending
    begin
      glEnable(GL_BLEND);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE);
    end;
  end;

  // Use the normalized anchor value
  glTranslatef(FPos.X - (FAnchor.X * FRegion.Width * FScale), FPos.Y - (FAnchor.Y * FRegion.Height * FScale), 0);
  glScalef(FScale, FScale, 1);

  // Apply rotation using the normalized pivot value
  glTranslatef(FPivot.X * FRegion.Width, FPivot.Y * FRegion.Height, 0);
  glRotatef(FAngle, 0, 0, 1);
  glTranslatef(-FPivot.X * FRegion.Width, -FPivot.Y * FRegion.Height, 0);

  // Apply flip
  if FHFlip then FlipX := -1 else FlipX := 1;
  if FVFlip then FlipY := -1 else FlipY := 1;
  glScalef(FlipX, FlipY, 1);

  // Adjusted texture coordinates and vertices for the specified rectangle
  glBegin(GL_QUADS);
    glTexCoord2f(FRegion.X/FSize.Width, FRegion.Y/FSize.Height); glVertex2f(0, 0);
    glTexCoord2f((FRegion.X + FRegion.Width)/FSize.Width, FRegion.Y/FSize.Height); glVertex2f(FRegion.Width, 0);
    glTexCoord2f((FRegion.X + FRegion.Width)/FSize.Width, (FRegion.Y + FRegion.Height)/FSize.Height); glVertex2f(FRegion.Width, FRegion.Height);
    glTexCoord2f(FRegion.X/FSize.Width, (FRegion.Y + FRegion.Height)/FSize.Height); glVertex2f(0, FRegion.Height);
  glEnd();

  glPopMatrix();

  glDisable(GL_TEXTURE_2D);
  glBindTexture(GL_TEXTURE_2D, 0);
end;

procedure  TlgTexture.DrawTiled(const AWindow: TlgWindow; const ADeltaX, ADeltaY: Single);
var
  LW,LH    : Integer;
  LOX,LOY  : Integer;
  LPX,LPY  : Single;
  LFX,LFY  : Single;
  LTX,LTY  : Integer;
  LVPW,LVPH: Integer;
  LVR,LVB  : Integer;
  LIX,LIY  : Integer;
  LViewport: TlgRect;
begin
  if FHandle = 0 then Exit;

  SetPivot(0, 0);
  SetAnchor(0, 0);

  AWindow.GetViewport(LViewport);
  LVPW := Round(LViewport.Width);
  LVPH := Round(LViewport.Height);

  LW := Round(FSize.Width);
  LH := Round(FSize.Height);

  LOX := -LW+1;
  LOY := -LH+1;

  LPX := aDeltaX;
  LPY := aDeltaY;

  LFX := LPX-floor(LPX);
  LFY := LPY-floor(LPY);

  LTX := floor(LPX)-LOX;
  LTY := floor(LPY)-LOY;

  if (LTX>=0) then LTX := LTX mod LW + LOX else LTX := LW - -LTX mod LW + LOX;
  if (LTY>=0) then LTY := LTY mod LH + LOY else LTY := LH - -LTY mod LH + LOY;

  LVR := LVPW;
  LVB := LVPH;
  LIY := LTY;

  while LIY<LVB do
  begin
    LIX := LTX;
    while LIX<LVR do
    begin
      //al_draw_bitmap(FHandle, LIX+LFX, LIY+LFY, 0);
      SetPos(LIX+LFX, LIY+LFY);
      Draw();
      LIX := LIX+LW;
    end;
   LIY := LIY+LH;
  end;
end;

function  TlgTexture.SaveToFile(const AFilename: string): Boolean;
var
  LData: array of Byte;
  LFilename: string;
begin
  Result := False;
  if FHandle = 0 then Exit;
  if AFilename.IsEmpty then Exit;

 // Allocate space for the texture data
  SetLength(LData, Round(FSize.Width * FSize.Height * 4)); // Assuming RGBA format

  // Bind the texture
  glBindTexture(GL_TEXTURE_2D, FHandle);

  // Read the texture data
  glGetTexImage(GL_TEXTURE_2D, 0, GL_RGBA, GL_UNSIGNED_BYTE, @LData[0]);

  LFilename := TPath.ChangeExtension(AFilename, 'png');

  // Use stb_image_write to save the texture to a PNG file
  Result := Boolean(stbi_write_png(Utils.Marshal.AsUtf8(LFilename).ToPointer, Round(FSize.Width), Round(FSize.Height), 4, @LData[0], Round(FSize.Width * 4)));

  // Unbind the texture
  glBindTexture(GL_TEXTURE_2D, 0);
end;

function   TlgTexture.Lock(): Boolean;
begin
  Result := False;
  if Assigned(FLock) then Exit;

  GetMem(FLock, Round(FSize.Width*FSize.Height*4));
  if not Assigned(FLock) then Exit;

  glBindTexture(GL_TEXTURE_2D, FHandle);
  glGetTexImage(GL_TEXTURE_2D, 0, GL_RGBA, GL_UNSIGNED_BYTE, FLock);
  glBindTexture(GL_TEXTURE_2D, 0);

  Result := True;
end;

procedure  TlgTexture.Unlock();
begin
  if not Assigned(FLock) then Exit;

  glBindTexture(GL_TEXTURE_2D, FHandle);
  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, Round(FSize.Width), Round(FSize.Height), GL_RGBA, GL_UNSIGNED_BYTE, FLock);
  glBindTexture(GL_TEXTURE_2D, 0);
  FreeMem(FLock);
  FLock := nil;
end;

function   TlgTexture.GetPixel(const X, Y: Single): TlgColor;
var
  FOffset: Integer;
  LPixel: Cardinal;
begin
  Result := BLANK;
  if not Assigned(FLock) then Exit;

  FOffset := Round((Y * FSize.Width + X) * 4);
  LPixel := PCardinal(FLock + FOffset)^;

  Result.Alpha := (LPixel shr 24) / $FF;
  Result.Blue := ((LPixel shr 16) and $FF) / $FF;
  Result.Green := ((LPixel shr 8) and $FF) / $FF;
  Result.Red := (LPixel and $FF) / $FF;
end;

procedure  TlgTexture.SetPixel(const X, Y: Single; const AColor: TlgColor);
var
  FOffset: Integer;
begin
  if not Assigned(FLock) then Exit;

  FOffset := Round((Y * FSize.Width + X) * 4);
  PCardinal(FLock + FOffset)^ :=
    (Round(AColor.Alpha*$FF) shl 24) or
    (Round(AColor.Blue*$FF) shl 16) or
    (Round(AColor.Green*$FF) shl 8) or
    Round(AColor.Red*$FF);
end;

procedure  TlgTexture.SetPixel(const X, Y: Single; const ARed, AGreen, ABlue, AAlpha: Byte);
var
  FOffset: Integer;
begin
  if not Assigned(FLock) then Exit;

  FOffset := Round((Y * FSize.Width + X) * 4);
  PCardinal(FLock + FOffset)^ :=
    (AAlpha shl 24) or
    (ABlue shl 16) or
    (AGreen shl 8) or
    ARed;
end;

function   TlgTexture.CollideAABB(const ATexture: TlgTexture): Boolean;
var
  boxA, boxB: c2AABB;

  function _c2v(x, y: Single): c2v;
  begin
    result.x := x;
    result.y := y;
  end;

begin
  // Set up AABB for this texture
  boxA.min := _c2V(FPos.X - (FAnchor.X * FRegion.Width * FScale), FPos.Y - (FAnchor.Y * FRegion.Height * FScale));
  boxA.max := _c2V((FPos.X - (FAnchor.X * FRegion.Width * FScale)) + FRegion.Width * FScale, (FPos.Y - (FAnchor.Y * FRegion.Height * FScale)) + FRegion.Height * FScale);

  // Set up AABB for the other texture
  boxB.min := _c2V(ATexture.FPos.X - (ATexture.FAnchor.X * ATexture.FRegion.Width * ATexture.FScale), ATexture.FPos.Y - (ATexture.FAnchor.Y * ATexture.FRegion.Height * ATexture.FScale));
  boxB.max := _c2V((ATexture.FPos.X - (ATexture.FAnchor.X * ATexture.FRegion.Width * ATexture.FScale)) + ATexture.FRegion.Width * ATexture.FScale, (ATexture.FPos.Y - (ATexture.FAnchor.Y * ATexture.FRegion.Height * ATexture.FScale)) + ATexture.FRegion.Height * ATexture.FScale);

  // Check for collision and return result
  Result := Boolean(c2AABBtoAABB(boxA, boxB));
end;

function TlgTexture.CollideOBB(const ATexture: TlgTexture): Boolean;
var
  obbA, obbB: TlgOBB;
begin
  // Set up OBB for this texture
  obbA.Center := Math.Point(FPos.X, FPos.Y);
  obbA.Extents := Math.Point(FRegion.Width * FScale / 2, FRegion.Height * FScale / 2);
  obbA.Rotation := FAngle;

  // Set up OBB for the other texture
  obbB.Center := Math.Point(ATexture.FPos.X, ATexture.FPos.Y);
  obbB.Extents := Math.Point(ATexture.FRegion.Width * ATexture.FScale / 2, ATexture.FRegion.Height * ATexture.FScale / 2);
  obbB.Rotation := ATexture.FAngle;

  // Check for collision and return result
  Result := Math.OBBIntersect(obbA, obbB);
end;

class function TlgTexture.LoadFromFile(const AFilename: string; const AColorKey: PlgColor): TlgTexture;
var
  LStream: TlgStream;
begin
  Result := TlgTexture.Create();

  LStream := TlgFileStream.Open(AFilename, smRead);
  try
    Result.Load(LStream, AColorKey);
  finally
    LStream.Free();
  end;
end;

class function TlgTexture.LoadFromZipFile(const AZipFile: TlgZipFile; const AFilename: string; const AColorKey: PlgColor): TlgTexture;
var
  LStream: TlgStream;
begin
  Result := nil;
  if not Assigned(AZipFile) then Exit;
  if not AZipFile.IsOpen() then Exit;

  Result := TlgTexture.Create();

  LStream := AZipFile.OpenFile(AFilename);
  try
    if not Assigned(LStream) then
    begin
      Result.Free();
      Result := nil;
      Exit;
    end;
    Result.Load(LStream, AColorKey);
  finally
    LStream.Free();
  end;
end;

{ === FONT ================================================================== }
{ --- TlgFont --------------------------------------------------------------- }
constructor TlgFont.Create();
begin
  inherited;
  FGlyph := TDictionary<Integer, TGlyph>.Create();
end;

destructor TlgFont.Destroy();
begin
  Unload();
  FGlyph.Free();
  inherited;
end;

function  TlgFont.Load(const AWindow: TlgWindow; const AStream: TlgStream; const ASize: Cardinal; const AGlyphs: string): Boolean;

var
  LBuffer: TlgVirtualBuffer;
  LChars: TlgVirtualBuffer;
  LFileSize: Int64;
  LFontInfo: stbtt_fontinfo;
  NumOfGlyphs: Integer;
  LGlyphChars: string;
  LCodePoints: array of Integer;
  LBitmap: array of Byte;
  LPackContext: stbtt_pack_context;
  LPackRange: stbtt_pack_range;
  I: Integer;
  LGlyph: TGlyph;
  LChar: Pstbtt_packedchar;
  LScale: Single;
  LAscent: Integer;
  LSize: Single;
  LMaxTextureSize: Integer;
  LDpiScale: Single;
begin
  Result := False;
  if not Assigned(AWindow) then Exit;

  LDpiScale := AWindow.FScale.y;
  LMaxTextureSize := AWindow.FMaxTextureSize;

  LSize := aSize * LDpiScale;
  LFileSize := AStream.Size();
  LBuffer := TlgVirtualBuffer.Create(LFileSize);
  try
    AStream.Read(LBuffer.Memory, LFileSize);
    if stbtt_InitFont(@LFontInfo, LBuffer.Memory, 0) = 0 then Exit;
    LGlyphChars := DEFAULT_GLYPHS + aGlyphs;
    LGlyphChars := Utils.RemoveDuplicates(LGlyphChars);
    NumOfGlyphs := LGlyphChars.Length;
    SetLength(LCodePoints, NumOfGlyphs);

    for I := 1 to NumOfGlyphs do
    begin
      LCodePoints[I-1] := Integer(Char(LGlyphChars[I]));
    end;

    LChars := TlgVirtualBuffer.Create(SizeOf(stbtt_packedchar) * (NumOfGlyphs+1));
    try
      LPackRange.font_size := -LSize;
      LPackRange.first_unicode_codepoint_in_range := 0;
      LPackRange.array_of_unicode_codepoints := @LCodePoints[0];
      LPackRange.num_chars := NumOfGlyphs;
      LPackRange.chardata_for_range := LChars.Memory;
      LPackRange.h_oversample := 1;
      LPackRange.v_oversample := 1;

      FAtlasSize := 32;

      while True do
      begin
        SetLength(LBitmap, FAtlasSize * FAtlasSize);
        stbtt_PackBegin(@LPackContext, @LBitmap[0], FAtlasSize, FAtlasSize, 0, 1, nil);
        stbtt_PackSetOversampling(@LPackContext, 1, 1);
        if stbtt_PackFontRanges(@LPackContext, LBuffer.Memory, 0, @LPackRange, 1) = 0  then
          begin
            LBitmap := nil;
            stbtt_PackEnd(@LPackContext);
            FAtlasSize := FAtlasSize * 2;
            if (FAtlasSize > LMaxTextureSize) then
            begin
              raise Exception.Create(Format('Font texture too large. Max size: %d', [LMaxTextureSize]));
            end;
          end
        else
          begin
            stbtt_PackEnd(@LPackContext);
            break;
          end;
      end;

      FAtlas := TlgTexture.Create();
      FAtlas.Load(@LBitmap[0], FAtlasSize, FAtlasSize);
      FAtlas.SetPivot(0,0);
      FAtlas.SetAnchor(0,0);
      FAtlas.SetBlend(tbAlpha);
      FAtlas.SetColor(WHITE);

      LBitmap := nil;

      LScale := stbtt_ScaleForMappingEmToPixels(@LFontInfo, LSize);
      stbtt_GetFontVMetrics(@LFontInfo, @LAscent, nil, nil);
      FBaseline := LAscent * LScale;

      FGlyph.Clear();
      for I := Low(LCodePoints) to High(LCodePoints) do
      begin
        LChar := Pstbtt_packedchar(LChars.Memory);
        Inc(LChar, I);

        LGlyph.SrcRect.x := LChar.x0;
        LGlyph.SrcRect.y := LChar.y0;
        LGlyph.SrcRect.Width := LChar.x1-LChar.x0;
        LGlyph.SrcRect.Height := LChar.y1-LChar.y0;

        LGlyph.DstRect.x := 0 + LChar.xoff;
        LGlyph.DstRect.y := 0 + LChar.yoff + FBaseline;
        LGlyph.DstRect.Width := (LChar.x1-LChar.x0);
        LGlyph.DstRect.Height := (LChar.y1-LChar.y0);

        LGlyph.XAdvance := LChar.xadvance;

        FGlyph.Add(LCodePoints[I], LGlyph);
      end;

      Result := True;

    finally
      LChars.Free();
    end;

  finally
    LBuffer.Free();
  end;
end;

procedure TlgFont.Unload();
begin
  if Assigned(FAtlas) then
  begin
    FAtlas.Free();
    FAtlas := nil;
  end;
  FGlyph.Clear();
end;

procedure TlgFont.DrawText(const AWindow: TlgWindow; const aX, aY: Single; const aColor: TlgColor; aHAlign: THAlign; const aMsg: string; const aArgs: array of const);
var
  LText: string;
  LChar: Integer;
  LGlyph: TGlyph;
  I, LLen: Integer;
  LX, LY: Single;
  LViewport: TlgRect;
  LWidth: Single;
begin
  LText := Format(aMsg, aArgs);
  LLen := LText.Length;

  LX := aX;
  LY := aY;

  AWindow.GetViewport(LViewport);

  case aHAlign of
    haLeft:
      begin
      end;
    haCenter:
      begin
        LWidth := TextLength(aMsg, aArgs);
        LX := (LViewport.Width - LWidth)/2;
      end;
    haRight:
      begin
        LWidth := TextLength(aMsg, aArgs);
        LX := LViewport.Width - LWidth;
      end;
  end;

  FAtlas.SetColor(AColor);

  for I := 1 to LLen do
  begin
    LChar := Integer(Char(LText[I]));
    if FGlyph.TryGetValue(LChar, LGlyph) then
    begin
      LGlyph.DstRect.x := LGlyph.DstRect.x + LX;
      LGlyph.DstRect.y := LGlyph.DstRect.y + LY;

      FAtlas.SetRegion(LGlyph.SrcRect);
      FAtlas.SetPos(LGlyph.DstRect.x, LGlyph.DstRect.y);
      FAtlas.Draw();
      LX := LX + LGlyph.XAdvance;
    end;
  end;
end;

procedure TlgFont.DrawText(const AWindow: TlgWindow; const aX: Single; var aY: Single; const aLineSpace: Single; const aColor: TlgColor; aHAlign: THAlign; const aMsg: string; const aArgs: array of const);
begin
  DrawText(AWindow, aX, aY, aColor, aHAlign, aMsg, aArgs);
  aY := aY + FBaseLine + aLineSpace;
end;

function  TlgFont.TextLength(const aMsg: string; const aArgs: array of const): Single;
var
  LText: string;
  LChar: Integer;
  LGlyph: TGlyph;
  I, LLen: Integer;
  LWidth: Single;
begin
  LText := Format(aMsg, aArgs);
  LLen := LText.Length;

  LWidth := 0;

  for I := 1 to LLen do
  begin
    LChar := Integer(Char(LText[I]));
    if FGlyph.TryGetValue(LChar, LGlyph) then
    begin
      LWidth := LWidth + LGlyph.XAdvance;
    end;
  end;

  Result := LWidth;
end;

function  TlgFont.TextHeight: Single;
begin
  Result := FBaseLine;
end;

function TlgFont.SaveTexture(const AFilename: string): Boolean;
begin
  Result := FAtlas.SaveToFile(AFilename);
end;

class function TlgFont.LoadFromFile(const AWindow: TlgWindow; const AFilename: string; const ASize: Cardinal; const AGlyphs: string): TlgFont;
var
  LStream: TlgStream;
begin
  Result := nil;
  if not Assigned(AWindow) then Exit;

  LStream := TlgFileStream.Open(AFilename, smRead);
  try
    if not Assigned(LStream) then Exit;
    Result := TlgFont.Create();
    if not Assigned(Result) then Exit;
    if not Result.Load(AWindow, LStream, ASize, AGlyphs) then
    begin
      Result.Free();
      Result := nil;
      Exit;
    end;
  finally
    LStream.Free();
  end;
end;

class function TlgFont.LoadFromZipFile(const AWindow: TlgWindow; const AZipFile: TlgZipFile; const AFilename: string; const ASize: Cardinal; const AGlyphs: string): TlgFont;
var
  LStream: TlgStream;
begin
  Result := nil;
  if not Assigned(AWindow) then Exit;
  if not Assigned(AZipFile) then Exit;
  if not AZipFile.IsOpen() then Exit;

  LStream := AZipFile.OpenFile(AFilename);
  try
    if not Assigned(LStream) then Exit;
    Result := TlgFont.Create();
    if not Assigned(Result) then Exit;
    if not Result.Load(AWindow, LStream, ASize, AGlyphs) then
    begin
      Result.Free();
      Result := nil;
      Exit;
    end;
  finally
    LStream.Free();
  end;
end;

class function  TlgFont.LoadDefault(const AWindow: TlgWindow; const aSize: Cardinal; const aGlyphs: string=''): TlgFont;
var
  LResStream: TResourceStream;
  LStream: TlgStream;
begin
  Result := nil;
  if not Assigned(AWindow) then Exit;
  if not Utils.ResourceExists(HInstance, CDefaultFontResName) then Exit;

  LResStream := TResourceStream.Create(HInstance, CDefaultFontResName, RT_RCDATA);
  try
    LStream := TlgMemoryStream.Open(LResStream.Memory, LResStream.Size);
    try
      Result := TlgFont.Create();
      if not Assigned(Result) then Exit;
      if not Result.Load(AWindow, LStream, ASize, AGlyphs) then
      begin
        Result.Free();
        Result := nil;
        Exit;
      end;
    finally
      LStream.Free();
    end;
  finally
    LResStream.Free();
  end;
end;

{ === VIDEO ================================================================= }

{ --- TlgVideo -------------------------------------------------------------- }
procedure TlgVideo_DecodeAudio(APLM: Pplm_t; ASamples: Pplm_samples_t; AUserData: Pointer); cdecl;
var
  I: Integer;
  LValue: smallint;
  LVideo: TlgVideo;
begin
  LVideo := AUserData;

  for i := 0 to LVideo.SAMEPLE_SIZE-1 do
  begin
    LValue :=  Round(EnsureRange(ASamples.interleaved[i], -1.0, 1.0) * 32767);
    LVideo.FAudioDecodeBuffer[i * 2] := Byte(LValue);               // Store the low byte
    LVideo.FAudioDecodeBuffer[i * 2 + 1] := Byte(LValue shr 8);    // Store the high byte
  end;
  LVideo.FRingBuffer.Write(LVideo.FAudioDecodeBuffer, (LVideo.SAMEPLE_SIZE*sizeof(smallint)));
end;

procedure TlgVideo_DecodeVideo(APLM: Pplm_t; AFrame: Pplm_frame_t; AUserData: Pointer); cdecl;
var
  LVideo: TlgVideo;
begin
  LVideo := AUserData;

  // convert YUV to RGBA
  plm_frame_to_rgba(AFrame, @LVideo.FRGBABuffer[0], Round(LVideo.FTexture.FSize.Width*4));

  // update OGL texture
  glBindTexture(GL_TEXTURE_2D, LVideo.FTexture.FHandle);
  glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, AFrame^.width, AFrame^.height, GL_RGBA, GL_UNSIGNED_BYTE, LVideo.FRGBABuffer);
end;

procedure TlgVideo_LoadBuffer(ABuffer: pplm_buffer_t; AUserData: pointer); cdecl;
var
  LBytesRead: Int64;
  LVideo: TlgVideo;
begin
  LVideo := AUserData;

  // read data from inputstream
  LBytesRead := LVideo.FStream.Read(@LVideo.FStaticPlmBuffer[0], LVideo.RGBBUFFER_SIZE);

  // push LBytesRead to PLM buffer
  if LBytesRead > 0 then
    begin
      plm_buffer_write(aBuffer, @LVideo.FStaticPlmBuffer[0], LBytesRead);
    end
  else
    begin
      // set status to stopped
      LVideo.FStatus := vsStopped;
    end;
end;

constructor TlgVideo.Create();
begin
  inherited;
end;

destructor TlgVideo.Destroy();
begin
  Unload();
  inherited;
end;

function  TlgVideo.Load(var AStream: TlgStream): Boolean;
var
  LBuffer: Pplm_buffer_t;
  I: Integer;
begin
  Result := False;

  if IsLoaded() then Exit;
  if not Assigned(AStream) then Exit;

  FStream := AStream;
  FStatus := vsStopped;

  AStream := nil;

  // init plm buffer
  LBuffer := plm_buffer_create_with_capacity(RGBBUFFER_SIZE);
  if not Assigned(LBuffer) then Exit;

  plm_buffer_set_load_callback(LBuffer, TlgVideo_LoadBuffer, Self);
  FPlm := plm_create_with_buffer(LBuffer, 1);
  if not Assigned(FPlm) then
  begin
    plm_buffer_destroy(LBuffer);
    Exit;
  end;
  FSampleRate := plm_get_samplerate(FPlm);
  FFrameTime := 1/Timer.TargetFrameRate();

  // create video render texture
  FTexture := TlgTexture.Create();
  FTexture.SetBlend(tbNone);
  if not FTexture.Allocate(plm_get_width(FPlm), plm_get_height(FPlm)) then
  begin
    plm_destroy(FPlm);
    Exit;
  end;

  // alloc the video rgba buffer
  SetLength(FRGBABuffer, Round(FTexture.GetSize.Width*FTexture.GetSize.Height*4));
  if not Assigned(FRGBABuffer) then
  begin
    FTexture.Free();
    plm_destroy(FPlm);
    Exit;
  end;

  plm_set_audio_lead_time(FPlm, (SAMEPLE_SIZE*AUDIO_CHANES)/FSampleRate);
  plm_set_audio_decode_callback(FPlm, TlgVideo_DecodeAudio, Self);
  plm_set_video_decode_callback(FPlm, TlgVideo_DecodeVideo, Self);

  alGenSources(1, @FSource);
  alGenBuffers(NUM_BUFFERS, @FBuffers);

  FRingBuffer := TlgRingBuffer<Byte>.Create((FSampleRate*AUDIO_CHANES*sizeof(smallint))*2);

  Utils.ClearStaticBuffer();
  for I := 0 to NUM_BUFFERS-1 do
  begin
    alBufferData(FBuffers[I], AL_FORMAT_STEREO16, Utils.GetStaticBuffer(), 100, FSampleRate);
  end;
  alSourceQueueBuffers(FSource, NUM_BUFFERS, @FBuffers[0]);

  FTexture.SetPivot(0, 0);
  FTexture.SetAnchor(0, 0);
  FTexture.SetBlend(tbNone);

  FTaskID := TaskList.Add(
    procedure
    begin
      UpdateAudio();
    end
  );

  Result := True;
end;

function  TlgVideo.IsLoaded(): Boolean;
begin
  Result := Assigned(FPlm);
end;

procedure TlgVideo.Unload();
begin
  if not IsLoaded() then Exit;

  TaskList.Remove(FTaskID);

  alSourceStop(FSource);
  alDeleteSources(1, @FSource);
  alDeleteBuffers(NUM_BUFFERS, @FBuffers);

  plm_destroy(FPlm);
  FStream.Free();
  FTexture.Free();
  FRingBuffer.Free();

  FSource := 0;
  FBuffers[0] := 0;
  FBuffers[1] := 0;
  FPlm := nil;
  FRingBuffer := nil;
  FTexture := nil;
  FStatus := vsStopped;
end;

procedure TlgVideo.Play(const APlay: Boolean);
begin
  if APlay then
    begin
      alSourcePlay(FSource);
      FStatus := vsPlaying
    end
  else
    begin
      alSourceStop(FSource);
      FStatus := vsStopped;
    end;
end;

function  TlgVideo.GetPos(): TlgPoint;
begin
  Result := FTexture.GetPos();
end;

procedure TlgVideo.SetPos(const APos: TlgPoint);
begin
  FTexture.SetPos(APos);
end;

procedure TlgVideo.SetPos(const X, Y: Single);
begin
  FTexture.SetPos(X, Y);
end;

function  TlgVideo.GetVolume: Single;
begin
  Result := FVolume;
end;

procedure TlgVideo.SetVolume(const AVolume: Single);
begin
  FVolume := AVolume;
end;

function  TlgVideo.GetScale(): Single;
begin
  Result := FTexture.GetScale();
end;

procedure TlgVideo.SetScale(const AScale: Single);
begin
  FTexture.SetScale(AScale);
end;

function  TlgVideo.IsLooping(): Boolean;
begin
  Result := FLooping;
end;

procedure TlgVideo.SetLooping(const ALoop: Boolean);
begin
  FLooping := ALoop;
end;

procedure TlgVideo.UpdateAudio();
var
  LProcessed: ALint;
  LWhich: integer;
  LState: Integer;
begin
  if FStatus = vsStopped then Exit;

  alGetSourcei(FSource, AL_BUFFERS_PROCESSED, @LProcessed);
  while LProcessed > 0 do
  begin
    alSourceUnqueueBuffers(FSource, 1, @LWhich);
    alBufferData(LWhich, AL_FORMAT_STEREO16, FRingBuffer.DirectReadPointer(SAMEPLE_SIZE*sizeof(smallint)), SAMEPLE_SIZE*sizeof(smallint), FSampleRate);
    alSourceQueueBuffers(FSource, 1, @LWhich);
    Dec(LProcessed);
  end;

  alGetSourcei(FSource, AL_SOURCE_STATE, @LState);
  if LState = AL_STOPPED then
  begin
    alSourcePlay(FSource);
  end;
end;

procedure TlgVideo.Update();
begin
  if not IsLoaded() then Exit;

  if FStatus = vsStopped then
  begin
    if FLooping then
      begin
        plm_rewind(FPlm);
        FStream.Seek(0, smStart);
        FRingBuffer.Clear();
        FStatus := vsPlaying;
      end
    else
      Exit;
  end;

  plm_decode(FPlm, FFrameTime);
end;

function  TlgVideo.GetStatus(): TlgVideoStatus;
begin
  Result := FStatus;
end;

procedure TlgVideo.Draw();
begin
  if FStatus = vsStopped then Exit;
  FTexture.Draw();
end;

class function TlgVideo.LoadFromFile(const AFilename: string): TlgVideo;
var
  LStream: TlgStream;
begin
  Result := nil;
  if AFilename.IsEmpty then Exit;

  LStream := TlgFileStream.Open(AFilename, smRead);
  if not Assigned(LStream) then Exit;

  Result := TlgVideo.Create();
  if not Result.Load(LStream) then
  begin
    Result.Free();
    LStream.Free();
    Result := nil;
    Exit;
  end;
end;

class function TlgVideo.LoadFromZipFile(const AZipFile: TlgZipFile; const AFilename: string): TlgVideo;
var
  LStream: TlgStream;
begin
  Result := nil;
  if not Assigned(AZipFile) then Exit;
  if not AZipFile.IsOpen then Exit;
  if AFilename.IsEmpty then Exit;

  LStream := AZipFile.OpenFile(AFilename);
  if not Assigned(LStream) then Exit;

  Result := TlgVideo.Create();
  if not Result.Load(LStream) then
  begin
    Result.Free();
    LStream.Free();
    Result := nil;
    Exit;
  end;
end;


{ === CAMERA ================================================================ }
{ --- TlgCamera ------------------------------------------------------------- }
procedure TlgCamera.SetRotation(const AValue: Single);
begin
  FRotation := EnsureRange(AValue, 0, 360);
end;

constructor TlgCamera.Create();
begin
  inherited;
  FScale := 1;
end;

destructor TlgCamera.Destroy();
begin
  inherited;
end;

procedure TlgCamera.Move(const X, Y: Single);
begin
  FX := FX + (X / FScale);
  FY := FY + (Y / FScale);
end;

procedure TlgCamera.Zoom(const AScale: Single);
begin
  FScale := FScale + (AScale * FScale);
end;

procedure TlgCamera.Rotate(const ARotation: Single);
begin
  FRotation := FRotation + ARotation;
end;

procedure TlgCamera.Use(const AWindow: TlgWindow);
var
  LViewport: TlgRect;
begin
  if not Assigned(AWindow) then
  begin
    glPopMatrix();
    FWindow := nil;
    Exit;
  end;

  glPushMatrix();
  AWindow.GetViewport(LViewport);

  glTranslatef((LViewport.Width/2), (LViewport.Height/2), 0);
  glRotatef(FRotation, 0, 0, 1);
  glScalef(FScale, FScale, 1);
  glTranslatef(-FX, -FY, 0);
end;

procedure TlgCamera.Reset();
begin
  if Assigned(FWindow) then
  begin
    glPopMatrix();
  end;
  FX := 0;
  FY := 0;
  FRotation := 0;
  FScale := 1;
end;

{ === GUI =================================================================== }

{ --- TlgGUI ---------------------------------------------------------------- }
// init
constructor TlgGUI.Create();
begin
  inherited;
  FCtx := nil;
end;

destructor TlgGUI.Destroy();
begin
  if Assigned(FCtx) then
    nk_glfw3_shutdown();
  FCtx := nil;
  inherited;
end;

function  TlgGUI.Setup(const AWindow: TlgWindow): Boolean;
var
  LResStream: TResourceStream;
  LAtlas: Pnk_font_atlas;
  LFont: Pnk_font;
begin
  Result := False;
  if not Assigned(AWindow) then Exit;

  FCtx := nk_glfw3_init(AWindow.GetHandle(), NK_GLFW3_DEFAULT);
  if not Assigned(FCtx) then Exit;

  LResStream := TResourceStream.Create(HInstance, CDefaultFontResName, RT_RCDATA);
  try
    nk_glfw3_font_stash_begin(@LAtlas);
    LFont := nk_font_atlas_add_from_memory(LAtlas, LResStream.Memory, LResStream.Size, 16, nil);
    nk_glfw3_font_stash_end();
    nk_style_load_all_cursors(FCtx, @LAtlas.cursors);
    nk_style_set_font(FCtx, @LFont.handle);
  finally
    LResStream.Free();
  end;
  Result := True;
end;

// frame
procedure TlgGUI.NewFrame();
begin
  if not Assigned(FCtx) then Exit;

  nk_glfw3_new_frame();
end;

procedure TlgGUI.Render();
begin
  if not Assigned(FCtx) then Exit;

  nk_glfw3_render(NK_ANTI_ALIASING_ON);
end;

// window
function  TlgGUI.BeginWindow(const ATitle: string; const X, Y, AWidth, AHeight: Single; const AFlags: Cardinal): Boolean;
begin
  Result := False;
  if not Assigned(FCtx) then Exit;

  Result := Boolean(nk_begin(FCtx, Utils.Marshal.AsUtf8(ATitle).ToPointer, nk_rect_rtn(50, 50, 230, 250), AFlags) = nk_true)
end;

procedure TlgGUI.EndWindow();
begin
  if not Assigned(FCtx) then Exit;

  nk_end(FCtx);
end;

// layout
procedure TlgGUI.LayoutRowDynamic(const AHeight: Single; const AColumns: Integer);
begin
  nk_layout_row_dynamic(FCtx, AHeight, AColumns);
end;

procedure TlgGUI.LayoutRowStatic(const AHeight: Single; const AItemWidth, AColumns: Integer);
begin
  nk_layout_row_static(FCtx, AHeight, AItemWidth, AColumns);
end;

// button
function  TlgGUI.ButtonLabel(const ATitle: string): Boolean;
begin
  Result := Boolean(nk_button_label(FCtx, Utils.Marshal.AsUtf8(ATitle).ToPointer) = nk_true);
end;

// option
function  TlgGUI.OptionLabel(const ATitle: string; const AActive: Boolean): Boolean;
begin
  Result := Boolean(nk_option_label(FCtx, Utils.Marshal.AsUtf8(ATitle).ToPointer, Ord(AActive)) = nk_true);
end;

// property
procedure TlgGUI.PropertyInt(const AName: string; const AValue: PInteger; const AMin, AMax, AStep: Integer; const AIncPerPixel: Single);
begin
  nk_property_int(FCtx,  Utils.Marshal.AsUtf8(AName).ToPointer, AMin, AValue, AMax, AStep, AIncPerPixel);
end;

// class methods
class function TlgGUI.Init(const AWindow: TlgWindow): TlgGUI;
begin
  Result := TlgGUI.Create();
  if not Result.Setup(AWindow) then
  begin
    Result.Free();
    Result := nil;
  end;
end;

{ === POLYGON =============================================================== }
constructor TlgPolygon.Create();
begin
  inherited;
end;

destructor TlgPolygon.Destroy();
begin
  Clear();
  inherited;
end;

procedure TlgPolygon.Save(const AFilename: string);
var
  LSize: Integer;
  LStream: TlgStream;
begin
  LStream := TlgFileStream.Open(AFilename, smWrite);
  try
    // FItemCount
    LStream.Write(@FItemCount, SizeOf(FItemCount));

    // FItem
    LSize := SizeOf(FSegment[0]) * FItemCount;
    LStream.Write(@FSegment[0], LSize);

    // FWorldPoint
    LSize := SizeOf(FWorldPoint[0]) * FItemCount;
    LStream.Write(@FWorldPoint[0], LSize);

  finally
    LStream.Free();
  end;
end;

procedure TlgPolygon.Load(const AStream: TlgStream; const AFilename: string);
var
  LSize: Integer;
begin
  if Assigned(AStream) then Exit;

  Clear();

  // FItemCount
  AStream.Read(@FItemCount, SizeOf(FItemCount));

  // FItem
  SetLength(FSegment, FItemCount);
  LSize := SizeOf(FSegment[0]) * FItemCount;
  AStream.Read(@FSegment[0], LSize);

  // FWorldPoint
  SetLength(FWorldPoint, FItemCount);
  LSize := SizeOf(FWorldPoint[0]) * FItemCount;
  AStream.Read(@FWorldPoint[0], LSize);
end;

procedure TlgPolygon.CopyFrom(aPolygon: TlgPolygon);
var
  I: Integer;
begin
  Clear;
  for I := 0 to FItemCount-1 do
  begin
    with FSegment[I] do
    begin
      AddLocalPoint(Round(Point.X), Round(Point.Y), Visible);
    end;
  end;
end;

procedure TlgPolygon.Clear();
begin
  FSegment := nil;
  FWorldPoint := nil;
  FItemCount := 0;
end;

procedure TlgPolygon.AddLocalPoint(AX, AY: Single; aVisible: Boolean);
begin
  Inc(FItemCount);
  SetLength(FSegment, FItemCount);
  SetLength(FWorldPoint, FItemCount);
  FSegment[FItemCount-1].Point.X := aX;
  FSegment[FItemCount-1].Point.Y := aY;
  FSegment[FItemCount-1].Visible := aVisible;
  FWorldPoint[FItemCount-1].X := 0;
  FWorldPoint[FItemCount-1].Y := 0;
end;

function  TlgPolygon.Transform(AX, AY, AScale, AAngle: Single; AOrigin: PlgPoint; AHFlip, AVFlip: Boolean): Boolean;
var
  I: Integer;
  P: TlgPoint;
begin
  Result := False;

  if FItemCount < 2 then  Exit;

  for I := 0 to FItemCount-1 do
  begin
    // get local coord
    P.X := FSegment[I].Point.X;
    P.Y := FSegment[I].Point.Y;

    // move point to origin
    if aOrigin <> nil then
    begin
      P.X := P.X - aOrigin.X;
      P.Y := P.Y - aOrigin.Y;
    end;

    if aVFlip then
      P.Y := -P.Y;

    if aHFlip then
      P.X := -P.X;

    // scale
    P.X := P.X * aScale;
    P.Y := P.Y * aScale;

    // rotate
    Math.AngleRotatePos(aAngle, P.X, P.Y);

    // convert to world
    P.X := P.X + aX;
    P.Y := P.Y + aY;

    // set world point
    FWorldPoint[I].X := P.X;
    FWorldPoint[I].Y := P.Y;
  end;

  Result := True;
end;

procedure TlgPolygon.Render(const AWindow: TlgWindow; const AX, AY, AScale, AAngle: Single; AThickness: Integer; AColor: TlgColor; AOrigin: PlgPoint; AHFlip, AVFlip: Boolean);
var
  I: Integer;
  X0,Y0,X1,Y1: Single;
begin
  if not Transform(aX, aY, aScale, aAngle, aOrigin, aHFlip,  aVFlip) then Exit;

  // draw line segments
  for I := 0 to FItemCount-2 do
  begin
    if FSegment[I].Visible then
    begin
      X0 := FWorldPoint[I].X;
      Y0 := FWorldPoint[I].Y;
      X1 := FWorldPoint[I+1].X;
      Y1 := FWorldPoint[I+1].Y;
      AWindow.DrawLine(X0, Y0, X1, Y1, AColor, AThickness);
    end;
  end;
end;

procedure TlgPolygon.SetSegmentVisible(AIndex: Integer; aVisible: Boolean);
begin
  FSegment[aIndex].Visible := True;
end;

function  TlgPolygon.IsSegmentVisible(AIndex: Integer): Boolean;
begin
  Result := FSegment[aIndex].Visible;
end;

function  TlgPolygon.PointCount(): Integer;
begin
  Result := FItemCount;
end;

function  TlgPolygon.WorldPoint(AIndex: Integer): PlgPoint;
begin
  Result := @FWorldPoint[aIndex];
end;

function  TlgPolygon.LocalPoint(AIndex: Integer): PlgPoint;
begin
  Result := @FSegment[aIndex].Point;
end;

{ === STARTFIELD ============================================================ }
{ --- TlgStarfield ---------------------------------------------------------- }
procedure TlgStarfield.TransformDrawPoint(const X, Y, Z: Single; const AWindow: TlgWindow);
var
  LX, LY: Single;
  LSW, LSH: Single;
  LOOZ: Single;
  LCV: Byte;
  LColor: TlgColor;
  LViewport: TlgRect;
  LScale: TlgPoint;

  function IsVisible(vx, vy, vw, vh: Single): Boolean;
  begin
    Result := False;
    if ((vx - vw) < 0) then
      Exit;
    if (vx > (LViewport.Width - 1)) then
      Exit;
    if ((vy - vh) < 0) then
      Exit;
    if (vy > (LViewport.Height - 1)) then
      Exit;
    Result := True;
  end;

begin
  AWindow.GetViewport(LViewport);
  AWindow.GetScale(LScale);
  FViewScaleRatio := LViewport.Width / LViewport.Height;
  FCenter.X := (LViewport.Width / 2) + LViewport.X;
  FCenter.Y := (LViewport.Height / 2) + LViewport.Y;

  LOOZ := ((1.0 / Z) * FViewScale);
  LX := (FCenter.X - LViewport.X) - (X * LOOZ) * FViewScaleRatio;
  LY := (FCenter.Y - LViewport.Y) + (Y * LOOZ) * FViewScaleRatio;
  LSW := (1.0 * LOOZ);
  if LSW < 1 then LSW := 1;
  LSH := (1.0 * LOOZ);
  if LSH < 1 then LSH := 1;
  LSW := LSW * LScale.x;
  LSH := LSH * LScale.y;
  if not IsVisible(LX, LY, LSW, LSH) then
    Exit;
  LCV := round(255.0 - (((1.0 / FMax.Z) / (1.0 / Z)) * 255.0));

  //LColor.Make(LCV, LCV, LCV, LCV);
  LColor.Red   := LCV / $FF;
  LColor.Green := LCV / $FF;
  LColor.Blue  := LCV / $FF;
  LColor.Alpha := LCV / $FF;

  LX := LX - FVirtualPos.X;
  LY := LY - FVirtualPos.Y;

  //GV.Display.DrawFilledRectangle(LX, LY, LSW, LSH, LColor);
  AWindow.DrawFilledRect(LX, LY, LSW, LSH, LColor, 0);
end;

procedure TlgStarfield.Done();
begin
  FStar := nil;
end;

constructor TlgStarfield.Create();
begin
  inherited;
end;

destructor TlgStarfield.Destroy();
begin
  Done;

  inherited;
end;
procedure TlgStarfield.Init(const AWindow: TlgWindow; const aStarCount: Cardinal; const AMinX, AMinY, AMinZ, AMaxX, AMaxY, AMaxZ, AViewScale: Single);
var
  I: Integer;
  LViewport: TlgRect;
begin
  Done;

  FStarCount := aStarCount;
  SetLength(FStar, FStarCount);

  AWindow.GetViewport(LViewport);

  FViewScale := aViewScale;
  FViewScaleRatio := LViewport.Width / LViewport.Height;
  FCenter.X := (LViewport.Width / 2) + LViewport.X;
  FCenter.Y := (LViewport.Height / 2) + LViewport.Y;
  FCenter.Z := 0;

  FMin.X := aMinX;
  FMin.Y := aMinY;
  FMin.Z := aMinZ;
  FMax.X := aMaxX;
  FMax.Y := aMaxY;
  FMax.Z := aMaxZ;

  for I := 0 to FStarCount - 1 do
  begin
    FStar[I].X := Math.RandomRange(FMin.X, FMax.X);
    FStar[I].Y := Math.RandomRange(FMin.Y, FMax.Y);
    FStar[I].Z := Math.RandomRange(FMin.Z, FMax.Z);
  end;

  SetXSpeed(0.0);
  SetYSpeed(0.0);
  SetZSpeed(-3);
  SetVirtualPos(0, 0);
end;

procedure TlgStarfield.SetVirtualPos(const X, Y: Single);
begin
  FVirtualPos.X := X;
  FVirtualPos.Y := Y;
end;

procedure TlgStarfield.GetVirtualPos(var X: Single; var Y: Single);
begin
  X := FVirtualPos.X;
  Y := FVirtualPos.Y;
end;

procedure TlgStarfield.SetXSpeed(const ASpeed: Single);
begin
  FSpeed.X := aSpeed;
end;

procedure TlgStarfield.SetYSpeed(const ASpeed: Single);
begin
  FSpeed.Y := aSpeed;
end;

procedure TlgStarfield.SetZSpeed(const ASpeed: Single);
begin
  FSpeed.Z := aSpeed;
end;

procedure TlgStarfield.Update();
var
  I: Integer;

  procedure SetRandomPos(aIndex: Integer);
  begin
    FStar[aIndex].X := Math.RandomRange(FMin.X, FMax.X);
    FStar[aIndex].Y := Math.RandomRange(FMin.Y, FMax.Y);
    FStar[aIndex].Z := Math.RandomRange(FMin.Z, FMax.Z);
  end;

begin

  for I := 0 to FStarCount - 1 do
  begin
    FStar[I].X := FStar[I].X + FSpeed.X;
    FStar[I].Y := FStar[I].Y + FSpeed.Y;
    FStar[I].Z := FStar[I].Z + FSpeed.Z;

    if FStar[I].X < FMin.X then
    begin
      SetRandomPos(I);
      FStar[I].X := FMax.X;
    end;

    if FStar[I].X > FMax.X then
    begin
      SetRandomPos(I);
      FStar[I].X := FMin.X;
    end;

    if FStar[I].Y < FMin.Y then
    begin
      SetRandomPos(I);
      FStar[I].Y := FMax.Y;
    end;

    if FStar[I].Y > FMax.Y then
    begin
      SetRandomPos(I);
      FStar[I].Y := FMin.Y;
    end;

    if FStar[I].Z < FMin.Z then
    begin
      SetRandomPos(I);
      FStar[I].Z := FMax.Z;
    end;

    if FStar[I].Z > FMax.Z then
    begin
      SetRandomPos(I);
      FStar[I].Z := FMin.Z;
    end;
  end;
end;

procedure TlgStarfield.Render(const AWindow: TlgWindow);
var
  I: Integer;
begin
  for I := 0 to FStarCount - 1 do
  begin
    TransformDrawPoint(FStar[I].X, FStar[I].Y, FStar[I].Z, AWindow);
  end;
end;

class function TlgStarfield.New(const AWindow: TlgWindow): TlgStarfield;
begin
  Result := TlgStarfield.Create();
  Result.Init(AWindow, 250, -1000, -1000, 10, 1000, 1000, 1000, 120);
end;

{ === LUA =================================================================== }
const
  cLuaAutoSetup = 'AutoSetup';

{$REGION ' Loaders '}
const cLOADER_LUA : array[1..436] of Byte = (
$2D, $2D, $20, $55, $74, $69, $6C, $69, $74, $79, $20, $66, $75, $6E, $63, $74,
$69, $6F, $6E, $20, $66, $6F, $72, $20, $68, $61, $76, $69, $6E, $67, $20, $61,
$20, $77, $6F, $72, $6B, $69, $6E, $67, $20, $69, $6D, $70, $6F, $72, $74, $20,
$66, $75, $6E, $63, $74, $69, $6F, $6E, $0A, $2D, $2D, $20, $46, $65, $65, $6C,
$20, $66, $72, $65, $65, $20, $74, $6F, $20, $75, $73, $65, $20, $69, $74, $20,
$69, $6E, $20, $79, $6F, $75, $72, $20, $6F, $77, $6E, $20, $70, $72, $6F, $6A,
$65, $63, $74, $73, $0A, $28, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $29,
$0A, $20, $20, $20, $20, $6C, $6F, $63, $61, $6C, $20, $73, $63, $72, $69, $70,
$74, $5F, $63, $61, $63, $68, $65, $20, $3D, $20, $7B, $7D, $3B, $0A, $20, $20,
$20, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $69, $6D, $70, $6F, $72,
$74, $28, $6E, $61, $6D, $65, $29, $0A, $20, $20, $20, $20, $20, $20, $20, $20,
$69, $66, $20, $73, $63, $72, $69, $70, $74, $5F, $63, $61, $63, $68, $65, $5B,
$6E, $61, $6D, $65, $5D, $20, $3D, $3D, $20, $6E, $69, $6C, $20, $74, $68, $65,
$6E, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $73, $63,
$72, $69, $70, $74, $5F, $63, $61, $63, $68, $65, $5B, $6E, $61, $6D, $65, $5D,
$20, $3D, $20, $6C, $6F, $61, $64, $66, $69, $6C, $65, $28, $6E, $61, $6D, $65,
$29, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $65, $6E, $64, $0A, $20, $20,
$20, $20, $20, $20, $20, $20, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $69,
$66, $20, $73, $63, $72, $69, $70, $74, $5F, $63, $61, $63, $68, $65, $5B, $6E,
$61, $6D, $65, $5D, $20, $7E, $3D, $20, $6E, $69, $6C, $20, $74, $68, $65, $6E,
$0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $72, $65, $74,
$75, $72, $6E, $20, $73, $63, $72, $69, $70, $74, $5F, $63, $61, $63, $68, $65,
$5B, $6E, $61, $6D, $65, $5D, $28, $29, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $65, $6E, $64, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $65, $72, $72,
$6F, $72, $28, $22, $46, $61, $69, $6C, $65, $64, $20, $74, $6F, $20, $6C, $6F,
$61, $64, $20, $73, $63, $72, $69, $70, $74, $20, $22, $20, $2E, $2E, $20, $6E,
$61, $6D, $65, $29, $0A, $20, $20, $20, $20, $65, $6E, $64, $0A, $65, $6E, $64,
$29, $28, $29, $0A
);

const cLUABUNDLE_LUA : array[1..3478] of Byte = (
$28, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $61, $72, $67, $73, $29, $0D,
$0A, $6C, $6F, $63, $61, $6C, $20, $6D, $6F, $64, $75, $6C, $65, $73, $20, $3D,
$20, $7B, $7D, $0D, $0A, $6D, $6F, $64, $75, $6C, $65, $73, $5B, $27, $61, $70,
$70, $2F, $62, $75, $6E, $64, $6C, $65, $5F, $6D, $61, $6E, $61, $67, $65, $72,
$2E, $6C, $75, $61, $27, $5D, $20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F,
$6E, $28, $2E, $2E, $2E, $29, $0D, $0A, $2D, $2D, $20, $43, $6C, $61, $73, $73,
$20, $66, $6F, $72, $20, $63, $6F, $6C, $6C, $65, $63, $74, $69, $6E, $67, $20,
$74, $68, $65, $20, $66, $69, $6C, $65, $27, $73, $20, $63, $6F, $6E, $74, $65,
$6E, $74, $20, $61, $6E, $64, $20, $62, $75, $69, $6C, $64, $69, $6E, $67, $20,
$61, $20, $62, $75, $6E, $64, $6C, $65, $20, $66, $69, $6C, $65, $0D, $0A, $6C,
$6F, $63, $61, $6C, $20, $73, $6F, $75, $72, $63, $65, $5F, $70, $61, $72, $73,
$65, $72, $20, $3D, $20, $69, $6D, $70, $6F, $72, $74, $28, $22, $61, $70, $70,
$2F, $73, $6F, $75, $72, $63, $65, $5F, $70, $61, $72, $73, $65, $72, $2E, $6C,
$75, $61, $22, $29, $0D, $0A, $0D, $0A, $72, $65, $74, $75, $72, $6E, $20, $66,
$75, $6E, $63, $74, $69, $6F, $6E, $28, $65, $6E, $74, $72, $79, $5F, $70, $6F,
$69, $6E, $74, $29, $0D, $0A, $20, $20, $20, $20, $6C, $6F, $63, $61, $6C, $20,
$73, $65, $6C, $66, $20, $3D, $20, $7B, $7D, $0D, $0A, $20, $20, $20, $20, $6C,
$6F, $63, $61, $6C, $20, $66, $69, $6C, $65, $73, $20, $3D, $20, $7B, $7D, $0D,
$0A, $20, $20, $20, $20, $0D, $0A, $20, $20, $20, $20, $2D, $2D, $20, $53, $65,
$61, $72, $63, $68, $65, $73, $20, $74, $68, $65, $20, $67, $69, $76, $65, $6E,
$20, $66, $69, $6C, $65, $20, $72, $65, $63, $75, $72, $73, $69, $76, $65, $6C,
$79, $20, $66, $6F, $72, $20, $69, $6D, $70, $6F, $72, $74, $20, $66, $75, $6E,
$63, $74, $69, $6F, $6E, $20, $63, $61, $6C, $6C, $73, $0D, $0A, $20, $20, $20,
$20, $73, $65, $6C, $66, $2E, $70, $72, $6F, $63, $65, $73, $73, $5F, $66, $69,
$6C, $65, $20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $66, $69,
$6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $6C, $6F, $63, $61, $6C, $20, $70, $61, $72, $73, $65, $72, $20, $3D, $20,
$73, $6F, $75, $72, $63, $65, $5F, $70, $61, $72, $73, $65, $72, $28, $66, $69,
$6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $66, $69, $6C, $65, $73, $5B, $66, $69, $6C, $65, $6E, $61, $6D, $65, $5D,
$20, $3D, $20, $70, $61, $72, $73, $65, $72, $2E, $63, $6F, $6E, $74, $65, $6E,
$74, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $0D, $0A, $20, $20, $20,
$20, $20, $20, $20, $20, $66, $6F, $72, $20, $5F, $2C, $20, $66, $20, $69, $6E,
$20, $70, $61, $69, $72, $73, $28, $70, $61, $72, $73, $65, $72, $2E, $69, $6E,
$63, $6C, $75, $64, $65, $73, $29, $20, $64, $6F, $0D, $0A, $20, $20, $20, $20,
$20, $20, $20, $20, $20, $20, $20, $20, $73, $65, $6C, $66, $2E, $70, $72, $6F,
$63, $65, $73, $73, $5F, $66, $69, $6C, $65, $28, $66, $29, $0D, $0A, $20, $20,
$20, $20, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $65,
$6E, $64, $0D, $0A, $20, $20, $20, $20, $0D, $0A, $20, $20, $20, $20, $2D, $2D,
$20, $43, $72, $65, $61, $74, $65, $20, $61, $20, $62, $75, $6E, $64, $6C, $65,
$20, $66, $69, $6C, $65, $20, $77, $68, $69, $63, $68, $20, $63, $6F, $6E, $74,
$61, $69, $6E, $73, $20, $74, $68, $65, $20, $64, $65, $74, $65, $63, $74, $65,
$64, $20, $66, $69, $6C, $65, $73, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C,
$66, $2E, $62, $75, $69, $6C, $64, $5F, $62, $75, $6E, $64, $6C, $65, $20, $3D,
$20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $64, $65, $73, $74, $5F, $66,
$69, $6C, $65, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $6C, $6F,
$63, $61, $6C, $20, $66, $69, $6C, $65, $20, $3D, $20, $69, $6F, $2E, $6F, $70,
$65, $6E, $28, $64, $65, $73, $74, $5F, $66, $69, $6C, $65, $2C, $20, $22, $77,
$22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $0D, $0A, $20, $20,
$20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65,
$28, $22, $28, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $61, $72, $67, $73,
$29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66,
$69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $6C, $6F, $63, $61, $6C,
$20, $6D, $6F, $64, $75, $6C, $65, $73, $20, $3D, $20, $7B, $7D, $5C, $6E, $22,
$29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $0D, $0A, $20, $20, $20,
$20, $20, $20, $20, $20, $2D, $2D, $20, $43, $72, $65, $61, $74, $65, $20, $61,
$20, $73, $6F, $72, $74, $65, $64, $20, $6C, $69, $73, $74, $20, $6F, $66, $20,
$6B, $65, $79, $73, $20, $73, $6F, $20, $74, $68, $65, $20, $6F, $75, $74, $70,
$75, $74, $20, $77, $69, $6C, $6C, $20, $62, $65, $20, $74, $68, $65, $20, $73,
$61, $6D, $65, $20, $77, $68, $65, $6E, $20, $74, $68, $65, $20, $69, $6E, $70,
$75, $74, $20, $64, $6F, $65, $73, $20, $6E, $6F, $74, $20, $63, $68, $61, $6E,
$67, $65, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $6C, $6F, $63, $61,
$6C, $20, $66, $69, $6C, $65, $6E, $61, $6D, $65, $73, $20, $3D, $20, $7B, $7D,
$0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $6F, $72, $20, $66, $69,
$6C, $65, $6E, $61, $6D, $65, $2C, $20, $5F, $20, $69, $6E, $20, $70, $61, $69,
$72, $73, $28, $66, $69, $6C, $65, $73, $29, $20, $64, $6F, $0D, $0A, $20, $20,
$20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $74, $61, $62, $6C, $65, $2E,
$69, $6E, $73, $65, $72, $74, $28, $66, $69, $6C, $65, $6E, $61, $6D, $65, $73,
$2C, $20, $66, $69, $6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20, $20,
$20, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $20, $20,
$20, $20, $74, $61, $62, $6C, $65, $2E, $73, $6F, $72, $74, $28, $66, $69, $6C,
$65, $6E, $61, $6D, $65, $73, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $2D, $2D, $20, $41, $64,
$64, $20, $66, $69, $6C, $65, $73, $20, $61, $73, $20, $6D, $6F, $64, $75, $6C,
$65, $73, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $6F, $72, $20,
$5F, $2C, $20, $66, $69, $6C, $65, $6E, $61, $6D, $65, $20, $69, $6E, $20, $70,
$61, $69, $72, $73, $28, $66, $69, $6C, $65, $6E, $61, $6D, $65, $73, $29, $20,
$64, $6F, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20,
$66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $6D, $6F, $64, $75,
$6C, $65, $73, $5B, $27, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28,
$66, $69, $6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20, $20, $20, $20,
$20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74,
$65, $28, $22, $27, $5D, $20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E,
$28, $2E, $2E, $2E, $29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20,
$20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74,
$65, $28, $66, $69, $6C, $65, $73, $5B, $66, $69, $6C, $65, $6E, $61, $6D, $65,
$5D, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20,
$66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $5C, $6E, $22, $29,
$0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $66, $69,
$6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $65, $6E, $64, $5C, $6E, $22,
$29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A,
$20, $20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69,
$74, $65, $28, $22, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $69, $6D, $70,
$6F, $72, $74, $28, $6E, $29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20,
$20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22,
$72, $65, $74, $75, $72, $6E, $20, $6D, $6F, $64, $75, $6C, $65, $73, $5B, $6E,
$5D, $28, $74, $61, $62, $6C, $65, $2E, $75, $6E, $70, $61, $63, $6B, $28, $61,
$72, $67, $73, $29, $29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20,
$20, $20, $20, $66, $69, $6C, $65, $3A, $77, $72, $69, $74, $65, $28, $22, $65,
$6E, $64, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20,
$0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $77,
$72, $69, $74, $65, $28, $22, $6C, $6F, $63, $61, $6C, $20, $65, $6E, $74, $72,
$79, $20, $3D, $20, $69, $6D, $70, $6F, $72, $74, $28, $27, $22, $20, $2E, $2E,
$20, $65, $6E, $74, $72, $79, $5F, $70, $6F, $69, $6E, $74, $20, $2E, $2E, $20,
$22, $27, $29, $5C, $6E, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20,
$20, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $69, $6C, $65, $3A,
$77, $72, $69, $74, $65, $28, $22, $65, $6E, $64, $29, $28, $7B, $2E, $2E, $2E,
$7D, $29, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $66, $69,
$6C, $65, $3A, $66, $6C, $75, $73, $68, $28, $29, $0D, $0A, $20, $20, $20, $20,
$20, $20, $20, $20, $66, $69, $6C, $65, $3A, $63, $6C, $6F, $73, $65, $28, $29,
$0D, $0A, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $0D,
$0A, $20, $20, $20, $20, $72, $65, $74, $75, $72, $6E, $20, $73, $65, $6C, $66,
$0D, $0A, $65, $6E, $64, $0D, $0A, $65, $6E, $64, $0D, $0A, $6D, $6F, $64, $75,
$6C, $65, $73, $5B, $27, $61, $70, $70, $2F, $6D, $61, $69, $6E, $2E, $6C, $75,
$61, $27, $5D, $20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $2E,
$2E, $2E, $29, $0D, $0A, $2D, $2D, $20, $4D, $61, $69, $6E, $20, $66, $75, $6E,
$63, $74, $69, $6F, $6E, $20, $6F, $66, $20, $74, $68, $65, $20, $70, $72, $6F,
$67, $72, $61, $6D, $0D, $0A, $6C, $6F, $63, $61, $6C, $20, $62, $75, $6E, $64,
$6C, $65, $5F, $6D, $61, $6E, $61, $67, $65, $72, $20, $3D, $20, $69, $6D, $70,
$6F, $72, $74, $28, $22, $61, $70, $70, $2F, $62, $75, $6E, $64, $6C, $65, $5F,
$6D, $61, $6E, $61, $67, $65, $72, $2E, $6C, $75, $61, $22, $29, $0D, $0A, $0D,
$0A, $72, $65, $74, $75, $72, $6E, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E,
$28, $61, $72, $67, $73, $29, $0D, $0A, $20, $20, $20, $20, $69, $66, $20, $23,
$61, $72, $67, $73, $20, $3D, $3D, $20, $31, $20, $61, $6E, $64, $20, $61, $72,
$67, $73, $5B, $31, $5D, $20, $3D, $3D, $20, $22, $2D, $76, $22, $20, $74, $68,
$65, $6E, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $70, $72, $69, $6E,
$74, $28, $22, $6C, $75, $61, $62, $75, $6E, $64, $6C, $65, $20, $76, $30, $2E,
$30, $31, $22, $29, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $6F, $73,
$2E, $65, $78, $69, $74, $28, $29, $0D, $0A, $20, $20, $20, $20, $65, $6C, $73,
$65, $69, $66, $20, $23, $61, $72, $67, $73, $20, $7E, $3D, $20, $32, $20, $74,
$68, $65, $6E, $0D, $0A, $20, $20, $20, $20, $20, $20, $20, $20, $70, $72, $69,
$6E, $74, $28, $22, $75, $73, $61, $67, $65, $3A, $20, $6C, $75, $61, $62, $75,
$6E, $64, $6C, $65, $20, $69, $6E, $20, $6F, $75, $74, $22, $29, $0D, $0A, $20,
$20, $20, $20, $20, $20, $20, $20, $6F, $73, $2E, $65, $78, $69, $74, $28, $29,
$0D, $0A, $20, $20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $0D,
$0A, $20, $20, $20, $20, $6C, $6F, $63, $61, $6C, $20, $69, $6E, $66, $69, $6C,
$65, $20, $3D, $20, $61, $72, $67, $73, $5B, $31, $5D, $0D, $0A, $20, $20, $20,
$20, $6C, $6F, $63, $61, $6C, $20, $6F, $75, $74, $66, $69, $6C, $65, $20, $3D,
$20, $61, $72, $67, $73, $5B, $32, $5D, $0D, $0A, $20, $20, $20, $20, $6C, $6F,
$63, $61, $6C, $20, $62, $75, $6E, $64, $6C, $65, $20, $3D, $20, $62, $75, $6E,
$64, $6C, $65, $5F, $6D, $61, $6E, $61, $67, $65, $72, $28, $69, $6E, $66, $69,
$6C, $65, $29, $0D, $0A, $20, $20, $20, $20, $62, $75, $6E, $64, $6C, $65, $2E,
$70, $72, $6F, $63, $65, $73, $73, $5F, $66, $69, $6C, $65, $28, $69, $6E, $66,
$69, $6C, $65, $2C, $20, $62, $75, $6E, $64, $6C, $65, $29, $0D, $0A, $20, $20,
$20, $20, $0D, $0A, $20, $20, $20, $20, $62, $75, $6E, $64, $6C, $65, $2E, $62,
$75, $69, $6C, $64, $5F, $62, $75, $6E, $64, $6C, $65, $28, $6F, $75, $74, $66,
$69, $6C, $65, $29, $0D, $0A, $65, $6E, $64, $0D, $0A, $65, $6E, $64, $0D, $0A,
$6D, $6F, $64, $75, $6C, $65, $73, $5B, $27, $61, $70, $70, $2F, $73, $6F, $75,
$72, $63, $65, $5F, $70, $61, $72, $73, $65, $72, $2E, $6C, $75, $61, $27, $5D,
$20, $3D, $20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $2E, $2E, $2E, $29,
$0D, $0A, $2D, $2D, $20, $43, $6C, $61, $73, $73, $20, $66, $6F, $72, $20, $65,
$78, $74, $72, $61, $63, $74, $69, $6E, $67, $20, $69, $6D, $70, $6F, $72, $74,
$20, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $63, $61, $6C, $6C, $73, $20,
$66, $72, $6F, $6D, $20, $73, $6F, $75, $72, $63, $65, $20, $66, $69, $6C, $65,
$73, $0D, $0A, $72, $65, $74, $75, $72, $6E, $20, $66, $75, $6E, $63, $74, $69,
$6F, $6E, $28, $66, $69, $6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20, $20,
$20, $20, $6C, $6F, $63, $61, $6C, $20, $66, $69, $6C, $65, $20, $3D, $20, $69,
$6F, $2E, $6F, $70, $65, $6E, $28, $66, $69, $6C, $65, $6E, $61, $6D, $65, $2C,
$20, $22, $72, $22, $29, $0D, $0A, $20, $20, $20, $20, $69, $66, $20, $66, $69,
$6C, $65, $20, $3D, $3D, $20, $6E, $69, $6C, $20, $74, $68, $65, $6E, $0D, $0A,
$20, $20, $20, $20, $20, $20, $20, $20, $65, $72, $72, $6F, $72, $28, $22, $46,
$69, $6C, $65, $20, $6E, $6F, $74, $20, $66, $6F, $75, $6E, $64, $3A, $20, $22,
$20, $2E, $2E, $20, $66, $69, $6C, $65, $6E, $61, $6D, $65, $29, $0D, $0A, $20,
$20, $20, $20, $65, $6E, $64, $0D, $0A, $20, $20, $20, $20, $6C, $6F, $63, $61,
$6C, $20, $66, $69, $6C, $65, $5F, $63, $6F, $6E, $74, $65, $6E, $74, $20, $3D,
$20, $66, $69, $6C, $65, $3A, $72, $65, $61, $64, $28, $22, $2A, $61, $22, $29,
$0D, $0A, $20, $20, $20, $20, $66, $69, $6C, $65, $3A, $63, $6C, $6F, $73, $65,
$28, $29, $0D, $0A, $20, $20, $20, $20, $6C, $6F, $63, $61, $6C, $20, $69, $6E,
$63, $6C, $75, $64, $65, $64, $5F, $66, $69, $6C, $65, $73, $20, $3D, $20, $7B,
$7D, $0D, $0A, $20, $20, $20, $20, $0D, $0A, $20, $20, $20, $20, $2D, $2D, $20,
$53, $65, $61, $72, $63, $68, $20, $66, $6F, $72, $20, $69, $6D, $70, $6F, $72,
$74, $28, $29, $20, $63, $61, $6C, $6C, $73, $20, $77, $69, $74, $68, $20, $64,
$6F, $62, $75, $6C, $65, $20, $71, $75, $6F, $74, $65, $73, $20, $28, $21, $29,
$0D, $0A, $20, $20, $20, $20, $66, $6F, $72, $20, $66, $20, $69, $6E, $20, $73,
$74, $72, $69, $6E, $67, $2E, $67, $6D, $61, $74, $63, $68, $28, $66, $69, $6C,
$65, $5F, $63, $6F, $6E, $74, $65, $6E, $74, $2C, $20, $27, $69, $6D, $70, $6F,
$72, $74, $25, $28, $5B, $22, $5C, $27, $5D, $28, $5B, $5E, $5C, $27, $22, $5D,
$2D, $29, $5B, $22, $5C, $27, $5D, $25, $29, $27, $29, $20, $64, $6F, $0D, $0A,
$20, $20, $20, $20, $20, $20, $20, $20, $74, $61, $62, $6C, $65, $2E, $69, $6E,
$73, $65, $72, $74, $28, $69, $6E, $63, $6C, $75, $64, $65, $64, $5F, $66, $69,
$6C, $65, $73, $2C, $20, $66, $29, $0D, $0A, $20, $20, $20, $20, $65, $6E, $64,
$0D, $0A, $20, $20, $20, $20, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C, $66,
$20, $3D, $20, $7B, $7D, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C, $66, $2E,
$66, $69, $6C, $65, $6E, $61, $6D, $65, $20, $3D, $20, $66, $69, $6C, $65, $6E,
$61, $6D, $65, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C, $66, $2E, $63, $6F,
$6E, $74, $65, $6E, $74, $20, $3D, $20, $66, $69, $6C, $65, $5F, $63, $6F, $6E,
$74, $65, $6E, $74, $0D, $0A, $20, $20, $20, $20, $73, $65, $6C, $66, $2E, $69,
$6E, $63, $6C, $75, $64, $65, $73, $20, $3D, $20, $69, $6E, $63, $6C, $75, $64,
$65, $64, $5F, $66, $69, $6C, $65, $73, $0D, $0A, $20, $20, $20, $20, $72, $65,
$74, $75, $72, $6E, $20, $73, $65, $6C, $66, $0D, $0A, $65, $6E, $64, $0D, $0A,
$65, $6E, $64, $0D, $0A, $6D, $6F, $64, $75, $6C, $65, $73, $5B, $27, $6C, $75,
$61, $62, $75, $6E, $64, $6C, $65, $2E, $6C, $75, $61, $27, $5D, $20, $3D, $20,
$66, $75, $6E, $63, $74, $69, $6F, $6E, $28, $2E, $2E, $2E, $29, $0D, $0A, $2D,
$2D, $20, $45, $6E, $74, $72, $79, $20, $70, $6F, $69, $6E, $74, $20, $6F, $66,
$20, $74, $68, $65, $20, $70, $72, $6F, $67, $72, $61, $6D, $2E, $0D, $0A, $2D,
$2D, $20, $4F, $6E, $6C, $79, $20, $62, $61, $73, $69, $63, $20, $73, $74, $75,
$66, $66, $20, $69, $73, $20, $73, $65, $74, $20, $75, $70, $20, $68, $65, $72,
$65, $2C, $20, $74, $68, $65, $20, $61, $63, $74, $75, $61, $6C, $20, $70, $72,
$6F, $67, $72, $61, $6D, $20, $69, $73, $20, $69, $6E, $20, $61, $70, $70, $2F,
$6D, $61, $69, $6E, $2E, $6C, $75, $61, $0D, $0A, $6C, $6F, $63, $61, $6C, $20,
$61, $72, $67, $73, $20, $3D, $20, $7B, $2E, $2E, $2E, $7D, $0D, $0A, $0D, $0A,
$2D, $2D, $20, $43, $68, $65, $63, $6B, $20, $69, $66, $20, $77, $65, $20, $61,
$72, $65, $20, $61, $6C, $72, $65, $61, $64, $79, $20, $62, $75, $6E, $64, $6C,
$65, $64, $0D, $0A, $69, $66, $20, $69, $6D, $70, $6F, $72, $74, $20, $3D, $3D,
$20, $6E, $69, $6C, $20, $74, $68, $65, $6E, $0D, $0A, $20, $20, $20, $20, $64,
$6F, $66, $69, $6C, $65, $28, $22, $75, $74, $69, $6C, $2F, $6C, $6F, $61, $64,
$65, $72, $2E, $6C, $75, $61, $22, $29, $0D, $0A, $65, $6E, $64, $0D, $0A, $0D,
$0A, $69, $6D, $70, $6F, $72, $74, $28, $22, $61, $70, $70, $2F, $6D, $61, $69,
$6E, $2E, $6C, $75, $61, $22, $29, $28, $61, $72, $67, $73, $29, $0D, $0A, $65,
$6E, $64, $0D, $0A, $66, $75, $6E, $63, $74, $69, $6F, $6E, $20, $69, $6D, $70,
$6F, $72, $74, $28, $6E, $29, $0D, $0A, $72, $65, $74, $75, $72, $6E, $20, $6D,
$6F, $64, $75, $6C, $65, $73, $5B, $6E, $5D, $28, $74, $61, $62, $6C, $65, $2E,
$75, $6E, $70, $61, $63, $6B, $28, $61, $72, $67, $73, $29, $29, $0D, $0A, $65,
$6E, $64, $0D, $0A, $6C, $6F, $63, $61, $6C, $20, $65, $6E, $74, $72, $79, $20,
$3D, $20, $69, $6D, $70, $6F, $72, $74, $28, $27, $6C, $75, $61, $62, $75, $6E,
$64, $6C, $65, $2E, $6C, $75, $61, $27, $29, $0D, $0A, $65, $6E, $64, $29, $28,
$7B, $2E, $2E, $2E, $7D, $29
);
{$ENDREGION}

function LuaWrapperClosure(aState: Pointer): Integer; cdecl;
var
  LMethod: TMethod;
  LClosure: TlgLuaFunction absolute LMethod;
  LLua: TlgLua;
begin
  // get lua object
  LLua := lua_touserdata(aState, lua_upvalueindex(1));

  // get lua class routine
  LMethod.Code := lua_touserdata(aState, lua_upvalueindex(2));
  LMethod.Data := lua_touserdata(aState, lua_upvalueindex(3));

  // init the context
  LLua.Context.Setup;

  // call class routines
  LClosure(LLua.Context);

  // return result count
  Result := LLua.Context.PushCount;

  // clean up stack
  LLua.Context.Cleanup;
end;

function LuaWrapperWriter(aState: Pointer; const aBuffer: Pointer; aSize: NativeUInt; aData: Pointer): Integer; cdecl;
var
  LStream: TStream;
begin
  LStream := TStream(aData);
  try
    LStream.WriteBuffer(aBuffer^, aSize);
    Result := 0;
  except
    on E: EStreamError do
      Result := 1;
  end;
end;

{ TLuaValue }
class operator TlgLuaValue.Implicit(const AValue: Integer): TlgLuaValue;
begin
  Result.AsType := vtInteger;
  Result.AsInteger := AValue;
end;

class operator TlgLuaValue.Implicit(AValue: Double): TlgLuaValue;
begin
  Result.AsType := vtDouble;
  Result.AsNumber := AValue;
end;

class operator TlgLuaValue.Implicit(AValue: System.PChar): TlgLuaValue;
begin
  Result.AsType := vtString;
  Result.AsString := AValue;
end;

class operator TlgLuaValue.Implicit(AValue: TlgLuaTable): TlgLuaValue;
begin
  Result.AsType := vtTable;
  Result.AsTable := AValue;
end;

class operator TlgLuaValue.Implicit(AValue: Pointer): TlgLuaValue;
begin
  Result.AsType := vtPointer;
  Result.AsPointer := AValue;
end;

class operator TlgLuaValue.Implicit(AValue: Boolean): TlgLuaValue;
begin
  Result.AsType := vtBoolean;
  Result.AsBoolean := AValue;
end;

class operator TlgLuaValue.Implicit(AValue: TlgLuaValue): Integer;
begin
  Result := AValue.AsInteger;
end;

class operator TlgLuaValue.Implicit(AValue: TlgLuaValue): Double;
begin
  Result := AValue.AsNumber;
end;

var TLuaValue_Implicit_LValue: string = '';
class operator TlgLuaValue.Implicit(AValue: TlgLuaValue): System.PChar;
begin
  TLuaValue_Implicit_LValue := AValue.AsString;
  Result := PChar(TLuaValue_Implicit_LValue);
end;

class operator TlgLuaValue.Implicit(AValue: TlgLuaValue): Pointer;
begin
  Result := AValue.AsPointer
end;

class operator TlgLuaValue.Implicit(AValue: TlgLuaValue): Boolean;
begin
  Result := AValue.AsBoolean;
end;

{ Routines }
function ParseTableNames(aNames: string): TStringDynArray;
var
  LItems: TArray<string>;
  LI: Integer;
begin
  LItems := aNames.Split(['.']);
  SetLength(Result, Length(LItems));
  for LI := 0 to High(LItems) do
  begin
    Result[LI] := LItems[LI];
  end;
end;

{ TLuaContext }
procedure TlgLuaContext.Setup;
begin
  FPushCount := 0;
  FPushFlag := True;
end;

procedure TlgLuaContext.Check;
begin
  if FPushFlag then
  begin
    FPushFlag := False;
    ClearStack;
  end;
end;

procedure TlgLuaContext.IncStackPushCount;
begin
  Inc(FPushCount);
end;

procedure TlgLuaContext.Cleanup;
begin
  if FPushFlag then
  begin
    ClearStack;
  end;
end;

function TlgLuaContext.PushTableForSet(AName: array of string; AIndex: Integer; var AStackIndex: Integer; var AFieldNameIndex: Integer): Boolean;
var
  LMarshall: TMarshaller;
  LI: Integer;
begin
  Result := False;

  // validate name array size
  AStackIndex := Length(AName);
  if AStackIndex < 1 then  Exit;

  // validate return aStackIndex and aFieldNameIndex
  if Length(AName) = 1 then
    AFieldNameIndex := 0
  else
    AFieldNameIndex := Length(AName) - 1;

  // table does not exist, exit
  if lua_type(FLua.State, AIndex) <> LUA_TTABLE then Exit;

  // process sub tables
  for LI := 0 to AStackIndex - 1 do
  begin
    // check if table at field aIndex[i] exits
    lua_getfield(FLua.State, LI + AIndex, LMarshall.AsAnsi(AName[LI]).ToPointer);

    // table field does not exists, create a new one
    if lua_type(FLua.State, -1) <> LUA_TTABLE then
    begin
      // clean up stack
      lua_pop(FLua.State, 1);

      // push new table
      lua_newtable(FLua.State);

      // set new table a field
      lua_setfield(FLua.State, LI + AIndex, LMarshall.AsAnsi(AName[LI]).ToPointer);

      // push field table back on stack
      lua_getfield(FLua.State, LI + AIndex, LMarshall.AsAnsi(AName[LI]).ToPointer);
    end;
  end;

  Result := True;
end;

function TlgLuaContext.PushTableForGet(AName: array of string; AIndex: Integer; var AStackIndex: Integer; var AFieldNameIndex: Integer): Boolean;
var
  LMarshall: TMarshaller;
  LI: Integer;
begin
  Result := False;

  // validate name array size
  AStackIndex := Length(AName);
  if AStackIndex < 1 then  Exit;

  // validate return aStackIndex and aFieldNameIndex
  if AStackIndex = 1 then
    AFieldNameIndex := 0
  else
    AFieldNameIndex := AStackIndex - 1;

  // table does not exist, exit
  if lua_type(FLua.State, AIndex) <> LUA_TTABLE then  Exit;

  // process sub tables
  for LI := 0 to AStackIndex - 2 do
  begin
    // check if table at field aIndex[i] exits
    lua_getfield(FLua.State, LI + AIndex, LMarshall.AsAnsi(AName[LI]).ToPointer);

    // table field does not exists, create a new one
    if lua_type(FLua.State, -1) <> LUA_TTABLE then Exit;
  end;

  Result := True;
end;

constructor TlgLuaContext.Create(ALua: TlgLua);
begin
  FLua := ALua;
  FPushCount := 0;
  FPushFlag := False;
end;

destructor TlgLuaContext.Destroy();
begin
  FLua := nil;
  FPushCount := 0;
  FPushFlag := False;
  inherited;
end;

function TlgLuaContext.ArgCount: Integer;
begin
  Result := lua_gettop(FLua.State);
end;

function TlgLuaContext.PushCount: Integer;
begin
  Result := FPushCount;
end;

procedure TlgLuaContext.ClearStack();
begin
  lua_pop(FLua.State, lua_gettop(FLua.State));
  FPushCount := 0;
  FPushFlag := False;
end;

procedure TlgLuaContext.PopStack(ACount: Integer);
begin
  lua_pop(FLua.State, ACount);
end;

function TlgLuaContext.GetStackType(AIndex: Integer): TlgLuaType;
begin
  Result := TlgLuaType(lua_type(FLua.State, AIndex));
end;

var TLuaContext_GetValue_LStr: string = '';
function TlgLuaContext.GetValue(AType: TlgLuaValueType; AIndex: Integer): TlgLuaValue;
begin
  case AType of
    vtInteger:
      begin
        Result := lua_tointeger(FLua.State, AIndex);
      end;
    vtDouble:
      begin
        Result := lua_tonumber(FLua.State, AIndex);
      end;
    vtString:
      begin
        TLuaContext_GetValue_LStr := lua_tostring(FLua.State, AIndex);
        Result := PChar(TLuaContext_GetValue_LStr);
      end;
    vtPointer:
      begin
        Result := lua_touserdata(FLua.State, AIndex);
      end;
    vtBoolean:
      begin
        Result := Boolean(lua_toboolean(FLua.State, AIndex));
      end;
  else
    begin

    end;
  end;
end;

procedure TlgLuaContext.PushValue(AValue: TlgLuaValue);
var
  LMarshall: TMarshaller;
begin
  Check;

  case AValue.AsType of
    vtInteger:
      begin
        lua_pushinteger(FLua.State, AValue);
      end;
    vtDouble:
      begin
        lua_pushnumber(FLua.State, AValue);
      end;
    vtString:
      begin
        lua_pushstring(FLua.State, LMarshall.AsAnsi(AValue.AsString).ToPointer);
      end;
    vtTable:
      begin
        lua_newtable(FLua.State);
      end;
    vtPointer:
      begin
        lua_pushlightuserdata(FLua.State, AValue);
      end;
    vtBoolean:
      begin
        lua_pushboolean(FLua.State, AValue.AsBoolean.ToInteger);
      end;
  end;

  IncStackPushCount();
end;

procedure TlgLuaContext.SetTableFieldValue(const AName: string; AValue: TlgLuaValue; AIndex: Integer);
var
  LMarshall: TMarshaller;
  LStackIndex: Integer;
  LFieldNameIndex: Integer;
  LItems: TStringDynArray;
  LOk: Boolean;
begin
  LItems := ParseTableNames(AName);
  if not PushTableForSet(LItems, AIndex, LStackIndex, LFieldNameIndex) then Exit;
  LOk := True;

  case AValue.AsType of
    vtInteger:
      begin
        lua_pushinteger(FLua.State, AValue);
      end;
    vtDouble:
      begin
        lua_pushnumber(FLua.State, AValue);
      end;
    vtString:
      begin
        lua_pushstring(FLua.State, LMarshall.AsAnsi(AValue.AsString).ToPointer);
      end;
    vtPointer:
      begin
        lua_pushlightuserdata(FLua.State, AValue);
      end;
    vtBoolean:
      begin
        lua_pushboolean(FLua.State, AValue.AsBoolean.ToInteger);
      end;
  else
    begin
      LOk := False;
    end;
  end;

  if LOk then
  begin
    lua_setfield(FLua.State, LStackIndex + (AIndex - 1),
      LMarshall.AsAnsi(LItems[LFieldNameIndex]).ToPointer);
  end;

  PopStack(LStackIndex);
end;

var TLuaContext_GetTableFieldValue_LStr: string = '';
function TlgLuaContext.GetTableFieldValue(const AName: string; AType: TlgLuaValueType; AIndex: Integer): TlgLuaValue;
var
  LMarshall: TMarshaller;
  LStackIndex: Integer;
  LFieldNameIndex: Integer;
  LItems: TStringDynArray;
begin
  LItems := ParseTableNames(AName);
  if not PushTableForGet(LItems, AIndex, LStackIndex, LFieldNameIndex) then
    Exit;
  lua_getfield(FLua.State, LStackIndex + (AIndex - 1),
    LMarshall.AsAnsi(LItems[LFieldNameIndex]).ToPointer);

  case AType of
    vtInteger:
      begin
        Result := lua_tointeger(FLua.State, -1);
      end;
    vtDouble:
      begin
        Result := lua_tonumber(FLua.State, -1);
      end;
    vtString:
      begin
        TLuaContext_GetTableFieldValue_LStr := lua_tostring(FLua.State, -1);
        Result := PChar(TLuaContext_GetTableFieldValue_LStr);
      end;
    vtPointer:
      begin
        Result := lua_touserdata(FLua.State, -1);
      end;
    vtBoolean:
      begin
        Result := Boolean(lua_toboolean(FLua.State, -1));
      end;
  end;

  PopStack(LStackIndex);
end;

procedure TlgLuaContext.SetTableIndexValue(const AName: string; AValue: TlgLuaValue; AIndex: Integer; AKey: Integer);
var
  LMarshall: TMarshaller;
  LStackIndex: Integer;
  LFieldNameIndex: Integer;
  LItems: TStringDynArray;
  LOk: Boolean;

  procedure LPushValue;
  begin
    LOk := True;

    case AValue.AsType of
      vtInteger:
        begin
          lua_pushinteger(FLua.State, AValue);
        end;
      vtDouble:
        begin
          lua_pushnumber(FLua.State, AValue);
        end;
      vtString:
        begin
          lua_pushstring(FLua.State, LMarshall.AsAnsi(AValue.AsString).ToPointer);
        end;
      vtPointer:
        begin
          lua_pushlightuserdata(FLua.State, AValue);
        end;
      vtBoolean:
        begin
          lua_pushboolean(FLua.State, AValue.AsBoolean.ToInteger);
        end;
    else
      begin
        LOk := False;
      end;
    end;
  end;

begin
  LItems := ParseTableNames(AName);
  if Length(LItems) > 0 then
    begin
      if not PushTableForGet(LItems, AIndex, LStackIndex, LFieldNameIndex) then  Exit;
      LPushValue;
      if LOk then
        lua_rawseti (FLua.State, LStackIndex + (AIndex - 1), AKey);
    end
  else
    begin
      LPushValue;
      if LOk then
      begin
        lua_rawseti (FLua.State, AIndex, AKey);
      end;
      LStackIndex := 0;
    end;

    PopStack(LStackIndex);
end;

var TLuaContext_GetTableIndexValue_LStr: string = '';
function TlgLuaContext.GetTableIndexValue(const AName: string; AType: TlgLuaValueType; AIndex: Integer; AKey: Integer): TlgLuaValue;
var
  LStackIndex: Integer;
  LFieldNameIndex: Integer;
  LItems: TStringDynArray;
begin
  LItems := ParseTableNames(AName);
  if Length(LItems) > 0 then
    begin
      if not PushTableForGet(LItems, AIndex, LStackIndex, LFieldNameIndex) then Exit;
      lua_rawgeti (FLua.State, LStackIndex + (AIndex - 1), AKey);
    end
  else
    begin
      lua_rawgeti (FLua.State, AIndex, AKey);
      LStackIndex := 0;
    end;

  case AType of
    vtInteger:
      begin
        Result := lua_tointeger(FLua.State, -1);
      end;
    vtDouble:
      begin
        Result := lua_tonumber(FLua.State, -1);
      end;
    vtString:
      begin
        TLuaContext_GetTableIndexValue_LStr := lua_tostring(FLua.State, -1);
        Result := PChar(TLuaContext_GetTableIndexValue_LStr);
      end;
    vtPointer:
      begin
        Result := lua_touserdata(FLua.State, -1);
      end;
    vtBoolean:
      begin
        Result := Boolean(lua_toboolean(FLua.State, -1));
      end;
  end;

  PopStack(LStackIndex);
end;


{ TLua }
procedure TlgLua.Open();
begin
  if FState <> nil then Exit;
  FState := luaL_newstate;
  SetGCStepSize(200);
  luaL_openlibs(FState);
  LoadBuffer(@cLOADER_LUA, Length(cLOADER_LUA));
  FContext := TlgLuaContext.Create(Self);
  SetVariable('LGT.LuaVersion', GetVariable('jit.version', vtString));
  SetVariable('LGT.Version', LGT_PROJECT);
end;

procedure TlgLua.Close();
begin
  if FState = nil then Exit;
  FreeAndNil(FContext);
  lua_close(FState);
  FState := nil;
end;

procedure TlgLua.CheckLuaError(const aError: Integer);
var
  LErr: string;
begin
  if FState = nil then Exit;

  case aError of
    // success
    0:
      begin

      end;
    // a runtime error.
    LUA_ERRRUN:
      begin
        LErr := lua_tostring(FState, -1);
        lua_pop(FState, 1);
        raise ElgLuaRuntimeException.CreateFmt('Runtime error [%s]', [LErr]);
      end;
    // memory allocation error. For such errors, Lua does not call the error handler function.
    LUA_ERRMEM:
      begin
        LErr := lua_tostring(FState, -1);
        lua_pop(FState, 1);
        raise ElgLuaException.CreateFmt('Memory allocation error [%s]', [LErr]);
      end;
    // error while running the error handler function.
    LUA_ERRERR:
      begin
        LErr := lua_tostring(FState, -1);
        lua_pop(FState, 1);
        raise ElgLuaException.CreateFmt
          ('Error while running the error handler function [%s]', [LErr]);
      end;
    LUA_ERRSYNTAX:
      begin
        LErr := lua_tostring(FState, -1);
        lua_pop(FState, 1);
        raise ElgLuaSyntaxError.CreateFmt('Syntax Error [%s]', [LErr]);
      end
  else
    begin
      LErr := lua_tostring(FState, -1);
      lua_pop(FState, 1);
      raise ElgLuaException.CreateFmt('Unknown Error [%s]', [LErr]);
    end;
  end;
end;

function TlgLua.PushGlobalTableForSet(aName: array of string; var aIndex: Integer): Boolean;
var
  LMarshall: TMarshaller;
  LI: Integer;
begin
  Result := False;

  if FState = nil then Exit;

  if Length(aName) < 2 then Exit;

  aIndex := Length(aName) - 1;

  // check if global table exists
  lua_getglobal(FState, LMarshall.AsAnsi(aName[0]).ToPointer);

  // table does not exist, create new one
  if lua_type(FState, lua_gettop(FState)) <> LUA_TTABLE then
  begin
    // clean up stack
    lua_pop(FState, 1);

    // create new table
    lua_newtable(FState);

    // make it global
    lua_setglobal(FState, LMarshall.AsAnsi(aName[0]).ToPointer);

    // push global table back on stack
    lua_getglobal(FState, LMarshall.AsAnsi(aName[0]).ToPointer);
  end;

  // process tables in global table at index 1+
  // global table on stack, process remaining tables
  for LI := 1 to aIndex - 1 do
  begin
    // check if table at field aIndex[i] exits
    lua_getfield(FState, LI, LMarshall.AsAnsi(aName[LI]).ToPointer);

    // table field does not exists, create a new one
    if lua_type(FState, -1) <> LUA_TTABLE then
    begin
      // clean up stack
      lua_pop(FState, 1);

      // push new table
      lua_newtable(FState);

      // set new table a field
      lua_setfield(FState, LI, LMarshall.AsAnsi(aName[LI]).ToPointer);

      // push field table back on stack
      lua_getfield(FState, LI, LMarshall.AsAnsi(aName[LI]).ToPointer);
    end;
  end;

  Result := True;
end;

function TlgLua.PushGlobalTableForGet(aName: array of string; var aIndex: Integer): Boolean;
var
  LMarshall: TMarshaller;
  LI: Integer;
begin
  // assume false
  Result := False;

  if FState = nil then Exit;

  // check for valid table name count
  if Length(aName) < 2 then Exit;

  // init stack index
  aIndex := Length(aName) - 1;

  // lookup global table
  lua_getglobal(FState, LMarshall.AsAnsi(aName[0]).ToPointer);

  // check of global table exits
  if lua_type(FState, lua_gettop(FState)) = LUA_TTABLE then
  begin
    // process tables in global table at index 1+
    // global table on stack, process remaining tables
    for LI := 1 to aIndex - 1 do
    begin
      // get table at field aIndex[i]
      lua_getfield(FState, LI, LMarshall.AsAnsi(aName[LI]).ToPointer);

      // table field does not exists, exit
      if lua_type(FState, -1) <> LUA_TTABLE then
      begin
        // table name does not exit so we are out of here with an error
        Exit;
      end;
    end;
  end;

  // all table names exits we are good
  Result := True;
end;

procedure TlgLua.PushTValue(aValue: TValue);
var
  LUtf8s: RawByteString;
begin
  if FState = nil then Exit;

  case aValue.Kind of
    tkUnknown, tkChar, tkSet, tkMethod, tkVariant, tkArray, tkProcedure, tkRecord, tkInterface, tkDynArray, tkClassRef:
      begin
        lua_pushnil(FState);
      end;
    tkInteger:
      lua_pushinteger(FState, aValue.AsInteger);
    tkEnumeration:
      begin
        if aValue.IsType<Boolean> then
        begin
          if aValue.AsBoolean then
            lua_pushboolean(FState, Ord(True))
          else
            lua_pushboolean(FState, Ord(False));
        end
        else
          lua_pushinteger(FState, aValue.AsInteger);
      end;
    tkFloat:
      lua_pushnumber(FState, aValue.AsExtended);
    tkString, tkWChar, tkLString, tkWString, tkUString:
      begin
        LUtf8s := UTF8Encode(aValue.AsString);
        lua_pushstring(FState, PAnsiChar(LUtf8s));
      end;
    //tkClass:
    //  lua_pushlightuserdata(FState, Pointer(aValue.AsObject));
    tkInt64:
      lua_pushnumber(FState, aValue.AsInt64);
    //tkPointer:
    //  lua_pushlightuserdata(FState, Pointer(aValue.AsObject));
  end;
end;

function TlgLua.CallFunction(const aParams: array of TValue): TValue;
var
  LP: TValue;
  LR: Integer;
begin
  if FState = nil then Exit;

  for LP in aParams do
    PushTValue(LP);
  LR := lua_pcall(FState, Length(aParams), 1, 0);
  CheckLuaError(LR);
  lua_pop(FState, 1);
  case lua_type(FState, -1) of
    LUA_TNIL:
      begin
        Result := nil;
      end;

    LUA_TBOOLEAN:
      begin
        Result := Boolean(lua_toboolean(FState, -1));
      end;

    LUA_TNUMBER:
      begin
        Result := lua_tonumber(FState, -1);
      end;

    LUA_TSTRING:
      begin
        Result := lua_tostring(FState, -1);
      end;
  else
    Result := nil;
  end;
end;

procedure TlgLua.Bundle(aInFilename: string; aOutFilename: string);
begin
  if FState = nil then Exit;

  if aInFilename.IsEmpty then  Exit;
  if aOutFilename.IsEmpty then Exit;
  aInFilename := aInFilename.Replace('\', '/');
  aOutFilename := aOutFilename.Replace('\', '/');
  LoadBuffer(@cLUABUNDLE_LUA, Length(cLUABUNDLE_LUA), False);
  DoCall([PChar(aInFilename), PChar(aOutFilename)]);
end;

constructor TlgLua.Create();
begin
  inherited;

  FState := nil;
  Open;
end;

destructor TlgLua.Destroy;
begin
  Close();
  inherited;
end;

procedure TlgLua.Reset();
begin
  if FState = nil then Exit;

  //TODO: Add OnPreLuaReset callback
  Close;
  Open;
  //TODO: add OnPostLuaReset callback
end;

function TlgLua.LoadFile(const aFilename: string; aAutoRun: Boolean): Boolean;
var
  LMarshall: TMarshaller;
  LErr: string;
  LRes: Integer;
begin
  Result := False;
  if FState = nil then Exit;

  if aFilename.IsEmpty then Exit;

  if not TFile.Exists(aFilename) then Exit;
  if aAutoRun then
    LRes := luaL_dofile(FState, LMarshall.AsUtf8(aFilename).ToPointer)
  else
    LRes := luaL_loadfile(FState, LMarshall.AsUtf8(aFilename).ToPointer);
  if LRes <> 0 then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ElgLuaException.Create(LErr);
  end;

  Result := True;
end;

procedure TlgLua.LoadString(const aData: string; aAutoRun: Boolean);
var
  LMarshall: TMarshaller;
  LErr: string;
  LRes: Integer;
  LData: string;
begin
  if FState = nil then Exit;

  LData := aData;
  if LData.IsEmpty then Exit;

  if aAutoRun then
    LRes := luaL_dostring(FState, LMarshall.AsAnsi(LData).ToPointer)
  else
    LRes := luaL_loadstring(FState, LMarshall.AsAnsi(LData).ToPointer);

  if LRes <> 0 then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ElgLuaException.Create(LErr);
  end;
end;

procedure TlgLua.LoadStream(aStream: TStream; aSize: NativeUInt; aAutoRun: Boolean);
var
  LMemStream: TMemoryStream;
  LSize: NativeUInt;
begin
  if FState = nil then Exit;

  LMemStream := TMemoryStream.Create;
  try
    if aSize = 0 then
      LSize := aStream.Size
    else
      LSize := aSize;
    LMemStream.Position := 0;
    LMemStream.CopyFrom(aStream, LSize);
    LoadBuffer(LMemStream.Memory, LMemStream.size, aAutoRun);
  finally
    FreeAndNil(LMemStream);
  end;
end;

procedure TlgLua.LoadBuffer(aData: Pointer; aSize: NativeUInt; aAutoRun: Boolean);
var
  LMemStream: TMemoryStream;
  LRes: Integer;
  LErr: string;
  LSize: NativeUInt;
begin
  if FState = nil then Exit;

  LMemStream := TMemoryStream.Create;
  try
    LMemStream.Write(aData^, aSize);
    LMemStream.Position := 0;
    LSize := LMemStream.Size;
    if aAutoRun then
      LRes := luaL_dobuffer(FState, LMemStream.Memory, LSize, 'LoadBuffer')
    else
      LRes := luaL_loadbuffer(FState, LMemStream.Memory, LSize, 'LoadBuffer');
  finally
    FreeAndNil(LMemStream);
  end;

  if LRes <> 0 then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ElgLuaException.Create(LErr);
  end;
end;

procedure TlgLua.SaveByteCode(aStream: TStream);
var
  LRet: Integer;
begin
  if FState = nil then Exit;

  if lua_type(FState, lua_gettop(FState)) <> LUA_TFUNCTION then Exit;

  try
    LRet := lua_dump(FState, LuaWrapperWriter, aStream);
    if LRet <> 0 then
      raise ElgLuaException.CreateFmt('lua_dump returned code %d', [LRet]);
  finally
    lua_pop(FState, 1);
  end;
end;

procedure TlgLua.LoadByteCode(aStream: TStream; aName: string; aAutoRun: Boolean);
var
  LRes: NativeUInt;
  LErr: string;
  LMemStream: TMemoryStream;
  LMarshall: TMarshaller;
begin
  if FState = nil then Exit;
  if aStream = nil then Exit;
  if aStream.size <= 0 then Exit;

  LMemStream := TMemoryStream.Create;

  try
    LMemStream.CopyFrom(aStream, aStream.size);

    if aAutoRun then
    begin
      LRes := luaL_dobuffer(FState, LMemStream.Memory, LMemStream.size,
        LMarshall.AsAnsi(aName).ToPointer)
    end
    else
      LRes := luaL_loadbuffer(FState, LMemStream.Memory, LMemStream.size,
        LMarshall.AsAnsi(aName).ToPointer);
  finally
    LMemStream.Free;
  end;

  if LRes <> 0 then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ElgLuaException.Create(LErr);
  end;

end;

procedure TlgLua.PushLuaValue(aValue: TlgLuaValue);
begin
  if FState = nil then Exit;

  case aValue.AsType of
    vtInteger:
      begin
        lua_pushinteger(FState, aValue.AsInteger);
      end;
    vtDouble:
      begin
        lua_pushnumber(FState, aVAlue.AsNumber);
      end;
    vtString:
      begin
        lua_pushstring(FState, PAnsiChar(UTF8Encode(aValue.AsString)));
      end;
    vtPointer:
      begin
        lua_pushlightuserdata(FState, aValue.AsPointer);
      end;
    vtBoolean:
      begin
        lua_pushboolean(FState, aValue.AsBoolean.ToInteger);
      end;
  else
    begin
      lua_pushnil(FState);
    end;
  end;
end;

var TLua_GetLuaValue_LStr: string = '';
function TlgLua.GetLuaValue(aIndex: Integer): TlgLuaValue;
begin
  Result := nil;

  if FState = nil then Exit;

  case lua_type(FState, aIndex) of
    LUA_TNIL:
      begin
        Result := nil;
      end;

    LUA_TBOOLEAN:
      begin
        Result := Boolean(lua_toboolean(FState, aIndex));
      end;

    LUA_TNUMBER:
      begin
        Result := lua_tonumber(FState, aIndex);
      end;

    LUA_TSTRING:
      begin
        TLua_GetLuaValue_LStr := lua_tostring(FState, aIndex);
        Result := PChar(TLua_GetLuaValue_LStr);
      end;
  else
    begin
      Result := nil;
    end;
  end;
end;

function TlgLua.DoCall(const aParams: array of TlgLuaValue): TlgLuaValue;
var
  LValue: TlgLuaValue;
  LRes: Integer;
begin
  if FState = nil then Exit;

  for LValue in aParams do
  begin
    PushLuaValue(LValue);
  end;

  LRes := lua_pcall(FState, Length(aParams), 1, 0);
  CheckLuaError(LRes);
  Result := GetLuaValue(-1);
end;

function TlgLua.DoCall(aParamCount: Integer): TlgLuaValue;
var
  LRes: Integer;
begin
  Result := nil;
  if FState = nil then Exit;

  LRes := lua_pcall(FState, aParamCount, 1, 0);
  CheckLuaError(LRes);
  Result := GetLuaValue(-1);
  CleanStack();
end;

procedure TlgLua.CleanStack();
begin
  if FState = nil then Exit;

  lua_pop(FState, lua_gettop(FState));
end;

function TlgLua.Call(const aName: string; const aParams: array of TlgLuaValue): TlgLuaValue;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
begin
  Result := nil;
  if FState = nil then Exit;

  if aName.IsEmpty then Exit;

  CleanStack;

  LItems := ParseTableNames(aName);

  if Length(LItems) > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;

      lua_getfield(FState,  LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LItems[0]).ToPointer);
    end;

  if not lua_isnil(FState, lua_gettop(FState)) then
  begin
    if lua_isfunction(FState, -1) then
    begin
      Result := DoCall(aParams);
    end;
  end;

  CleanStack();
end;

function TlgLua.PrepCall(const aName: string): Boolean;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
begin
  Result := False;
  if FState = nil then Exit;

  if aName.IsEmpty then Exit;

  CleanStack;

  LItems := ParseTableNames(aName);

  if Length(LItems) > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;

      lua_getfield(FState,  LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LItems[0]).ToPointer);
    end;

  Result := True;
end;

function TlgLua.Call(aParamCount: Integer): TlgLuaValue;
begin
  Result := nil;
  if FState <> nil then Exit;

  if not lua_isnil(FState, lua_gettop(FState)) then
  begin
    if lua_isfunction(FState, -1) then
    begin
      Result := DoCall(aParamCount);
    end;
  end;
end;

function TlgLua.RoutineExist(const aName: string): Boolean;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
  LName: string;
begin
  Result := False;
  if FState = nil then Exit;

  LName := aName;
  if LName.IsEmpty then  Exit;

  LItems := ParseTableNames(LName);

  LCount := Length(LItems);

  if LCount > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;
      lua_getfield(FState, LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LName).ToPointer);
    end;

  if not lua_isnil(FState, lua_gettop(FState)) then
  begin
    if lua_isfunction(FState, -1) then
    begin
      Result := True;
    end;
  end;

  CleanStack();
end;

procedure TlgLua.Run();
var
  LErr: string;
  LRes: Integer;
begin
  if FState = nil then Exit;

  LRes := LUA_OK;

  if lua_type(FState, lua_gettop(FState)) = LUA_TFUNCTION then
  begin
    LRes := lua_pcall(FState, 0, LUA_MULTRET, 0);
  end;

  if LRes <> 0 then
  begin
    LErr := lua_tostring(FState, -1);
    lua_pop(FState, 1);
    raise ElgLuaException.Create(LErr);
  end;
end;

function TlgLua.VariableExist(const aName: string): Boolean;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
  LName: string;
begin
  Result := False;
  if FState = nil then Exit;

  LName := aName;
  if LName.IsEmpty then Exit;

  LItems := ParseTableNames(LName);
  LCount := Length(LItems);

  if LCount > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;
      lua_getfield(FState, LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else if LCount = 1 then
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LName).ToPointer);
    end
  else
    begin
      Exit;
    end;

  if not lua_isnil(FState, lua_gettop(FState)) then
  begin
    Result := lua_isvariable(FState, -1);
  end;

  CleanStack();
end;

var TLua_GetVariable_LStr: string = '';
function TlgLua.GetVariable(const aName: string; aType: TlgLuaValueType): TlgLuaValue;
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
  LName: string;
begin
  Result := nil;
  if FState = nil then Exit;

  LName := aName;
  if LName.IsEmpty then Exit;

  LItems := ParseTableNames(LName);
  LCount := Length(LItems);

  if LCount > 1 then
    begin
      if not PushGlobalTableForGet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;
      lua_getfield(FState, LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer);
    end
  else if LCount = 1 then
    begin
      lua_getglobal(FState, LMarshall.AsAnsi(LName).ToPointer);
    end
  else
    begin
      Exit;
    end;

  case aType of
    vtInteger:
      begin
        Result := lua_tointeger(FState, -1);
      end;
    vtDouble:
      begin
        Result := lua_tonumber(FState, -1);
      end;
    vtString:
      begin
        TLua_GetVariable_LStr := lua_tostring(FState, -1);
        Result := PChar(TLua_GetVariable_LStr);
      end;
    vtPointer:
      begin
        Result := lua_touserdata(FState, -1);
      end;
    vtBoolean:
      begin
        Result := Boolean(lua_toboolean(FState, -1));
      end;
  end;

  CleanStack();
end;

procedure TlgLua.SetVariable(const aName: string; aValue: TlgLuaValue);
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LItems: TStringDynArray;
  LOk: Boolean;
  LCount: Integer;
  LName: string;
begin
  if FState = nil then Exit;

  LName := aName;
  if LName.IsEmpty then Exit;

  LItems := ParseTableNames(aName);
  LCount := Length(LItems);

  if LCount > 1 then
    begin
      if not PushGlobalTableForSet(LItems, LIndex) then
      begin
        CleanStack;
        Exit;
      end;
    end
  else if LCount < 1 then
    begin
      Exit;
    end;

  LOk := True;

  case aValue.AsType of
    vtInteger:
      begin
        lua_pushinteger(FState, aValue);
      end;
    vtDouble:
      begin
        lua_pushnumber(FState, aValue);
      end;
    vtString:
      begin
        lua_pushstring(FState, LMarshall.AsUtf8(aValue).ToPointer);
      end;
    vtPointer:
      begin
        lua_pushlightuserdata(FState, aValue);
      end;
    vtBoolean:
      begin
        lua_pushboolean(FState, aValue.AsBoolean.ToInteger);
      end;
  else
    begin
      LOk := False;
    end;
  end;

  if LOk then
  begin
    if LCount > 1 then
      begin
        lua_setfield(FState, LIndex, LMarshall.AsAnsi(LItems[LIndex]).ToPointer)
      end
    else
      begin
        lua_setglobal(FState, LMarshall.AsAnsi(LName).ToPointer);
      end;
  end;

  CleanStack();
end;

procedure TlgLua.RegisterRoutine(const aName: string; aRoutine: TlgLuaFunction);
var
  LMethod: TMethod;
  LMarshall: TMarshaller;
  LIndex: Integer;
  LNames: array of string;
  LI: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
begin
  if FState = nil then Exit;
  if aName.IsEmpty then Exit;

  // parse table LNames in table.table.xxx format
  LItems := ParseTableNames(aName);

  LCount := Length(LItems);

  SetLength(LNames, Length(LItems));

  for LI := 0 to High(LItems) do
  begin
    LNames[LI] := LItems[LI];
  end;

  // init sub table LNames
  if LCount > 1 then
    begin
      // push global table to stack
      if not PushGlobalTableForSet(LNames, LIndex) then
      begin
        CleanStack;
        Exit;
      end;

      // push closure
      LMethod.Code := TMethod(aRoutine).Code;
      LMethod.Data := TMethod(aRoutine).Data;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setfield(FState, -2, LMarshall.AsAnsi(LNames[LIndex]).ToPointer);

      CleanStack();
    end
  else if (LCount = 1) then
    begin
      // push closure
      LMethod.Code := TMethod(aRoutine).Code;
      LMethod.Data := TMethod(aRoutine).Data;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // set as global
      lua_setglobal(FState, LMarshall.AsAnsi(LNames[0]).ToPointer);
    end;
end;

procedure TlgLua.RegisterRoutine(const aName: string; aData: Pointer; aCode: Pointer);
var
  LMarshall: TMarshaller;
  LIndex: Integer;
  LNames: array of string;
  LI: Integer;
  LItems: TStringDynArray;
  LCount: Integer;
begin
  if FState = nil then Exit;
  if aName.IsEmpty then Exit;

  // parse table LNames in table.table.xxx format
  LItems := ParseTableNames(aName);

  LCount := Length(LItems);

  SetLength(LNames, Length(LItems));

  for LI := 0 to High(LItems) do
  begin
    LNames[LI] := LItems[LI];
  end;

  // init sub table LNames
  if LCount > 1 then
    begin
      // push global table to stack
      if not PushGlobalTableForSet(LNames, LIndex) then
      begin
        CleanStack;
        Exit;
      end;

      // push closure
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, aCode);
      lua_pushlightuserdata(FState, aData);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setfield(FState, -2, LMarshall.AsAnsi(LNames[LIndex]).ToPointer);

      CleanStack();
    end
  else if (LCount = 1) then
    begin
      // push closure
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, aCode);
      lua_pushlightuserdata(FState, aData);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // set as global
      lua_setglobal(FState, LMarshall.AsAnsi(LNames[0]).ToPointer);
    end;
end;

procedure TlgLua.RegisterRoutines(aClass: TClass);
var
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LRttiMethod: TRttiMethod;
  LMethodAutoSetup: TRttiMethod;

  LRttiParameters: TArray<System.Rtti.TRttiParameter>;
  LMethod: TMethod;
  LMarshall: TMarshaller;
begin
  if FState = nil then Exit;

  LRttiType := LRttiContext.GetType(aClass);
  LMethodAutoSetup := nil;

  for LRttiMethod in LRttiType.GetMethods do
  begin
    if (LRttiMethod.MethodKind <> mkClassProcedure) then continue;
    if (LRttiMethod.Visibility <> mvPublic) then continue;

    LRttiParameters := LRttiMethod.GetParameters;

    // check for public AutoSetup class function
    if SameText(LRttiMethod.Name, cLuaAutoSetup) then
    begin
      if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = IlgLua) then
      begin
        // call auto setup for this class
        // LRttiMethod.Invoke(aClass, [Self]);
        LMethodAutoSetup := LRttiMethod;
      end;
      continue;
    end;

    { Check if one parameter of type ILuaContext is present }
    if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = IlgLuaContext) then
    begin
      // push closure
      LMethod.Code := LRttiMethod.CodeAddress;
      LMethod.Data := aClass;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setglobal(FState, LMarshall.AsAnsi(LRttiMethod.Name).ToPointer);
    end;
  end;

  // clean up stack
  CleanStack();

  // invoke autosetup?
  if Assigned(LMethodAutoSetup) then
  begin
    // call auto setup LMethod
    LMethodAutoSetup.Invoke(aClass, [Self]);

    // clean up stack
    CleanStack();
  end;
end;

procedure TlgLua.RegisterRoutines(aObject: TObject);
var
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LRttiMethod: TRttiMethod;
  LMethodAutoSetup: TRttiMethod;
  LRttiParameters: TArray<System.Rtti.TRttiParameter>;
  LMethod: TMethod;
  LMarshall: TMarshaller;
begin
  if FState = nil then Exit;

  LRttiType := LRttiContext.GetType(aObject.ClassType);
  LMethodAutoSetup := nil;
  for LRttiMethod in LRttiType.GetMethods do
  begin
    if (LRttiMethod.MethodKind <> mkProcedure) then  continue;
    if (LRttiMethod.Visibility <> mvPublic) then continue;

    LRttiParameters := LRttiMethod.GetParameters;

    // check for public AutoSetup class function
    if SameText(LRttiMethod.Name, cLuaAutoSetup) then
    begin
      if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = IlgLua) then
      begin
        // call auto setup for this class
        LMethodAutoSetup := LRttiMethod;
      end;
      continue;
    end;

    { Check if one parameter of type ILuaContext is present }
    if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = IlgLuaContext) then
    begin
      // push closure
      LMethod.Code := LRttiMethod.CodeAddress;
      LMethod.Data := aObject;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setglobal(FState, LMarshall.AsAnsi(LRttiMethod.Name).ToPointer);
    end;
  end;

  // clean up stack
  CleanStack();

  // invoke autosetup?
  if Assigned(LMethodAutoSetup) then
  begin
    // call auto setup LMethod
    LMethodAutoSetup.Invoke(aObject, [Self]);

    // clean up stack
    CleanStack();
  end;
end;

procedure TlgLua.RegisterRoutines(const aTables: string; aClass: TClass; const aTableName: string);
var
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LRttiMethod: TRttiMethod;
  LMethodAutoSetup: TRttiMethod;

  LRttiParameters: TArray<System.Rtti.TRttiParameter>;
  LMethod: TMethod;
  LMarshall: TMarshaller;
  LIndex: Integer;
  LNames: array of string;
  TblName: string;
  LI: Integer;
  LItems: TStringDynArray;
  LLastIndex: Integer;
begin
  if FState = nil then Exit;

  // init the routines table name
  if aTableName.IsEmpty then
    TblName := aClass.ClassName
  else
    TblName := aTableName;

  // parse table LNames in table.table.xxx format
  LItems := ParseTableNames(aTables);

  // init sub table LNames
  if Length(LItems) > 0 then
  begin
    SetLength(LNames, Length(LItems) + 2);

    for LI := 0 to High(LItems) do
    begin
      LNames[LI] := LItems[LI];
    end;

    LLastIndex := Length(LItems);

    // set last as table name for functions
    LNames[LLastIndex] := TblName;
    LNames[LLastIndex + 1] := TblName;
  end
  else
  begin
    SetLength(LNames, 2);
    LNames[0] := TblName;
    LNames[1] := TblName;
  end;

  // push global table to stack
  if not PushGlobalTableForSet(LNames, LIndex) then
  begin
    CleanStack();
    Exit;
  end;

  LRttiType := LRttiContext.GetType(aClass);
  LMethodAutoSetup := nil;
  for LRttiMethod in LRttiType.GetMethods do
  begin
    if (LRttiMethod.MethodKind <> mkClassProcedure) then
      continue;
    if (LRttiMethod.Visibility <> mvPublic) then
      continue;

    LRttiParameters := LRttiMethod.GetParameters;

    // check for public AutoSetup class function
    if SameText(LRttiMethod.Name, cLuaAutoSetup) then
    begin
      if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = IlgLua) then
      begin
        // call auto setup for this class
        // LRttiMethod.Invoke(aClass, [Self]);
        LMethodAutoSetup := LRttiMethod;
      end;
      continue;
    end;

    { Check if one parameter of type ILuaContext is present }
    if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = IlgLuaContext) then
    begin
      // push closure
      LMethod.Code := LRttiMethod.CodeAddress;
      LMethod.Data := aClass;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setfield(FState, -2, LMarshall.AsAnsi(LRttiMethod.Name).ToPointer);
    end;
  end;

  // clean up stack
  CleanStack();

  // invoke autosetup?
  if Assigned(LMethodAutoSetup) then
  begin
    // call auto setup LMethod
    LMethodAutoSetup.Invoke(aClass, [Self]);

    // clean up stack
    CleanStack();
  end;
end;

procedure TlgLua.RegisterRoutines(const aTables: string; aObject: TObject; const aTableName: string);
var
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LRttiMethod: TRttiMethod;
  LMethodAutoSetup: TRttiMethod;
  LRttiParameters: TArray<System.Rtti.TRttiParameter>;
  LMethod: TMethod;
  LMarshall: TMarshaller;
  LIndex: Integer;
  LNames: array of string;
  TblName: string;
  LI: Integer;
  LItems: TStringDynArray;
  LLastIndex: Integer;
begin
  if FState = nil then Exit;

  // init the routines table name
  if aTableName.IsEmpty then
    TblName := aObject.ClassName
  else
    TblName := aTableName;

  // parse table LNames in table.table.xxx format
  LItems := ParseTableNames(aTables);

  // init sub table LNames
  if Length(LItems) > 0 then
    begin
      SetLength(LNames, Length(LItems) + 2);

      LLastIndex := 0;
      for LI := 0 to High(LItems) do
      begin
        LNames[LI] := LItems[LI];
        LLastIndex := LI;
      end;

      // set last as table name for functions
      LNames[LLastIndex] := TblName;
      LNames[LLastIndex + 1] := TblName;
    end
  else
    begin
      SetLength(LNames, 2);
      LNames[0] := TblName;
      LNames[1] := TblName;
    end;

  // push global table to stack
  if not PushGlobalTableForSet(LNames, LIndex) then
  begin
    CleanStack();
    Exit;
  end;

  LRttiType := LRttiContext.GetType(aObject.ClassType);
  LMethodAutoSetup := nil;
  for LRttiMethod in LRttiType.GetMethods do
  begin
    if (LRttiMethod.MethodKind <> mkProcedure) then continue;
    if (LRttiMethod.Visibility <> mvPublic) then continue;

    LRttiParameters := LRttiMethod.GetParameters;

    // check for public AutoSetup class function
    if SameText(LRttiMethod.Name, cLuaAutoSetup) then
    begin
      if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = IlgLua) then
      begin
        // call auto setup for this class
        // LRttiMethod.Invoke(aObject.ClassType, [Self]);
        LMethodAutoSetup := LRttiMethod;
      end;
      continue;
    end;

    { Check if one parameter of type ILuaContext is present }
    if (Length(LRttiParameters) = 1) and (Assigned(LRttiParameters[0].ParamType)) and (LRttiParameters[0].ParamType.TypeKind = tkInterface) and (TRttiInterfaceType(LRttiParameters[0].ParamType).GUID = IlgLuaContext) then
    begin
      // push closure
      LMethod.Code := LRttiMethod.CodeAddress;
      LMethod.Data := aObject;
      lua_pushlightuserdata(FState, Self);
      lua_pushlightuserdata(FState, LMethod.Code);
      lua_pushlightuserdata(FState, LMethod.Data);
      lua_pushcclosure(FState, @LuaWrapperClosure, 3);

      // add field to table
      lua_setfield(FState, -2, LMarshall.AsAnsi(LRttiMethod.Name).ToPointer);
    end;
  end;

  // clean up stack
  CleanStack();

  // invoke autosetup?
  if Assigned(LMethodAutoSetup) then
  begin
    // call auto setup LMethod
    LMethodAutoSetup.Invoke(aObject, [Self]);

    // clean up stack
    CleanStack();
  end;
end;

procedure TlgLua.CompileToStream(aFilename: string; aStream: TStream; aCleanOutput: Boolean);
var
  LInFilename: string;
  LBundleFilename: string;
begin
  if FState = nil then Exit;

  LInFilename := aFilename;
  LBundleFilename := TPath.GetFileNameWithoutExtension(LInFilename) + '_bundle.lua';
  LBundleFilename := TPath.Combine(TPath.GetDirectoryName(LInFilename), LBundleFilename);
  Bundle(LInFilename, LBundleFilename);
  LoadFile(PChar(LBundleFilename), False);
  SaveByteCode(aStream);
  CleanStack;

  if aCleanOutput then
  begin
    if TFile.Exists(LBundleFilename) then
    begin
      TFile.Delete(LBundleFilename);
    end;
  end;
end;

procedure TlgLua.SetGCStepSize(aStep: Integer);
begin
  FGCStep := aStep;
end;

function TlgLua.GetGCStepSize: Integer;
begin
  Result := FGCStep;
end;

function TlgLua.GetGCMemoryUsed: Integer;
begin
  Result := 0;
  if FState = nil then Exit;

  Result := lua_gc(FState, LUA_GCCOUNT, FGCStep);
end;

procedure TlgLua.CollectGarbage;
begin
  if FState = nil then Exit;

  lua_gc(FState, LUA_GCSTEP, FGCStep);
end;

{ === SPRITE ================================================================ }
{ --- TlgSprite ------------------------------------------------------------- }
constructor TlgSprite.Create();
begin
  inherited;
  FTextures := nil;
  FGroups := nil;
  FPageCount := 0;
  FGroupCount := 0;
end;

destructor TlgSprite.Destroy();
begin
  Clear();
  inherited;
end;

procedure TlgSprite.Clear();
var
  I: Integer;
begin
  if FTextures <> nil then
  begin
    // free group data
    for I := 0 to FGroupCount - 1 do
    begin
      // free image array
      FGroups[I].Image := nil;
    end;

    // free page
    for I := 0 to FPageCount - 1 do
    begin
      if Assigned(FTextures[I]) then
      begin
        FTextures[I].Free();
        FTextures[I] := nil;
      end;
    end;
  end;

  FTextures := nil;
  FGroups := nil;
  FPageCount := 0;
  FGroupCount := 0;
end;

function TlgSprite.LoadPageFromFile(const AFilename: string; AColorKey: PlgColor): Integer;
var
  LTexture: TlgTexture;
begin
  Result := -1;
  LTexture := TlgTexture.LoadFromFile(AFilename, AColorKey);
  if not Assigned(LTexture) then Exit;

  Result := FPageCount;
  Inc(FPageCount);
  SetLength(FTextures, FPageCount);
  FTextures[Result] := LTexture;
end;

function TlgSprite.LoadPageFromZipFile(const AZipFile: TlgZipFile; const AFilename: string; AColorKey: PlgColor): Integer;
var
  LTexture: TlgTexture;
begin
  Result := -1;
  LTexture := TlgTexture.LoadFromZipFile(AZipFile, AFilename, AColorKey);
  if not Assigned(LTexture) then Exit;

  Result := FPageCount;
  Inc(FPageCount);
  SetLength(FTextures, FPageCount);
  FTextures[Result] := LTexture;
end;

function TlgSprite.AddGroup(): Integer;
begin
  Result := FGroupCount;
  Inc(FGroupCount);
  SetLength(FGroups, FGroupCount);
end;

function TlgSprite.GetGroupCount(): Integer;
begin
  Result := FGroupCount;
end;

function TlgSprite.AddImageFromRect(const APage, AGroup: Integer; const ARect: TlgRect; const AXOffset: Integer; const AYOffset: Integer): Integer;
begin
  Result := -1;
  if not InRange(APage, 0, FPageCount-1) then Exit;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;

  Result := FGroups[AGroup].Count;
  Inc(FGroups[AGroup].Count);
  SetLength(FGroups[AGroup].Image, FGroups[AGroup].Count);

  FGroups[AGroup].Image[Result].Rect.X := ARect.X + AXOffset;
  FGroups[AGroup].Image[Result].Rect.Y := ARect.Y + AYOffset;
  FGroups[AGroup].Image[Result].Rect.Width := aRect.Width;
  FGroups[AGroup].Image[Result].Rect.Height := aRect.Height;
  FGroups[AGroup].Image[Result].Page := APage;
end;

function TlgSprite.AddImageFromGrid(const APage, AGroup, AGridX, AGridY, AGridWidth, AGridHeight: Integer; const AXOffset: Integer; const AYOffset: Integer): Integer;
begin
  Result := -1;
  if not InRange(APage, 0, FPageCount-1) then Exit;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;

  Result := FGroups[AGroup].Count;
  Inc(FGroups[AGroup].Count);
  SetLength(FGroups[AGroup].Image, FGroups[AGroup].Count);

  FGroups[AGroup].Image[Result].Rect.X := (aGridWidth * aGridX) + AXOffset;
  FGroups[AGroup].Image[Result].Rect.Y := (aGridHeight * aGridY) + AYOffset;
  FGroups[AGroup].Image[Result].Rect.Width := aGridWidth;
  FGroups[AGroup].Image[Result].Rect.Height := aGridHeight;
  FGroups[AGroup].Image[Result].Page := APage;
end;

function TlgSprite.AddImages(const APage, AGroup, AColCount, ARowCount, AImageWidth, AImageHeight: Integer; const AXOffset: Integer=0; const AYOffset: Integer=0): Boolean;
var
  X, Y: Integer;
begin
  Result := False;
  for Y  := 0 to ARowCount-1 do
  begin
    for X := 0 to AColCount-1 do
    begin
      if AddImageFromGrid(APage, AGroup, X, Y,  AImageWidth, AImageHeight, AXOffset, AYOffset) = -1 then Exit;
    end;
  end;
  Result := True;
end;

function TlgSprite.GetImageCount(const AGroup: Integer): Integer;
begin
  Result := -1;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  Result := FGroups[AGroup].Count;
end;

function TlgSprite.GetImageWidth(const ANum, AGroup: Integer): Single;
begin
  Result := -1;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  if not InRange(ANum, 0, FGroups[AGroup].Count-1) then Exit;
  Result := FGroups[AGroup].Image[ANum].Rect.Width;
end;

function TlgSprite.GetImageHeight(const ANum, AGroup: Integer): Single;
begin
  Result := 0;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  if not InRange(ANum, 0, FGroups[AGroup].Count-1) then Exit;
  Result := FGroups[AGroup].Image[ANum].Rect.Height;
end;

function TlgSprite.GetImageTexture(const ANum, AGroup: Integer): TlgTexture;
begin
  Result := nil;
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  if not InRange(ANum, 0, FGroups[AGroup].Count-1) then Exit;
  Result := FTextures[FGroups[AGroup].Image[ANum].Page];
end;

function TlgSprite.GetImageRegion(const ANum, AGroup: Integer): TlgRect;
begin
  Result := Math.Rect(-1,-1,-1,-1);
  if not InRange(AGroup, 0, FGroupCount-1) then Exit;
  if not InRange(ANum, 0, FGroups[AGroup].Count-1) then Exit;
  Result := FGroups[AGroup].Image[ANum].Rect;
end;

{ === ENTITY ================================================================ }
{ --- TlgEntity ------------------------------------------------------------- }
constructor TlgEntity.Create();
begin
  inherited;
end;

destructor TlgEntity.Destroy();
begin
  inherited;
end;

function TlgEntity.Init(const ASprite: TlgSprite; const AGroup: Integer): Boolean;
begin
  Result := False;
  if not Assigned(ASprite) then Exit;
  if not InRange(AGroup, 0, ASprite.GetGroupCount()-1) then Exit;

  FSprite := aSprite;
  FGroup := AGroup;
  SetFrameRange(0, ASprite.GetImageCount(FGroup)-1);
  SetFrameSpeed(5);
  SetScaleAbs(1.0);
  RotateAbs(0);
  SetAngleOffset(0);
  SetColor(WHITE);
  SetHFlip(False);
  SetVFlip(False);
  SetLoopFrame(True);
  SetPosAbs(0, 0);
  SetBlend(tbAlpha);
  SetPivot(0.5, 0.5);
  SetAnchor(0.5, 0.5);

  Result := True;
end;

function  TlgEntity.GetPivot(): TlgPoint;
begin
  Result := FPivot;
end;

procedure TlgEntity.SetPivot(const APoint: TlgPoint);
begin
  FPivot := APoint;
end;

procedure TlgEntity.SetPivot(const X, Y: Single);
begin
  FPivot.x := X;
  FPivot.y := Y;
end;

function  TlgEntity.GetAnchor(): TlgPoint;
begin
  Result := FAnchor;
end;

procedure TlgEntity.SetAnchor(const APoint: TlgPoint);
begin
  FAnchor := APoint;
end;

procedure TlgEntity.SetAnchor(const X, Y: Single);
begin
  FAnchor.x := X;
  FAnchor.y := Y;
end;

procedure TlgEntity.SetFrameRange(const aFirst, aLast: Integer);
begin
  FFirstFrame := aFirst;
  FLastFrame  := aLast;
end;

function  TlgEntity.NextFrame(): Boolean;
begin
  Result := False;
  if FFrameTimer.Check() then
  begin
    Inc(FFrame);
    if FFrame > FLastFrame then
    begin
      if FLoopFrame then
        FFrame := FFirstFrame
      else
        FFrame := FLastFrame;
      Result := True;
    end;
  end;
  SetFrame(FFrame);
end;

function  TlgEntity.PrevFrame(): Boolean;
begin
  Result := False;
  if FFrameTimer.Check() then
  begin
    Dec(FFrame);
    if FFrame < FFirstFrame then
    begin
      if FLoopFrame then
        FFrame := FLastFrame
      else
        FFrame := FFirstFrame;
      Result := True;
    end;
  end;

  SetFrame(FFrame);
end;

function  TlgEntity.GetFrame(): Integer;
begin
  Result := FFrame;
end;

procedure TlgEntity.SetFrame(const AFrame: Integer);
var
  LW, LH, LR: Single;
begin
  FFrame := aFrame;
  EnsureRange(FFrame, 0, FSprite.GetImageCount(FGroup)-1);

  LW := FSprite.GetImageWidth(FFrame, FGroup);
  LH := FSprite.GetImageHeight(FFrame, FGroup);

  LR := (LW + LH) / 2;

  FWidth  := LW * FScale;
  FHeight := LH * FScale;
  FRadius := LR * FScale;
end;

function  TlgEntity.GetFrameSpeed(): Single;
begin
  Result := FFrameTimer.Speed();
end;

procedure TlgEntity.SetFrameSpeed(const AFrameSpeed: Single);
begin
  FFrameTimer.InitFPS(AFrameSpeed);
end;

function  TlgEntity.GetFirstFrame(): Integer;
begin
  Result := FFirstFrame;
end;

function  TlgEntity.GetLastFrame(): Integer;
begin
  Result := FLastFrame;
end;

procedure TlgEntity.SetPosAbs(const X, Y: Single);
begin
  FPos.X := X;
  FPos.Y := Y;
  FDir.X := 0;
  FDir.Y := 0;
end;

procedure TlgEntity.SetPosRel(const X, Y: Single);
begin
  FPos.X := FPos.X + X;
  FPos.Y := FPos.Y + Y;
  FDir.X := X;
  FDir.Y := Y;
end;

function  TlgEntity.GetPos(): TlgVec;
begin
  Result := Math.Vec(0,0);
end;

function  TlgEntity.GetDir(): TlgVec;
begin
  Result := Math.Vec(0,0);
end;

procedure TlgEntity.SetScaleAbs(const AScale: Single);
begin
  FScale := AScale;
  SetFrame(FFrame);
end;

procedure TlgEntity.SetScaleRel(const AScale: Single);
begin
  FScale := FScale + AScale;
  SetFrame(FFrame);
end;

function  TlgEntity.GetAngle(): Single;
begin
  Result := FAngle;
end;

function  TlgEntity.GetAngleOffset(): Single;
begin
  Result := FAngleOffset;
end;

procedure TlgEntity.SetAngleOffset(const AAngle: Single);
begin
  FAngleOffset := FAngleOffset + AAngle;
  Math.ClipValueFloat(FAngleOffset, 0, 360, True);
end;

procedure TlgEntity.RotateAbs(const AAngle: Single);
begin
  FAngle := AAngle;
  Math.ClipValueFloat(FAngle, 0, 360, True);
end;

procedure TlgEntity.RotateRel(const AAngle: Single);
begin
  FAngle := FAngle + AAngle;
  Math.ClipValueFloat(FAngle, 0, 360, True);
end;

function  TlgEntity.RotateToAngle(const AAngle, ASpeed: Single): Boolean;
var
  Step: Single;
  Len : Single;
  S   : Single;
begin
  Result := False;
  Step := Math.AngleDifference(FAngle, AAngle);
  Len  := Sqrt(Step*Step);
  if Len = 0 then
    Exit;
  S    := (Step / Len) * aSpeed;
  FAngle := FAngle + S;
  if Math.SameValueExt(Step, 0, S) then
  begin
    RotateAbs(aAngle);
    Result := True;
  end;
end;

function  TlgEntity.RotateToPos(const X, Y, ASpeed: Single): Boolean;
var
  LAngle: Single;
  LStep: Single;
  LLen: Single;
  LS: Single;
  LTmpPos: TlgVec;
begin
  Result := False;
  LTmpPos.X  := X;
  LTmpPos.Y  := Y;

  LAngle := -FPos.Angle(LTmpPos);
  LStep := Math.AngleDifference(FAngle, LAngle);
  LLen  := Sqrt(LStep*LStep);
  if LLen = 0 then
    Exit;
  LS := (LStep / LLen) * aSpeed;

  if not Math.SameValueExt(LStep, LS, aSpeed) then
    RotateRel(LS)
  else begin
    RotateRel(LStep);
    Result := True;
  end;
end;

function  TlgEntity.RotateToPosAt(const aSrcX, aSrcY, ADestX, ADestY, ASpeed: Single): Boolean;
var
  LAngle: Single;
  LStep : Single;
  LLen  : Single;
  LS    : Single;
  LSPos,LDPos : TlgVec;
begin
  Result := False;
  LSPos.X := aSrcX;
  LSPos.Y := aSrcY;
  LDPos.X  := aDestX;
  LDPos.Y  := aDestY;

  LAngle := LSPos.Angle(LDPos);
  LStep := Math.AngleDifference(FAngle, LAngle);
  LLen  := Sqrt(LStep*LStep);
  if LLen = 0 then
    Exit;
  LS := (LStep / LLen) * aSpeed;
  if not Math.SameValueExt(LStep, LS, aSpeed) then
    RotateRel(LS)
  else begin
    RotateRel(LStep);
    Result := True;
  end;
end;

procedure TlgEntity.Thrust(const ASpeed: Single);
var
  LS: Single;
  LA: Integer;
begin
  LA := Round(FAngle + 90.0);
  LA := Math.ClipValueInt(LA, 0, 360, True);

  LS := -aSpeed;

  FDir.x := Math.AngleCos(LA) * LS;
  FDir.y := Math.AngleSin(LA) * LS;

  FPos.x := FPos.x + FDir.x;
  FPos.y := FPos.y + FDir.y;
end;

procedure TlgEntity.ThrustAngle(const AAngle, ASpeed: Single);
var
  LS: Single;
  LA: Integer;
begin
  LA := Round(AAngle);

  Math.ClipValueInt(LA, 0, 360, True);

  LS := -aSpeed;

  FDir.x := Math.AngleCos(LA) * LS;
  FDir.y := Math.AngleSin(LA) * LS;

  FPos.x := FPos.x + FDir.x;
  FPos.y := FPos.y + FDir.y;
end;

function  TlgEntity.ThrustToPos(const aThrustSpeed, ARotSpeed, ADestX, ADestY, ASlowdownDist, AStopDist, AStopSpeed, AStopSpeedEpsilon: Single): Boolean;
var
  LDist : Single;
  LStep : Single;
  LSpeed: Single;
  LDestPos: TlgVec;
  LStopDist: Single;
begin
  Result := False;

  if aSlowdownDist <= 0 then Exit;
  LStopDist := AStopDist;
  if LStopDist < 0 then LStopDist := 0;

  LDestPos.X := aDestX;
  LDestPos.Y := aDestY;
  LDist := FPos.Distance(LDestPos);

  LDist := LDist - LStopDist;

  if LDist > aSlowdownDist then
    begin
      LSpeed := aThrustSpeed;
    end
  else
    begin
      LStep := (LDist/aSlowdownDist);
      LSpeed := (aThrustSpeed * LStep);
      if LSpeed <= aStopSpeed then
      begin
        LSpeed := 0;
        Result := True;
      end;
    end;

  if RotateToPos(aDestX, aDestY, aRotSpeed) then
  begin
    Thrust(LSpeed);
  end;
end;

function  TlgEntity.IsVisible(const AWindow: TlgWindow): Boolean;
var
  LHW,LHH: Single;
  LVPX,LVPY,LVPW,LVPH: Integer;
  LX,LY: Single;
begin
  Result := False;

  LHW := FWidth / 2;
  LHH := FHeight / 2;

  AWindow.GetViewport(@LVPX, @LVPY, @LVPW, @LVPH);

  Dec(LVPW); Dec(LVPH);

  LX := FPos.X;
  LY := FPos.Y;

  if LX > (LVPW + LHW) then Exit;
  if LX < -LHW    then Exit;
  if LY > (LVPH + LHH) then Exit;
  if LY < -LHH    then Exit;

  Result := True;
end;

function  TlgEntity.IsFullyVisible(const AWindow: TlgWindow): Boolean;
var
  LHW,LHH: Single;
  LVPX,LVPY,LVPW,LVPH: Integer;
  LX,LY: Single;
begin
  Result := False;

  LHW := FWidth / 2;
  LHH := FHeight / 2;

  AWindow.GetViewport(@LVPX, @LVPY, @LVPW, @LVPH);

  Dec(LVPW); Dec(LVPH);

  LX := FPos.X;
  LY := FPos.Y;

  if LX > (LVPW - LHW) then Exit;
  if LX <  LHW       then Exit;
  if LY > (LVPH - LHH) then Exit;
  if LY <  LHH       then Exit;

  Result := True;
end;

function  TlgEntity.Overlap(const X, Y, aRadius, aShrinkFactor: Single): Boolean;
var
  LDist: Single;
  LR1,LR2: Single;
  LV0,LV1: TlgVec;
begin
  LR1  := FRadius * aShrinkFactor;
  LR2  := aRadius * aShrinkFactor;

  LV0.X := FPos.X;
  LV0.Y := FPos.Y;

  LV1.x := X;
  LV1.y := Y;

  LDist := LV0.Distance(LV1);

  if (LDist < LR1) or (LDist < LR2) then
    Result := True
  else
   Result := False;
end;

function  TlgEntity.Overlap(const AEntity: TlgEntity; const AType: TEntityOverlap=eoAABB): Boolean;
var
  LTextureA, LTextureB: TlgTexture;
begin
  Result := False;

  LTextureA := FSprite.GetImageTexture(FFrame, FGroup);
  LTextureB := AEntity.FSprite.GetImageTexture(AEntity.FFrame, AEntity.FGroup);

  LTextureA.SetPivot(FPivot);
  LTextureA.SetAnchor(FAnchor);
  LTextureA.SetPos(FPos.x, FPos.y);
  LTextureA.SetScale(FScale);
  LTextureA.SetAngle(FAngle);
  LTextureA.SetHFlip(FHFlip);
  LTextureA.SetVFlip(FVFlip);
  LTextureA.SetRegion(FSprite.GetImageRegion(FFrame, FGroup));

  LTextureB.SetPivot(AEntity.FPivot);
  LTextureB.SetAnchor(AEntity.FAnchor);
  LTextureB.SetPos(AEntity.FPos.x, AEntity.FPos.y);
  LTextureB.SetScale(AEntity.FScale);
  LTextureB.SetAngle(AEntity.FAngle);
  LTextureB.SetHFlip(AEntity.FHFlip);
  LTextureB.SetVFlip(AEntity.FVFlip);
  LTextureB.SetRegion(AEntity.FSprite.GetImageRegion(FFrame, FGroup));

  case AType of
    eoAABB: Result := LTextureA.CollideAABB(LTextureB);
    eoOBB : Result := LTextureA.CollideOBB(LTextureB);
  end;

end;

procedure TlgEntity.Render();
var
  LTexture: TlgTexture;
begin
  LTexture := FSprite.GetImageTexture(FFrame, FGroup);
  LTexture.SetPivot(FPivot);
  LTexture.SetAnchor(FAnchor);
  LTexture.SetPos(FPos.x, FPos.y);
  LTexture.SetScale(FScale);
  LTexture.SetAngle(FAngle);
  LTexture.SetHFlip(FHFlip);
  LTexture.SetVFlip(FVFlip);
  LTexture.SetRegion(FSprite.GetImageRegion(FFrame, FGroup));
  LTexture.SetBlend(FBlend);
  LTexture.SetColor(FColor);
  LTexture.Draw();
end;

procedure TlgEntity.RenderAt(const X, Y: Single);
var
  LTexture: TlgTexture;
begin
  LTexture := FSprite.GetImageTexture(FFrame, FGroup);
  LTexture.SetPivot(FPivot);
  LTexture.SetAnchor(FAnchor);
  LTexture.SetPos(X, Y);
  LTexture.SetScale(FScale);
  LTexture.SetAngle(FAngle);
  LTexture.SetHFlip(FHFlip);
  LTexture.SetVFlip(FVFlip);
  LTexture.SetRegion(FSprite.GetImageRegion(FFrame, FGroup));
  LTexture.SetBlend(FBlend);
  LTexture.SetColor(FColor);
  LTexture.Draw();
end;

function  TlgEntity.GetSprite(): TlgSprite;
begin
  Result := FSprite;
end;

function  TlgEntity.GetGroup(): Integer;
begin
  Result := FGroup;
end;

function  TlgEntity.GetScale(): Single;
begin
  Result := FScale;
end;

function  TlgEntity.GetColor(): TlgColor;
begin
  Result := FColor;
end;

procedure TlgEntity.SetColor(const AColor: TlgColor);
begin
  FColor := AColor;
end;

function  TlgEntity.GetBlend(): TlgTextureBlend;
begin
  Result := FBlend;
end;

procedure TlgEntity.SetBlend(const AValue: TlgTextureBlend);
begin
  FBlend := AValue;
end;

function  TlgEntity.GetHFlip(): Boolean;
begin
  Result := FHFlip;
end;

procedure TlgEntity.SetHFlip(const AFlip: Boolean);
begin
  FHFlip := AFlip;
end;

function  TlgEntity.GetVFlip(): Boolean;
begin
  Result := FVFlip;
end;

procedure TlgEntity.SetVFlip(const AFlip: Boolean);
begin
  FVFlip := AFlip;
end;

function  TlgEntity.GetLoopFrame(): Boolean;
begin
  Result := FLoopFrame;
end;

procedure TlgEntity.SetLoopFrame(const aLoop: Boolean);
begin
  FLoopFrame := ALoop;
end;

function  TlgEntity.GetWidth(): Single;
begin
  Result := FWidth;
end;

function  TlgEntity.GetHeight(): Single;
begin
  Result := FHeight;
end;

function  TlgEntity.GetRadius(): Single;
begin
  Result := FRadius;
end;

class function TlgEntity.New(const ASprite: TlgSprite; const aGroup: Integer): TlgEntity;
begin
  Result := TlgEntity.Create();
  if not Result.Init(ASprite, AGroup) then
  begin
    Result.Free();
    Result := nil;
    Exit;
  end;
end;

{ === GAME ================================================================== }
{ --- TlgGame --------------------------------------------------------------- }
constructor TlgGame.Create();
begin
  inherited;
end;

destructor TlgGame.Destroy();
begin
  inherited;
end;

procedure TlgGame.OnDefineSettings(var ASettings: TSettings);
begin
  // window
  ASettings.WindowWidth := TlgWindow.DEFAULT_WIDTH;
  ASettings.WindowHeight := TlgWindow.DEFAULT_HEIGHT;
  ASettings.WindowTitle := 'Your Game';
  ASettings.WindowClearColor := DARKSLATEBROWN;

  // default font
  ASettings.DefaultFontSize := 10;
  ASettings.DefaultFontGlyphs := '';

  // zipfile
  ASettings.ZipFilePassword := TlgZipStream.DEFAULT_PASSWORD;
  ASettings.ZipFilename := 'Data.zip';

  // hud
  ASettings.HudPos := Math.Point(3, 3);
  ASettings.HudLinespace := 0;
end;

function  TlgGame.OnInitSettings(): Boolean;
begin
  Result := False;

  // window
  FWindow := TlgWindow.Init(FSettings.WindowTitle, FSettings.WindowWidth, FSettings.WindowHeight);
  if not Assigned(FWindow) then Exit;

  // default font
  FDefaultFont := TlgFont.LoadDefault(FWindow, FSettings.DefaultFontSize, FSettings.DefaultFontGlyphs);
  if not Assigned(FDefaultFont) then Exit;

  // zipfile
  FZipFile := TlgZipFile.Init(FSettings.ZipFilename, FSettings.ZipFilePassword);
  if not Assigned(FZipFile) then Exit;

  // hud
  FHud.Pos := FSettings.HudPos;
  FHud.Linespace := FSettings.HudLinespace;

  Result := True;
end;

procedure TlgGame.OnQuitSettings();
begin
  // zipFile
  if Assigned(FZipFile) then
  begin
    FZipFile.Free();
    FZipFile := nil;
  end;

  // default font
  if Assigned(FDefaultFont) then
  begin
    FDefaultFont.Free();
    FDefaultFont := nil;
  end;

  // window
  if Assigned(FWindow) then
  begin
    FWindow.Free();
    FWindow := nil;
  end;
end;

function  TlgGame.OnStartup(): Boolean;
begin
  Result := True;
end;

procedure TlgGame.OnShutdown();
begin
end;

procedure TlgGame.OnUpdate();
begin
  // quit on escape
  if FWindow.GetKey(KEY_ESCAPE, isWasPressed) then
    FWindow.SetShouldClose(True)
end;

procedure TlgGame.OnRender();
begin
end;

procedure TlgGame.OnRenderHud();
begin
  // reset hud
  HudReset();

  // default display hud info
  HudPrint(WHITE, '%d fps', [Timer.FrameRate()]);
  HudPrint(GREEN, 'ESC - Quit', []);
end;

function  TlgGame.Settings: PSettings;
begin
  Result := @FSettings;
end;

function  TlgGame.Hud: PHud;
begin
  Result := @FHud;
end;

procedure TlgGame.HudReset();
begin
  FHud.Pos := FSettings.HudPos;
end;

procedure TlgGame.HudPrint(const AColor: TlgColor; const AMsg: string; const AArgs: array of const);
begin
  FDefaultFont.DrawText(FWindow, FHud.Pos.x, FHud.Pos.y, FHud.Linespace, AColor, haLeft, AMsg, AArgs);
end;

procedure TlgGame.Run();
begin
  // define settings
  OnDefineSettings(FSettings);

  try
    // init settings
    if not OnInitSettings() then Exit;
    try
      // check if window is open
      if not FWindow.IsOpen then Exit;

      // process startup
      if not OnStartup() then Exit;

      // enter game loop
      while not FWindow.ShouldClose() do
      begin
        // start frame
        FWindow.StartFrame();

        // process updates
        OnUpdate();

          // start drawing
          FWindow.StartDrawing();

            // clear window
            FWindow.Clear(FSettings.WindowClearColor);

            // render
            OnRender();

            // render hud
            OnRenderHud();

          // end drawing
          FWindow.EndDrawing();

        // end frame
        FWindow.EndFrame();
      end;

    finally
      // process shutdown
      OnShutdown();
    end;

  finally
    // process quit setting
    OnQuitSettings();
  end;
end;

{ lgRunGame }
procedure lgRunGame(const AGame: TlgGameClass);
var
  LGame: TlgGame;
begin
  LGame := Game;
  try
    Game := AGame.Create;
    try
      Game.Run();
    finally
      Game.Free();
    end;
  finally
    Game := LGame;
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

  // init utils
  Utils := TlgUtils.Create();

  // init console
  Terminal := TlgTerminal.Create();

  // load deps dll
  LoadDepsDLL();


  // init library
  if glfwInit() <> GLFW_TRUE then AbortDepsDLL();
  Math := TlgMath.Create();
  Timer := TlgDeterministicTimer.Create();
  Timer.Init();
  TaskList := TlgTaskList.Create();
  TaskList.Start();
end;

finalization
begin
  // shutdown library
  if Assigned(TaskList) then TaskList.Free();
  if Assigned(Timer) then Timer.Free();
  if Assigned(Math) then Math.Free();
  glfwTerminate();

  // unload deps dll
  UnloadDepsDLL();

  // release console
  Terminal.Free();

  // release utils
  Utils.Free();

  // restore code page
  SetConsoleCP(InputCodePage);
  SetConsoleOutputCP(OutputCodePage);
end;

end.
