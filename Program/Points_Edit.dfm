object fmPoints_Edit: TfmPoints_Edit
  Left = 469
  Top = 309
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Торговые точки'
  ClientHeight = 146
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 22
    Top = 0
    Width = 23
    Height = 13
    Caption = 'Код'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 168
    Top = 0
    Width = 89
    Height = 13
    Caption = 'Наименование'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 184
    Top = 75
    Width = 31
    Height = 13
    Caption = 'Адрес'
  end
  object Label4: TLabel
    Left = 126
    Top = 38
    Width = 31
    Height = 13
    Caption = 'Район'
  end
  object Label5: TLabel
    Left = 294
    Top = 38
    Width = 81
    Height = 13
    Caption = 'Арендная плата'
  end
  object edit_kod: TEdit
    Left = 0
    Top = 16
    Width = 73
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object edit_name: TEdit
    Left = 72
    Top = 16
    Width = 321
    Height = 21
    TabOrder = 0
  end
  object edit_address: TEdit
    Left = 0
    Top = 91
    Width = 393
    Height = 21
    TabOrder = 1
  end
  object button_Ok: TButton
    Left = 0
    Top = 117
    Width = 217
    Height = 25
    Caption = 'Сохранить'
    TabOrder = 2
    OnClick = button_OkClick
  end
  object button_cancel: TButton
    Left = 240
    Top = 117
    Width = 153
    Height = 25
    Caption = 'Отменить'
    TabOrder = 3
    OnClick = button_cancelClick
  end
  object edit_rayon: TEdit
    Left = 0
    Top = 53
    Width = 265
    Height = 21
    TabOrder = 5
  end
  object Edit_arenda: TdxCalcEdit
    Left = 272
    Top = 53
    Width = 121
    TabOrder = 6
    Alignment = taRightJustify
    Text = '0'
    StoredValues = 1
  end
end
