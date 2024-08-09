object fmPayDesk_Edit: TfmPayDesk_Edit
  Left = 503
  Top = 391
  BorderStyle = bsSingle
  Caption = 'Ввод денежных операций'
  ClientHeight = 182
  ClientWidth = 252
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 9
    Width = 79
    Height = 13
    Caption = 'Торговая точка'
  end
  object Label2: TLabel
    Left = 24
    Top = 34
    Width = 50
    Height = 13
    Caption = 'Продавец'
  end
  object Label3: TLabel
    Left = 10
    Top = 59
    Width = 77
    Height = 13
    Caption = 'Дата операции'
  end
  object Label4: TLabel
    Left = 8
    Top = 82
    Width = 85
    Height = 13
    Caption = 'Статья расходов'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 24
    Top = 108
    Width = 34
    Height = 13
    Caption = 'Сумма'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object edit_point: TEdit
    Left = 96
    Top = 8
    Width = 153
    Height = 21
    Color = clMenu
    ReadOnly = True
    TabOrder = 2
    Text = 'edit_point'
  end
  object Edit_kod_man: TdxEdit
    Left = 96
    Top = 32
    Width = 153
    Color = clMenu
    TabOrder = 3
    Text = 'Edit_kod_man'
    Alignment = taCenter
    ReadOnly = True
    StoredValues = 65
  end
  object Edit_Date_in_out: TdxEdit
    Left = 96
    Top = 56
    Width = 153
    Color = clMenu
    TabOrder = 4
    Text = 'Edit_Date_in_out'
    Alignment = taCenter
    ReadOnly = True
    StoredValues = 65
  end
  object combobox_expenses: TComboBox
    Left = 96
    Top = 80
    Width = 153
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    OnKeyDown = combobox_expensesKeyDown
  end
  object Edit_Amount: TdxCalcEdit
    Left = 96
    Top = 104
    Width = 153
    TabOrder = 0
    Alignment = taRightJustify
    Text = '0'
    StoredValues = 1
  end
  object button_ok: TButton
    Left = 0
    Top = 152
    Width = 137
    Height = 25
    Caption = 'Сохранить'
    TabOrder = 1
    OnClick = button_okClick
  end
  object button_cancel: TButton
    Left = 136
    Top = 152
    Width = 113
    Height = 25
    Caption = 'Отменить'
    TabOrder = 6
    OnClick = button_cancelClick
  end
  object edit_note: TEdit
    Left = 0
    Top = 128
    Width = 249
    Height = 21
    TabOrder = 7
  end
end
