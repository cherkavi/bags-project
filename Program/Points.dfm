object fmPOINTS: TfmPOINTS
  Left = 370
  Top = 310
  Width = 533
  Height = 390
  Caption = 'Торговые точки'
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
    Width = 525
    Height = 44
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 57
      Top = 1
      Width = 86
      Height = 15
      Caption = 'Наименование'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 278
      Top = 1
      Width = 37
      Height = 15
      Caption = 'Адрес'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edit_filter_name: TEdit
      Left = 34
      Top = 17
      Width = 131
      Height = 22
      TabOrder = 0
    end
    object edit_filter_address: TEdit
      Left = 226
      Top = 17
      Width = 130
      Height = 22
      TabOrder = 1
    end
    object button_filter: TButton
      Left = 390
      Top = 2
      Width = 112
      Height = 41
      Caption = 'Фильтр'
      TabOrder = 2
      OnClick = button_filterClick
    end
    object button_all: TButton
      Left = 524
      Top = 2
      Width = 39
      Height = 41
      Caption = '...'
      TabOrder = 3
      OnClick = button_allClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 44
    Width = 525
    Height = 275
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 523
      Height = 273
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
      OnDblClick = Button_editClick
      Columns = <
        item
          Expanded = False
          FieldName = 'KOD'
          Title.Alignment = taCenter
          Title.Caption = 'Код'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = 'Наименование'
          Width = 116
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RAYON'
          Title.Caption = 'Район'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ADDRESS'
          Title.Alignment = taCenter
          Title.Caption = 'Адрес'
          Width = 275
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ARENDA'
          Title.Caption = 'Арендная плата'
          Width = 106
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 319
    Width = 525
    Height = 44
    Align = alBottom
    TabOrder = 2
    object button_add: TButton
      Left = 17
      Top = 9
      Width = 165
      Height = 27
      Caption = 'Добавление'
      TabOrder = 0
      OnClick = button_addClick
    end
    object Button_edit: TButton
      Left = 190
      Top = 9
      Width = 199
      Height = 27
      Caption = 'Редактирование'
      TabOrder = 1
      OnClick = Button_editClick
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_points
    Left = 400
    Top = 169
  end
  object PopupMenu1: TPopupMenu
    Left = 136
    Top = 169
    object Excel1: TMenuItem
      Caption = 'Вывести в Excel'
      OnClick = Excel1Click
    end
  end
end
