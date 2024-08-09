object fmPoints_sale: TfmPoints_sale
  Left = 309
  Top = 284
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Продажи за день'
  ClientHeight = 622
  ClientWidth = 749
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
  object Label1: TLabel
    Left = 40
    Top = 0
    Width = 122
    Height = 16
    Caption = 'Торговая точка:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 256
    Top = 0
    Width = 96
    Height = 16
    Caption = 'Дата продаж'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label_source: TLabel
    Left = 224
    Top = 42
    Width = 189
    Height = 16
    Caption = 'Товар на торговой точке'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label_destination: TLabel
    Left = 226
    Top = 314
    Width = 207
    Height = 16
    Caption = 'Товар, который был продан'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object label_source_sum: TLabel
    Left = 448
    Top = 45
    Width = 26
    Height = 13
    Caption = '0,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object label_destination_sum: TLabel
    Left = 456
    Top = 317
    Width = 26
    Height = 13
    Caption = '0,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 547
    Top = 0
    Width = 75
    Height = 16
    Caption = 'Продавец'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object label_destination_sum_add: TLabel
    Left = 502
    Top = 317
    Width = 26
    Height = 13
    Caption = '0,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edit_points: TEdit
    Left = 8
    Top = 16
    Width = 177
    Height = 21
    Color = clMenu
    ReadOnly = True
    TabOrder = 0
    Text = 'edit_points'
  end
  object edit_date: TEdit
    Left = 259
    Top = 16
    Width = 89
    Height = 21
    Color = clMenu
    ReadOnly = True
    TabOrder = 1
    Text = 'edit_date'
  end
  object grid_source: TStringGrid
    Left = 8
    Top = 62
    Width = 737
    Height = 241
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 2
    ColWidths = (
      64
      283
      123
      96
      96)
  end
  object grid_destination: TStringGrid
    Left = 4
    Top = 341
    Width = 741
    Height = 241
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 3
    ColWidths = (
      64
      283
      123
      96
      96)
  end
  object button_down: TButton
    Left = 8
    Top = 309
    Width = 205
    Height = 25
    Caption = 'Продажа'
    TabOrder = 4
    OnClick = button_downClick
  end
  object Button_up: TButton
    Left = 554
    Top = 309
    Width = 189
    Height = 25
    Caption = 'Отменить продажу'
    TabOrder = 5
    OnClick = Button_upClick
  end
  object edit_seller: TEdit
    Left = 416
    Top = 16
    Width = 329
    Height = 21
    Color = clMenu
    ReadOnly = True
    TabOrder = 6
    Text = 'edit_seller'
  end
  object button_ok: TButton
    Left = 5
    Top = 584
    Width = 740
    Height = 33
    Caption = 'Закончить ввод и зафиксировать изменения'
    TabOrder = 7
    OnClick = button_okClick
  end
end
