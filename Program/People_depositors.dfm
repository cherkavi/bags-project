object fmPeople_depositors: TfmPeople_depositors
  Left = 420
  Top = 333
  Width = 493
  Height = 283
  Caption = 'fmPeople_depositors'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 485
    Height = 207
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'FAMILIYA'
        Title.Alignment = taCenter
        Title.Caption = 'Фамилия'
        Width = 169
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IMYA'
        Title.Alignment = taCenter
        Title.Caption = 'Имя'
        Width = 171
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 207
    Width = 485
    Height = 49
    Align = alBottom
    TabOrder = 1
    object button_ok: TButton
      Left = 8
      Top = 8
      Width = 297
      Height = 33
      Caption = 'Выбрать'
      TabOrder = 0
      OnClick = button_okClick
    end
    object button_cancel: TButton
      Left = 320
      Top = 8
      Width = 161
      Height = 33
      Caption = 'Отменить'
      TabOrder = 1
      OnClick = button_cancelClick
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_people
    Left = 192
    Top = 16
  end
end
