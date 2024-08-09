object fmSell_from_Storehouse_transaction: TfmSell_from_Storehouse_transaction
  Left = 455
  Top = 308
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Продажа товара со склада'
  ClientHeight = 202
  ClientWidth = 454
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
    Left = 182
    Top = 0
    Width = 76
    Height = 13
    Caption = 'Наименование'
  end
  object Label2: TLabel
    Left = 82
    Top = 40
    Width = 79
    Height = 13
    Caption = 'Цена по прайсу'
  end
  object Label3: TLabel
    Left = 184
    Top = 40
    Width = 87
    Height = 13
    Caption = 'Сумма по прайсу'
  end
  object Label4: TLabel
    Left = 288
    Top = 40
    Width = 147
    Height = 13
    Caption = 'Разница с суммой по прайсу'
  end
  object Label5: TLabel
    Left = 82
    Top = 80
    Width = 79
    Height = 13
    Caption = 'Цена в закупке'
  end
  object Label6: TLabel
    Left = 184
    Top = 80
    Width = 87
    Height = 13
    Caption = 'Сумма в закупке'
  end
  object Label7: TLabel
    Left = 288
    Top = 80
    Width = 153
    Height = 13
    Caption = 'Разница с суммой по закупке'
  end
  object Label8: TLabel
    Left = 18
    Top = 122
    Width = 34
    Height = 13
    Caption = 'Кол-во'
  end
  object Label9: TLabel
    Left = 210
    Top = 122
    Width = 34
    Height = 13
    Caption = 'Сумма'
  end
  object Label10: TLabel
    Left = 90
    Top = 122
    Width = 60
    Height = 13
    Caption = 'Цена за шт.'
  end
  object edit_name: TEdit
    Left = 8
    Top = 16
    Width = 433
    Height = 21
    ReadOnly = True
    TabOrder = 0
    Text = 'Edit_name'
  end
  object button_ok: TButton
    Left = 16
    Top = 168
    Width = 161
    Height = 25
    Caption = 'Продажа'
    TabOrder = 1
    OnClick = button_okClick
  end
  object button_cancel: TButton
    Left = 320
    Top = 168
    Width = 121
    Height = 25
    Caption = 'Отменить'
    TabOrder = 2
    OnClick = button_cancelClick
  end
  object Edit_quantity_current: TdxSpinEdit
    Left = 7
    Top = 136
    Width = 58
    TabOrder = 3
    Alignment = taRightJustify
    OnChange = Edit_quantity_currentChange
    StoredValues = 1
  end
  object Edit_price: TdxEdit
    Left = 86
    Top = 56
    Width = 73
    TabOrder = 4
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_price_buying: TdxEdit
    Left = 86
    Top = 96
    Width = 73
    TabOrder = 5
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_price_current: TdxEdit
    Left = 86
    Top = 136
    Width = 73
    TabOrder = 6
    OnKeyUp = Edit_price_currentKeyUp
    Alignment = taRightJustify
    StoredValues = 1
  end
  object Edit_summa_price: TdxEdit
    Left = 190
    Top = 56
    Width = 73
    TabOrder = 7
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_summa_buying: TdxEdit
    Left = 190
    Top = 96
    Width = 73
    TabOrder = 8
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_summa_current: TdxEdit
    Left = 190
    Top = 136
    Width = 73
    TabOrder = 9
    OnKeyUp = Edit_summa_currentKeyUp
    Alignment = taRightJustify
    StoredValues = 1
  end
  object Edit_price_balance: TdxEdit
    Left = 318
    Top = 56
    Width = 73
    TabOrder = 10
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_price_buying_balance: TdxEdit
    Left = 318
    Top = 96
    Width = 73
    TabOrder = 11
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
end
