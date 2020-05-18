unit UzLogQSO;

interface

uses
  System.SysUtils, System.Classes, StrUtils, IniFiles, Forms, Windows, Menus,
  System.DateUtils, Generics.Collections, Generics.Defaults,
  UzlogConst;

type
  TQSOData = record
    Time : TDateTime;
    CallSign: string[12]; { 13 bytes }
    NrSent: string[30];
    NrRcvd: string[30];
    RSTSent: Smallint; // word;  {2 bytes}
    RSTRcvd: word;
    Serial: Integer; { 4 bytes ? }
    Mode: TMode; { 1 byte }
    Band: TBand; { 1 byte }
    Power: TPower; { 1 byte }
    Multi1: string[30];
    Multi2: string[30];
    NewMulti1: Boolean;
    NewMulti2: Boolean;
    Points: byte;
    Operator: string[14]; { Operator's name }
    Memo: string[64]; { max 64 char = 65 bytes }
    CQ: Boolean; { not used yet }
    Dupe: Boolean;
    Reserve: byte; { used for z-link commands }
    TX: byte; { Transmitter number for 2 TX category }
    Power2: Integer; { used by ARRL DX side only }
    Reserve2: Integer; { $FF when forcing to log }
    Reserve3: Integer; { QSO ID# }
    {TTSSSSRRCC   TT:TX#(00-21) SSSS:Serial counter
                                     RR:Random(00-99) CC:Edit counter 00 and up}
  end;

  TQSO = class(TObject)
  private
    FTime: TDateTime;
    FCallSign: string; { 13 bytes }
    FNrSent: string;
    FNrRcvd: string;
    FRSTSent: Integer; // word;  {2 bytes}
    FRSTRcvd: Integer;
    FSerial: Integer; { 4 bytes ? }
    FMode: TMode; { 1 byte }
    FBand: TBand; { 1 byte }
    FPower: TPower; { 1 byte }
    FMulti1: string;
    FMulti2: string;
    FNewMulti1: Boolean;
    FNewMulti2: Boolean;
    FPoints: Integer;
    FOperator: string; { Operator's name }
    FMemo: string; { max 64 char = 65 bytes }
    FCQ: Boolean; { not used yet }
    FDupe: Boolean;
    FReserve: Integer; { used for z-link commands }
    FTX: Integer; { Transmitter number for 2 TX category }
    FPower2: Integer; { used by ARRL DX side only }
    FReserve2: Integer; { $FF when forcing to log }
    FReserve3: Integer; { QSO ID# }
    {TTSSSSRRCC   TT:TX#(00-21) SSSS:Serial counter
                                      RR:Random(00-99) CC:Edit counter 00 and up}
    function GetFileRecord(): TQSOData;
    procedure SetFileRecord(src: TQSOData);
  public
    constructor Create;
    procedure IncTime;
    procedure DecTime;
    function SerialStr : string;
    function TimeStr : string;
    function DateStr : string;
    function BandStr : string;
    function ModeStr : string;
    function PowerStr : string;
    function NewPowerStr : string;
    function PointStr : string;
    function RSTStr : string;
    function RSTSentStr : string;
    function PartialSummary(DispDate: Boolean) : string;
    function CheckCallSummary : string;
    procedure UpdateTime;
    function zLogALL : string;
    function DOSzLogText : string;
    function DOSzLogTextShort : string;
    function QSOinText : string; {for data transfer}
    procedure TextToQSO(str : string); {convert text to bin}
    function QTCStr : string;

    function SameQSO(aQSO: TQSO) : Boolean;
    function SameQSOID(aQSO: TQSO) : Boolean;
    function SameMode(aQSO: TQSO): Boolean;
    function SameMode2(aMode: TMode) : Boolean;

    procedure Assign(src: TQSO);

    property Time: TDateTime read FTime write FTime;
    property Callsign: string read FCallsign write FCallsign;
    property NrSent: string read FNrSent write FNrSent;
    property NrRcvd: string read FNrRcvd write FNrRcvd;
    property RSTSent: Integer read FRSTSent write FRSTSent;
    property RSTRcvd: Integer read FRSTRcvd write FRSTRcvd;
    property Serial: Integer read FSerial write FSerial;
    property Mode: TMode read FMode write FMode;
    property Band: TBand read FBand write FBand;
    property Power: TPower read FPower write FPower;
    property Multi1: string read FMulti1 write FMulti1;
    property Multi2: string read FMulti2 write FMulti2;
    property NewMulti1: Boolean read FNewMulti1 write FNewMulti1;
    property NewMulti2: Boolean read FNewMulti2 write FNewMulti2;
    property Points: Integer read FPoints write FPoints;
    property Operator: string read FOperator write FOperator;
    property Memo: string read FMemo write FMemo;
    property CQ: Boolean read FCQ write FCQ;
    property Dupe: Boolean read FDupe write FDupe;
    property Reserve: Integer read FReserve write FReserve;
    property TX: Integer read FTX write FTX;
    property Power2: Integer read FPower2 write FPower2;
    property Reserve2: Integer read FReserve2 write FReserve2;
    property Reserve3: Integer read FReserve3 write FReserve3;

    property FileRecord: TQSOData read GetFileRecord write SetFileRecord;
  end;

  TQSOCallsignComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOTimeComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSOBandComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSODupeWithoutModeComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TQSODupeWithModeComparer = class(TComparer<TQSO>)
  public
    function Compare(const Left, Right: TQSO): Integer; override;
  end;

  TSortMethod = ( soCallsign = 0, soTime, soBand, soDupeCheck );

  TQSOList = class(TObjectList<TQSO>)
  private
    FCallsignComparer: TQSOCallsignComparer;
    FTimeComparer: TQSOTimeComparer;
    FBandComparer: TQSOBandComparer;
    FDupeWithoutModeComparer: TQSODupeWithoutModeComparer;
    FDupeWithModeComparer: TQSODupeWithModeComparer;
  public
    constructor Create(OwnsObjects: Boolean = True);
    destructor Destroy(); override;
    function IndexOf(C: string): Integer; overload;
    function MergeFile(filename: string): Integer;
    procedure Sort(SortMethod: TSortMethod; fWithMode: Boolean = False); overload;
    function DupeCheck(aQSO: TQSO; fWithMode: Boolean): TQSO;
  end;

  TQSOListArray = array[b19..HiBand] of TQSOList;

  TLog = class(TObject)
  private
    FSaved : Boolean;
    FQsoList: TQSOList;
    FQueList: TQSOList;
    FQueOK : Boolean;
    FAcceptDifferentMode : Boolean;
    FCountHigherPoints : Boolean;
    FDifferentModePointer : Integer; //points to a qso on a different mode but not dupe
    FDupeCheckList: array[b19..HiBand] of TQSOList;
    FBandList: TQSOListArray;
    procedure Delete(i : Integer);
  public
    constructor Create(memo : string);
    destructor Destroy; override;

    function Year: Integer; //returns the year of the 1st qso
    function TotalQSO : Integer;
    function TotalPoints : Integer;
    function TotalCW : Integer;
    function TotalMulti1 : Integer;
    function TotalMulti2 : Integer;

    procedure Add(aQSO : TQSO);
    procedure Insert(i : Integer; aQSO : TQSO);

    procedure DeleteQSO(aQSO: TQSO);

    procedure SaveToFile(Filename : string);
    procedure SaveToFilezLogDOSTXT(Filename : string);
    procedure SaveToFilezLogALL(Filename : string);
    procedure SaveToFileByTX(Filename : string);
    function IsDupe(aQSO : TQSO) : Integer;
    function IsDupe2(aQSO : TQSO; index : Integer; var dupeindex : Integer) : Boolean;
    procedure AddQue(aQSO : TQSO);
    procedure ProcessQue;
    procedure Clear2(); // deletes all QSOs without destroying the List. Keeps List[0] intact
    procedure SortByTime;
    function ContainBand : TBandBool;
    procedure SetDupeFlags;
//    procedure DeleteBand(B : TBand);
    function CheckQSOID(i : Integer) : Boolean;
    procedure RebuildDupeCheckList;
    procedure ClearDupeCheckList;
    function QuickDupe(aQSO : TQSO) : TQSO;
    procedure RemoveDupes;
    function OpQSO(OpName : string) : Integer;

    function IndexOf(aQSO: TQSO): Integer; overload;
    function ObjectOf(callsign: string): TQSO; overload;

    function LoadFromFile(filename: string): Integer;
//    function MergeFile(filename: string): Integer;

    function IsWorked(strCallsign: string; band: TBand): Boolean;

    property Saved: Boolean read FSaved write FSaved;
    property AcceptDifferentMode: Boolean read FAcceptDifferentMode write FAcceptDifferentMode;
    property CountHigherPoints: Boolean read FCountHigherPoints write FCountHigherPoints;
    property DifferentModePointer: Integer read FDifferentModePointer write FDifferentModePointer; //points to a qso on a different mode but not dupe

    property QsoList: TQSOList read FQsoList;
    property BandList: TQSOListArray read FBandList;
  end;

implementation

uses
  UzLogGlobal;

{ TQSO }

constructor TQSO.Create;
begin
   Inherited;

   FTime := Date + Time;
   FCallSign := '';
   { FNrSent := ''; }
   FNrRcvd := '';

   if FMode = mCW then begin
      FRSTSent := 599;
      FRSTRcvd := 599;
   end
   else begin
      FRSTSent := 59;
      FRSTRcvd := 59;
   end;

   FSerial := 1;
   FMulti1 := '';
   FMulti2 := '';
   FNewMulti1 := False;
   FNewMulti2 := False;
   FPoints := 1;
   { FOperator := ''; }
   FMemo := '';
   FCQ := False;
   FDupe := False;
   FReserve := 0;
   FTX := 0;
   FPower2 := 500;
   FReserve2 := 0;
   FReserve3 := 0;
end;

procedure TQSO.IncTime;
begin
   Self.FTime := Self.FTime + 1.0 / (24 * 60);
end;

procedure TQSO.DecTime;
begin
   Self.FTime := Self.FTime - 1.0 / (24 * 60);
end;

function TQSO.QSOinText: string; { for data transfer }
var
   slText: TStringList;
begin
   slText := TStringList.Create();
   slText.StrictDelimiter := True;
   slText.Delimiter := _sep;
   try
      slText.Add('ZLOGQSODATA:');
      slText.Add(FloatToStr(Time));
      slText.Add(Callsign);
      slText.Add(NrSent);
      slText.Add(NrRcvd);
      slText.Add(IntToStr(RSTSent));
      slText.Add(IntToStr(RSTRcvd));
      slText.Add(IntToStr(Serial));
      slText.Add(IntToStr(ord(Mode)));
      slText.Add(IntToStr(ord(Band)));
      slText.Add(IntToStr(ord(Power)));
      slText.Add(Multi1);
      slText.Add(Multi2);
      slText.Add(BoolToStr(NewMulti1));
      slText.Add(BoolToStr(NewMulti2));
      slText.Add(IntToStr(Points));
      slText.Add(Operator);
      slText.Add(Memo);
      slText.Add(BoolToStr(CQ));
      slText.Add(BoolToStr(Dupe));
      slText.Add(IntToStr(Reserve));
      slText.Add(IntToStr(TX));
      slText.Add(IntToStr(Power2));
      slText.Add(IntToStr(Reserve2));
      slText.Add(IntToStr(Reserve3));

      Result := slText.DelimitedText;
   finally
      slText.Free();
   end;
end;

procedure TQSO.TextToQSO(str: string); { convert text to bin }
var
   slText: TStringList;
begin
   slText := TStringList.Create();
   slText.StrictDelimiter := True;
   slText.Delimiter := _sep;
   try
   try
      slText.DelimitedText := str;

      if slText[0] <> 'ZLOGQSODATA:' then begin
         Exit;
      end;

      Time     := StrToFloat(slText[1]);
      CallSign := slText[2];
      NrSent   := slText[3];
      NrRcvd   := slText[4];
      RSTSent  := StrToInt(slText[5]);
      RSTRcvd  := StrToInt(slText[6]);
      Serial   := StrToInt(slText[7]);
      Mode     := TMode(StrToInt(slText[8]));
      Band     := TBand(StrToInt(slText[9]));
      Power    := TPower(StrToInt(slText[10]));
      Multi1   := slText[11];
      Multi2   := slText[12];
      NewMulti1 := StrToBool(slText[13]);
      NewMulti2 := StrToBool(slText[14]);
      Points   := StrToInt(slText[15]);
      Operator := slText[16];
      Memo     := slText[17];
      CQ       := StrToBool(slText[18]);
      Dupe     := StrToBool(slText[19]);
      Reserve  := StrToInt(slText[20]);
      TX       := StrToInt(slText[21]);
      Power2   := StrToInt(slText[22]);
      Reserve2 := StrToInt(slText[23]);
      Reserve3 := StrToInt(slText[24]);
   except
      on EConvertError do begin
         FMemo := 'Convert Error!';
      end;
   end;
   finally
      slText.Free();
   end;
end;

procedure TQSO.UpdateTime;
begin
   if UseUTC then begin
      FTime := GetUTC();
   end
   else begin
      FTime := Now;
   end;
end;

function TQSO.SerialStr: string;
var
   S: string;
begin
   S := IntToStr(Self.FSerial);
   case length(S) of
      1:
         S := '00' + S;
      2:
         S := '0' + S;
   end;

   Result := S;
end;

function TQSO.QTCStr: string;
begin
   Result := FormatDateTime('hhnn', Self.Time) + ' ' + Self.CallSign + ' ' + Self.NrRcvd;
end;

function TQSO.TimeStr: string;
begin
   Result := FormatDateTime('hh:nn', Self.Time);
end;

function TQSO.DateStr: string;
begin
   Result := FormatDateTime('yy/mm/dd', Self.Time);
end;

function TQSO.BandStr: string;
begin
   Result := MHzString[Self.FBand];
end;

function TQSO.ModeStr: string;
begin
   Result := ModeString[Self.FMode];
end;

function TQSO.PowerStr: string;
var
   i: Integer;
begin
   i := Self.FPower2;
   case i of
      9999:
         Result := 'KW';
      10000:
         Result := '1KW';
      10001:
         Result := 'K';
      else
         Result := IntToStr(i);
   end;
end;

function TQSO.NewPowerStr: string;
begin
   Result := NewPowerString[Self.FPower];
end;

function TQSO.PointStr: string;
begin
   Result := IntToStr(Self.FPoints);
end;

function TQSO.RSTStr: string;
begin
   Result := IntToStr(Self.FRSTRcvd);
end;

function TQSO.RSTSentStr: string;
begin
   Result := IntToStr(Self.FRSTSent);
end;

function TQSO.PartialSummary(DispDate: Boolean): string;
var
   S: string;
begin
   if DispDate then begin
      S := DateStr + ' ';
   end
   else begin
      S := '';
   end;

   S := S + TimeStr + ' ' +
        FillRight(Self.CallSign, 12) +
        FillRight(Self.NrRcvd, 15) +
        FillRight(BandStr, 5) +
        FillRight(ModeStr, 5);

   Result := S;
end;

function TQSO.CheckCallSummary: string;
var
   S: string;
begin
   S := FillRight(BandStr, 5) +
        TimeStr + ' ' +
        FillRight(Self.CallSign, 12) +
        FillRight(Self.NrRcvd, 15) +
        FillRight(ModeStr, 5);

   Result := S;
end;

function TQSO.DOSzLogText: string;
var
   S, temp: string;
   Year, Month, Day, Hour, Min, Sec, MSec: word;
begin
   S := '';
   DecodeDate(Self.FTime, Year, Month, Day);
   DecodeTime(Self.FTime, Hour, Min, Sec, MSec);
   S := S + FillLeft(IntToStr(Month), 3) + ' ' + FillLeft(IntToStr(Day), 3) + ' ';

   temp := IntToStr(Hour * 100 + Min);
   case length(temp) of
      1:
         temp := '000' + temp;
      2:
         temp := '00' + temp;
      3:
         temp := '0' + temp;
   end;

   S := S + temp + ' ';
   S := S + FillRight(Self.CallSign, 11);
   S := S + FillLeft(IntToStr(Self.RSTSent), 3);
   S := S + FillRight(Self.NrSent, 31);
   S := S + FillLeft(IntToStr(Self.RSTRcvd), 3);
   S := S + FillRight(Self.NrRcvd, 31);

   if Self.NewMulti1 then
      S := S + FillLeft(Self.Multi1, 6)
   else
      S := S + '      ';

   S := S + '  ' + FillLeft(MHzString[Self.Band], 4);
   S := S + '  ' + FillRight(ModeString[Self.Mode], 3);
   S := S + ' ' + FillRight(IntToStr(Self.Points), 2);

   if Self.FOperator <> '' then begin
      S := S + '%%' + Self.Operator + '%%';
   end;

   S := S + Self.Memo;

   Result := S;
end;

function TQSO.DOSzLogTextShort: string;
var
   S, temp: string;
   Year, Month, Day, Hour, Min, Sec, MSec: word;
begin
   S := '';
   DecodeDate(Self.Time, Year, Month, Day);
   DecodeTime(Self.Time, Hour, Min, Sec, MSec);
   S := S + FillLeft(IntToStr(Month), 3) + ' ' + FillLeft(IntToStr(Day), 3) + ' ';

   temp := IntToStr(Hour * 100 + Min);
   case length(temp) of
      1:
         temp := '000' + temp;
      2:
         temp := '00' + temp;
      3:
         temp := '0' + temp;
   end;

   S := S + temp + ' ';
   S := S + FillRight(Self.CallSign, 11);
   S := S + FillLeft(IntToStr(Self.RSTSent), 3);
   S := S + FillRight(Self.NrSent, 10);
   S := S + FillLeft(IntToStr(Self.RSTRcvd), 3);
   S := S + FillRight(Self.NrRcvd, 10);

   if Self.NewMulti1 then
      S := S + FillLeft(Self.Multi1, 6)
   else
      S := S + '      ';
   S := S + '  ' + FillLeft(MHzString[Self.Band], 4);
   S := S + '  ' + FillRight(ModeString[Self.Mode], 3);
   S := S + ' ' + FillRight(IntToStr(Self.Points), 2);
   if Self.Operator <> '' then begin
      S := S + '  ' + '%%' + Self.Operator + '%%';
   end;

   S := S + '  ' + Self.Memo;

   Result := S;
end;

function TQSO.zLogALL: string;
var
   S: string;
   nrlen: Integer;
begin
   nrlen := 7;
   S := '';
   S := S + FormatDateTime('yyyy/mm/dd hh":"nn ', Self.Time);
   S := S + FillRight(Self.CallSign, 13);
   S := S + FillRight(IntToStr(Self.RSTSent), 4);
   S := S + FillRight(Self.NrSent, nrlen + 1);
   S := S + FillRight(IntToStr(Self.RSTRcvd), 4);
   S := S + FillRight(Self.NrRcvd, nrlen + 1);

   if Self.NewMulti1 then
      S := S + FillRight(Self.Multi1, 6)
   else
      S := S + '-     ';

   if Self.NewMulti2 then
      S := S + FillRight(Self.Multi2, 6)
   else
      S := S + '-     ';

   S := S + FillRight(MHzString[Self.Band], 5);
   S := S + FillRight(ModeString[Self.Mode], 5);
   S := S + FillRight(IntToStr(Self.Points), 3);

   if Self.Operator <> '' then begin
      S := S + FillRight('%%' + Self.Operator + '%%', 19);
   end;

   if dmZlogGlobal.MultiOp > 0 then begin
      S := S + FillRight('TX#' + IntToStr(Self.TX), 6);
   end;

   S := S + Self.Memo;
   Result := S;
end;

function TQSO.SameQSO(aQSO: TQSO): Boolean;
begin
   if (aQSO.FBand = Self.FBand) and
      (aQSO.FCallSign = Self.FCallSign) and
      (aQSO.FMode = Self.FMode) and
      (aQSO.FDupe = Self.FDupe) and
      (aQSO.FSerial = Self.FSerial) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TQSO.SameQSOID(aQSO: TQSO): Boolean;
begin
   if (aQSO.FReserve3 div 100) = (Self.FReserve3 div 100) then begin
      Result := True;
   end
   else begin
      Result := False;
   end;
end;

function TQSO.SameMode(aQSO: TQSO): Boolean;
begin
   Result := False;
   case Self.FMode of
      mCW: begin
         if aQSO.FMode = mCW then begin
            Result := True;
         end;
      end;

      mSSB, mFM, mAM: begin
         if aQSO.FMode in [mSSB, mFM, mAM] then begin
            Result := True;
         end;
      end;

      mRTTY: begin
         if aQSO.FMode = mRTTY then begin
            Result := True;
         end;
      end;

      mOther: begin
         if aQSO.FMode = mOther then begin
            Result := True;
         end;
      end;

      else begin
         Result := False;
      end;
   end;
end;

function TQSO.SameMode2(aMode: TMode): Boolean;
begin
   Result := False;
   case Self.FMode of
      mCW: begin
         if aMode = mCW then begin
            Result := True;
         end;
      end;

      mSSB, mFM, mAM: begin
         if aMode in [mSSB, mFM, mAM] then begin
            Result := True;
         end;
      end;

      mRTTY: begin
         if aMode = mRTTY then begin
            Result := True;
         end;
      end;

      mOther: begin
         if aMode = mOther then begin
            Result := True;
         end;
      end;

      else begin
         Result := False;
      end;
   end;
end;

procedure TQSO.Assign(src: TQSO);
begin
   FTime := src.FTime;
   FCallSign := src.FCallSign;
   FNrSent := src.FNrSent;
   FNrRcvd := src.FNrRcvd;
   FRSTSent := src.FRSTSent;
   FRSTRcvd := src.FRSTRcvd;
   FSerial := src.FSerial;
   FMode := src.FMode;
   FBand := src.FBand;
   FPower := src.FPower;
   FMulti1 := src.FMulti1;
   FMulti2 := src.FMulti2;
   FNewMulti1 := src.FNewMulti1;
   FNewMulti2 := src.FNewMulti2;
   FPoints := src.FPoints;
   FOperator := src.FOperator;
   FMemo := src.FMemo;
   FCQ := src.FCQ;
   FDupe := src.FDupe;
   FReserve := src.FReserve;
   FTX := src.FTX;
   FPower2 := src.FPower2;
   FReserve2 := src.FReserve2;
   FReserve3 := src.FReserve3;
end;

function TQSO.GetFileRecord(): TQSOData;
begin
   Result.Time       := FTime;
   Result.CallSign   := ShortString(FCallSign);
   Result.NrSent     := ShortString(FNrSent);
   Result.NrRcvd     := ShortString(FNrRcvd);
   Result.RSTSent    := SmallInt(FRSTSent);
   Result.RSTRcvd    := Word(FRSTRcvd);
   Result.Serial     := FSerial;
   Result.Mode       := FMode;
   Result.Band       := FBand;
   Result.Power      := FPower;
   Result.Multi1     := ShortString(FMulti1);
   Result.Multi2     := ShortString(FMulti2);
   Result.NewMulti1  := FNewMulti1;
   Result.NewMulti2  := FNewMulti2;
   Result.Points     := Byte(FPoints);
   Result.Operator   := ShortString(FOperator);
   Result.Memo       := ShortString(FMemo);
   Result.CQ         := FCQ;
   Result.Dupe       := FDupe;
   Result.Reserve    := Byte(FReserve);
   Result.TX         := Byte(FTX);
   Result.Power2     := FPower2;
   Result.Reserve2   := FReserve2;
   Result.Reserve3   := FReserve3;
end;

procedure TQSO.SetFileRecord(src: TQSOData);
begin
   FTime       := src.Time;
   FCallSign   := string(src.CallSign);
   FNrSent     := string(src.NrSent);
   FNrRcvd     := string(src.NrRcvd);
   FRSTSent    := Integer(src.RSTSent);
   FRSTRcvd    := Integer(src.RSTRcvd);
   FSerial     := src.Serial;
   FMode       := src.Mode;
   FBand       := src.Band;
   FPower      := src.Power;
   FMulti1     := string(src.Multi1);
   FMulti2     := string(src.Multi2);
   FNewMulti1  := src.NewMulti1;
   FNewMulti2  := src.NewMulti2;
   FPoints     := Integer(src.Points);
   FOperator   := string(src.Operator);
   FMemo       := string(src.Memo);
   FCQ         := src.CQ;
   FDupe       := src.Dupe;
   FReserve    := Integer(src.Reserve);
   FTX         := Integer(src.TX);
   FPower2     := src.Power2;
   FReserve2   := src.Reserve2;
   FReserve3   := src.Reserve3;
end;

{ TQSOList }

constructor TQSOList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
   FCallsignComparer := TQSOCallsignComparer.Create();
   FTimeComparer := TQSOTimeComparer.Create();
   FBandComparer := TQSOBandComparer.Create();
   FDupeWithoutModeComparer := TQSODupeWithoutModeComparer.Create();
   FDupeWithModeComparer := TQSODupeWithModeComparer.Create();
end;

destructor TQSOList.Destroy();
begin
   Inherited;
   FCallsignComparer.Free();
   FTimeComparer.Free();
   FBandComparer.Free();
   FDupeWithoutModeComparer.Free();
   FDupeWithModeComparer.Free();
end;

function TQSOList.IndexOf(C: string): Integer;
var
   i: Integer;
begin
   for i := 0 to Count - 1 do begin
      if Items[i].CallSign = C then begin
         Result := i;
         Exit;
      end;
   end;

   Result := -1;
end;

function TQSOList.MergeFile(filename: string): Integer;
var
   qso: TQSO;
   dat: TQSOData;
   f: file of TQSOData;
   i, merged: integer;
begin
   merged := 0;

   AssignFile(f, filename);
   Reset(f);
   Read(f, dat); // first qso comment

   for i := 1 to FileSize(f) - 1 do begin
      Read(f, dat);

      qso := TQSO.Create;
      qso.FileRecord := dat;

      if IndexOf(qso.Callsign) = -1 then begin
         Add(qso);
         Inc(merged);
      end
      else begin
         qso.Free();
      end;
   end;

   System.close(f);
   Result := merged;
end;

procedure TQSOList.Sort(SortMethod: TSortMethod; fWithMode: Boolean);
begin
   case SortMethod of
      soCallsign: begin
         Sort(FCallsignComparer);
      end;

      soTime: begin
         Sort(FTimeComparer);
      end;

      soBand: begin
         Sort(FBandComparer);
      end;

      soDupeCheck: begin
         if fWithMode = True then begin
            Sort(FDupeWithModeComparer);
         end
         else begin
            Sort(FDupeWithoutModeComparer);
         end;
      end;
   end;
end;

function TQSOList.DupeCheck(aQSO: TQSO; fWithMode: Boolean): TQSO;
var
   Index: Integer;
   Q: TQSO;
   C: TComparer<TQSO>;
begin
   Q := TQSO.Create();
   try
      Q.Assign(aQSO);
      Q.Callsign := CoreCall(Q.Callsign);

      if fWithMode = True then begin
         C := FDupeWithModeComparer;
      end
      else begin
         C := FDupeWithoutModeComparer;
      end;

      if BinarySearch(Q, Index, C) = True then begin
         Result := Items[Index];
      end
      else begin
         Result := nil;
      end;
   finally
      Q.Free();
   end;
end;

{ TLog }

constructor TLog.Create(Memo: string);
var
   Q: TQSO;
   B: TBand;
begin
   Inherited Create();

   // ADIF_FieldName := 'qth';

   FQsoList := TQSOList.Create();
   FQueList := TQSOList.Create();

   for B := b19 to HiBand do begin
      FDupeCheckList[B] := TQSOList.Create();
      FBandList[B] := TQSOList.Create(False);
   end;

   Q := TQSO.Create;
   Q.Callsign := '';
   Q.Memo := Memo;
   Q.Time := 0;
   Q.RSTSent := 0;
   Add(Q);

   for B := b19 to HiBand do begin
      FBandList[B].Add(Q);
   end;

   FSaved := True;
   FQueOK := True;
   FAcceptDifferentMode := False;
   FCountHigherPoints := False;
   FDifferentModePointer := 0;
end;

destructor TLog.Destroy;
var
   B: TBand;
begin
   for B := b19 to HiBand do begin
      FDupeCheckList[B].Free();
      FBandList[B].Free();
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('QsoList=' + IntToStr(FQsoList.Count)));
   {$ENDIF}

   FQsoList.Free();
   FQueList.Free();

   Inherited;
end;

function TLog.ContainBand: TBandBool;
var
   R: TBandBool;
   B: TBand;
   i: Integer;
begin
   for B := b19 to HiBand do begin
      R[B] := False;
   end;

   for i := 1 to TotalQSO do begin
      R[FQSOList[i].FBand] := True;
   end;

   Result := R;
end;

function TLog.Year: Integer;
var
   T: TDateTime;
   y, M, d: word;
begin
   Result := 0;
   if TotalQSO > 0 then
      T := FQSOList[1].FTime
   else
      exit;

   DecodeDate(T, y, M, d);
   Result := y;
end;

procedure TLog.SortByTime;
begin
   if TotalQSO < 2 then begin
      exit;
   end;

   FQSOList.Sort(soTime);
end;

procedure TLog.Clear2();
var
   i: Integer;
begin
   For i := FQSOList.Count - 1 downto 1 do begin
      Delete(i);
   end;

   ClearDupeCheckList;
   FSaved := False;
end;

procedure TLog.ClearDupeCheckList;
var
   B: TBand;
begin
   for B := b19 to HiBand do begin
      FDupeCheckList[B].Clear;
   end;
end;

procedure TLog.Add(aQSO: TQSO);
var
   xQSO: TQSO;
begin
   FQsoList.Add(aQSO);

   xQSO := TQSO.Create;
   xQSO.Assign(aQSO);
   xQSO.Callsign := CoreCall(xQSO.Callsign);
   FDupeCheckList[xQSO.FBand].Add(xQSO);
   FDupeCheckList[xQSO.FBand].Sort(soDupeCheck, FAcceptDifferentMode);

   FBandList[xQSO.Band].Add(aQSO);

   FSaved := False;
end;

procedure TLog.AddQue(aQSO: TQSO);
var
   xQSO: TQSO;
begin
   xQSO := TQSO.Create;
   xQSO.Assign(aQSO);
   // xQSO.QSO.Reserve := actAdd;
   FQueList.Add(xQSO);
   FSaved := False;
end;

procedure TLog.ProcessQue;
var
   xQSO, yQSO, zQSO, wQSO: TQSO;
   i, id: Integer;
begin
   if FQueList.Count = 0 then begin
      exit;
   end;

   Repeat
   until FQueOK;

   while FQueList.Count > 0 do begin

      xQSO := TQSO.Create();
      xQSO.Assign(FQueList[0]);

      case xQSO.FReserve of
         actAdd: begin
            Add(xQSO);
         end;

         actDelete: begin
               for i := 1 to TotalQSO do begin
                  yQSO := FQsoList[i];
                  if xQSO.SameQSOID(yQSO) then begin
                     Delete(i);
                     break;
                  end;
               end;
         end;

         actEdit: begin
            for i := 1 to TotalQSO do begin
               yQSO := FQsoList[i];
               if xQSO.SameQSOID(yQSO) then begin
                  // FQsoList[i].QSO := xQSO.QSO;
                  yQSO.Assign(xQSO);
                  RebuildDupeCheckList;
                  break;
               end;
            end;
         end;

         actInsert: begin
            for i := 1 to TotalQSO do begin
               yQSO := FQsoList[i];
               id := xQSO.FReserve2 div 100;
               if id = (yQSO.FReserve3 div 100) then begin
                  wQSO := TQSO.Create;
                  wQSO.Assign(xQSO);
                  Insert(i, wQSO);
                  break;
               end;
            end;
         end;

         actLock: begin
            for i := 1 to TotalQSO do begin
               zQSO := FQsoList[i];
               if xQSO.SameQSOID(zQSO) then begin
                  FQsoList[i].FReserve := actLock;
                  break;
               end;
            end;
         end;

         actUnlock: begin
            for i := 1 to TotalQSO do begin
               zQSO := FQsoList[i];
               if xQSO.SameQSOID(zQSO) then begin
                  FQsoList[i].FReserve := 0;
                  break;
               end;
            end;
         end;
      end;

//      FQueList[0].Free; // added 0.23
      FQueList.Delete(0);
   end;

   FSaved := False;
end;

procedure TLog.Delete(i: Integer);
var
   aQSO: TQSO;
   Index: Integer;
begin
   if i > TotalQSO then begin
      Exit;
   end;

   aQSO := FQsoList[i];

   Index := FBandList[aQSO.Band].IndexOf(aQSO);
   if Index > -1 then begin
      FBandList[aQSO.Band].Delete(Index);
   end;

   FQsoList.Delete(i);

   FSaved := False;
   RebuildDupeCheckList;
end;

procedure TLog.DeleteQSO(aQSO: TQSO);
var
   Index: Integer;
begin
   Index := FBandList[aQSO.Band].IndexOf(aQSO);
   if Index > -1 then begin
      FBandList[aQSO.Band].Delete(Index);
   end;

   Index := FQSOList.IndexOf(aQSO);
   if Index > -1 then begin
      FQsoList.Delete(Index);
   end;

   FSaved := False;
   RebuildDupeCheckList;
end;

procedure TLog.RemoveDupes;
var
   i: Integer;
   aQSO: TQSO;
begin
   for i := 1 to TotalQSO do begin
      aQSO := FQsoList[i];
      if Pos('-DUPE-', aQSO.Memo) > 0 then begin
         Delete(i);
      end;
   end;

   FSaved := False;
   RebuildDupeCheckList;
end;

function TLog.CheckQSOID(i: Integer): Boolean;
var
   j, id: Integer;
begin
   Result := False;
   id := i div 100; // last two digits are edit counter
   for j := 1 to TotalQSO do begin
      if id = (FQsoList[j].FReserve3 div 100) then begin
         Result := True;
         break;
      end;
   end;
end;

procedure TLog.Insert(i: Integer; aQSO: TQSO);
begin
   FQsoList.Insert(i, aQSO);
   RebuildDupeCheckList;
   FSaved := False;
end;

procedure TLog.SaveToFile(Filename: string);
var
   D: TQSOData;
   f: file of TQSOData;
   i: Integer;
   back: string;
begin
   back := ChangeFileExt(Filename, '.BAK');
   if FileExists(back) then begin
      System.SysUtils.DeleteFile(back);
   end;
   RenameFile(Filename, back);

   AssignFile(f, Filename);
   Rewrite(f);

   for i := 0 to TotalQSO do begin // changed from 1 to TotalQSO to 0 to TotalQSO
      D := FQsoList[i].FileRecord;
      Write(f, D);
   end;

   CloseFile(f);

   FSaved := True;
end;

procedure TLog.SaveToFilezLogDOSTXT(Filename: string);
var
   f: textfile;
   i, j, max: Integer;
const
   LongHeader = 'mon day time  callsign      sent                              rcvd                           multi   MHz mode pts memo';
   ShortHeader = 'mon day time  callsign      sent         rcvd      multi   MHz mode pts memo';
begin
   AssignFile(f, Filename);
   Rewrite(f);

   { str := 'zLog for Windows Text File'; }
   max := 0;
   j := 0;
   for i := 1 to TotalQSO do begin
      j := length(FQsoList[i].FNrRcvd);
      if j > max then begin
         max := j;
      end;

      j := length(FQsoList[i].FNrSent);
      if j > max then begin
         max := j;
      end;
   end;

   if j >= 10 then begin
      writeln(f, LongHeader);
      for i := 1 to TotalQSO do begin
         writeln(f, FQsoList[i].DOSzLogText);
      end;
   end
   else begin
      writeln(f, ShortHeader);
      for i := 1 to TotalQSO do begin
         writeln(f, FQsoList[i].DOSzLogTextShort);
      end;
   end;

   CloseFile(f);
end;

procedure TLog.SaveToFilezLogALL(Filename: string);
var
   f: textfile;
   Header: string;
   i: Integer;
begin
   Header := 'zLog for Windows '; // +Options.Settings._mycall;
   AssignFile(f, Filename);
   Rewrite(f);

   { str := 'zLog for Windows Text File'; }
   writeln(f, Header);

   for i := 1 to TotalQSO do begin
      writeln(f, FQsoList[i].zLogALL);
   end;

   CloseFile(f);
end;

procedure TLog.SaveToFileByTX(Filename: string);
var
   f: textfile;
   Header: string;
   i, j: Integer;
   txset: set of byte;
begin
   txset := [];
   for i := 1 to TotalQSO do begin
      txset := txset + [FQsoList[i].FTX];
   end;

   Header := 'zLog for Windows '; // +Options.Settings._mycall;
   System.Delete(Filename, length(Filename) - 2, 3);
   for i := 0 to 255 do begin
      if i in txset then begin
         AssignFile(f, Filename + '.' + IntToStr(i) + '.TX');
         Rewrite(f);
         writeln(f, Header + ' TX# ' + IntToStr(i));
         for j := 1 to TotalQSO do
            if FQsoList[j].FTX = i then
               writeln(f, FQsoList[j].zLogALL);
         CloseFile(f);
      end;
   end;
end;

procedure TLog.RebuildDupeCheckList;
var
   i: Integer;
   Q: TQSO;
   B: TBand;
begin
   ClearDupeCheckList;

   for i := 1 to FQsoList.Count - 1 do begin
      Q := TQSO.Create();
      Q.Assign(FQsoList[i]);
      Q.Callsign := CoreCall(Q.Callsign);
      FDupeCheckList[Q.FBand].Add(Q);
   end;

   for B := b19 to HiBand do begin
      FDupeCheckList[B].Sort(soDupeCheck, FAcceptDifferentMode);
   end;
end;

function TLog.QuickDupe(aQSO: TQSO): TQSO;
var
   Q: TQSO;
begin
   // ����o���h�Ō�M�ς݂�
   Q := FDupeCheckList[aQSO.FBand].DupeCheck(aQSO, FAcceptDifferentMode);
   if Q = nil then begin   // ����M
      Result := nil;
      Exit;
   end;

   Result := Q;
end;

function TLog.OpQSO(OpName: string): Integer;
var
   i, j: Integer;
begin
   j := 0;

   for i := 1 to TotalQSO do begin
      if FQsoList[i].Operator = OpName then begin
         inc(j);
      end;
   end;

   Result := j;
end;

function TLog.IsDupe(aQSO: TQSO): Integer;
var
   x: Integer;
   i: word;
   str: string;
begin
   FDifferentModePointer := 0;
   x := 0;
   str := CoreCall(aQSO.CallSign);

   for i := 1 to TotalQSO do begin
      if (aQSO.FBand = FQsoList[i].Band) and (str = CoreCall(FQsoList[i].CallSign)) then begin
         if Not(FAcceptDifferentMode) then begin
            x := i;
            break;
         end
         else begin
            if aQSO.SameMode(FQsoList[i]) then begin
               x := i;
               break;
            end
            else { different mode qso exists but not dupe }
            begin
               FDifferentModePointer := i;
            end;
         end;
      end;
   end;
   Result := x;
end;

function TLog.IsDupe2(aQSO: TQSO; index: Integer; var dupeindex: Integer): Boolean;
var
   boo: Boolean;
   i: word;
   str: string;
begin
   boo := False;
   str := CoreCall(aQSO.CallSign);

   for i := 1 to TotalQSO do begin
      if (aQSO.FBand = FQsoList[i].Band) and (str = CoreCall(FQsoList[i].CallSign)) and ((index <= 0) or (index <> i)) then begin
         if Not(AcceptDifferentMode) or (AcceptDifferentMode and aQSO.SameMode(FQsoList[i])) then begin
            boo := True;
            if index > 0 then
               dupeindex := i;
            break;
         end;
      end;
   end;
   Result := boo;
end;

procedure TLog.SetDupeFlags;
var
   i, j: Integer;
   str, temp: string;
   aQSO: TQSO;
   TempList: array [ord('A') .. ord('Z')] of TStringList;
   ch: Char;
   core: string;
begin
   if TotalQSO = 0 then
      exit;

   for i := ord('A') to ord('Z') do begin
      TempList[i] := TStringList.Create;
      TempList[i].Sorted := True;
      TempList[i].Capacity := 200;
   end;

   for i := 1 to TotalQSO do begin
      aQSO := FQsoList[i];
      core := CoreCall(aQSO.CallSign);

      if AcceptDifferentMode then
         str := core + aQSO.BandStr + aQSO.ModeStr
      else
         str := core + aQSO.BandStr;

      if core = '' then
         ch := 'Z'
      else
         ch := core[length(core)];

      if not CharInSet(ch, ['A' .. 'Z']) then
         ch := 'Z';

      if TempList[ord(ch)].Find(str, j) = True then begin
         aQSO.Points := 0;
         aQSO.Dupe := True;
         temp := aQSO.Memo;
         if Pos('-DUPE-', temp) = 0 then begin
            aQSO.Memo := '-DUPE- ' + temp;
         end;
      end
      else begin
         aQSO.Dupe := False;

         temp := aQSO.Memo;
         if Pos('-DUPE-', temp) = 1 then begin
            aQSO.Memo := copy(temp, 8, 255);
         end;

         TempList[ord(ch)].Add(str);
      end;
   end;

   for i := ord('A') to ord('Z') do begin
      TempList[i].Clear;
      TempList[i].Free;
   end;
end;

function TLog.TotalQSO: Integer;
begin
   Result := FQsoList.Count - 1;
end;

function TLog.TotalPoints: Integer;
var
   points, i: Integer;
begin
   points := 0;

   for i := 1 to TotalQSO do begin
      points := points + FQsoList[i].FPoints;
   end;

   Result := points;
end;

function TLog.TotalCW: Integer;
var
   cnt, i: Integer;
begin
   cnt := 0;
   for i := 1 to TotalQSO do begin
      if FQsoList[i].FMode = mCW then begin
         Inc(cnt);
      end;
   end;

   Result := cnt;
end;

function TLog.TotalMulti1: Integer;
var
   cnt, i: Integer;
begin
   cnt := 0;
   for i := 1 to TotalQSO do begin
      if FQsoList[i].FNewMulti1 then begin
         Inc(cnt);
      end;
   end;

   Result := cnt;
end;

function TLog.TotalMulti2: Integer;
var
   cnt, i: Integer;
begin
   cnt := 0;
   for i := 1 to TotalQSO do begin
      if FQsoList[i].FNewMulti2 then begin
         Inc(cnt);
      end;
   end;

   Result := cnt;
end;

function TLog.IndexOf(aQSO: TQSO): Integer;
var
   i: Integer;
begin
   for i := 1 to TotalQSO do begin
      if FQsoList[i].SameQSO(aQSO) then begin
         Result := i;
         Exit;
      end;
   end;

   Result := -1;
end;

function TLog.ObjectOf(callsign: string): TQSO;
var
   i: Integer;
begin
   for i := 1 to TotalQSO do begin
      if FQsoList[i].Callsign = callsign then begin
         Result := FQsoList[i];
         Exit;
      end;
   end;

   Result := nil;
end;


function TLog.LoadFromFile(filename: string): Integer;
var
   Q: TQSO;
   D: TQSOData;
   f: file of TQSOData;
   i: Integer;
begin
   AssignFile(f, filename);
   Reset(f);
   Read(f, D);

   Q := nil;
   GLOBALSERIAL := 0;

   for i := 1 to FileSize(f) - 1 do begin
      Read(f, D);

      Q := TQSO.Create();
      Q.FileRecord := D;

      if Q.Reserve3 = 0 then begin
         Q.Reserve3 := dmZLogGlobal.NewQSOID;
      end;

      Add(Q);
   end;

   if Q <> nil then begin
      GLOBALSERIAL := (Q.Reserve3 div 10000) mod 10000;
   end;

   CloseFile(f);

   Result := FQsoList.Count;
end;

function TLog.IsWorked(strCallsign: string; band: TBand): Boolean;
var
   Q: TQSO;
begin
   Q := TQSO.Create();
   try
      if Integer(band) = -1 then begin
         Result := False;
         Exit;
      end;

      Q.Callsign := strCallsign;
      Q.Band := band;

      if FDupeCheckList[band].DupeCheck(Q, False) <> nil then begin
         Result := True;
      end
      else begin
         Result := False;
      end;

      {$IFDEF DEBUG}
      OutputDebugString(PChar('*** IsWorked() = ' + strCallsign + ' ' + BoolToStr(Result, True) + ' ***'));
      {$ENDIF}
   finally
      Q.Free();
   end;
end;

{ TQSOCallsignComparer }

function TQSOCallsignComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign);
end;

{ TQSOTimeComparer }

function TQSOTimeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareDateTime(Left.Time, Right.Time);
end;

{ TQSOBandComparer }

function TQSOBandComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := Integer(Left.Band) - Integer(Right.Band);
end;

{ TQSODupeWithoutModeComparer }

function TQSODupeWithoutModeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign) +
             ((Integer(Left.Band) - Integer(Right.Band)) * 10);
end;

{ TQSODupeWithModeComparer }

function TQSODupeWithModeComparer.Compare(const Left, Right: TQSO): Integer;
begin
   Result := CompareText(Left.Callsign, Right.Callsign) +
             ((Integer(Left.Band) - Integer(Right.Band)) * 10) +
             ((Integer(Left.Mode) - Integer(Right.Mode)) * 100);
end;

end.
