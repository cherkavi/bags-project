object fmPoints_sale: TfmPoints_sale
  Left = 256
  Top = 199
  Width = 870
  Height = 640
  Caption = 'Продажи по торговой точке'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 297
    Width = 862
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 862
    Height = 297
    Align = alTop
    Caption = 'Наличие товара на торговой точке '
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 858
      Height = 44
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 76
        Top = 1
        Width = 94
        Height = 13
        Caption = 'Торговая точка'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 262
        Top = 2
        Width = 31
        Height = 13
        Caption = 'Дата'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 332
        Top = 1
        Width = 172
        Height = 13
        Caption = 'Фильтр на Наименование товара'
      end
      object Label9: TLabel
        Left = 512
        Top = 1
        Width = 159
        Height = 13
        Caption = 'Фильтр на Примечание товара'
      end
      object edit_point_name: TEdit
        Left = 16
        Top = 17
        Width = 199
        Height = 21
        ReadOnly = True
        TabOrder = 0
        Text = 'edit_point_name'
      end
      object edit_date_in_out: TdxDateEdit
        Left = 224
        Top = 17
        Width = 97
        TabOrder = 1
        ReadOnly = False
        Date = -700000
        StoredValues = 64
      end
      object edit_filter_source_commodity: TEdit
        Left = 332
        Top = 17
        Width = 162
        Height = 21
        TabOrder = 2
        OnKeyUp = edit_filter_source_commodityKeyUp
      end
      object button_sell: TButton
        Left = 673
        Top = 8
        Width = 122
        Height = 25
        Caption = 'Продажа'
        TabOrder = 3
        OnClick = button_sellClick
      end
      object edit_filter_source_commodity_note: TEdit
        Left = 514
        Top = 16
        Width = 144
        Height = 21
        TabOrder = 4
        OnKeyUp = edit_filter_source_commodityKeyUp
      end
    end
    object dbGrid_source: TDBGrid
      Left = 2
      Top = 59
      Width = 858
      Height = 236
      Align = alClient
      DataSource = DataSource_source
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ASSORTMENT_NAME'
          Title.Alignment = taCenter
          Title.Caption = 'Наименование'
          Width = 135
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'QUANTITY'
          Title.Alignment = taCenter
          Title.Caption = 'Кол-во'
          Width = 116
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PRICE'
          Title.Alignment = taCenter
          Title.Caption = 'Цена'
          Width = 89
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'SUMA'
          Title.Alignment = taCenter
          Title.Caption = 'Сумма'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ASSORTMENT_NOTE'
          Title.Caption = 'Примечание'
          Width = 140
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 300
    Width = 862
    Height = 313
    Align = alClient
    Caption = 'Проданный товар и текущие расходы'
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 2
      Top = 60
      Width = 858
      Height = 251
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Реализованный товар'
        object DBGrid_destination_commodity: TDBGrid
          Left = 0
          Top = 0
          Width = 850
          Height = 224
          Align = alClient
          DataSource = DataSource_destination_commodity
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
              FieldName = 'ASSORTMENT_NAME'
              Title.Alignment = taCenter
              Title.Caption = 'Наименование'
              Width = 130
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'QUANTITY'
              Title.Alignment = taCenter
              Title.Caption = 'Кол-во'
              Width = 127
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'PRICE'
              Title.Alignment = taCenter
              Title.Caption = 'Цена'
              Width = 76
              Visible = True
            end
            item
              Alignment = taRightJustify
              Expanded = False
              FieldName = 'SUMA'
              Title.Alignment = taCenter
              Title.Caption = 'Сумма'
              Width = 104
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ASSORTMENT_NOTE'
              Title.Caption = 'Примечание'
              Width = 122
              Visible = True
            end>
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Текущие расходы и приходы'
        ImageIndex = 1
        object Panel3: TPanel
          Left = 674
          Top = 0
          Width = 176
          Height = 223
          Align = alRight
          TabOrder = 0
          object Label6: TLabel
            Left = 9
            Top = 96
            Width = 160
            Height = 13
            Caption = 'Сумма полученная от продавца'
          end
          object button_expenses_add: TButton
            Left = 8
            Top = 13
            Width = 161
            Height = 60
            Caption = 'Добавить расход/приход'
            TabOrder = 0
            OnClick = button_expenses_addClick
          end
          object button_expenses_delete: TButton
            Left = 40
            Top = -8
            Width = 161
            Height = 25
            Caption = 'Удалить расход/приход'
            TabOrder = 1
            Visible = False
            OnClick = button_expenses_deleteClick
          end
          object edit_seller_give_money: TdxCalcEdit
            Left = 16
            Top = 120
            Width = 152
            TabOrder = 2
            Alignment = taRightJustify
            Text = '0'
            StoredValues = 1
          end
          object button_save: TButton
            Left = 16
            Top = 184
            Width = 153
            Height = 33
            Caption = 'Сохранить данные'
            Enabled = False
            TabOrder = 3
            OnClick = button_saveClick
          end
          object Button_calculate: TButton
            Left = 16
            Top = 144
            Width = 151
            Height = 25
            Caption = 'Подсчитать'
            TabOrder = 4
            OnClick = Button_calculateClick
          end
        end
        object StringGrid_expenses: TStringGrid
          Left = 441
          Top = 0
          Width = 233
          Height = 223
          Align = alRight
          ColCount = 4
          DefaultColWidth = 200
          DefaultRowHeight = 20
          FixedCols = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
          TabOrder = 1
          OnDblClick = StringGrid_expensesDblClick
          ColWidths = (
            212
            35
            32
            200)
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 441
          Height = 223
          Align = alClient
          TabOrder = 2
          object StringGrid_expenses_current: TStringGrid
            Left = 1
            Top = 1
            Width = 439
            Height = 182
            Align = alClient
            ColCount = 7
            DefaultColWidth = 30
            DefaultRowHeight = 20
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
            PopupMenu = PopupMenu_expenses
            TabOrder = 0
            ColWidths = (
              30
              183
              64
              94
              30
              30
              30)
          end
          object Panel5: TPanel
            Left = 1
            Top = 183
            Width = 439
            Height = 39
            Align = alBottom
            TabOrder = 1
            object Label7: TLabel
              Left = 125
              Top = 2
              Width = 71
              Height = 13
              Caption = 'Общая сумма'
            end
            object Label8: TLabel
              Left = 269
              Top = 2
              Width = 88
              Height = 13
              Caption = 'Баланс продавца'
            end
            object Edit_expenses_summa: TdxEdit
              Left = 110
              Top = 16
              Width = 120
              TabOrder = 0
              Text = 'Edit_expenses_summa'
              Alignment = taRightJustify
              ReadOnly = True
              StoredValues = 65
            end
            object Edit_seller_balance: TdxEdit
              Left = 245
              Top = 16
              Width = 121
              TabOrder = 1
              Text = 'Edit_seller_balance'
              Alignment = taRightJustify
              ReadOnly = True
              StoredValues = 65
            end
          end
        end
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 15
      Width = 858
      Height = 45
      Align = alTop
      TabOrder = 1
      object Label4: TLabel
        Left = 335
        Top = 1
        Width = 172
        Height = 13
        Caption = 'Фильтр на Наименование товара'
      end
      object Label5: TLabel
        Left = 112
        Top = 1
        Width = 59
        Height = 13
        Caption = 'Продавец'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 514
        Top = 2
        Width = 159
        Height = 13
        Caption = 'Фильтр на Примечание товара'
      end
      object Edit_filter_destination_commodity: TEdit
        Left = 348
        Top = 17
        Width = 155
        Height = 21
        TabOrder = 0
        OnKeyUp = edit_filter_source_commodityKeyUp
      end
      object button_sell_skip: TButton
        Left = 680
        Top = 9
        Width = 113
        Height = 25
        Caption = 'Отменить продажу'
        TabOrder = 1
        OnClick = button_sell_skipClick
      end
      object edit_seller: TEdit
        Left = 16
        Top = 17
        Width = 238
        Height = 21
        ReadOnly = True
        TabOrder = 2
        Text = 'edit_seller'
      end
      object CheckBox_step_in: TCheckBox
        Left = 267
        Top = 18
        Width = 78
        Height = 17
        Caption = 'Синхронно'
        TabOrder = 3
        OnClick = CheckBox_step_inClick
      end
      object Edit_filter_destination_commodity_note: TEdit
        Left = 527
        Top = 17
        Width = 144
        Height = 21
        TabOrder = 4
        OnKeyUp = edit_filter_source_commodityKeyUp
      end
    end
  end
  object DataSource_source: TDataSource
    DataSet = fmDataModule.Query_transfer_source
    Left = 80
    Top = 152
  end
  object DataSource_destination_commodity: TDataSource
    DataSet = fmDataModule.Query_transfer_destination
    Left = 78
    Top = 452
  end
  object PopupMenu_expenses: TPopupMenu
    Left = 214
    Top = 447
    object delete1: TMenuItem
      Caption = 'Удалить статью'
      OnClick = delete1Click
    end
  end
end
