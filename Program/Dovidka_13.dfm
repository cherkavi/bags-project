object fmDovidka_13: TfmDovidka_13
  Left = 547
  Top = 416
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Текущий баланс продавца'
  ClientHeight = 260
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 144
    Top = 0
    Width = 82
    Height = 13
    Caption = 'Торговая точка:'
  end
  object combobox_points: TComboBox
    Left = 80
    Top = 16
    Width = 209
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object button_execute: TButton
    Left = 19
    Top = 229
    Width = 321
    Height = 25
    Caption = 'Вывести данные в Excel'
    TabOrder = 1
    OnClick = button_executeClick
  end
  object grid_main: TDBGrid
    Left = 8
    Top = 48
    Width = 345
    Height = 177
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'KOD'
        Title.Caption = 'Код'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FAMILIYA'
        Title.Alignment = taCenter
        Title.Caption = 'Фамилия'
        Width = 125
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IMYA'
        Title.Alignment = taCenter
        Title.Caption = 'Имя'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OTCHESTVO'
        Title.Alignment = taCenter
        Title.Caption = 'Отчество'
        Width = 90
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_people
    Left = 208
    Top = 88
  end
end
