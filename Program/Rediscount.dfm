object fmRediscount: TfmRediscount
  Left = 63
  Top = -1
  Width = 1036
  Height = 728
  Caption = 'Переучет'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1028
    Height = 701
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 337
      Top = 1
      Width = 3
      Height = 699
      Cursor = crHSplit
    end
    object Splitter2: TSplitter
      Left = 729
      Top = 1
      Width = 3
      Height = 699
      Cursor = crHSplit
      Align = alRight
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 336
      Height = 699
      Align = alLeft
      TabOrder = 0
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 334
        Height = 84
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 56
          Top = 1
          Width = 79
          Height = 13
          Caption = 'Торговая точка'
        end
        object Label2: TLabel
          Left = 208
          Top = 1
          Width = 26
          Height = 13
          Caption = 'Дата'
        end
        object Label3: TLabel
          Left = 128
          Top = 41
          Width = 50
          Height = 13
          Caption = 'Продавец'
        end
        object combobox_points: TComboBox
          Left = 24
          Top = 17
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = combobox_pointsChange
        end
        object Edit_data_rediscount: TdxDateEdit
          Left = 176
          Top = 17
          Width = 97
          TabOrder = 1
          ReadOnly = False
          OnChange = combobox_pointsChange
          Date = -700000
          StoredValues = 64
        end
        object combobox_seller: TComboBox
          Left = 24
          Top = 57
          Width = 249
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
        end
      end
      object Panel7: TPanel
        Left = 1
        Top = 634
        Width = 334
        Height = 64
        Align = alBottom
        TabOrder = 1
        object GroupBox4: TGroupBox
          Left = 1
          Top = 1
          Width = 332
          Height = 62
          Align = alClient
          Caption = 'Торговая точка'
          TabOrder = 0
          object Label5: TLabel
            Left = 174
            Top = 8
            Width = 34
            Height = 13
            Caption = 'Кол-во'
          end
          object Label6: TLabel
            Left = 278
            Top = 8
            Width = 34
            Height = 13
            Caption = 'Сумма'
          end
          object dxEdit1: TdxEdit
            Left = 143
            Top = 24
            Width = 65
            TabOrder = 0
            Alignment = taRightJustify
            ReadOnly = True
            StoredValues = 65
          end
          object dxEdit2: TdxEdit
            Left = 247
            Top = 24
            Width = 73
            TabOrder = 1
            Alignment = taRightJustify
            ReadOnly = True
            StoredValues = 65
          end
        end
      end
      object Panel9: TPanel
        Left = 1
        Top = 85
        Width = 334
        Height = 549
        Align = alClient
        TabOrder = 2
        object StringGrid_point: TStringGrid
          Left = 1
          Top = 1
          Width = 332
          Height = 547
          Align = alClient
          DefaultRowHeight = 20
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          PopupMenu = PopupMenu_point
          TabOrder = 0
          ColWidths = (
            38
            64
            64
            64
            64)
        end
      end
    end
    object Panel4: TPanel
      Left = 340
      Top = 1
      Width = 389
      Height = 699
      Align = alClient
      TabOrder = 1
      object Panel6: TPanel
        Left = 1
        Top = 1
        Width = 387
        Height = 84
        Align = alTop
        TabOrder = 0
        object Label4: TLabel
          Left = 104
          Top = 1
          Width = 129
          Height = 13
          Caption = 'Путь к текстовому файлу'
        end
        object Edit_path_to_file: TEdit
          Left = 8
          Top = 17
          Width = 281
          Height = 21
          TabOrder = 0
        end
        object Button_load_file: TButton
          Left = 8
          Top = 43
          Width = 217
          Height = 32
          Caption = 'Загрузить файл'
          TabOrder = 1
          OnClick = Button_load_fileClick
        end
        object button_open_file: TButton
          Left = 288
          Top = 17
          Width = 25
          Height = 22
          Caption = '...'
          TabOrder = 2
          OnClick = button_open_fileClick
        end
        object button_edit_file: TButton
          Left = 227
          Top = 47
          Width = 118
          Height = 23
          Caption = 'Редактировать файл'
          TabOrder = 3
          OnClick = button_edit_fileClick
        end
      end
      object Panel8: TPanel
        Left = 1
        Top = 634
        Width = 387
        Height = 64
        Align = alBottom
        TabOrder = 1
        object GroupBox3: TGroupBox
          Left = 1
          Top = 1
          Width = 385
          Height = 62
          Align = alClient
          Caption = 'Переучет'
          TabOrder = 0
          object Label11: TLabel
            Left = 191
            Top = 8
            Width = 34
            Height = 13
            Caption = 'Кол-во'
          end
          object Label12: TLabel
            Left = 287
            Top = 8
            Width = 34
            Height = 13
            Caption = 'Сумма'
          end
          object dxEdit3: TdxEdit
            Left = 152
            Top = 24
            Width = 81
            TabOrder = 0
            Alignment = taRightJustify
            ReadOnly = True
            StoredValues = 65
          end
          object dxEdit4: TdxEdit
            Left = 256
            Top = 24
            Width = 89
            TabOrder = 1
            Alignment = taRightJustify
            ReadOnly = True
            StoredValues = 65
          end
        end
      end
      object Panel10: TPanel
        Left = 1
        Top = 85
        Width = 387
        Height = 549
        Align = alClient
        TabOrder = 2
        object StringGrid_real: TStringGrid
          Left = 1
          Top = 1
          Width = 385
          Height = 547
          Align = alClient
          DefaultRowHeight = 20
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          PopupMenu = PopupMenu_real
          TabOrder = 0
          ColWidths = (
            39
            64
            64
            64
            64)
        end
      end
    end
    object Panel11: TPanel
      Left = 732
      Top = 1
      Width = 295
      Height = 699
      Align = alRight
      TabOrder = 2
      object Panel12: TPanel
        Left = 1
        Top = 1
        Width = 293
        Height = 84
        Align = alTop
        TabOrder = 0
        object Label13: TLabel
          Left = 24
          Top = 64
          Width = 159
          Height = 13
          Caption = 'Баланс продавца по переучету:'
        end
        object dxEdit9: TdxEdit
          Left = 187
          Top = 60
          Width = 97
          TabOrder = 0
          Alignment = taRightJustify
          ReadOnly = True
          StoredValues = 65
        end
        object button_commit: TButton
          Left = 8
          Top = 30
          Width = 277
          Height = 25
          Caption = 'Зафиксировать переучет'
          Enabled = False
          TabOrder = 1
          OnClick = button_commitClick
        end
        object button_preview: TButton
          Left = 10
          Top = 2
          Width = 273
          Height = 25
          Caption = 'Просмотр результатов'
          TabOrder = 2
          OnClick = button_previewClick
        end
      end
      object Panel13: TPanel
        Left = 1
        Top = 634
        Width = 293
        Height = 64
        Align = alBottom
        TabOrder = 1
        object GroupBox1: TGroupBox
          Left = 1
          Top = 1
          Width = 146
          Height = 62
          Align = alClient
          Caption = 'Недостача'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          object Label7: TLabel
            Left = 8
            Top = 16
            Width = 37
            Height = 13
            Caption = 'Кол-во:'
          end
          object Label8: TLabel
            Left = 8
            Top = 40
            Width = 37
            Height = 13
            Caption = 'Сумма:'
          end
          object dxEdit5: TdxEdit
            Left = 48
            Top = 13
            Width = 94
            TabOrder = 0
            Alignment = taRightJustify
            ReadOnly = True
            StoredValues = 65
          end
          object dxEdit6: TdxEdit
            Left = 48
            Top = 37
            Width = 94
            TabOrder = 1
            Alignment = taRightJustify
            ReadOnly = True
            StoredValues = 65
          end
        end
        object GroupBox2: TGroupBox
          Left = 147
          Top = 1
          Width = 145
          Height = 62
          Align = alRight
          Caption = 'Перебор'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 1
          object Label9: TLabel
            Left = 8
            Top = 16
            Width = 37
            Height = 13
            Caption = 'Кол-во:'
          end
          object Label10: TLabel
            Left = 8
            Top = 40
            Width = 37
            Height = 13
            Caption = 'Сумма:'
          end
          object dxEdit7: TdxEdit
            Left = 47
            Top = 13
            Width = 94
            TabOrder = 0
            Alignment = taRightJustify
            ReadOnly = True
            StoredValues = 65
          end
          object dxEdit8: TdxEdit
            Left = 47
            Top = 37
            Width = 94
            TabOrder = 1
            Alignment = taRightJustify
            ReadOnly = True
            StoredValues = 65
          end
        end
      end
      object Panel14: TPanel
        Left = 1
        Top = 85
        Width = 293
        Height = 549
        Align = alClient
        TabOrder = 2
        object StringGrid_match: TStringGrid
          Left = 1
          Top = 1
          Width = 291
          Height = 547
          Align = alClient
          DefaultRowHeight = 20
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
          PopupMenu = PopupMenu_match
          TabOrder = 0
          ColWidths = (
            37
            55
            55
            52
            53)
        end
      end
    end
  end
  object PopupMenu_point: TPopupMenu
    Left = 210
    Top = 238
    object Excel1: TMenuItem
      Caption = 'Вывести в Excel'
      OnClick = Excel1Click
    end
  end
  object PopupMenu_real: TPopupMenu
    Left = 461
    Top = 230
    object Excel2: TMenuItem
      Caption = 'Вывести в Excel'
      OnClick = Excel2Click
    end
  end
  object PopupMenu_match: TPopupMenu
    Left = 745
    Top = 294
    object Excel3: TMenuItem
      Caption = 'Вывести в Excel'
      OnClick = Excel3Click
    end
  end
end
