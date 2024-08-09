object fmRediscount_edit_file_add: TfmRediscount_edit_file_add
  Left = 591
  Top = 282
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Редактирование значения'
  ClientHeight = 113
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 88
    Top = 0
    Width = 110
    Height = 13
    Caption = 'Полученное значение'
  end
  object Label2: TLabel
    Left = 88
    Top = 40
    Width = 115
    Height = 13
    Caption = 'Значение, для замены'
  end
  object edit_source: TEdit
    Left = 8
    Top = 16
    Width = 281
    Height = 21
    Color = clMenu
    ReadOnly = True
    TabOrder = 0
  end
  object edit_destination: TEdit
    Left = 8
    Top = 56
    Width = 281
    Height = 21
    TabOrder = 1
  end
  object button_ok: TButton
    Left = 8
    Top = 80
    Width = 145
    Height = 25
    Caption = 'Заменить'
    TabOrder = 2
    OnClick = button_okClick
  end
  object button_cancel: TButton
    Left = 184
    Top = 80
    Width = 105
    Height = 25
    Caption = 'Отменить'
    TabOrder = 3
    OnClick = button_cancelClick
  end
end
