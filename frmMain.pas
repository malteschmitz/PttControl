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
    HotkeyLabeledEdit: TLabeledEdit;
    procedure TxDdeClientItemChange(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure DisconnectBtnClick(Sender: TObject);
    procedure DdeClientConvClose(Sender: TObject);
    procedure DdeClientConvOpen(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TxChkBoxClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure SetTxValue(state: String);
    procedure Hotkey(var Message: TMessage); Message WM_HOTKEY;
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

  RegisterHotKey(Handle, 12, 0, VK_F3);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if TxChkBox.Enabled then
    DdeClientConv.CloseLink;

  UnregisterHotKey(Handle, 12);
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F3 then
    HotkeyLabeledEdit.Text := 'DOWN';
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F3 then
    HotkeyLabeledEdit.Text := 'UP';
end;

procedure TMainForm.Hotkey(var Message: TMessage);
begin
  if Message.WParam = 12 then
  begin
    SetForegroundWindow(Handle);
    ShowWindow(Handle, SW_RESTORE);
    HotkeyLabeledEdit.Text := 'DOWN';
  end;
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
