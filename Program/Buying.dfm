object fmBuying: TfmBuying
  Left = 206
  Top = 170
  Width = 595
  Height = 500
  Caption = 'Ввод/вывод денежных средств'
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
    Width = 587
    Height = 168
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 9
      Width = 127
      Height = 14
      Caption = 'Статья прихода/расхода'
    end
    object Label2: TLabel
      Left = 222
      Top = 9
      Width = 47
      Height = 14
      Caption = 'Работник'
    end
    object Label3: TLabel
      Left = 362
      Top = 9
      Width = 26
      Height = 14
      Caption = 'Дата'
    end
    object Label4: TLabel
      Left = 491
      Top = 9
      Width = 35
      Height = 14
      Caption = 'Сумма'
    end
    object Label5: TLabel
      Left = 250
      Top = 60
      Width = 63
      Height = 14
      Caption = 'Примечание'
    end
    object combobox_expenses: TComboBox
      Left = 9
      Top = 26
      Width = 156
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 0
    end
    object edit_amount: TdxCalcEdit
      Left = 439
      Top = 26
      Width = 139
      TabOrder = 1
      Alignment = taRightJustify
      Text = '0'
      StoredValues = 1
    end
    object combobox_people: TComboBox
      Left = 172
      Top = 26
      Width = 156
      Height = 22
      Style = csDropDownList
      ItemHeight = 14
      TabOrder = 2
      OnChange = combobox_peopleChange
    end
    object edit_date: TdxDateEdit
      Left = 336
      Top = 26
      Width = 96
      TabOrder = 3
      OnChange = edit_dateChange
      Date = -700000
    end
    object edit_note: TEdit
      Left = 9
      Top = 78
      Width = 566
      Height = 22
      TabOrder = 4
    end
    object button_add: TButton
      Left = 17
      Top = 112
      Width = 553
      Height = 44
      Caption = 'Добавить'
      TabOrder = 5
      OnClick = button_addClick
    end
    object button_delete: TButton
      Left = 560
      Top = 112
      Width = 139
      Height = 44
      Caption = 'Удалить'
      TabOrder = 6
      Visible = False
      OnClick = button_deleteClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 168
    Width = 587
    Height = 305
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 585
      Height = 303
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'DATE_IN_OUT'
          Title.Alignment = taCenter
          Title.Caption = 'Дата'
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'AMOUNT'
          Title.Alignment = taCenter
          Title.Caption = 'Сумма'
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EXPENSES_NAME'
          Title.Caption = 'Статья прихода/расхода'
          Width = 94
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FAMILIYA'
          Title.Caption = 'Фамилия'
          Width = 107
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IMYA'
          Title.Caption = 'Имя'
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOTE'
          Title.Caption = 'Примечание'
          Width = 164
          Visible = True
        end>
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.Query_Buying
    Left = 336
    Top = 204
  end
  object PopupMenu1: TPopupMenu
    Left = 144
    Top = 292
    object N1: TMenuItem
      Caption = 'удалить'
      OnClick = N1Click
    end
  end
end
