object fmPoint_Sale_Transaction: TfmPoint_Sale_Transaction
  Left = 538
  Top = 196
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Продажа товара'
  ClientHeight = 239
  ClientWidth = 256
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
    Left = 2
    Top = 10
    Width = 82
    Height = 13
    Caption = 'Торговая точка:'
  end
  object Label2: TLabel
    Left = 3
    Top = 35
    Width = 53
    Height = 13
    Caption = 'Продавец:'
  end
  object Label3: TLabel
    Left = 1
    Top = 59
    Width = 76
    Height = 13
    Caption = 'Дата продажи:'
  end
  object Label4: TLabel
    Left = 4
    Top = 84
    Width = 60
    Height = 13
    Caption = 'Код товара:'
  end
  object Label5: TLabel
    Left = 3
    Top = 108
    Width = 79
    Height = 13
    Caption = 'Наименование:'
  end
  object Label6: TLabel
    Left = 5
    Top = 132
    Width = 29
    Height = 13
    Caption = 'Цена:'
  end
  object Label7: TLabel
    Left = 4
    Top = 157
    Width = 34
    Height = 13
    Caption = 'Кол-во'
  end
  object Label8: TLabel
    Left = 4
    Top = 181
    Width = 74
    Height = 13
    Caption = 'Общая сумма:'
  end
  object edit_seller: TdxEdit
    Left = 88
    Top = 32
    Width = 161
    Color = clMenu
    TabOrder = 4
    Text = 'edit_seller'
    ReadOnly = True
    StoredValues = 64
  end
  object edit_points: TdxEdit
    Left = 88
    Top = 8
    Width = 161
    Color = clMenu
    TabOrder = 5
    Text = 'dxEdit1'
    ReadOnly = True
    StoredValues = 64
  end
  object edit_date: TdxEdit
    Left = 88
    Top = 56
    Width = 161
    Color = clMenu
    TabOrder = 6
    Text = 'dxEdit1'
    ReadOnly = True
    StoredValues = 64
  end
  object Edit_kod: TdxEdit
    Left = 88
    Top = 80
    Width = 161
    TabOrder = 7
    Text = 'dxEdit1'
    ReadOnly = True
    StoredValues = 64
  end
  object Edit_name: TdxEdit
    Left = 88
    Top = 104
    Width = 161
    TabOrder = 8
    Text = 'dxEdit1'
    ReadOnly = True
    StoredValues = 64
  end
  object Edit_price: TdxEdit
    Left = 120
    Top = 128
    Width = 89
    TabOrder = 9
    Text = 'dxEdit1'
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_suma: TdxEdit
    Left = 120
    Top = 176
    Width = 89
    TabOrder = 3
    Text = 'dxEdit1'
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_quantity: TdxSpinEdit
    Left = 120
    Top = 152
    Width = 89
    TabOrder = 0
    OnKeyUp = Edit_quantityKeyUp
    Alignment = taCenter
    OnChange = Edit_quantityChange
    StoredValues = 1
  end
  object button_ok: TButton
    Left = 3
    Top = 208
    Width = 121
    Height = 25
    Caption = 'Провести'
    TabOrder = 1
    OnClick = button_okClick
  end
  object button_cancel: TButton
    Left = 144
    Top = 208
    Width = 107
    Height = 25
    Caption = 'Отменить'
    TabOrder = 2
    OnClick = button_cancelClick
  end
end
