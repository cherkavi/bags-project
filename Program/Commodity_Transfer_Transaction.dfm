object fmCommodity_Transfer_Transaction: TfmCommodity_Transfer_Transaction
  Left = 528
  Top = 463
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Перемещение товара:'
  ClientHeight = 178
  ClientWidth = 369
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
    Left = 8
    Top = 8
    Width = 160
    Height = 13
    Caption = 'Склад-Источник передает:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 173
    Height = 13
    Caption = 'Склад-Приемник принимает:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 108
    Top = 23
    Width = 19
    Height = 13
    Caption = 'Код'
    Visible = False
  end
  object Label4: TLabel
    Left = 133
    Top = 56
    Width = 76
    Height = 13
    Caption = 'Наименование'
  end
  object Label5: TLabel
    Left = 28
    Top = 104
    Width = 34
    Height = 13
    Alignment = taCenter
    Caption = 'Кол-во'
  end
  object Label6: TLabel
    Left = 119
    Top = 104
    Width = 26
    Height = 13
    Caption = 'Цена'
  end
  object Label7: TLabel
    Left = 201
    Top = 104
    Width = 34
    Height = 13
    Caption = 'Сумма'
  end
  object Label8: TLabel
    Left = 276
    Top = 104
    Width = 77
    Height = 13
    Caption = 'Дата операции'
  end
  object edit_assortment_kod: TEdit
    Left = 100
    Top = 39
    Width = 41
    Height = 21
    Color = clScrollBar
    TabOrder = 3
    Text = 'edit_assortment_kod'
    Visible = False
  end
  object edit_name: TEdit
    Left = 8
    Top = 72
    Width = 353
    Height = 21
    Color = clMenu
    TabOrder = 4
    Text = 'edit_name'
  end
  object Edit_quantity: TdxSpinEdit
    Left = 7
    Top = 120
    Width = 81
    TabOrder = 0
    Alignment = taCenter
    OnChange = Edit_quantityChange
    StoredValues = 1
  end
  object edit_source: TEdit
    Left = 183
    Top = 4
    Width = 177
    Height = 21
    Color = clMenu
    ReadOnly = True
    TabOrder = 5
    Text = 'edit_source'
  end
  object edit_destination: TEdit
    Left = 183
    Top = 29
    Width = 178
    Height = 21
    Color = clMenu
    ReadOnly = True
    TabOrder = 6
    Text = 'edit_destination'
  end
  object edit_price: TdxEdit
    Left = 96
    Top = 120
    Width = 73
    Color = clScrollBar
    TabOrder = 7
    Text = 'edit_price'
    Alignment = taRightJustify
    StoredValues = 1
  end
  object Edit_suma: TdxEdit
    Left = 176
    Top = 120
    Width = 73
    Color = clScrollBar
    TabOrder = 8
    Text = 'edit_price'
    Alignment = taRightJustify
    StoredValues = 1
  end
  object date_in_out: TdxDateEdit
    Left = 259
    Top = 120
    Width = 103
    Color = clMenu
    TabOrder = 9
    ReadOnly = False
    Date = -700000
    StoredValues = 64
  end
  object button_ok: TButton
    Left = 8
    Top = 147
    Width = 169
    Height = 25
    Caption = 'Перенести товар'
    TabOrder = 1
    OnClick = button_okClick
  end
  object button_cancel: TButton
    Left = 232
    Top = 147
    Width = 131
    Height = 25
    Caption = 'Отмена переноса'
    TabOrder = 2
    OnClick = button_cancelClick
  end
end
