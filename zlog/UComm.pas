unit UComm;

{$I+}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Console, ExtCtrls, Menus, AnsiStrings, ComCtrls, Vcl.ClipBrd,
  Console2, USpotClass, CPDrv, UzLogConst, UzLogGlobal, UzLogQSO, HelperLib,
  OverbyteIcsWndControl, OverbyteIcsTnCnx, Vcl.ExtDlgs, System.SyncObjs;

const
  SPOTMAX = 20000;

type
  TCommProcessThread = class(TThread)
  private
    FParent: TForm;
  protected
    procedure Execute; override;
  public
    constructor Create(formParent: TForm);
  end;

  TCommForm = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    Edit: TEdit;
    Panel2: TPanel;
    ListBox: TListBox;
    StatusLine: TStatusBar;
    Console: TColorConsole2;
    Splitter1: TSplitter;
    Telnet: TTnCnx;
    ConnectButton: TButton;
    checkAutoLogin: TCheckBox;
    checkRelaySpot: TCheckBox;
    checkNotifyCurrentBand: TCheckBox;
    ClusterComm: TCommPortDriver;
    PopupMenu: TPopupMenu;
    menuSaveToFile: TMenuItem;
    SaveTextFileDialog1: TSaveTextFileDialog;
    checkAutoReconnect: TCheckBox;
    checkRecordLogs: TCheckBox;
    popupCommand: TPopupMenu;
    menuPasteCommand: TMenuItem;
    checkUseAllowDenyLists: TCheckBox;
    procedure CommReceiveData(Buffer: Pointer; BufferLength: Word);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure TimerProcess(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TelnetDisplay(Sender: TTnCnx; Str: String);
    procedure ConnectButtonClick(Sender: TObject);
    procedure TelnetSessionConnected(Sender: TTnCnx; Error: Word);
    procedure TelnetSessionClosed(Sender: TTnCnx; Error: Word);
    procedure CreateParams(var Params: TCreateParams); override;
    //procedure AsyncCommRxChar(Sender: TObject; Count: Integer);
    procedure FormShow(Sender: TObject);
    procedure ListBoxDblClick(Sender: TObject);
    procedure ListBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormActivate(Sender: TObject);
    procedure ClusterCommReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Cardinal);
    procedure TelnetDataAvailable(Sender: TTnCnx; Buffer: Pointer;
      Len: Integer);
    procedure ListBoxMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure menuSaveToFileClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure menuPasteCommandClick(Sender: TObject);
  private
    { Private declarations }
    FCommBuffer : TStringList;
    FCommTemp : string; {command work string}
    FCommStarted : boolean;
    FRelayPacketData : boolean;
    FSpotList : TSpotList;
    FSpotListLock: TRTLCriticalSection;

    FUseClusterLog: Boolean;
    FClusterLog: TextFile;
    FClusterLogFileName: string;
    FDisconnectClicked: Boolean;

    FAutoLogined: Boolean;

    FCommProcessThread: TCommProcessThread;

    FSpotterList: TStringList;
    FAllowList: TStringList;
    FDenyList: TStringList;

    procedure DeleteSpot(_from, _to : integer);

    function GetFontSize(): Integer;
    procedure SetFontSize(v: Integer);

    procedure CommProcess;
    procedure ProcessSpot(Sp : TSpot);

    procedure WriteData(str : string);
    procedure WriteConsole(strText: string);

    procedure RenewListBox;
    procedure EnableConnectButton(boo : boolean);
    function GetLocalEcho(): Boolean;
    procedure TerminateCommProcessThread();
    procedure LoadAllowDenyList();
  public
    { Public declarations }
    procedure PreProcessSpotFromZLink(S : string; N: Integer);
    procedure TransmitSpot(S : string); // local or via network
    procedure ImplementOptions();
    procedure RenewOptions();
    procedure Renew; // red or black
    procedure RemoteConnectButtonPush;
    function MaybeConnected : boolean; {returns false if port = telnet and
                                         not connected but doesn't know abt
                                         packet }

    procedure WriteLine(str : string); // adds linebreak
    procedure WriteLineConsole(str : string);
    procedure WriteStatusLine(S : string);

    procedure Lock();
    procedure Unlock();

    property FontSize: Integer read GetFontSize write SetFontSize;
    property SpotList: TSpotList read FSpotList;

    property DenyList: TStringList read FDenyList;
  end;

resourcestring
  UComm_Connect = 'Connect';
  UComm_Disconnect = 'Disconnect';
  UComm_Connecting = 'Connecting...';
  UComm_Disconnecting = 'Disconnecting...';

var
  CommBufferLock: TCriticalSection;

implementation

uses
  Main, UOptions, UZLinkForm, URigControl, UBandScope2, UzLogSpc;

{$R *.DFM}

procedure TCommForm.DeleteSpot(_from, _to : integer);
var
   i : integer;
begin
   Lock();
   try
      if _from < 0 then begin
         Exit;
      end;

      if _to < _from then begin
         Exit;
      end;

      if _to > FSpotList.Count - 1 then begin
         Exit;
      end;

      ListBox.Items.BeginUpdate();
      for i := _from to _to do begin
         FSpotList.Delete(_from);
         ListBox.Items.Delete(_from);
      end;
      ListBox.Items.EndUpdate();
   finally
      Unlock();
   end;
end;

procedure TCommForm.WriteStatusLine(S : string);
begin
   StatusLine.SimpleText := S;
end;

function TCommForm.MaybeConnected : boolean;
begin
   if (dmZlogGlobal.Settings._clusterport = 7) and (Telnet.IsConnected = False) then
      Result := False
   else
      Result := True;
end;

procedure TCommForm.EnableConnectButton(boo : boolean);
begin
   ConnectButton.Enabled := boo;
end;

procedure TCommForm.WriteLine(str: string);
begin
   WriteData(str + LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TCommForm.WriteLineConsole(str : string);
begin
   WriteConsole(str + LineBreakCode[ord(Console.LineBreak)]);
end;

procedure TCommForm.WriteConsole(strText: string);
begin
   Console.WriteString(strText);

   try
      if (checkRecordLogs.Checked = True) and (FUseClusterLog = True) then begin
         Write(FClusterLog, strText);
         Flush(FClusterLog);
      end;
   except
      on E: Exception do begin
         Console.WriteString(E.Message);
         FUseClusterLog := False;
         CloseFile(FClusterLog);
      end;
   end;
end;

procedure TCommForm.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TCommForm.WriteData(str : string);
begin
   case dmZlogGlobal.Settings._clusterport of
      1..6: begin
         if ClusterComm.Connected then begin
            ClusterComm.SendString(AnsiString(str));
         end;
      end;

      7: begin
         if Telnet.IsConnected then begin
            Telnet.SendStr(str);
         end;
      end;
   end;
end;

procedure TCommForm.CommReceiveData(Buffer: Pointer; BufferLength: Word);
var
   str : string;
begin
   str := string(AnsiStrings.StrPas(PAnsiChar(Buffer)));
   CommBufferLock.Enter();
   FCommBuffer.Add(str);
   CommBufferLock.Leave();
end;

procedure TCommForm.EditKeyPress(Sender: TObject; var Key: Char);
var
   fLocalEcho: Boolean;
   s : string;
begin
   fLocalEcho := GetLocalEcho();

   s := '';
   if Key = Chr($0D) then begin
      if pos('RELAY', UpperCase(Edit.Text)) = 1 then begin
         if pos('ON', UpperCase(Edit.Text)) > 0 then begin
            FRelayPacketData := True;
         end
         else begin
            FRelayPacketData := False;
         end;

         WriteLineConsole(Edit.Text);
         exit;
      end;

      if dmZlogGlobal.Settings._clusterport = 0 then begin
         MainForm.ZLinkForm.SendRemoteCluster(Edit.Text);
      end
      else begin
         WriteData(Edit.Text + LineBreakCode[ord(Console.LineBreak)]);
      end;

      if fLocalEcho then begin
         WriteLineConsole(Edit.Text);
      end;

      Key := Chr($0);
      Edit.Text := '';
      Exit;
   end;

   case Key of
      ^A, ^B, ^C, ^D, ^E, ^F, ^G, {^H,} ^I, ^J, ^K, ^L,
      ^M, ^N, ^O, ^P, ^Q, ^R, ^S, ^T, ^U, ^V, ^W, ^X, ^Y, ^Z: begin
         s := s + Key;

         if dmZlogGlobal.Settings._clusterport = 0 then begin
            MainForm.ZLinkForm.SendRemoteCluster(s);
         end
         else begin
            WriteData(s);
         end;
      end;
   end;
end;

procedure TCommForm.ImplementOptions();
var
   i: Integer;
begin
   EnableConnectButton((dmZlogGlobal.Settings._clusterport = 7) and (dmZlogGlobal.Settings._cluster_telnet.FHostName <> ''));

   if dmZlogGlobal.Settings._clusterbaud <> 99 then begin
      ClusterComm.BaudRate := TBaudRate(dmZlogGlobal.Settings._clusterbaud+1);
   end;

   if dmZlogGlobal.Settings._clusterport in [1..6] then begin
      ClusterComm.Port := TPortNumber(dmZlogGlobal.Settings._clusterport);
      ClusterComm.Connect;
   end
   else begin
      ClusterComm.Disconnect;
   end;

   case dmZlogGlobal.Settings._clusterport of
      1..6 : Console.LineBreak := TConsole2LineBreak(dmZlogGlobal.Settings._cluster_com.FLineBreak);
      7 :    Console.LineBreak := TConsole2LineBreak(dmZlogGlobal.Settings._cluster_telnet.FLineBreak);
   end;

   i := Pos(':', dmZlogGlobal.Settings._cluster_telnet.FHostName);
   if i = 0 then begin
      Telnet.Host := dmZlogGlobal.Settings._cluster_telnet.FHostName;
      Telnet.Port := IntToStr(dmZlogGlobal.Settings._cluster_telnet.FPortNumber);
   end
   else begin
      Telnet.Host := Copy(dmZlogGlobal.Settings._cluster_telnet.FHostName, 1, i - 1);
      Telnet.Port := Copy(dmZlogGlobal.Settings._cluster_telnet.FHostName, i + 1);
   end;

   checkAutoLogin.Checked     := dmZLogGlobal.Settings.FClusterAutoLogin;
   checkAutoReconnect.Checked := dmZLogGlobal.Settings.FClusterAutoReconnect;
   checkRelaySpot.Checked     := dmZLogGlobal.Settings.FClusterRelaySpot;
   checkNotifyCurrentBand.Checked := dmZLogGlobal.Settings.FClusterNotifyCurrentBand;
   checkRecordLogs.Checked    := dmZLogGlobal.Settings.FClusterRecordLogs;
   checkUseAllowDenyLists.Checked := dmZLogGlobal.Settings.FClusterUseAllowDenyLists;
end;

procedure TCommForm.RenewOptions();
begin
   dmZLogGlobal.Settings.FClusterAutoLogin      := checkAutoLogin.Checked;
   dmZLogGlobal.Settings.FClusterAutoReconnect  := checkAutoReconnect.Checked;
   dmZLogGlobal.Settings.FClusterRelaySpot      := checkRelaySpot.Checked;
   dmZLogGlobal.Settings.FClusterNotifyCurrentBand := checkNotifyCurrentBand.Checked;
   dmZLogGlobal.Settings.FClusterRecordLogs     := checkRecordLogs.Checked;
   dmZLogGlobal.Settings.FClusterUseAllowDenyLists := checkUseAllowDenyLists.Checked;
end;

procedure TCommForm.FormCreate(Sender: TObject);
begin
   InitializeCriticalSection(FSpotListLock);
   ListBox.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   Console.Font.Name := dmZLogGlobal.Settings.FBaseFontName;
   FRelayPacketData := False;
   FSpotList := TSpotList.Create;
   FCommStarted := False;
   FCommBuffer := TStringList.Create;
   FCommTemp := '';
   FSpotterList := TStringList.Create();
   FSpotterList.Duplicates := dupIgnore;
   FSpotterList.Sorted := True;
   FSpotterList.CaseSensitive := False;
   FAllowList := TStringList.Create();
   FAllowList.Duplicates := dupIgnore;
   FAllowList.Sorted := True;
   FAllowList.CaseSensitive := False;
   FDenyList := TStringList.Create();
   FDenyList.Duplicates := dupIgnore;
   FDenyList.Sorted := True;
   FDenyList.CaseSensitive := False;

   ImplementOptions();

   FDisconnectClicked := False;
   FUseClusterLog := False;
   FClusterLogFileName := StringReplace(Application.ExeName, '.exe', '_telnet_log_' + FormatDateTime('yyyymmdd', Now) + '.txt', [rfReplaceAll]);
   FAutoLogined := False;
   FCommProcessThread := nil;
end;

procedure TCommForm.RenewListBox;
var
   i: Integer;
begin
   ListBox.Items.BeginUpdate();
   Lock();
   try
      ListBox.Clear;

      for i := 0 to FSpotList.Count - 1 do begin
         ListBox.AddItem(FSpotList[i].ClusterSummary, FSpotList[i]);
      end;
   finally
      Unlock();
      ListBox.Items.EndUpdate();
   end;

   ListBox.ShowLast();
end;

procedure TCommForm.PreProcessSpotFromZLink(S : string; N: Integer);
var
   Sp : TSpot;
begin
   Sp := TSpot.Create;
   if Sp.Analyze(S) = True then begin

      // データ発生源はZ-Server
      Sp.SpotSource := ssClusterFromZServer;
      Sp.SpotGroup := N;

      ProcessSpot(Sp);
   end
   else begin
      Sp.Free;
   end;
end;

procedure TCommForm.ProcessSpot(Sp : TSpot);
var
   i : integer;
   S : TSpot;
   dupe, _deleted : boolean;
   Expire : double;
begin
   try
      Lock();
      try
         dupe := false;
         _deleted := false;

         Expire := dmZlogGlobal.Settings._spotexpire / (60 * 24);

         ListBox.Items.BeginUpdate();
         for i := FSpotList.Count - 1 downto 0 do begin
            S := FSpotList[i];
            if Now - S.Time > Expire then begin
               FSpotList.Delete(i);
               ListBox.Items.Delete(i);
               _deleted := True;
            end;

            if (S.Call = Sp.Call) and (S.FreqHz = Sp.FreqHz) then begin
               dupe := True;
               break;
            end;
         end;
         ListBox.Items.EndUpdate();

         if _deleted then begin
   //         RenewListBox;
         end;

         // このコンテストで使用しないバンドは除く
         if (MainForm.BandMenu.Items[ord(Sp.Band)].Visible = False) or
            (MainForm.BandMenu.Items[ord(Sp.Band)].Enabled = False) then begin
            Sp.Free();
            Exit;
         end;

// #300 これは余計だった
//         // 使わないBandScopeは除く
//         if dmZLogGlobal.Settings._usebandscope[Sp.Band] = False then begin
//            Sp.Free();
//            Exit;
//         end;

         // Spot上限を超えたか？
         if FSpotList.Count > SPOTMAX then begin
            Sp.Free();
            Exit;
         end;

         if dupe then begin
            Sp.Free();
            Exit;
         end;

         // JAのみ？
         if dmZLogGlobal.Settings._bandscope_show_only_domestic = True then begin
            if IsDomestic(Sp.Call) = False then begin
               Sp.Free();
               Exit;
            end;
         end;

         // 周波数よりモードを決める
         // この時点でmOtherならBAND PLAN外と見なして良い
         Sp.Mode := dmZLogGlobal.BandPlan.GetEstimatedMode(Sp.FreqHz);

         // BAND PLAN内？
         if dmZLogGlobal.Settings._bandscope_show_only_in_bandplan = True then begin
            if dmZLogGlobal.BandPlan.IsInBand(Sp.Band, Sp.Mode, Sp.FreqHz) = False then begin
               Sp.Free();
               Exit;
            end;
         end;

         // 交信済みチェック
         SpotCheckWorked(Sp);

         // Spotリストへ追加
         FSpotList.Add(Sp);
      finally
         Unlock();
      end;

      if checkNotifyCurrentBand.Checked and (Sp.Band <> Main.CurrentQSO.Band) then begin
      end
      else begin
         MyContest.MultiForm.ProcessCluster(TBaseSpot(Sp));
      end;

      ListBox.Items.BeginUpdate();
      ListBox.AddItem(Sp.ClusterSummary, Sp);
      ListBox.Items.EndUpdate();
      ListBox.ShowLast();

      // BandScopeに登録
      MainForm.BandScopeAddClusterSpot(Sp);
   except
      on E: Exception do begin
         dmZLogGlobal.WriteErrorLog(E.Message);
         dmZLogGlobal.WriteErrorLog(E.StackTrace);
      end;
   end;
end;

procedure TCommForm.TransmitSpot(S : string); // local or via network
begin
   if dmZlogGlobal.Settings._clusterport = 0 then begin
      MainForm.ZLinkForm.SendSpotViaNetwork(S);
   end
   else begin
      WriteLine(S);
   end;
end;

function TrimCRLF(SS : string) : string;
var
   S: string;
begin
   S := SS;
   while (length(S) > 0) and ((S[1] = Chr($0A)) or (S[1] = Chr($0D))) do begin
      Delete(S, 1, 1);
   end;

   while (length(S) > 0) and ((S[length(S)] = Chr($0A)) or (S[length(S)] = Chr($0D))) do begin
      Delete(S, length(S), 1);
   end;

   Result := S;
end;

procedure TCommForm.CommProcess;
var
   max , i, j: integer;
   str: string;
   Sp : TSpot;
begin
   max := FCommBuffer.Count - 1;
   for i := 0 to max do begin
      WriteConsole(FCommBuffer.Strings[i]);
   end;

   for i := 0 to max do begin
      str := FCommBuffer.Strings[0];

      // Auto Login
      if (checkAutoLogin.Checked = True) and (FAutoLogined = False) then begin
         if (Pos('login:', str) > 0) or
            (Pos('Please enter your call:', str) > 0) then begin
            Sleep(500);
            WriteLine(dmZlogGlobal.MyCall);
            FAutoLogined := True;
         end;
      end;

      for j := 1 to length(str) do begin
         if (str[j] = Chr($0A)) then begin
            FCommTemp := TrimCRLF(FCommTemp);

            {$IFDEF DEBUG}
            OutputDebugString(PChar('FCommTemp = [' + FCommTemp + ']'));
            {$ENDIF}

            if FRelayPacketData then begin
               MainForm.ZLinkForm.SendPacketData(FCommTemp);
            end;

            Sp := TSpot.Create;
            if Sp.Analyze(FCommTemp) = True then begin

               // Spotterのチェック
               if checkUseAllowDenyLists.Checked = True then begin
                  if (FDenyList.Count > 0) and (FDenyList.IndexOf(Sp.ReportedBy) >= 0) then begin
                     {$IFDEF DEBUG}
                     OutputDebugString(PChar('This reporter [' + Sp.ReportedBy + '] has been rejected by the deny list'));
                     {$ENDIF}
                     Sp.Free();
                     FCommTemp := '';
                     Continue;
                  end;
                  if (FAllowList.Count > 0) and (FAllowList.IndexOf(Sp.ReportedBy) = -1) then begin
                     {$IFDEF DEBUG}
                     OutputDebugString(PChar('This reporter [' + Sp.ReportedBy + '] is not on the allow list'));
                     {$ENDIF}
                     Sp.Free();
                     FCommTemp := '';
                     Continue;
                  end;
               end;

               // データ発生源はCluster
               Sp.SpotSource := ssCluster;

               ProcessSpot(Sp);

               if checkRelaySpot.Checked then begin
                  MainForm.ZLinkForm.RelaySpot(FCommTemp);
               end;

               // Spotterリストに登録
               if (Sp.ReportedBy <> '') and (FSpotterList.IndexOf(Sp.ReportedBy) = -1) then begin
                  FSpotterList.Add(Sp.ReportedBy);
                  {$IFDEF DEBUG}
                  OutputDebugString(PChar('This reporter [' + Sp.ReportedBy + '] has been added to your spotter list'));
                  {$ENDIF}
               end;
            end
            else begin
              Sp.Free;
            end;

            FCommTemp := '';
         end
         else begin
            FCommTemp := FCommTemp + str[j];
         end;
      end;

      CommBufferLock.Enter();
      FCommBuffer.Delete(0);
      CommBufferLock.Leave();
   end;
end;

procedure TCommForm.TimerProcess;
begin
   Timer1.Enabled := False;
   try
      // Auto Reconnect
      if (checkAutoReconnect.Checked = True) and (Telnet.IsConnected() = False) and
         (FDisconnectClicked = False) and (ConnectButton.Caption = 'Connect') then begin
         ConnectButton.Click();
      end;

//      CommProcess;
   finally
      Timer1.Enabled := True;
   end;
end;

procedure TCommForm.FormDestroy(Sender: TObject);
begin
   ClusterComm.Disconnect;
   ClusterComm.Free;

   Telnet.Close;

   TerminateCommProcessThread();

   FSpotList.Free();
   FCommBuffer.Free();

   FSpotterList.Free();
   FAllowList.Free();
   FDenyList.Free();
end;

procedure TCommForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.SetLastFocus();
   end;
end;

procedure TCommForm.TelnetDisplay(Sender: TTnCnx; Str: String);
begin
   CommBufferLock.Enter();
   FCommBuffer.Add(str);
   CommBufferLock.Leave();
end;

procedure TCommForm.ConnectButtonClick(Sender: TObject);
begin
   try
      Edit.SetFocus;

      if dmZlogGlobal.Settings._clusterport = 0 then begin
         MainForm.ZLinkForm.PushRemoteConnect;
         exit;
      end;

      if Telnet.IsConnected then begin
         ConnectButton.Caption := UComm_Disconnecting;
         FDisconnectClicked := True;
         Telnet.Close;
         TerminateCommProcessThread();
      end
      else begin
         LoadAllowDenyList();
         Telnet.Connect;
         ConnectButton.Caption := UComm_Connecting;
         FDisconnectClicked := False;
         Timer1.Enabled := True;
         FCommProcessThread := TCommProcessThread.Create(Self);
         FCommProcessThread.Start();
      end;
   except
      on E: Exception do begin
         WriteConsole(E.Message);
         Timer1.Enabled := False;
         checkAutoReconnect.Checked := False;
      end;
   end;
end;

procedure TCommForm.RemoteConnectButtonPush;
begin
   if (dmZlogGlobal.Settings._clusterport = 0) then begin
      //ZLinkForm.PushRemoteConnect;
      exit;
   end;

   if Telnet.IsConnected then begin
      //Telnet.Close;
      //ConnectButton.Caption := 'Disconnecting...';
   end
   else begin
      Telnet.Connect;
      ConnectButton.Caption := UComm_Connecting;
   end;
end;

procedure TCommForm.TelnetSessionConnected(Sender: TTnCnx; Error: Word);
begin
   try
      if checkRecordLogs.Checked = True then begin
         // 300Mの空き容量があった場合にrecordする
         if CheckDiskFreeSpace(ExtractFilePath(FClusterLogFileName), 300) = True then begin
            AssignFile(FClusterLog, FClusterLogFileName);

            if FileExists(FClusterLogFileName) = True then begin
               Append(FClusterLog);
            end
            else begin
               Rewrite(FClusterLog);
            end;

            FUseClusterLog := True;
         end
         else begin
            Console.WriteString('**** Not enough free disk space (Not Record!) ****');
            FUseClusterLog := False;
         end;
      end;

      checkAutoLogin.Enabled := False;
      checkAutoReconnect.Enabled := False;
      checkRelaySpot.Enabled := False;
      checkNotifyCurrentBand.Enabled := False;
      checkRecordLogs.Enabled := False;
      checkUseAllowDenyLists.Enabled := False;

      ConnectButton.Caption := UComm_Disconnect;
      WriteLineConsole('connected to ' + Telnet.Host);

      FAutoLogined := False;
   except
      on E: Exception do begin
         Console.WriteString(E.Message);
         FUseClusterLog := False;
      end;
   end;
end;

procedure TCommForm.TelnetSessionClosed(Sender: TTnCnx; Error: Word);
var
   fname: string;
begin
   WriteLineConsole('disconnected...');

   if (checkRecordLogs.Checked = True) and (FUseClusterLog = True) then begin
      CloseFile(FClusterLog);
   end;
   FUseClusterLog := False;

   checkAutoLogin.Enabled := True;
   checkAutoReconnect.Enabled := True;
   checkRelaySpot.Enabled := True;
   checkNotifyCurrentBand.Enabled := True;
   checkRecordLogs.Enabled := True;
   checkUseAllowDenyLists.Enabled := True;
   ConnectButton.Caption := UComm_Connect;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_list.txt';
   FSpotterList.SaveToFile(fname);

   fname := ExtractFilePath(Application.ExeName) + 'spotter_deny.txt';
   FDenyList.SaveToFile(fname);
end;

procedure TCommForm.FormShow(Sender: TObject);
begin
   ConnectButton.Enabled := (dmZlogGlobal.Settings._clusterport = 7);
end;

procedure TCommForm.ListBoxDblClick(Sender: TObject);
var
   Sp : TSpot;
begin
   if ListBox.ItemIndex = -1 then begin
      Exit;
   end;

   if ListBox.Items[ListBox.ItemIndex] = '' then begin
      Exit;
   end;

   Sp := TSpot(ListBox.Items.Objects[ListBox.ItemIndex]);
   if Sp = nil then begin
      Exit;
   end;

   // 相手局をセット
   MainForm.SetYourCallsign(Sp.Call, Sp.Number);

   // 周波数をセット
   MainForm.SetFrequency(Sp.FreqHz);
end;

procedure TCommForm.ListBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_RETURN: begin
         ListBoxDblClick(Self);
      end;

      VK_DELETE: begin
         DeleteSpot(ListBox.ItemIndex, ListBox.ItemIndex);
      end;
   end;
end;

procedure TCommForm.ListBoxMeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
   Height := Abs(TListBox(Control).Font.Height) + 2;
end;

procedure TCommForm.ListBoxDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
   XOffSet: Integer;
   YOffSet: Integer;
   S : string;
   H: Integer;
   SP: TSpot;
begin
   with (Control as TListBox).Canvas do begin
      FillRect(Rect);								{ clear the rectangle }
      XOffset := 2;								{ provide default offset }

      H := Rect.Bottom - Rect.Top;
      YOffset := (H - Abs(TListBox(Control).Font.Height)) div 2;

      S := TListBox(Control).Items[Index];
      SP := TSpot(TListBox(Control).Items.Objects[Index]);
      if SP.IsNewMulti = True then begin
         if odSelected in State then begin
            Font.Color := clFuchsia;
         end
         else begin
            Font.Color := clRed;
         end;
      end
      else begin
         if SP.Worked then begin
            if odSelected in State then begin
               Font.Color := clWhite;
            end
            else begin
               Font.Color := clBlack;
            end;
         end
         else begin
            if odSelected in State then begin
               Font.Color := clYellow;
            end
            else begin
               Font.Color := clGreen;
            end;
         end;
      end;

      TextOut(Rect.Left + XOffset, Rect.Top + YOffSet, S);
   end;
end;

procedure TCommForm.Renew;
begin
   ListBox.Refresh;
end;

procedure TCommForm.FormActivate(Sender: TObject);
begin
  {if StayOnTop.Checked = False then
    FormStyle := fsNormal;}
end;


procedure TCommForm.Button1Click(Sender: TObject);
begin
   Telnet.Close();
end;

procedure TCommForm.ClusterCommReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
var
   i: Integer;
   ptr: PAnsiChar;
   str: AnsiString;
begin
   str := '';
   ptr := PAnsiChar(DataPtr);

   for i := 0 to DataSize - 1 do begin
      str := str + AnsiChar(ptr[i]);
   end;

   CommBufferLock.Enter();
   FCommBuffer.Add(string(str));
   CommBufferLock.Leave();
end;

procedure TCommForm.TelnetDataAvailable(Sender: TTnCnx; Buffer: Pointer; Len: Integer);
var
   str : string;
begin
   str := string(AnsiStrings.StrPas(PAnsiChar(Buffer)));
   CommBufferLock.Enter();
   FCommBuffer.Add(str);
   CommBufferLock.Leave();
end;

function TCommForm.GetFontSize(): Integer;
begin
   Result := ListBox.Font.Size;
end;

procedure TCommForm.SetFontSize(v: Integer);
begin
   ListBox.Font.Size := v;
   Console.Font.Size := v;
end;

procedure TCommForm.menuPasteCommandClick(Sender: TObject);
var
   i: Integer;
   slText: TStringList;
   fLocalEcho: Boolean;
   strCommand: string;
begin
   fLocalEcho := GetLocalEcho();
   ClipBoard.Open();
   slText := TStringList.Create();
   try
      if ClipBoard.HasFormat(CF_TEXT) = False then begin
         Exit;
      end;

      slText.Text := ClipBoard.AsText;
      for i := 0 to slText.Count - 1 do begin
         strCommand := slText.Strings[i];
         WriteData(strCommand + LineBreakCode[ord(Console.LineBreak)]);

         if fLocalEcho then begin
            WriteLineConsole(strCommand);
         end;

         Sleep(100);
      end;
   finally
      ClipBoard.Close();
      slText.Free();
   end;
end;

procedure TCommForm.menuSaveToFileClick(Sender: TObject);
var
   i: Integer;
   F: TextFile;
begin
   if SaveTextFileDialog1.Execute() = False then begin
      Exit;
   end;

   AssignFile(F, SaveTextFileDialog1.FileName);
   Rewrite(F);

   for i := 0 to ListBox.Items.Count - 1 do begin
      WriteLn(F, ListBox.Items[i]);
   end;

   CloseFile(F);
end;

procedure TCommForm.Lock();
begin
   EnterCriticalSection(FSpotListLock);
end;

procedure TCommForm.Unlock();
begin
   LeaveCriticalSection(FSpotListLock);
end;

function TCommForm.GetLocalEcho(): Boolean;
begin
   case dmZlogGlobal.Settings._clusterport of
      1..6: Result := dmZlogGlobal.Settings._cluster_com.FLocalEcho;
      7:    Result := dmZlogGlobal.Settings._cluster_telnet.FLocalEcho;
      else  Result := False;
   end;
end;

procedure TCommForm.TerminateCommProcessThread();
begin
   if Assigned(FCommProcessThread) then begin
      FCommProcessThread.Terminate();
      FCommProcessThread.WaitFor();
      FCommProcessThread.Free();
      FCommProcessThread := nil;
   end;
end;

procedure TCommForm.LoadAllowDenyList();
var
   fname: string;
begin
   FSpotterList.Clear();
   FAllowList.Clear();
   FDenyList.Clear();

   fname := ExtractFilePath(Application.ExeName) + 'spotter_list.txt';
   if FileExists(fname) then begin
      FSpotterList.LoadFromFile(fname);
   end;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_allow.txt';
   if FileExists(fname) then begin
      FAllowList.LoadFromFile(fname);
   end;

   fname := ExtractFilePath(Application.ExeName) + 'spotter_deny.txt';
   if FileExists(fname) then begin
      FDenyList.LoadFromFile(fname);
   end;
end;

{ TCommProcessThread }

constructor TCommProcessThread.Create(formParent: TForm);
begin
   inherited Create(True);
   FParent := formParent;
end;

procedure TCommProcessThread.Execute();
begin
   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** begin - TCommProcessThread.Execute - ****'));
   {$ENDIF}

   repeat
      Sleep(100);
      TCommForm(FParent).CommProcess;
   until Terminated;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('*** end - TCommProcessThread.Execute - ****'));
   {$ENDIF}
end;

initialization
   CommBufferLock := TCriticalSection.Create();

finalization
   CommBufferLock.Free();

end.
