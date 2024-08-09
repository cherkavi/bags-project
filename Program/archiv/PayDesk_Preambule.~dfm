object fmPayDesk_Preambule: TfmPayDesk_Preambule
  Left = 414
  Top = 225
  Width = 537
  Height = 352
  Caption = 'Кассы за день'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 529
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 4
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
      Left = 248
      Top = 4
      Width = 79
      Height = 13
      Caption = 'Дата продаж'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object combobox_points: TComboBox
      Left = 32
      Top = 20
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = combobox_pointsChange
    end
    object edit_date: TdxDateEdit
      Left = 224
      Top = 20
      Width = 121
      TabOrder = 1
      OnChange = combobox_pointsChange
      Date = -700000
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 49
    Width = 529
    Height = 227
    Align = alClient
    Caption = 'Продавцы, которые продавали товар'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object dbGrid: TDBGrid
      Left = 2
      Top = 15
      Width = 525
      Height = 210
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnDblClick = button_input_payClick
      Columns = <
        item
          Expanded = False
          FieldName = 'KOD'
          Title.Caption = 'Код'
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FAMILIYA'
          Title.Caption = 'Фамилия'
          Width = 136
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IMYA'
          Title.Caption = 'Имя'
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OTCHESTVO'
          Title.Caption = 'Отчество'
          Width = 139
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 276
    Width = 529
    Height = 49
    Align = alBottom
    TabOrder = 2
    object button_input_pay: TButton
      Left = 144
      Top = 8
      Width = 273
      Height = 33
      Caption = 'Ввод'
      TabOrder = 0
      OnClick = button_input_payClick
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_PayDesk_preambule
    Left = 272
    Top = 185
  end
end
