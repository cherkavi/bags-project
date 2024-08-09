object fmStartUp: TfmStartUp
  Left = 683
  Top = 243
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Выбор базы данных'
  ClientHeight = 186
  ClientWidth = 156
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 156
    Height = 129
    Align = alClient
    TabOrder = 0
    object RadioButton_bags: TRadioButton
      Left = 48
      Top = 8
      Width = 73
      Height = 17
      Caption = 'Сумки'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButton_glove: TRadioButton
      Left = 48
      Top = 32
      Width = 73
      Height = 17
      Caption = 'Перчатки'
      TabOrder = 1
    end
    object RadioButton_purse: TRadioButton
      Left = 48
      Top = 56
      Width = 73
      Height = 17
      Caption = 'Портмоне'
      TabOrder = 2
    end
    object RadioButton_tree: TRadioButton
      Left = 48
      Top = 80
      Width = 73
      Height = 17
      Caption = 'Елки'
      TabOrder = 3
    end
    object RadioButton_new: TRadioButton
      Left = 48
      Top = 104
      Width = 113
      Height = 17
      Caption = 'Колготки'
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 129
    Width = 156
    Height = 57
    Align = alBottom
    TabOrder = 1
    object button_enter: TButton
      Left = 8
      Top = 8
      Width = 137
      Height = 41
      Caption = 'Открыть'
      TabOrder = 0
      OnClick = button_enterClick
    end
  end
end
