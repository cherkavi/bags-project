object fmAssortment_Edit: TfmAssortment_Edit
  Left = 391
  Top = 372
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Редактирование, добаление ассортимента товаров'
  ClientHeight = 126
  ClientWidth = 519
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
  object Label2: TLabel
    Left = 136
    Top = 4
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
    Left = 46
    Top = 44
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
  object Label4: TLabel
    Left = 286
    Top = 44
    Width = 74
    Height = 13
    Caption = 'Примечание'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 118
    Top = 44
    Width = 83
    Height = 13
    Caption = 'Цена закупки'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edit_name: TEdit
    Left = 8
    Top = 20
    Width = 329
    Height = 21
    TabOrder = 0
  end
  object Edit_note: TEdit
    Left = 224
    Top = 60
    Width = 287
    Height = 21
    TabOrder = 3
  end
  object edit_price: TdxCalcEdit
    Left = 6
    Top = 60
    Width = 105
    TabOrder = 1
    Alignment = taCenter
    Text = '0'
    StoredValues = 1
  end
  object button_ok: TButton
    Left = 6
    Top = 92
    Width = 291
    Height = 25
    Caption = 'Сохранить'
    TabOrder = 4
    OnClick = button_okClick
  end
  object Button_cancel: TButton
    Left = 310
    Top = 92
    Width = 201
    Height = 25
    Caption = 'Отменить'
    TabOrder = 5
    OnClick = Button_cancelClick
  end
  object edit_price_buying: TdxCalcEdit
    Left = 112
    Top = 59
    Width = 97
    TabOrder = 2
    Alignment = taCenter
    Text = '0'
    StoredValues = 1
  end
  object button_generator: TButton
    Left = 344
    Top = 19
    Width = 167
    Height = 22
    Caption = 'Сгенерировать макс. значение'
    TabOrder = 6
    OnClick = button_generatorClick
  end
end
