object fmPoints_sale_preambule: TfmPoints_sale_preambule
  Left = 283
  Top = 73
  Width = 567
  Height = 628
  Caption = 'Продажи на точках'
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
    Top = 309
    Width = 559
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 559
    Height = 45
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 222
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
    object combobox_points: TComboBox
      Left = 76
      Top = 19
      Width = 397
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = combobox_pointsChange
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 45
    Width = 559
    Height = 264
    Align = alTop
    Caption = 'Продавец'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object dbgrid_seller: TDBGrid
      Left = 2
      Top = 15
      Width = 555
      Height = 213
      Align = alClient
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnDblClick = dbgrid_sellerDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'KOD'
          Title.Alignment = taCenter
          Title.Caption = 'Код'
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FAMILIYA'
          Title.Alignment = taCenter
          Title.Caption = 'Фамилия'
          Width = 138
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IMYA'
          Title.Alignment = taCenter
          Title.Caption = 'Имя'
          Width = 217
          Visible = True
        end>
    end
    object Panel2: TPanel
      Left = 2
      Top = 228
      Width = 555
      Height = 34
      Align = alBottom
      TabOrder = 1
      object Label2: TLabel
        Left = 4
        Top = 8
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
      object Edit_Date: TdxDateEdit
        Left = 39
        Top = 6
        Width = 108
        TabOrder = 0
        Alignment = taCenter
        ReadOnly = False
        OnChange = Edit_DateChange
        Date = -700000
        StoredValues = 65
      end
      object Button_ok: TButton
        Left = 148
        Top = 3
        Width = 217
        Height = 25
        Caption = 'Ввести продажи'
        TabOrder = 1
        OnClick = Button_okClick
      end
      object button_cancel: TButton
        Left = 407
        Top = 3
        Width = 78
        Height = 25
        Caption = 'Закончить'
        TabOrder = 2
        OnClick = button_cancelClick
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 312
    Width = 559
    Height = 289
    Align = alClient
    Caption = 'Внесенные продажи'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object dbGrid_sells: TDBGrid
      Left = 2
      Top = 15
      Width = 555
      Height = 272
      Align = alClient
      DataSource = DataSource2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'FAMILIYA'
          Title.Caption = 'Продавец'
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Caption = 'Наименование'
          Width = 125
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = 'Кол-во'
          Width = 52
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Цена'
          Width = 71
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUMA'
          Title.Alignment = taCenter
          Title.Caption = 'Сумма'
          Width = 80
          Visible = True
        end>
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_people
    Left = 312
    Top = 168
  end
  object DataSource2: TDataSource
    DataSet = fmDataModule.query_assortment_view
    Left = 264
    Top = 464
  end
end
