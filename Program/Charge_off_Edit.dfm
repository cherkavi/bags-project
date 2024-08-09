object fmCharge_Off_Edit: TfmCharge_Off_Edit
  Left = 652
  Top = 250
  BorderStyle = bsSingle
  Caption = 'Списывание товара'
  ClientHeight = 164
  ClientWidth = 277
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
    Left = 48
    Top = 3
    Width = 94
    Height = 13
    Caption = 'Торговая точка'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 211
    Top = 4
    Width = 31
    Height = 13
    Caption = 'Дата'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 20
    Top = 44
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
  object Label4: TLabel
    Left = 131
    Top = 45
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
  object Label5: TLabel
    Left = 2
    Top = 88
    Width = 70
    Height = 13
    Caption = 'Количество'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 110
    Top = 88
    Width = 31
    Height = 13
    Caption = 'Цена'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 210
    Top = 88
    Width = 40
    Height = 13
    Caption = 'Сумма'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit_point: TdxEdit
    Left = 0
    Top = 20
    Width = 177
    Color = clMenu
    TabOrder = 0
    Text = 'Edit_point'
    ReadOnly = True
    StoredValues = 64
  end
  object Edit_date: TdxEdit
    Left = 184
    Top = 20
    Width = 89
    Color = clMenu
    TabOrder = 1
    Text = 'Edit_date'
    Alignment = taCenter
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_assortment_kod: TdxEdit
    Left = 0
    Top = 60
    Width = 65
    Color = clMenu
    TabOrder = 2
    Text = 'Edit_assortment_kod'
    Alignment = taCenter
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_name: TdxEdit
    Left = 72
    Top = 60
    Width = 201
    Color = clMenu
    TabOrder = 3
    Text = 'Edit_name'
    ReadOnly = True
    StoredValues = 64
  end
  object Edit_quantity: TdxSpinEdit
    Left = 4
    Top = 104
    Width = 65
    TabOrder = 4
    Alignment = taCenter
    OnChange = Edit_quantityChange
    MaxValue = 1
    Value = 1
    StoredValues = 49
  end
  object Edit_price: TdxEdit
    Left = 88
    Top = 104
    Width = 78
    Color = clMenu
    TabOrder = 5
    Text = 'Edit_price'
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_suma: TdxEdit
    Left = 184
    Top = 104
    Width = 89
    Color = clMenu
    TabOrder = 6
    Text = 'Edit_suma'
    Alignment = taRightJustify
    ReadOnly = True
    StoredValues = 65
  end
  object button_ok: TButton
    Left = 3
    Top = 132
    Width = 166
    Height = 25
    Caption = 'Списать'
    TabOrder = 7
    OnClick = button_okClick
  end
  object button_cancel: TButton
    Left = 176
    Top = 131
    Width = 97
    Height = 25
    Caption = 'Отменить'
    TabOrder = 8
    OnClick = button_cancelClick
  end
end
