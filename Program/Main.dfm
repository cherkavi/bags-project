object fmMain: TfmMain
  Left = 487
  Top = 172
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Главная форма'
  ClientHeight = 471
  ClientWidth = 346
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
  object GroupBox2: TGroupBox
    Left = 2
    Top = 2
    Width = 339
    Height = 79
    Caption = 'Манипуляции с товаром'
    TabOrder = 0
    object button_commodity_to_main: TButton
      Left = 8
      Top = 16
      Width = 321
      Height = 25
      Caption = 'Довоз товара на склад'
      TabOrder = 0
      OnClick = button_commodity_to_mainClick
    end
    object button_commodity_transfer: TButton
      Left = 8
      Top = 48
      Width = 321
      Height = 25
      Caption = 'Перемещение товара'
      TabOrder = 1
      OnClick = button_commodity_transferClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 2
    Top = 80
    Width = 339
    Height = 86
    Caption = 'Продажи'
    TabOrder = 1
    object button_points_sale: TButton
      Left = 8
      Top = 16
      Width = 321
      Height = 25
      Caption = 'Ежедневные продажи'
      TabOrder = 0
      OnClick = button_points_saleClick
    end
    object button_sell_from_storehouse: TButton
      Left = 8
      Top = 48
      Width = 321
      Height = 25
      Caption = 'Продажа товара со склада (Склад, Менты, Брак)'
      TabOrder = 1
      OnClick = button_sell_from_storehouseClick
    end
  end
  object GroupBox4: TGroupBox
    Left = 2
    Top = 217
    Width = 339
    Height = 81
    Caption = 'Работа со словарями'
    TabOrder = 2
    object button_assortment: TButton
      Left = 186
      Top = 16
      Width = 141
      Height = 25
      Caption = 'Ассортимент'
      TabOrder = 0
      OnClick = button_assortmentClick
    end
    object button_people: TButton
      Left = 12
      Top = 16
      Width = 153
      Height = 25
      Caption = 'Работники'
      TabOrder = 1
      OnClick = button_peopleClick
    end
    object button_points: TButton
      Left = 12
      Top = 48
      Width = 317
      Height = 25
      Caption = 'Торговые точки'
      TabOrder = 2
      OnClick = button_pointsClick
    end
    object button_expenses: TButton
      Left = 328
      Top = 48
      Width = 139
      Height = 25
      Caption = 'Статьи расходов'
      TabOrder = 3
      Visible = False
      OnClick = button_expensesClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 2
    Top = 166
    Width = 339
    Height = 51
    Caption = 'Прием/выдача денег'
    TabOrder = 3
    object Button_buying: TButton
      Left = 8
      Top = 16
      Width = 321
      Height = 25
      Caption = 'Ввод/вывод денежных средств'
      TabOrder = 0
      OnClick = Button_buyingClick
    end
  end
  object button_points_sale_skip: TButton
    Left = 352
    Top = 16
    Width = 265
    Height = 25
    Caption = 'Отмена продаж за день'
    TabOrder = 4
    OnClick = button_points_sale_skipClick
  end
  object button_charge_off: TButton
    Left = 352
    Top = 46
    Width = 265
    Height = 25
    Caption = 'Списывание товара'
    TabOrder = 5
    OnClick = button_charge_offClick
  end
  object GroupBox6: TGroupBox
    Left = 2
    Top = 304
    Width = 339
    Height = 49
    Caption = 'Переучет'
    TabOrder = 6
    object button_rediscount: TButton
      Left = 8
      Top = 16
      Width = 324
      Height = 25
      Caption = 'Переучет'
      TabOrder = 0
      OnClick = button_rediscountClick
    end
  end
  object GroupBox7: TGroupBox
    Left = 2
    Top = 352
    Width = 339
    Height = 49
    Caption = 'Загрузка удаленных переучетов'
    TabOrder = 7
    object button_getmail: TButton
      Left = 8
      Top = 16
      Width = 177
      Height = 25
      Caption = 'Из сети'
      TabOrder = 0
      OnClick = button_getmailClick
    end
    object button_get_com: TButton
      Left = 192
      Top = 16
      Width = 139
      Height = 25
      Caption = 'Из порта (COM)'
      TabOrder = 1
      OnClick = button_get_comClick
    end
  end
  object button_browser_dovidka: TButton
    Left = 4
    Top = 408
    Width = 337
    Height = 57
    Caption = 'Отчеты'
    TabOrder = 8
    OnClick = button_browser_dovidkaClick
  end
end
