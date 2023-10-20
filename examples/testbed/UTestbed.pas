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
  System.Classes,
  System.Math,
  WinApi.Windows,
  LGT.Deps,
  LGT;

procedure RunTests;

implementation

const
  CZipFilename = 'Data.zip';

{------------------------------------------------------------------------------
 This example illustrates how to build a ZIP file.
----------------------------------------------------------------------------- }

procedure Test01;
begin
  Console.PrintLn('Building %s...', [CZipFilename]);

  if TlgZipStream.Build(CZipFilename, 'res', nil, nil) then
    Console.PrintLn(#10#10+'Success!', [])
  else
    Console.PrintLn(#10#10+'Failed!', []);
end;

{------------------------------------------------------------------------------
 This example illustrates the procedure for initializing the audio system.
----------------------------------------------------------------------------- }

procedure Test02();
var
  LAudio: TlgAudio;
begin

  LAudio := TlgAudio.Create();
  try
    if LAudio.Open() then
    begin
      WriteLn(LAudio.GetDeviceName());
      LAudio.Close();
    end;
  finally
    LAudio.Free();
  end;

end;

{------------------------------------------------------------------------------
 This example demonstrates the loading and playback of multichannel audio
 from a ZIP stream.
----------------------------------------------------------------------------- }
procedure Test03();
var
  LAudio: TlgAudio;
  LSound: array[0..6] of TlgSound;
  LChan: array[0..15] of TlgSound;
  LStream: TlgStream;
  I: Integer;

  function FindFree(): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := 0 to 15 do
    begin
      if LChan[i].GetStatus = asStopped then
      begin
        Result := I;
        Exit;
      end;
    end;
  end;

  function Play(const Id: Integer): Integer;
  var
    LIndex: Integer;
  begin
    Result := -1;
    if not InRange(Id, 1, 6) then Exit;
    LIndex := FindFree();
    if LIndex = -1 then Exit;
    LChan[LIndex].Copy(LSound[Id], False);
    LChan[LIndex].Play(True);
    Result := LIndex;
  end;

begin

  LAudio := TlgAudio.Create();
  LAudio.Open();

  for I := 0 to 15 do
  begin
    LChan[I] := TlgSound.Create(LAudio);
  end;

  // load music
  LSound[0] := TlgSound.Create(LAudio);
  LStream := TlgZipStream.Open(CZipFilename, 'res/music/song01.ogg');
  LSound[0].Load(LStream, slStream);
  LSound[0].Play(True);
  LSound[0].SetLooping(True);

  // load sfx
  for I := 1 to 6 do
  begin
    LSound[I] := TlgSound.Create(LAudio);
    LStream := TlgZipStream.Open(CZipFilename, Format('res/sfx/samp%d.ogg',[I-1]));
    LSound[I].Load(LStream, slMemory);
    LStream.Free();
  end;

  Console.PrintLn('Press 1-6 to play sound, ESC to quit...');

  while true do
  begin
    Timer.Start();
    LAudio.Update();

    if Console.KeyWasPressed(Ord('1')) then Play(1);
    if Console.KeyWasPressed(Ord('2')) then Play(2);
    if Console.KeyWasPressed(Ord('3')) then Play(3);
    if Console.KeyWasPressed(Ord('4')) then Play(4);
    if Console.KeyWasPressed(Ord('5')) then Play(5);
    if Console.KeyWasPressed(Ord('6')) then Play(6);

    if Console.KeyWasPressed(VK_ESCAPE) then Break;

    Timer.Stop();

    Console.SetTitle('LGT (%d fps)', [Timer.TargetFrameRate()]);
  end;

  for I := 0 to 2 do
  begin
    LSound[i].Free();
  end;

  for I := 0 to 15 do
  begin
    LChan[I].Free();
  end;

  //NOTE: all sound objects are managed so any sound instances will be
  //      will be released when audio instance is destroyed.
  LAudio.Free();

end;

const
  NUM_BUFFERS = 2;
  SAMEPLE_SIZE = 2304;
  AUDIO_CHANES = 2;
var
  Source: ALuint;
  Buffers: array[0..NUM_BUFFERS-1] of ALuint;
  SampleRate: Integer;
  RingBuffer: TlgRingBuffer<Byte>;
  Status: TlgAudioStatus;
  AudioDecodeBuffer: array[0..(SAMEPLE_SIZE*sizeof(smallint))] of Byte;

procedure UpdateAudio();
var
  LProcessed: ALint;
  LWhich: integer;
  LState: Integer;
begin
  if Status = asStopped then Exit;

  alGetSourcei(Source, AL_BUFFERS_PROCESSED, @LProcessed);
  while LProcessed > 0 do
  begin
    alSourceUnqueueBuffers(Source, 1, @LWhich);
    alBufferData(LWhich, AL_FORMAT_STEREO16, RingBuffer.DirectReadPointer(SAMEPLE_SIZE*sizeof(smallint)), SAMEPLE_SIZE*sizeof(smallint), SampleRate);
    alSourceQueueBuffers(Source, 1, @LWhich);
    Dec(LProcessed);
  end;

  alGetSourcei(Source, AL_SOURCE_STATE, @LState);
  if LState = AL_STOPPED then
  begin
    alSourcePlay(Source);
  end;
end;

procedure Test04_PLMAudioDecodeCallback(APLM: Pplm_t; ASamples: Pplm_samples_t; AUserData: Pointer); cdecl;
var
  I: Integer;
  LValue: smallint;
begin
  for i := 0 to SAMEPLE_SIZE-1 do
  begin
    LValue :=  Round(EnsureRange(ASamples.interleaved[i], -1.0, 1.0) * 32767);
    AudioDecodeBuffer[i * 2] := Byte(LValue);               // Store the low byte
    AudioDecodeBuffer[i * 2 + 1] := Byte(LValue shr 8);    // Store the high byte
  end;
  RingBuffer.Write(AudioDecodeBuffer, (SAMEPLE_SIZE*sizeof(smallint)));
  //writeln('audio callback');
end;


procedure Test04;

var
  LPlm: Pplm_t;
  LAudio: TlgAudio;
  LExitThread: Boolean;
  LFrameTime: Double;
  I: Integer;
  LThread: TThread;
  LLoop: Boolean;
begin

  LAudio := TlgAudio.Create();
  LAudio.Open();

  LPlm := plm_create_with_filename('res/videos/GameKit.mpg');
  //LPlm := plm_create_with_filename('res/videos/tinyBigGAMES.mpg');
  SampleRate := plm_get_samplerate(LPlm);
  LFrameTime := 1/(Timer.TargetFrameRate() / 2);
  plm_set_audio_lead_time(LPLM, (SAMEPLE_SIZE*AUDIO_CHANES)/SampleRate);
  plm_set_audio_decode_callback(LPLM, Test04_PLMAudioDecodeCallback, nil);

  alGenSources(1, @Source);
  alGenBuffers(NUM_BUFFERS, @Buffers);

  RingBuffer := TlgRingBuffer<Byte>.Create((SampleRate*AUDIO_CHANES*sizeof(smallint))*2);

  Utils.ClearStaticBuffer();
  for I := 0 to NUM_BUFFERS-1 do
  begin
    alBufferData(Buffers[I], AL_FORMAT_STEREO16, Utils.GetStaticBuffer(), 100, SampleRate);
  end;
  alSourceQueueBuffers(Source, NUM_BUFFERS, @Buffers[0]);
  alSourcePlay(Source);

  LExitThread := False;

  LThread := TThread.CreateAnonymousThread(
    procedure
    begin
      writeln('started thread...');
      while not LExitThread do
      begin
        Utils.EnterCriticalSection();
        LAudio.Update();
        UpdateAudio();
        Utils.LeaveCriticalSection();
      end;
      writeln('exit thread...');
    end
  );
  LThread.Priority := tpNormal;
  LThread.Start();

  Status := asPlaying;
  LLoop := True;

  while True do
  begin
    Timer.Start();

    if Status = asPlaying then
    begin
      if not Boolean(plm_has_ended(LPlm)) then
        begin
          Utils.EnterCriticalSection();
          plm_decode(LPlm, LFrameTime);
          Utils.LeaveCriticalSection();
          //writeln('decode');
        end
      else
        begin
          Status := asStopped;
          if LLoop then
          begin
            Utils.EnterCriticalSection();
            RingBuffer.Clear();
            plm_seek(LPlm, 0, 1);
            Utils.LeaveCriticalSection();
            Status := asPlaying;
          end;
        end;
    end;

    if Console.KeyWasPressed(VK_ESCAPE) then
      Break;

    Console.SetTitle('LGT (%d fps)', [Timer.TargetFrameRate()]);

    Timer.Stop();
  end;

  LExitThread := True;

  alSourceStop(Source);
  alDeleteSources(1, @Source);
  alDeleteBuffers(NUM_BUFFERS, @Buffers);

  RingBuffer.Free();
  plm_destroy(LPlm);

  LAudio.Free();
end;

procedure Test05();
var
  LWindow: TlgWindow;
  LAngle: Single;
begin
  LWindow := TlgWindow.Create();

  LWindow.Open('Test05');

  while true do
  begin
    Timer.Start();

    if LWindow.ShouldClose() then
      Break;

    LAngle := LAngle + 1.0;
    LAngle := Math.ClipValueFloat(LAngle, 0, 360, True);

    LWindow.StartDrawing();

      LWindow.Clear(DARKSLATEBROWN);
      LWindow.DrawFilledCircle(0, 0, 50, ORANGE);
      LWindow.DrawFilledRect(100, 100, 100, 100, DARKGREEN, LAngle);
      LWindow.DrawRect(200, 200, 100, 100, 2, DARKORCHID, LAngle);

    LWindow.EndDrawing();

    LWindow.SetTitle(Format('Test05 (%d fps)', [Timer.TargetFrameRate]));

    Timer.Stop();
  end;

  LWindow.Close();

  LWindow.Free();

end;

procedure RunTests();
begin
  //Test01();
  //Test02();
  //Test03();
  //Test04();
  Test05();
  Console.Pause();
end;

end.
