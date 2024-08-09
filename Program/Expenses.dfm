object fmExpenses: TfmExpenses
  Left = 471
  Top = 313
  Width = 429
  Height = 333
  Caption = 'Статьи расходов-доходов'
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
    Width = 421
    Height = 266
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object dbGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 419
      Height = 264
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
          FieldName = 'KOD'
          Title.Alignment = taCenter
          Title.Caption = 'Код'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = 'Наименование'
          Width = 209
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SIGN'
          Title.Caption = 'Множитель'
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 266
    Width = 421
    Height = 40
    Align = alBottom
    TabOrder = 1
    object button_add: TButton
      Left = 120
      Top = 8
      Width = 201
      Height = 25
      Caption = 'Добавить'
      TabOrder = 0
      OnClick = button_addClick
    end
    object button_edit: TButton
      Left = 376
      Top = 8
      Width = 33
      Height = 25
      Caption = 'Редактировать'
      TabOrder = 1
      Visible = False
      OnClick = button_editClick
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_expenses
    Left = 192
    Top = 96
  end
end
