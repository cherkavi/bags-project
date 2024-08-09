object fmPayDesk: TfmPayDesk
  Left = 426
  Top = 285
  Width = 631
  Height = 536
  Caption = 'Ввод денежных средств'
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
  object Splitter1: TSplitter
    Left = 0
    Top = 249
    Width = 623
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 35
      Top = 2
      Width = 79
      Height = 13
      Caption = 'Торговая точка'
    end
    object Label2: TLabel
      Left = 155
      Top = 2
      Width = 67
      Height = 13
      Caption = 'Дата продаж'
    end
    object Label3: TLabel
      Left = 363
      Top = 2
      Width = 49
      Height = 13
      Caption = 'Фамилия'
    end
    object Label4: TLabel
      Left = 267
      Top = 2
      Width = 19
      Height = 13
      Caption = 'Код'
    end
    object Label5: TLabel
      Left = 499
      Top = 2
      Width = 22
      Height = 13
      Caption = 'Имя'
    end
    object edit_point_name: TdxEdit
      Left = 3
      Top = 18
      Width = 142
      Color = clMenu
      TabOrder = 0
      Text = 'edit_point_name'
      ReadOnly = True
      StoredValues = 64
    end
    object Edit_Date_sale: TdxEdit
      Left = 147
      Top = 18
      Width = 86
      Color = clMenu
      TabOrder = 1
      Text = 'Edit_Date_sale'
      ReadOnly = True
      StoredValues = 64
    end
    object Edit_seller_familiya: TdxEdit
      Left = 307
      Top = 18
      Width = 142
      Color = clMenu
      TabOrder = 2
      Text = 'Edit_seller_familiya'
      ReadOnly = True
      StoredValues = 64
    end
    object Edit_kod: TdxEdit
      Left = 256
      Top = 18
      Width = 49
      Color = clMenu
      TabOrder = 3
      Text = 'Edit_kod'
      ReadOnly = True
      StoredValues = 64
    end
    object Edit_seller_name: TdxEdit
      Left = 451
      Top = 18
      Width = 142
      Color = clMenu
      TabOrder = 4
      Text = 'Edit_seller_familiya'
      ReadOnly = True
      StoredValues = 64
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 472
    Width = 623
    Height = 37
    Align = alBottom
    TabOrder = 1
    object button_add: TButton
      Left = 8
      Top = 6
      Width = 137
      Height = 25
      Caption = 'Добавить'
      TabOrder = 0
      OnClick = button_addClick
    end
    object edit_balance: TdxEdit
      Left = 496
      Top = 8
      Width = 121
      Color = clMenu
      TabOrder = 1
      Text = 'edit_balance'
      Alignment = taRightJustify
      ReadOnly = True
      StoredValues = 65
    end
    object button_edit: TButton
      Left = 152
      Top = 6
      Width = 151
      Height = 25
      Caption = 'Редактировать'
      TabOrder = 2
      OnClick = button_editClick
    end
    object button_delete: TButton
      Left = 378
      Top = 6
      Width = 113
      Height = 25
      Caption = 'Удалить'
      TabOrder = 3
      OnClick = button_deleteClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 49
    Width = 623
    Height = 200
    Align = alTop
    Caption = 'Список проданного товара за день'
    TabOrder = 2
    object dbgrid_commodity: TDBGrid
      Left = 2
      Top = 15
      Width = 619
      Height = 154
      Align = alClient
      DataSource = DataSource_commodity
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ASSORTMENT_KOD'
          Title.Alignment = taCenter
          Title.Caption = 'Код'
          Width = 43
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Caption = 'Наименование'
          Width = 211
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = 'Кол-во'
          Width = 63
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Цена'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUMA'
          Title.Alignment = taRightJustify
          Title.Caption = 'Сумма'
          Visible = True
        end>
    end
    object Panel3: TPanel
      Left = 2
      Top = 169
      Width = 619
      Height = 29
      Align = alBottom
      TabOrder = 1
      object Label6: TLabel
        Left = 224
        Top = 8
        Width = 259
        Height = 13
        Caption = 'Общая сумма товара, проданного за день:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Edit_commodity_suma: TdxMaskEdit
        Left = 494
        Top = 4
        Width = 121
        Color = clMenu
        TabOrder = 0
        Alignment = taRightJustify
        IgnoreMaskBlank = False
        ReadOnly = True
        Text = 'Edit_commodity_suma'
        StoredValues = 65
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 252
    Width = 623
    Height = 220
    Align = alClient
    Caption = 'Список поступивших средств'
    TabOrder = 3
    object DBGrid_money: TDBGrid
      Left = 2
      Top = 15
      Width = 619
      Height = 174
      Align = alClient
      DataSource = DataSource_money
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = button_editClick
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Caption = 'Операция'
          Width = 210
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AMOUNT'
          Title.Alignment = taRightJustify
          Title.Caption = 'Сумма'
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOTE'
          Title.Caption = 'Примечание'
          Width = 154
          Visible = True
        end>
    end
    object Panel4: TPanel
      Left = 2
      Top = 189
      Width = 619
      Height = 29
      Align = alBottom
      TabOrder = 1
      object Label7: TLabel
        Left = 211
        Top = 8
        Width = 273
        Height = 13
        Caption = 'Общая сумма средств, поступивших за день:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Edit_money_suma: TdxEdit
        Left = 495
        Top = 3
        Width = 121
        Color = clMenu
        TabOrder = 0
        Text = 'Edit_money_suma'
        Alignment = taRightJustify
        StoredValues = 1
      end
    end
  end
  object DataSource_commodity: TDataSource
    DataSet = fmDataModule.query_PayDesk_commodity
    Left = 168
    Top = 97
  end
  object DataSource_money: TDataSource
    DataSet = fmDataModule.Query_PayDesk_Money
    Left = 176
    Top = 325
  end
end
