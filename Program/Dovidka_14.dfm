object fmDovidka_14: TfmDovidka_14
  Left = 599
  Top = 340
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Сопряжение склада и торговой точки'
  ClientHeight = 105
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 92
    Top = 0
    Width = 79
    Height = 13
    Caption = 'Торговая точка'
  end
  object ComboBox_points: TComboBox
    Left = 34
    Top = 13
    Width = 203
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object button_absent_on_point: TButton
    Left = 8
    Top = 40
    Width = 249
    Height = 25
    Caption = 'Есть на складе, но нет на точке'
    TabOrder = 1
    OnClick = button_absent_on_pointClick
  end
  object button_present_on_point: TButton
    Left = 8
    Top = 72
    Width = 249
    Height = 25
    Caption = 'Есть на точке, но нет на складе'
    TabOrder = 2
    OnClick = button_present_on_pointClick
  end
end
