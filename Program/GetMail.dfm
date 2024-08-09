object fmGetMail: TfmGetMail
  Left = 567
  Top = 221
  BorderStyle = bsSingle
  Caption = 'Получение почты'
  ClientHeight = 308
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object memo_history: TMemo
    Left = 0
    Top = 34
    Width = 351
    Height = 274
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 351
    Height = 34
    Align = alTop
    TabOrder = 1
    object button_get_mail: TButton
      Left = 8
      Top = 4
      Width = 337
      Height = 24
      Caption = 'Получить письма из сети'
      TabOrder = 0
      OnClick = button_get_mailClick
    end
  end
  object NMpop3: TNMPOP3
    Port = 110
    ReportLevel = 0
    Parse = False
    DeleteOnRead = False
    Left = 280
    Top = 32
  end
end
