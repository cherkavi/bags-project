object fmGetCom: TfmGetCom
  Left = 352
  Top = 255
  Width = 390
  Height = 340
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Получение переучетов из COM порта'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object memo_history: TMemo
    Left = 0
    Top = 33
    Width = 382
    Height = 239
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 382
    Height = 33
    Align = alTop
    TabOrder = 1
    object label_indicator: TLabel
      Left = 121
      Top = 5
      Width = 160
      Height = 20
      Caption = 'Получение данных'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 272
    Width = 382
    Height = 41
    Align = alBottom
    TabOrder = 2
    object button_close: TButton
      Left = 5
      Top = 8
      Width = 255
      Height = 25
      Caption = 'Закрыть'
      TabOrder = 0
      OnClick = button_closeClick
    end
    object button_clear_buffer: TButton
      Left = 269
      Top = 8
      Width = 92
      Height = 25
      Caption = 'Очистить буфер'
      TabOrder = 1
      OnClick = button_clear_bufferClick
    end
  end
  object ComPort: TVaComm
    Baudrate = br9600
    FlowControl.OutCtsFlow = False
    FlowControl.OutDsrFlow = False
    FlowControl.ControlDtr = dtrDisabled
    FlowControl.ControlRts = rtsDisabled
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    FlowControl.DsrSensitivity = False
    FlowControl.TxContinueOnXoff = False
    PortNum = 1
    DeviceName = 'COM%d'
    OnRxChar = ComPortRxChar
    Left = 256
  end
  object Timer_indicator: TTimer
    Interval = 250
    OnTimer = Timer_indicatorTimer
    Left = 224
  end
end
