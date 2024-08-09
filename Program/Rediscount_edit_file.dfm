object fmRediscount_edit_file: TfmRediscount_edit_file
  Left = 405
  Top = 340
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Редактирование переучета'
  ClientHeight = 505
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 120
    Top = 0
    Width = 277
    Height = 13
    Caption = 'Путь к файлу, в котором находится искомый переучет'
  end
  object edit_path_to_file: TEdit
    Left = 8
    Top = 16
    Width = 481
    Height = 21
    Color = clMenu
    ReadOnly = True
    TabOrder = 0
    Text = 'edit_path_to_file'
  end
  object StringGrid_main: TStringGrid
    Left = 8
    Top = 48
    Width = 481
    Height = 393
    ColCount = 2
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 1
    OnDblClick = StringGrid_mainDblClick
    ColWidths = (
      217
      200)
  end
  object button_edit: TButton
    Left = 136
    Top = 440
    Width = 249
    Height = 25
    Caption = 'Редактировать'
    TabOrder = 2
    OnClick = button_editClick
  end
  object button_change: TButton
    Left = 8
    Top = 472
    Width = 481
    Height = 25
    Caption = 'Произвести замену'
    TabOrder = 3
    OnClick = button_changeClick
  end
end
