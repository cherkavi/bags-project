object fmCommodity_to_Main: TfmCommodity_to_Main
  Left = 177
  Top = 151
  Width = 701
  Height = 780
  Caption = 'Довоз товара на склад'
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
    Top = 342
    Width = 693
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 693
    Height = 342
    Align = alTop
    TabOrder = 0
    object DBGrid2: TDBGrid
      Left = 1
      Top = 38
      Width = 691
      Height = 262
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = 'Наименование'
          Width = 274
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Цена'
          Width = 61
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE_BUYING'
          Title.Alignment = taCenter
          Title.Caption = 'Цена закупки'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOTE'
          Title.Alignment = taCenter
          Title.Caption = 'Примечание'
          Width = 187
          Visible = True
        end>
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 691
      Height = 37
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 10
        Top = 7
        Width = 178
        Height = 20
        Caption = 'Ассортимент товара'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 327
        Top = 1
        Width = 116
        Height = 13
        Caption = 'Наименование фильтр'
      end
      object caption_4: TLabel
        Left = 477
        Top = 1
        Width = 103
        Height = 13
        Caption = 'Примечание фильтр'
      end
      object edit_assortment_name_filter: TEdit
        Left = 324
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 0
        OnKeyUp = edit_assortment_name_filterKeyUp
      end
      object edit_assortment_note_filter: TEdit
        Left = 456
        Top = 14
        Width = 170
        Height = 21
        TabOrder = 1
        OnKeyUp = edit_assortment_note_filterKeyUp
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 300
      Width = 691
      Height = 41
      Align = alBottom
      TabOrder = 2
      object button_add_to_main: TButton
        Left = 8
        Top = 8
        Width = 337
        Height = 25
        Caption = 'Добавить выделенный товар на склад'
        TabOrder = 0
        OnClick = button_add_to_mainClick
      end
      object button_assortment_add: TButton
        Left = 376
        Top = 8
        Width = 161
        Height = 25
        Caption = 'Редактировать ассортимент'
        TabOrder = 1
        OnClick = button_assortment_addClick
      end
      object CheckBox_without_price_buying: TCheckBox
        Left = 544
        Top = 12
        Width = 145
        Height = 17
        Caption = 'Без учета закупки'
        TabOrder = 2
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 345
    Width = 693
    Height = 408
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 41
      Width = 691
      Height = 324
      Align = alClient
      DataSource = DataSource2
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = 'Наименование'
          Width = 254
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = 'Количество'
          Width = 72
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ASSORTMENT_PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Цена'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Сумма'
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ASSORTMENT_PRICE_BUYING'
          Title.Caption = 'Цена закупочная'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE_BUYING'
          Title.Caption = 'Сумма закупки'
          Width = 86
          Visible = True
        end>
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 691
      Height = 40
      Align = alTop
      TabOrder = 1
      object Label2: TLabel
        Left = 11
        Top = 11
        Width = 221
        Height = 20
        Caption = 'Наличие товар на складе'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 332
        Top = 1
        Width = 116
        Height = 13
        Caption = 'Наименование фильтр'
      end
      object edit_point_0_name_filter: TEdit
        Left = 330
        Top = 15
        Width = 121
        Height = 21
        TabOrder = 0
        OnKeyUp = edit_point_0_name_filterKeyUp
      end
      object CheckBox_in_step: TCheckBox
        Left = 248
        Top = 16
        Width = 81
        Height = 17
        Caption = 'Синхронно'
        TabOrder = 1
        OnClick = CheckBox_in_stepClick
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 365
      Width = 691
      Height = 42
      Align = alBottom
      TabOrder = 2
      object Label5: TLabel
        Left = 268
        Top = 2
        Width = 34
        Height = 13
        Caption = 'Кол-во'
      end
      object Label6: TLabel
        Left = 431
        Top = 1
        Width = 34
        Height = 13
        Caption = 'Сумма'
      end
      object Label7: TLabel
        Left = 556
        Top = 1
        Width = 78
        Height = 13
        Caption = 'Сумма закупки'
      end
      object edit_quantity: TdxEdit
        Left = 251
        Top = 16
        Width = 65
        TabOrder = 0
        Text = 'edit_quantity'
        Alignment = taRightJustify
        StoredValues = 1
      end
      object edit_price: TdxEdit
        Left = 402
        Top = 16
        Width = 81
        TabOrder = 1
        Text = 'edit_price'
        Alignment = taRightJustify
        StoredValues = 1
      end
      object edit_price_buying: TdxEdit
        Left = 554
        Top = 16
        Width = 81
        TabOrder = 2
        Text = 'edit_price_buying'
        Alignment = taRightJustify
        StoredValues = 1
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_assortment_view
    Left = 456
    Top = 80
  end
  object DataSource2: TDataSource
    DataSet = fmDataModule.query_point_0_view
    Left = 320
    Top = 400
  end
end
