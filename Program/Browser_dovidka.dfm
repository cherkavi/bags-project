object fmBrowser_dovidka: TfmBrowser_dovidka
  Left = 250
  Top = 245
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Отчеты'
  ClientHeight = 308
  ClientWidth = 711
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 0
    Top = -1
    Width = 353
    Height = 138
    Caption = 'Общие отчеты'
    TabOrder = 0
    object button_dovidka_2: TButton
      Left = 8
      Top = 80
      Width = 337
      Height = 25
      Hint = 
        'Весь товар, который был реализован с данного торгового места,'#13#10'б' +
        'ез учета переучетов'
      Caption = 'Список реализованного товара за день'
      TabOrder = 1
      OnClick = button_dovidka_2Click
    end
    object button_dovidka_1_2: TButton
      Left = 89
      Top = 41
      Width = 60
      Height = 25
      Caption = 'Общий'
      TabOrder = 2
      OnClick = button_dovidka_1_2Click
    end
    object button_dovidka_2_2: TButton
      Left = 88
      Top = 104
      Width = 60
      Height = 25
      Caption = 'Общий'
      TabOrder = 3
      OnClick = button_dovidka_2_2Click
    end
    object button_dovidka_1_3: TButton
      Left = 204
      Top = 41
      Width = 64
      Height = 25
      Caption = 'По цене'
      TabOrder = 4
      OnClick = button_dovidka_1_3Click
    end
    object button_dovidka_2_3: TButton
      Left = 204
      Top = 104
      Width = 64
      Height = 25
      Caption = 'По цене'
      TabOrder = 5
      OnClick = button_dovidka_2_3Click
    end
    object button_dovidka_14: TButton
      Left = 200
      Top = 16
      Width = 149
      Height = 25
      Hint = 
        'Получить данные по наличию '#13#10'разницы в ассортименте склада и тор' +
        'говой точки'
      Caption = 'Сопряжение со складом'
      TabOrder = 6
      OnClick = button_dovidka_14Click
    end
    object button_dovidka_1: TButton
      Left = 8
      Top = 16
      Width = 191
      Height = 25
      Hint = 
        'Сумма всего товара, '#13#10'который находился на данной торговой точке' +
        ' '#13#10'по заданной дате'
      Caption = 'Остатки товара на точке'
      TabOrder = 0
      OnClick = button_dovidka_1Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 137
    Width = 353
    Height = 168
    Caption = 'Балансы'
    TabOrder = 1
    object Button_Dovidka_3: TButton
      Left = 8
      Top = 47
      Width = 265
      Height = 25
      Caption = 'Балансы людей'
      TabOrder = 0
      OnClick = Button_Dovidka_3Click
    end
    object Button_Dovidka_4: TButton
      Left = 8
      Top = 16
      Width = 265
      Height = 25
      Caption = 'Баланс кассы'
      TabOrder = 1
      OnClick = Button_Dovidka_4Click
    end
    object button_dovidka_3_2: TButton
      Left = 285
      Top = 47
      Width = 60
      Height = 25
      Caption = 'Общий'
      TabOrder = 2
      OnClick = button_dovidka_3_2Click
    end
    object button_dovidka_4_2: TButton
      Left = 284
      Top = 16
      Width = 60
      Height = 25
      Caption = 'Общий'
      TabOrder = 3
      OnClick = button_dovidka_4_2Click
    end
    object button_dovidka_6: TButton
      Left = 8
      Top = 107
      Width = 337
      Height = 25
      Caption = 'Баланс дня (все кассы за день)'
      TabOrder = 4
      OnClick = button_dovidka_6Click
    end
    object button_dovidka_12: TButton
      Left = 8
      Top = 137
      Width = 337
      Height = 25
      Caption = 'Анализ "выгодности" торговой точки'
      TabOrder = 5
      OnClick = button_dovidka_12Click
    end
    object button_dovidka_13: TButton
      Left = 8
      Top = 77
      Width = 337
      Height = 25
      Hint = 'Получить баланс продавца между переучетами'
      Caption = 'Текущий баланс продавца'
      TabOrder = 6
      OnClick = button_dovidka_13Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 356
    Top = -1
    Width = 353
    Height = 202
    Caption = 'Специальные отчеты'
    TabOrder = 2
    object button_dovidka_7: TButton
      Left = 8
      Top = 17
      Width = 337
      Height = 25
      Hint = 
        'Все довозы товара на торговые точки,'#13#10'и только довозы, без вычит' +
        'ания "ухода" товара'#13#10'   '#13#10'Только положительные договора по контр' +
        'агентам,'#13#10'без суммирования с отрицательными договорами,'#13#10'если он' +
        'и даже были'
      Caption = 'Положительные договора по контрагентам'
      TabOrder = 0
      OnClick = button_dovidka_7Click
    end
    object button_dovidka_8: TButton
      Left = 8
      Top = 81
      Width = 337
      Height = 25
      Hint = 
        'Все уходы товара с торговых точек,'#13#10'и только уходы, без прибавле' +
        'ния "прихода" товара'#13#10'   '#13#10'Только отрицательные договора по конт' +
        'рагентам,'#13#10'без суммирования с положительными договорами,'#13#10'если о' +
        'ни даже были'
      Caption = 'Отрицательные договора по контрагентам'
      TabOrder = 1
      OnClick = button_dovidka_8Click
    end
    object button_dovidka_7_2: TButton
      Left = 88
      Top = 41
      Width = 60
      Height = 25
      Caption = 'Общий'
      TabOrder = 2
      OnClick = button_dovidka_7_2Click
    end
    object button_dovidka_8_2: TButton
      Left = 88
      Top = 105
      Width = 60
      Height = 25
      Caption = 'Общий'
      TabOrder = 3
      OnClick = button_dovidka_8_2Click
    end
    object Button_dovidka_7_3: TButton
      Left = 212
      Top = 41
      Width = 64
      Height = 25
      Caption = 'По цене'
      TabOrder = 4
      OnClick = Button_dovidka_7_3Click
    end
    object Button_dovidka_8_3: TButton
      Left = 212
      Top = 105
      Width = 64
      Height = 25
      Caption = 'По цене'
      TabOrder = 5
      OnClick = Button_dovidka_8_3Click
    end
    object button_dovidka_9_2: TButton
      Left = 88
      Top = 170
      Width = 60
      Height = 25
      Caption = 'Общий'
      TabOrder = 6
      OnClick = button_dovidka_9_2Click
    end
    object button_dovidka_9_3: TButton
      Left = 212
      Top = 170
      Width = 64
      Height = 25
      Caption = 'По цене'
      TabOrder = 7
      OnClick = button_dovidka_9_3Click
    end
    object button_dovidka_9: TButton
      Left = 8
      Top = 145
      Width = 337
      Height = 25
      Hint = 
        'Все уходы товара с торговых точек,'#13#10'и только уходы, без прибавле' +
        'ния "прихода" товара'#13#10'   '#13#10'Только отрицательные договора по конт' +
        'рагентам,'#13#10'без суммирования с положительными договорами,'#13#10'если о' +
        'ни даже были'
      Caption = 'Положительные + Отрицательные договора по контрагентам'
      TabOrder = 8
      OnClick = button_dovidka_9Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 357
    Top = 201
    Width = 353
    Height = 52
    Caption = 'Универсальные отчеты'
    TabOrder = 3
    object button_dovidka_10: TButton
      Left = 9
      Top = 16
      Width = 334
      Height = 29
      Caption = 'Универсальный отчет по движению товара'
      TabOrder = 0
      OnClick = button_dovidka_10Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 357
    Top = 255
    Width = 353
    Height = 50
    Caption = 'Подсчет итоговых денежных средств для вкладчиков'
    TabOrder = 4
    object button_dovidka_11: TButton
      Left = 10
      Top = 15
      Width = 333
      Height = 28
      Caption = 'Балансы вкладчиков'
      TabOrder = 0
      OnClick = button_dovidka_11Click
    end
  end
end
