object fmCharge_Off: TfmCharge_Off
  Left = 217
  Top = 123
  Width = 696
  Height = 502
  Caption = 'Списывание товара с торговой точки'
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
    Width = 688
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 688
    Height = 55
    Align = alTop
    Caption = 'Критерии отбора'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 124
      Top = 11
      Width = 89
      Height = 15
      Caption = 'Торговая точка'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 374
      Top = 9
      Width = 87
      Height = 15
      Caption = 'Дата списания'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 541
      Top = 10
      Width = 123
      Height = 15
      Caption = 'Фильтр на название:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object combobox_points: TComboBox
      Left = 25
      Top = 26
      Width = 294
      Height = 23
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
      OnChange = combobox_pointsChange
    end
    object edit_date: TdxDateEdit
      Left = 358
      Top = 26
      Width = 130
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ReadOnly = False
      OnChange = combobox_pointsChange
      Date = -700000
      StoredValues = 64
    end
    object edit_commodity_filter_name: TEdit
      Left = 543
      Top = 26
      Width = 130
      Height = 22
      TabOrder = 2
      OnKeyUp = edit_commodity_filter_nameKeyUp
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 55
    Width = 688
    Height = 213
    Align = alTop
    Caption = 'Наличие товара на торговой точке по заданной дате'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object DBGrid_commodity: TDBGrid
      Left = 2
      Top = 17
      Width = 684
      Height = 194
      Align = alClient
      DataSource = DataSource_commodity
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
      OnDblClick = button_charge_offClick
      Columns = <
        item
          Expanded = False
          FieldName = 'ASSORTMENT_KOD'
          Title.Caption = 'Код'
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Caption = 'Наименование'
          Width = 189
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = 'Кол-во'
          Width = 121
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Цена'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SUMA'
          Title.Alignment = taRightJustify
          Title.Caption = 'Сумма'
          Width = 85
          Visible = True
        end>
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 271
    Width = 688
    Height = 168
    Align = alClient
    Caption = 'Товар, который был списан по заданной дате'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object DBGrid_charge_off: TDBGrid
      Left = 2
      Top = 17
      Width = 684
      Height = 149
      Align = alClient
      DataSource = DataSource_charge_off
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
          FieldName = 'ASSORTMENT_KOD'
          Title.Caption = 'Код'
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Caption = 'Наименование'
          Width = 169
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Caption = 'Кол-во'
          Width = 120
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Цена'
          Width = 97
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SUMA'
          Title.Alignment = taRightJustify
          Title.Caption = 'Сумма'
          Width = 86
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 439
    Width = 688
    Height = 36
    Align = alBottom
    TabOrder = 3
    object button_charge_off: TButton
      Left = 9
      Top = 4
      Width = 440
      Height = 27
      Caption = 'Списать товар'
      TabOrder = 0
      OnClick = button_charge_offClick
    end
    object Button_restore: TButton
      Left = 482
      Top = 4
      Width = 200
      Height = 27
      Caption = 'Отменить списание товара'
      TabOrder = 1
      OnClick = Button_restoreClick
    end
  end
  object DataSource_commodity: TDataSource
    DataSet = fmDataModule.Query_transfer_source
    Left = 176
    Top = 139
  end
  object DataSource_charge_off: TDataSource
    DataSet = fmDataModule.Query_transfer_destination
    Left = 248
    Top = 356
  end
end
