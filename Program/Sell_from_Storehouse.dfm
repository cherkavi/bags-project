object fmSell_from_Storehouse: TfmSell_from_Storehouse
  Left = 211
  Top = 95
  Width = 809
  Height = 543
  Caption = 'Продажа товара со склада'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter
    Left = 0
    Top = 268
    Width = 801
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object GroupBox_storehouse: TGroupBox
    Left = 0
    Top = 0
    Width = 801
    Height = 268
    Align = alTop
    Caption = 'Склад'
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 16
      Width = 797
      Height = 49
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 93
        Top = 1
        Width = 30
        Height = 14
        Caption = 'Склад'
      end
      object Label2: TLabel
        Left = 246
        Top = 1
        Width = 102
        Height = 14
        Caption = 'Дата ввода продаж'
      end
      object Label3: TLabel
        Left = 534
        Top = 1
        Width = 104
        Height = 14
        Caption = 'Фильтр на названии'
      end
      object ComboBox_points: TComboBox
        Left = 9
        Top = 18
        Width = 216
        Height = 22
        Style = csDropDownList
        ItemHeight = 14
        TabOrder = 0
        OnChange = ComboBox_pointsChange
      end
      object Edit_date_storehouse: TdxDateEdit
        Left = 233
        Top = 18
        Width = 130
        TabOrder = 1
        Date = -700000
      end
      object edit_filter_storehouse_name: TEdit
        Left = 500
        Top = 18
        Width = 164
        Height = 22
        TabOrder = 2
        OnChange = edit_filter_storehouse_nameChange
      end
    end
    object DBGrid_storehouse: TDBGrid
      Left = 2
      Top = 65
      Width = 797
      Height = 201
      Align = alClient
      DataSource = DataSource_storehouse
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ASSORTMENT_NAME'
          Title.Alignment = taCenter
          Title.Caption = 'Наименование'
          Width = 211
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = 'Кол-во'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Цена'
          Width = 77
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SUMA'
          Title.Alignment = taCenter
          Title.Caption = 'Сумма'
          Width = 79
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PRICE_BUYING'
          Title.Alignment = taCenter
          Title.Caption = 'Цена закупки'
          Width = 81
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SUMA_BUYING'
          Title.Alignment = taCenter
          Title.Caption = 'Сумма закупки'
          Width = 85
          Visible = True
        end>
    end
  end
  object GroupBox_sell_commodity: TGroupBox
    Left = 0
    Top = 271
    Width = 801
    Height = 245
    Align = alClient
    Caption = 'Проданный со склада товар'
    TabOrder = 1
    object Panel2: TPanel
      Left = 2
      Top = 16
      Width = 797
      Height = 53
      Align = alTop
      TabOrder = 0
      object Label4: TLabel
        Left = 534
        Top = 1
        Width = 99
        Height = 14
        Caption = 'Фильтр в названии'
      end
      object edit_filter_sell_commodity: TEdit
        Left = 500
        Top = 18
        Width = 182
        Height = 22
        TabOrder = 0
        OnChange = edit_filter_storehouse_nameChange
      end
      object CheckBox_in_step: TCheckBox
        Left = 706
        Top = 19
        Width = 105
        Height = 19
        Caption = 'Синхронно'
        TabOrder = 1
        OnClick = CheckBox_in_stepClick
      end
      object button_sell: TButton
        Left = 9
        Top = 9
        Width = 311
        Height = 36
        Caption = 'Занести продажу'
        TabOrder = 2
        OnClick = button_sellClick
      end
      object button_sell_skip: TButton
        Left = 336
        Top = 9
        Width = 139
        Height = 35
        Caption = 'Отменить продажу'
        TabOrder = 3
        OnClick = button_sell_skipClick
      end
    end
    object DBGrid_sell_commodity: TDBGrid
      Left = 2
      Top = 69
      Width = 797
      Height = 174
      Align = alClient
      DataSource = DataSource_sell_commodity
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ASSORTMENT_NAME'
          Title.Caption = 'Наименование'
          Width = 172
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'MONEY_AMOUNT'
          Title.Caption = 'Сумма продажи'
          Width = 128
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WRITER_FAMILIYA'
          Title.Caption = 'Записал данные'
          Width = 134
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MONEY_DATE_WRITE'
          Title.Caption = 'Дата записи продажи'
          Width = 115
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ASSORTMENT_PRICE'
          Title.Caption = 'Цена по прайсу'
          Width = 99
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ASSORTMENT_PRICE_BUYING'
          Title.Caption = 'Цена закупки'
          Width = 77
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOTE'
          Title.Caption = 'Кол-во'
          Visible = True
        end>
    end
  end
  object DataSource_storehouse: TDataSource
    DataSet = fmDataModule.Query_transfer_source
    Left = 264
    Top = 120
  end
  object DataSource_sell_commodity: TDataSource
    DataSet = fmDataModule.Query_transfer_destination
    Left = 272
    Top = 348
  end
end
