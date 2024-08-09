object fmRediscount_list: TfmRediscount_list
  Left = 223
  Top = 158
  Width = 753
  Height = 479
  Caption = 'Список переучетов'
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
  TextHeight = 14
  object Panel2: TPanel
    Left = 0
    Top = 409
    Width = 745
    Height = 43
    Align = alBottom
    TabOrder = 0
    object button_select: TButton
      Left = 9
      Top = 9
      Width = 707
      Height = 27
      Caption = 'Выбрать'
      TabOrder = 0
      OnClick = button_selectClick
    end
  end
  object StringGrid_main: TStringGrid
    Left = 0
    Top = 0
    Width = 745
    Height = 409
    Align = alClient
    DefaultRowHeight = 20
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnDblClick = StringGrid_mainDblClick
    ColWidths = (
      84
      99
      73
      131
      104)
  end
  object PopupMenu1: TPopupMenu
    Left = 144
    Top = 120
    object N1: TMenuItem
      Caption = 'Сортировка по выделенному полю'
      OnClick = N1Click
    end
  end
end
