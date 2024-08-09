object fmExpenses_Edit: TfmExpenses_Edit
  Left = 455
  Top = 283
  BorderStyle = bsSingle
  Caption = 'Ввод/изменение'
  ClientHeight = 69
  ClientWidth = 425
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
    Left = 17
    Top = 0
    Width = 19
    Height = 13
    Caption = 'Код'
  end
  object Label2: TLabel
    Left = 173
    Top = 0
    Width = 76
    Height = 13
    Caption = 'Наименование'
  end
  object edit_kod: TEdit
    Left = 2
    Top = 16
    Width = 57
    Height = 21
    Color = clMenu
    ReadOnly = True
    TabOrder = 3
    Text = 'edit_kod'
  end
  object Edit_name: TEdit
    Left = 58
    Top = 16
    Width = 329
    Height = 21
    TabOrder = 0
    Text = 'Edit_name'
  end
  object button_ok: TButton
    Left = 2
    Top = 40
    Width = 201
    Height = 25
    Caption = 'Сохранить'
    TabOrder = 1
    OnClick = button_okClick
  end
  object button_cancel: TButton
    Left = 218
    Top = 40
    Width = 169
    Height = 25
    Caption = 'Отменить'
    TabOrder = 2
    OnClick = button_cancelClick
  end
  object radiobutton_positive: TRadioButton
    Left = 396
    Top = 13
    Width = 29
    Height = 17
    Caption = '+'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    TabStop = True
  end
  object RadioButton_negative: TRadioButton
    Left = 396
    Top = 29
    Width = 29
    Height = 17
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
end
