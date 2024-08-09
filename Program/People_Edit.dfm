object fmPeople_edit: TfmPeople_edit
  Left = 490
  Top = 281
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Пользователи'
  ClientHeight = 286
  ClientWidth = 254
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
    Left = 3
    Top = 32
    Width = 68
    Height = 13
    Caption = 'Должность'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 3
    Top = 78
    Width = 22
    Height = 13
    Caption = 'Имя'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 3
    Top = 103
    Width = 47
    Height = 13
    Caption = 'Отчество'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 3
    Top = 127
    Width = 43
    Height = 13
    Caption = 'Паспорт'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 3
    Top = 151
    Width = 55
    Height = 13
    Caption = 'Идент. код'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 3
    Top = 177
    Width = 79
    Height = 13
    Caption = 'Дата рождения'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 3
    Top = 54
    Width = 57
    Height = 13
    Caption = 'Фамилия'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 4
    Top = 5
    Width = 19
    Height = 13
    Caption = 'Код'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 8
    Top = 203
    Width = 45
    Height = 13
    Caption = 'Телефон'
  end
  object Label10: TLabel
    Left = 7
    Top = 228
    Width = 64
    Height = 13
    Caption = 'Место прож.'
  end
  object ComboBox_post: TComboBox
    Left = 97
    Top = 27
    Width = 150
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object edit_familiya: TEdit
    Left = 97
    Top = 51
    Width = 150
    Height = 21
    TabOrder = 1
  end
  object Edit_passport: TEdit
    Left = 97
    Top = 123
    Width = 150
    Height = 21
    TabOrder = 4
  end
  object Edit_otchestvo: TEdit
    Left = 97
    Top = 99
    Width = 150
    Height = 21
    TabOrder = 3
  end
  object Edit_imya: TEdit
    Left = 97
    Top = 75
    Width = 150
    Height = 21
    TabOrder = 2
  end
  object Edit_ident_kod: TEdit
    Left = 97
    Top = 147
    Width = 150
    Height = 21
    TabOrder = 5
  end
  object Date_begin: TdxDateEdit
    Left = 97
    Top = 173
    Width = 150
    TabOrder = 6
    Date = -700000
  end
  object button_ok: TButton
    Left = 4
    Top = 256
    Width = 129
    Height = 25
    Caption = 'Сохранить'
    TabOrder = 9
    OnClick = button_okClick
  end
  object Button_cancel: TButton
    Left = 144
    Top = 256
    Width = 106
    Height = 25
    Caption = 'Отмена'
    TabOrder = 10
    OnClick = Button_cancelClick
  end
  object edit_kod: TEdit
    Left = 97
    Top = 2
    Width = 150
    Height = 21
    ReadOnly = True
    TabOrder = 11
  end
  object edit_phone: TEdit
    Left = 96
    Top = 200
    Width = 153
    Height = 21
    TabOrder = 7
  end
  object edit_home: TEdit
    Left = 96
    Top = 228
    Width = 153
    Height = 21
    TabOrder = 8
  end
end
