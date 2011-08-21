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
    TxChkBox: TCheckBox;
    procedure TxDdeClientItemChange(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure DisconnectBtnClick(Sender: TObject);
    procedure DdeClientConvClose(Sender: TObject);
    procedure DdeClientConvOpen(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TxChkBoxClick(Sender: TObject);
  private
    procedure SetTxValue(state: String);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.ConnectBtnClick(Sender: TObject);
begin
  DdeClientConv.SetLink('HRD_RADIO_000', 'HRD_CAT');
  if not DdeClientConv.OpenLink then
  begin
    ShowMessage('Error opening link.');
  end;
end;

procedure TMainForm.DdeClientConvClose(Sender: TObject);
begin
  LinkStatusLabeledEdit.Text := 'CLOSED';
  TxChkBox.Enabled := False;
  SetTxValue('');
end;

procedure TMainForm.DdeClientConvOpen(Sender: TObject);
begin
  LinkStatusLabeledEdit.Text := 'OPEN';
  TxChkBox.Enabled := True;
  SetTxValue('');
end;

procedure TMainForm.DisconnectBtnClick(Sender: TObject);
begin
  DdeClientConv.CloseLink;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SetWindowLong(TxChkBox.Handle, GWL_STYLE,
    GetWindowLong(TxChkBox.Handle, GWL_STYLE) or BS_PUSHLIKE);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if TxChkBox.Enabled then
    DdeClientConv.CloseLink;
end;

procedure TMainForm.SetTxValue(state: String);
begin
  TxChkBox.OnClick := nil;
  if TxChkBox.Enabled then
  begin
    if state = 'On' then
      TxChkBox.State := cbChecked
    else if state = 'Off' then
      TxChkBox.State := cbUnchecked
    else
      TxChkBox.State := cbGrayed;
  end
  else
    TxChkBox.State := cbGrayed;
  TxChkBox.OnClick := TxChkBoxClick;
end;

procedure TMainForm.TxChkBoxClick(Sender: TObject);
var
  value: String;
begin
  if TxChkBox.Enabled then
  begin
    if TxChkBox.Checked then
      value := 'On'
    else
      value := 'Off';
    DdeClientConv.ExecuteMacro(PChar('butn TX=' + value), False);
  end;
end;

procedure TMainForm.TxDdeClientItemChange(Sender: TObject);
begin
  TxLabeledEdit.Text := TxDdeClientItem.Text;
  SetTxValue(TxDdeClientItem.Text);
end;

end.
