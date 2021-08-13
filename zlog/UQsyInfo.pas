unit UQsyInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TformQsyInfo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
    procedure SetQsyInfo(qsyok: Boolean; S: string);
  end;


implementation

{$R *.dfm}

procedure TformQsyInfo.FormCreate(Sender: TObject);
begin
   Panel1.Color := clBtnFace;
   Panel1.Font.Color := clWindow;
   Panel1.Caption := '';
end;

procedure TformQsyInfo.FormResize(Sender: TObject);
begin
   if ClientWidth > ClientHeight then begin
      ClientHeight := ClientWidth;
   end
   else begin
      ClientWidth := ClientHeight;
   end;
end;

procedure TformQsyInfo.SetQsyInfo(qsyok: Boolean; S: string);
begin
   if S = '' then begin
      Panel1.Color := clBtnFace;
      Panel1.Font.Color := clWindow;
   end
   else begin
      if qsyok = True then begin
         Panel1.Color := clLime;
         Panel1.Font.Color := clBlue;
      end
      else begin
         Panel1.Color := clYellow;
         Panel1.Font.Color := clRed;
      end;

      if Visible = False then begin
         Show();
      end;
   end;
   Label1.Caption := S;
end;

end.