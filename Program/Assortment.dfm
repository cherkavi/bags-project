object fmASSORTMENT: TfmASSORTMENT
  Left = 225
  Top = 140
  BorderStyle = bsSingle
  Caption = 'Ассортимент товара - ввод, редактирование'
  ClientHeight = 449
  ClientWidth = 584
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
  object panel_filter: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 47
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 3
      Width = 104
      Height = 13
      Caption = 'Название товара'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 185
      Top = 3
      Width = 112
      Height = 13
      Caption = 'Ценовой диапазон'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 139
      Top = 23
      Width = 6
      Height = 13
      Caption = 'с'
    end
    object Label4: TLabel
      Left = 228
      Top = 23
      Width = 12
      Height = 13
      Caption = 'по'
    end
    object Label5: TLabel
      Left = 345
      Top = 3
      Width = 74
      Height = 13
      Caption = 'Примечание'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edit_filter_name: TEdit
      Left = 16
      Top = 19
      Width = 113
      Height = 21
      TabOrder = 0
      OnKeyUp = edit_filter_nameKeyUp
    end
    object button_filter: TButton
      Left = 445
      Top = 9
      Width = 106
      Height = 32
      Caption = 'Применить фильтр'
      TabOrder = 1
      OnClick = button_filterClick
    end
    object edit_filter_price_begin: TdxCalcEdit
      Left = 149
      Top = 19
      Width = 70
      TabOrder = 2
      OnKeyUp = edit_filter_price_beginKeyUp
      Text = '0'
    end
    object edit_filter_price_end: TdxCalcEdit
      Left = 246
      Top = 19
      Width = 68
      TabOrder = 3
      OnKeyUp = edit_filter_price_endKeyUp
      Text = '0'
    end
    object button_all: TButton
      Left = 551
      Top = 9
      Width = 30
      Height = 32
      Caption = '...'
      TabOrder = 4
      OnClick = button_allClick
    end
    object edit_filter_note: TEdit
      Left = 320
      Top = 17
      Width = 121
      Height = 21
      TabOrder = 5
      OnKeyUp = edit_filter_noteKeyUp
    end
  end
  object panel_button: TPanel
    Left = 0
    Top = 410
    Width = 584
    Height = 39
    Align = alBottom
    TabOrder = 1
    object button_add: TButton
      Left = 16
      Top = 8
      Width = 172
      Height = 25
      Caption = 'Добавить'
      TabOrder = 0
      OnClick = button_addClick
    end
    object Button_edit: TButton
      Left = 204
      Top = 8
      Width = 177
      Height = 25
      Caption = 'Редактировать'
      TabOrder = 1
      OnClick = Button_editClick
    end
    object Button_delete: TButton
      Left = 520
      Top = 8
      Width = 59
      Height = 25
      Caption = 'Удалить'
      TabOrder = 2
      Visible = False
      OnClick = Button_deleteClick
    end
    object button_print_bar_code: TButton
      Left = 424
      Top = 8
      Width = 137
      Height = 25
      Caption = 'Печатать штрих-код'
      TabOrder = 3
      OnClick = button_print_bar_codeClick
    end
  end
  object panel_data: TPanel
    Left = 0
    Top = 47
    Width = 584
    Height = 363
    Align = alClient
    TabOrder = 2
    object DBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 582
      Height = 361
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu
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
          Title.Caption = 'Код товара'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = 'Наименование'
          Width = 158
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Цена'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRICE_BUYING'
          Title.Alignment = taCenter
          Title.Caption = 'Закупка'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOTE'
          Title.Alignment = taCenter
          Title.Caption = 'Примечание'
          Width = 219
          Visible = True
        end>
    end
  end
  object DataSource1: TDataSource
    DataSet = fmDataModule.query_assortment
    OnDataChange = DataSource1DataChange
    Left = 192
    Top = 128
  end
  object PopupMenu: TPopupMenu
    Left = 440
    Top = 159
    object N1: TMenuItem
      Caption = 'Печатать штрих-код'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = 'Редактировать'
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = 'Добавить'
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Excel1: TMenuItem
      Caption = 'Вывод ассортимента в Excel'
      OnClick = Excel1Click
    end
  end
  object report: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbFind, pbPageSetup]
    ShowProgress = False
    StoreInDFM = True
    RebuildPrinter = False
    OnGetValue = reportGetValue
    Left = 96
    Top = 215
    ReportForm = {
      19000000BF0300001900000000030046617800FFFFFFFFFF0900000035080000
      9B0B00000000000000000000000000000000000000FFFF00000000FFFF000000
      000000000000000000030400466F726D000F000080DC000000780000007C0100
      002C010000040000000000EB00000005004D656D6F310002000D000000360000
      00370000000F0000000300000001000000000000000000FFFFFF1F2C02000000
      000001000C005B50524943455D20E3F0ED2E00000000FFFF0000000000020000
      0001000000000500417269616C00080000000000000000000000000001000200
      00000000FFFFFF0000000002000000000000000A0E00546672426172436F6465
      566965770000730100000400426172310002000D000000070000007B0000002F
      0000000100000001000000000000000000FFFFFF1F2C02000000000001000F00
      5B4241525F434F44455F444154415D00000000FFFF0000000000020000000100
      0000000001000502000000000000000000F03F00000000000000000000F70100
      0005004D656D6F3200020044000000360000004A0000000F0000000300000001
      000000000000000000FFFFFF1F2C020000000000010006005B4E4F54455D0000
      0000FFFF00000000000200000001000000000500417269616C00080000000000
      00000000000000000100020000000000FFFFFF00000000020000000000000000
      008102000005004D656D6F33000200A300000037000000370000000F00000003
      00000001000000000000000000FFFFFF1F2C02000000000001000C005B505249
      43455D20E3F0ED2E00000000FFFF000000000002000000010000000005004172
      69616C0008000000000000000000000000000100020000000000FFFFFF000000
      0002000000000000000A0E00546672426172436F646556696577000009030000
      040042617232000200A3000000080000007B0000002F00000001000000010000
      00000000000000FFFFFF1F2C02000000000001000F005B4241525F434F44455F
      444154415D00000000FFFF000000000002000000010000000000010005020000
      00000000000000F03F000000000000000000008D03000005004D656D6F340002
      00DA000000370000004A0000000F0000000300000001000000000000000000FF
      FFFF1F2C020000000000010006005B4E4F54455D00000000FFFF000000000002
      00000001000000000500417269616C0008000000000000000000000000000100
      020000000000FFFFFF000000000200000000000000FEFEFF0000000000000000
      00000000FC000000000000000000000000000000005800ECBA8F4C1038E34087
      9F1202F54CE340}
  end
  object frBarCodeObject1: TfrBarCodeObject
    Left = 152
    Top = 215
  end
end
