object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'PTT Control'
  ClientHeight = 301
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object TxLabeledEdit: TLabeledEdit
    Left = 104
    Top = 224
    Width = 121
    Height = 21
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = 'HRD_TX'
    ReadOnly = True
    TabOrder = 0
  end
  object ConnectBtn: TButton
    Left = 40
    Top = 56
    Width = 75
    Height = 25
    Caption = 'ConnectBtn'
    TabOrder = 1
    OnClick = ConnectBtnClick
  end
  object DisconnectBtn: TButton
    Left = 64
    Top = 120
    Width = 75
    Height = 25
    Caption = 'DisconnectBtn'
    TabOrder = 2
    OnClick = DisconnectBtnClick
  end
  object LinkStatusLabeledEdit: TLabeledEdit
    Left = 240
    Top = 224
    Width = 121
    Height = 21
    EditLabel.Width = 52
    EditLabel.Height = 13
    EditLabel.Caption = 'Link Status'
    ReadOnly = True
    TabOrder = 3
  end
  object DdeClientConv: TDdeClientConv
    DdeService = 'HRD_RADIO_000'
    DdeTopic = 'HRD_CAT'
    ConnectMode = ddeManual
    FormatChars = True
    OnClose = DdeClientConvClose
    OnOpen = DdeClientConvOpen
    Left = 224
    Top = 16
    LinkInfo = (
      'Service HRD_RADIO_000'
      'Topic HRD_CAT')
  end
  object TxDdeClientItem: TDdeClientItem
    DdeConv = DdeClientConv
    DdeItem = 'HRD_TX'
    OnChange = TxDdeClientItemChange
    Left = 240
    Top = 120
  end
end
