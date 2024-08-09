object fmDovidka_11: TfmDovidka_11
  Left = 522
  Top = 283
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Балансы вкладчиков'
  ClientHeight = 208
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 128
    Top = 8
    Width = 59
    Height = 14
    Caption = 'Вкладчики'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListBox_depositor: TListBox
    Left = 8
    Top = 24
    Width = 305
    Height = 97
    ItemHeight = 14
    TabOrder = 0
  end
  object button_add_to_list: TButton
    Left = 8
    Top = 128
    Width = 193
    Height = 25
    Caption = 'Добавить в список'
    TabOrder = 1
    OnClick = button_add_to_listClick
  end
  object Button_delete_from_list: TButton
    Left = 208
    Top = 128
    Width = 105
    Height = 25
    Caption = 'Удалить из списка'
    TabOrder = 2
    OnClick = Button_delete_from_listClick
  end
  object button_execute: TButton
    Left = 8
    Top = 160
    Width = 305
    Height = 41
    Caption = 'Вывести в Excel'
    TabOrder = 3
    OnClick = button_executeClick
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 224
    Width = 329
    Height = 177
    FixedCols = 0
    FixedRows = 0
    TabOrder = 4
    Visible = False
  end
end
