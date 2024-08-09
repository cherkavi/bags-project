object fmCommodity_to_main_transaction: TfmCommodity_to_main_transaction
  Left = 422
  Top = 380
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Позиция на склад'
  ClientHeight = 201
  ClientWidth = 303
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
  TextHeight = 14
  object Label1: TLabel
    Left = 43
    Top = 117
    Width = 22
    Height = 15
    Caption = 'Код'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Label2: TLabel
    Left = 100
    Top = 26
    Width = 86
    Height = 15
    Caption = 'Наименование'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 23
    Top = -1
    Width = 240
    Height = 18
    Caption = 'Перемещение позиции на склад'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 17
    Top = 78
    Width = 69
    Height = 15
    Caption = 'Количество'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 233
    Top = 78
    Width = 37
    Height = 15
    Caption = 'Сумма'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 130
    Top = 121
    Width = 28
    Height = 15
    Caption = 'Дата'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 146
    Top = 78
    Width = 30
    Height = 15
    Caption = 'Цена'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edit_kod: TEdit
    Left = 34
    Top = 137
    Width = 45
    Height = 22
    ReadOnly = True
    TabOrder = 3
    Visible = False
  end
  object edit_name: TEdit
    Left = 9
    Top = 45
    Width = 285
    Height = 22
    ReadOnly = True
    TabOrder = 4
  end
  object edit_suma: TEdit
    Left = 211
    Top = 95
    Width = 83
    Height = 22
    ReadOnly = True
    TabOrder = 5
  end
  object Edit_quantity: TdxSpinEdit
    Left = 9
    Top = 95
    Width = 87
    TabOrder = 0
    OnChange = Edit_quantityChange
  end
  object button_ok: TButton
    Left = 9
    Top = 164
    Width = 147
    Height = 27
    Caption = 'Занести'
    TabOrder = 1
    OnClick = button_okClick
  end
  object button_cancel: TButton
    Left = 181
    Top = 164
    Width = 113
    Height = 27
    Caption = 'Отменить'
    TabOrder = 2
    OnClick = button_cancelClick
  end
  object Edit_date: TdxDateEdit
    Left = 104
    Top = 138
    Width = 96
    TabOrder = 6
    ReadOnly = False
    Date = -700000
    StoredValues = 64
  end
  object Edit_price: TEdit
    Left = 112
    Top = 95
    Width = 96
    Height = 22
    ReadOnly = True
    TabOrder = 7
  end
end
