unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DdeMan;

type
  TMainForm = class(TForm)
    DdeClientConv: TDdeClientConv;
    TxDdeClientItem: TDdeClientItem;
    TxLabeledEdit: TLabeledEdit;
    ConnectBtn: TButton;
    DisconnectBtn: TButton;
    LinkStatusLabeledEdit: TLabeledEdit;
    procedure TxDdeClientItemChange(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure DisconnectBtnClick(Sender: TObject);
    procedure DdeClientConvClose(Sender: TObject);
    procedure DdeClientConvOpen(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.ConnectBtnClick(Sender: TObject);
begin
  DdeClientConv.OpenLink;
end;

procedure TMainForm.DdeClientConvClose(Sender: TObject);
begin
  LinkStatusLabeledEdit.Text := 'CLOSED';
end;

procedure TMainForm.DdeClientConvOpen(Sender: TObject);
begin
  LinkStatusLabeledEdit.Text := 'OPEN';
end;

procedure TMainForm.DisconnectBtnClick(Sender: TObject);
begin
  DdeClientConv.CloseLink;
end;

procedure TMainForm.TxDdeClientItemChange(Sender: TObject);
begin
  TxLabeledEdit.Text := TxDdeClientItem.Text;
end;

end.
