object fmPEOPLE: TfmPEOPLE
  Left = 185
  Top = 165
  BorderStyle = bsSingle
  Caption = 'Работники'
  ClientHeight = 445
  ClientWidth = 723
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
    Width = 723
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 37
      Top = 2
      Width = 68
      Height = 13
      Caption = 'Должность'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 170
      Top = 2
      Width = 57
      Height = 13
      Caption = 'Фамилия'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 298
      Top = 2
      Width = 26
      Height = 13
      Caption = 'Имя'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 407
      Top = 2
      Width = 51
      Height = 13
      Caption = 'Паспорт'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 511
      Top = 2
      Width = 66
      Height = 13
      Caption = 'Идент. код'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object button_filter: TButton
      Left = 615
      Top = 2
      Width = 75
      Height = 37
      Caption = 'Фильтр'
      TabOrder = 0
      OnClick = button_filterClick
    end
    object button_all: TButton
      Left = 690
      Top = 3
      Width = 27
      Height = 36
      Caption = '...'
      TabOrder = 1
      OnClick = button_allClick
    end
    object combobox_filter_post: TComboBox
      Left = 8
      Top = 16
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = combobox_filter_postChange
    end
    object edit_filter_familiya: TEdit
      Left = 130
      Top = 16
      Width = 120
      Height = 21
      TabOrder = 3
      OnChange = edit_filter_familiyaChange
    end
    object edit_filter_imya: TEdit
      Left = 250
      Top = 16
      Width = 119
      Height = 21
      TabOrder = 4
      OnChange = edit_filter_imyaChange
    end
    object edit_filter_passport: TEdit
      Left = 369
      Top = 16
      Width = 120
      Height = 21
      TabOrder = 5
      OnChange = edit_filter_passportChange
    end
    object edit_filter_ident_kod: TEdit
      Left = 491
      Top = 16
      Width = 120
      Height = 21
      TabOrder = 6
      OnChange = edit_filter_ident_kodChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 723
    Height = 361
    Align = alClient
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 721
      Height = 359
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
      OnDblClick = button_editClick
      Columns = <
        item
          Expanded = False
          FieldName = 'KOD'
          Title.Alignment = taCenter
          Title.Caption = 'Код'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'POSTS_NAME'
          Title.Alignment = taCenter
          Title.Caption = 'Должность'
          Width = 74
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FAMILIYA'
          Title.Alignment = taCenter
          Title.Caption = 'Фамилия'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IMYA'
          Title.Alignment = taCenter
          Title.Caption = 'Имя'
          Width = 82
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OTCHESTVO'
          Title.Alignment = taCenter
          Title.Caption = 'Отчество'
          Width = 71
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PHONE'
          Title.Caption = 'Телефон'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PASSPORT'
          Title.Caption = 'Паспорт серия и номер'
          Width = 111
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IDENT_KOD'
          Title.Alignment = taCenter
          Title.Caption = 'Идент. код'
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATE_BEGIN'
          Title.Alignment = taCenter
          Title.Caption = 'Дата рождения'
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'HOME'
          Title.Caption = 'Место проживания'
          Width = 179
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 402
    Width = 723
    Height = 43
    Align = alBottom
    TabOrder = 2
    object button_add: TButton
      Left = 8
      Top = 8
      Width = 241
      Height = 25
      Caption = 'Добавить'
      TabOrder = 0
      OnClick = button_addClick
    end
    object button_edit: TButton
      Left = 264
      Top = 8
      Width = 249
      Height = 25
      Caption = 'Редактировать'
      TabOrder = 1
      OnClick = button_editClick
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_people
    Left = 304
    Top = 193
  end
  object PopupMenu1: TPopupMenu
    Left = 176
    Top = 113
    object Excel1: TMenuItem
      Caption = 'Вывести в Excel'
      OnClick = Excel1Click
    end
  end
end
