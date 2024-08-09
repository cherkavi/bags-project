object fmPoints_Sale_Skip: TfmPoints_Sale_Skip
  Left = 428
  Top = 330
  Width = 565
  Height = 324
  Caption = 'Отмена продаж по точке за день'
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
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 557
    Height = 53
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 85
      Top = 3
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
      Left = 302
      Top = 3
      Width = 76
      Height = 15
      Caption = 'Дата продаж'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 475
      Top = 3
      Width = 35
      Height = 14
      Caption = 'Сумма'
    end
    object combobox_points: TComboBox
      Left = 3
      Top = 20
      Width = 243
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 0
      OnChange = Edit_dateChange
    end
    object Edit_date: TdxDateEdit
      Left = 253
      Top = 20
      Width = 182
      TabOrder = 1
      OnChange = Edit_dateChange
      PopupAlignment = taCenter
      Date = -700000
    end
    object Edit_suma: TdxEdit
      Left = 443
      Top = 20
      Width = 104
      TabOrder = 2
      Alignment = taRightJustify
      StoredValues = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 253
    Width = 557
    Height = 44
    Align = alBottom
    TabOrder = 1
    object button_skip: TButton
      Left = 146
      Top = 9
      Width = 277
      Height = 27
      Caption = 'Отмена продаж за день'
      TabOrder = 0
      OnClick = button_skipClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 53
    Width = 557
    Height = 200
    Align = alClient
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 555
      Height = 198
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
          FieldName = 'ASSORTMENT_KOD'
          Title.Alignment = taCenter
          Title.Caption = 'Код'
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = 'Наименование'
          Width = 191
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = 'Кол-во'
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Цена'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SUMA'
          Title.Alignment = taCenter
          Title.Caption = 'Сумма'
          Width = 79
          Visible = True
        end>
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_points_sale_skip
    Left = 256
    Top = 153
  end
end
