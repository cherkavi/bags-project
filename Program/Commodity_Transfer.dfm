object fmCommodity_Transfer: TfmCommodity_Transfer
  Left = 407
  Top = 97
  BorderStyle = bsSingle
  Caption = 'Перемещение товара с точки на точку'
  ClientHeight = 686
  ClientWidth = 681
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
    Top = 321
    Width = 681
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object panel_source: TPanel
    Left = 0
    Top = 0
    Width = 681
    Height = 321
    Align = alTop
    TabOrder = 0
    object DBGrid_source: TDBGrid
      Left = 1
      Top = 52
      Width = 679
      Height = 227
      Align = alClient
      DataSource = DataSource_source
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
          Width = 249
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = 'Кол-во'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Цена'
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUMA'
          Title.Alignment = taCenter
          Title.Caption = 'Сумма'
          Width = 136
          Visible = True
        end>
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 679
      Height = 51
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 24
        Top = 3
        Width = 153
        Height = 20
        Caption = 'Источник - склад:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 261
        Top = 8
        Width = 117
        Height = 13
        Caption = 'Фильтр наименование'
      end
      object combobox_source: TComboBox
        Left = 7
        Top = 23
        Width = 195
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = combobox_sourceChange
      end
      object edit_source_filter_name: TEdit
        Left = 260
        Top = 24
        Width = 125
        Height = 21
        TabOrder = 1
        OnKeyUp = edit_source_filter_nameKeyUp
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 279
      Width = 679
      Height = 41
      Align = alBottom
      TabOrder = 2
      object Label5: TLabel
        Left = 294
        Top = 2
        Width = 34
        Height = 13
        Caption = 'Кол-во'
      end
      object Label6: TLabel
        Left = 498
        Top = 2
        Width = 34
        Height = 13
        Caption = 'Сумма'
      end
      object edit_source_quantity: TdxEdit
        Left = 272
        Top = 16
        Width = 73
        TabOrder = 0
        Text = '0'
        Alignment = taRightJustify
        StoredValues = 1
      end
      object Edit_source_amount: TdxEdit
        Left = 456
        Top = 16
        Width = 121
        TabOrder = 1
        Text = '0'
        Alignment = taRightJustify
        StoredValues = 1
      end
    end
  end
  object panel_destination: TPanel
    Left = 0
    Top = 324
    Width = 681
    Height = 362
    Align = alClient
    TabOrder = 1
    object DBGrid_destination: TDBGrid
      Left = 1
      Top = 61
      Width = 679
      Height = 258
      Align = alClient
      DataSource = DataSource_destination
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
          Width = 244
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = 'Кол-во'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Цена'
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUMA'
          Title.Alignment = taCenter
          Title.Caption = 'Сумма'
          Width = 132
          Visible = True
        end>
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 679
      Height = 60
      Align = alTop
      TabOrder = 1
      object Label2: TLabel
        Left = 21
        Top = 2
        Width = 157
        Height = 20
        Caption = 'Приемник - склад:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 264
        Top = 1
        Width = 117
        Height = 13
        Caption = 'Фильтр наименование'
      end
      object button_transfer: TButton
        Left = 463
        Top = 10
        Width = 181
        Height = 45
        Caption = 'Перенести выделенный товар'
        TabOrder = 0
        OnClick = button_transferClick
      end
      object ComboBox_destination: TComboBox
        Left = 8
        Top = 23
        Width = 188
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = ComboBox_destinationChange
      end
      object Edit_destination_filter_name: TEdit
        Left = 264
        Top = 17
        Width = 129
        Height = 21
        TabOrder = 2
        OnKeyUp = Edit_destination_filter_nameKeyUp
      end
      object CheckBox_in_step: TCheckBox
        Left = 288
        Top = 40
        Width = 97
        Height = 17
        Caption = 'Синхронно'
        TabOrder = 3
        OnClick = CheckBox_in_stepClick
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 319
      Width = 679
      Height = 42
      Align = alBottom
      TabOrder = 2
      object Label7: TLabel
        Left = 302
        Top = 2
        Width = 34
        Height = 13
        Caption = 'Кол-во'
      end
      object Label8: TLabel
        Left = 506
        Top = 2
        Width = 34
        Height = 13
        Caption = 'Сумма'
      end
      object edit_destination_quantity: TdxEdit
        Left = 280
        Top = 16
        Width = 73
        TabOrder = 0
        Text = '0'
        Alignment = taRightJustify
        StoredValues = 1
      end
      object edit_destination_amount: TdxEdit
        Left = 464
        Top = 16
        Width = 121
        TabOrder = 1
        Text = '0'
        Alignment = taRightJustify
        StoredValues = 1
      end
    end
  end
  object DataSource_destination: TDataSource
    DataSet = fmDataModule.Query_transfer_destination
    Left = 304
    Top = 488
  end
  object DataSource_source: TDataSource
    DataSet = fmDataModule.Query_transfer_source
    Left = 208
    Top = 104
  end
end
