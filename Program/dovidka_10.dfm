object fmDovidka_10: TfmDovidka_10
  Left = 323
  Top = 232
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '������������� ����� �� �������� ������'
  ClientHeight = 339
  ClientWidth = 544
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
  object Label2: TLabel
    Left = 167
    Top = 256
    Width = 44
    Height = 13
    Caption = '������'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 340
    Top = 256
    Width = 37
    Height = 13
    Caption = '�����'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edit_date_begin: TdxDateEdit
    Left = 160
    Top = 272
    Width = 97
    TabOrder = 0
    Date = -700000
  end
  object button_show: TButton
    Left = 8
    Top = 304
    Width = 537
    Height = 33
    Caption = '����������'
    TabOrder = 1
    OnClick = button_showClick
  end
  object checkbox_detail: TCheckBox
    Left = 424
    Top = 272
    Width = 81
    Height = 17
    Caption = '��������'
    TabOrder = 2
  end
  object CheckListBox_points: TCheckListBox
    Left = 0
    Top = 0
    Width = 233
    Height = 234
    ItemHeight = 13
    TabOrder = 3
  end
  object edit_date_end: TdxDateEdit
    Left = 285
    Top = 272
    Width = 97
    TabOrder = 4
    Date = -700000
  end
  object button_invert: TButton
    Left = 116
    Top = 234
    Width = 113
    Height = 17
    Caption = '�������������'
    TabOrder = 5
    OnClick = button_invertClick
  end
  object button_clear: TButton
    Left = 4
    Top = 234
    Width = 113
    Height = 17
    Caption = '��������'
    TabOrder = 6
    OnClick = button_clearClick
  end
  object GroupBox_1: TGroupBox
    Left = 235
    Top = -2
    Width = 150
    Height = 85
    Caption = '�������'
    TabOrder = 7
    object CheckBox_1: TCheckBox
      Left = 8
      Top = 16
      Width = 81
      Height = 17
      Caption = '�������'
      TabOrder = 0
      OnClick = CheckBox_1Click
    end
    object RadioButton_1_1: TRadioButton
      Left = 24
      Top = 32
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 1
    end
    object RadioButton_1_2: TRadioButton
      Left = 24
      Top = 48
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 2
    end
    object RadioButton_1_3: TRadioButton
      Left = 24
      Top = 64
      Width = 113
      Height = 17
      Caption = '������������'
      TabOrder = 3
    end
  end
  object GroupBox1: TGroupBox
    Left = 235
    Top = 82
    Width = 150
    Height = 85
    Caption = '�����'
    TabOrder = 8
    object CheckBox_2: TCheckBox
      Left = 10
      Top = 15
      Width = 137
      Height = 17
      Caption = '�����'
      TabOrder = 0
      OnClick = CheckBox_1Click
    end
    object RadioButton_2_1: TRadioButton
      Left = 24
      Top = 32
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 1
    end
    object RadioButton_2_2: TRadioButton
      Left = 24
      Top = 48
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 2
    end
    object RadioButton_2_3: TRadioButton
      Left = 24
      Top = 64
      Width = 113
      Height = 17
      Caption = '������������'
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 235
    Top = 167
    Width = 150
    Height = 85
    Caption = '��������'
    TabOrder = 9
    object CheckBox_3: TCheckBox
      Left = 11
      Top = 15
      Width = 137
      Height = 17
      Caption = '��������'
      TabOrder = 0
      OnClick = CheckBox_1Click
    end
    object RadioButton_3_1: TRadioButton
      Left = 24
      Top = 32
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 1
    end
    object RadioButton_3_2: TRadioButton
      Left = 24
      Top = 48
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 2
    end
    object RadioButton_3_3: TRadioButton
      Left = 24
      Top = 64
      Width = 113
      Height = 17
      Caption = '������������'
      TabOrder = 3
    end
  end
  object GroupBox3: TGroupBox
    Left = 387
    Top = -2
    Width = 150
    Height = 85
    Caption = '�����������'
    TabOrder = 10
    object CheckBox_4: TCheckBox
      Left = 8
      Top = 16
      Width = 105
      Height = 17
      Caption = '�����������'
      TabOrder = 0
      OnClick = CheckBox_1Click
    end
    object RadioButton_4_1: TRadioButton
      Left = 24
      Top = 32
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 1
    end
    object RadioButton_4_2: TRadioButton
      Left = 24
      Top = 48
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 2
    end
    object RadioButton_4_3: TRadioButton
      Left = 24
      Top = 64
      Width = 113
      Height = 17
      Caption = '������������'
      TabOrder = 3
    end
  end
  object GroupBox4: TGroupBox
    Left = 387
    Top = 82
    Width = 150
    Height = 85
    Caption = '������� �� ������'
    TabOrder = 11
    object CheckBox_6: TCheckBox
      Left = 10
      Top = 15
      Width = 137
      Height = 17
      Caption = '������� �� ������'
      TabOrder = 0
      OnClick = CheckBox_1Click
    end
    object RadioButton_6_1: TRadioButton
      Left = 24
      Top = 32
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 1
    end
    object RadioButton_6_2: TRadioButton
      Left = 24
      Top = 48
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 2
    end
    object RadioButton_6_3: TRadioButton
      Left = 24
      Top = 64
      Width = 113
      Height = 17
      Caption = '������������'
      TabOrder = 3
    end
  end
  object GroupBox5: TGroupBox
    Left = 387
    Top = 167
    Width = 150
    Height = 85
    Caption = '��������'
    TabOrder = 12
    object CheckBox_7: TCheckBox
      Left = 11
      Top = 15
      Width = 137
      Height = 17
      Caption = '��������'
      TabOrder = 0
      OnClick = CheckBox_1Click
    end
    object RadioButton_7_1: TRadioButton
      Left = 24
      Top = 32
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 1
    end
    object RadioButton_7_2: TRadioButton
      Left = 24
      Top = 48
      Width = 113
      Height = 17
      Caption = '�������������'
      TabOrder = 2
    end
    object RadioButton_7_3: TRadioButton
      Left = 24
      Top = 64
      Width = 113
      Height = 17
      Caption = '������������'
      TabOrder = 3
    end
  end
  object report: TfrReport
    Dataset = frDBDataSet1
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbHelp, pbExit, pbPageSetup]
    StoreInDFM = True
    Title = '���� ������ �� ����'
    RebuildPrinter = False
    OnGetValue = reportGetValue
    Top = 264
    ReportForm = {
      19000000E7090000190000000010004850204C617365724A6574203130323000
      FFFFFFFFFF09000000340800009A0B0000000000000000000000000000000000
      0000FFFF00000000FFFF000000000000000000000000030400466F726D000F00
      0080DC000000780000007C0100002C010000040000000200DA0000000C005265
      706F72745469746C65310002010000000010000000F602000082000000300000
      0001000000000000000000FFFFFF1F00000000000000000000000000FFFF0000
      00000002000000010000000000000001000000C8000000140000000100000000
      00000200510100000B004D6173746572446174613100020100000000AC000000
      F6020000140000003000050001000000000000000000FFFFFF1F000000000C00
      66724442446174615365743100000000000000FFFF0000000000020000000100
      00000000000001000000C800000014000000010000000000000200BE0100000D
      004D6173746572466F6F7465723100020100000000C6000000F6020000200000
      003000060001000000000000000000FFFFFF1F00000000000000000000000000
      FFFF000000000002000000010000000000000001000000C80000001400000001
      00000000000000009C02000005004D656D6F310002002C00000016000000AC02
      0000620000000300000001000000000000000000FFFFFF1F2C02000000000003
      003600CFEEEBEEE6E8F2E5EBFCEDFBE5202B20CEF2F0E8F6E0F2E5EBFCEDFBE5
      20E4EEE3EEE2EEF0E020EFEE20EAEEEDF2F0E0E3E5EDF2E0EC0D08005B504F49
      4E54535D0D1C0063205B444154455F424547494E5D20EFEE205B444154455F45
      4E445D00000000FFFF00000000000200000001000000000500417269616C000C
      000000020000000000020000000100020000000000FFFFFF0000000002000000
      0000000000004603000005004D656D6F320002001E000000AC000000BC000000
      1400000003000F0001000000000000000000FFFFFF1F2C02000000000001002C
      005B666D446174614D6F64756C652E71756572795F646F7669646B615F312E22
      504F494E54535F4E414D45225D00000000FFFF00000000000200000001000000
      000500417269616C000A0000000000000000000A0000000100020000000000FF
      FFFF0000000002000000000000000000F403000005004D656D6F33000200DA00
      0000AC000000E00000001400000003000F0001000000000000000000FFFFFF1F
      2C020000000000010030005B666D446174614D6F64756C652E71756572795F64
      6F7669646B615F312E224153534F52544D454E545F4E414D45225D00000000FF
      FF00000000000200000001000000000500417269616C000A0000000000000000
      00000000000100020000000000FFFFFF00000000020000000000000000009B04
      000005004D656D6F34000200BA010000AC000000600000001400000003000F00
      01000000000000000000FFFFFF1F2C020000000000010029005B666D44617461
      4D6F64756C652E71756572795F646F7669646B615F312E225155414E54495459
      225D00000000FFFF00000000000200000001000000000500417269616C000A00
      00000000000000000A0000000100020000000000FFFFFF000000000200000000
      00000000003F05000005004D656D6F350002001A020000AC0000006000000014
      00000003000F0001000000000000000000FFFFFF1F2C02000000000001002600
      5B666D446174614D6F64756C652E71756572795F646F7669646B615F312E2250
      52494345225D00000000FFFF0000000000020000000100000000050041726961
      6C000A0000000000000000000A0000000100020000000000FFFFFF0000000002
      000000000000000000E205000005004D656D6F360002007A020000AC00000060
      0000001400000003000F0001000000000000000000FFFFFF1F2C020000000000
      010025005B666D446174614D6F64756C652E71756572795F646F7669646B615F
      312E2253554D41225D00000000FFFF0000000000020000000100000000050041
      7269616C000A0000000000000000000A0000000100020000000000FFFFFF0000
      0000020000000000000000008C06000005004D656D6F3700020078020000CE00
      000060000000140000000300000001000000000000000000FFFFFF1F2C020000
      00000001002C005B53554D285B666D446174614D6F64756C652E71756572795F
      646F7669646B615F312E2253554D41225D295D00000000FFFF00000000000200
      000001000000000500417269616C000A00000000000000000000000000010002
      0000000000FFFFFF00000000020000000000000000001907000005004D656D6F
      38000200EC010000CE0000007C00000014000000030000000100000000000000
      0000FFFFFF1F2C02000000000001000F00C8F2EEE3EE20EDE020F1F3ECECF33A
      00000000FFFF00000000000200000001000000000500417269616C000A000000
      020000000000000000000100020000000000FFFFFF0000000002000000000000
      0000009A07000005004D656D6F390002001E0000007B000000BC000000140000
      0003000F0001000000000000000000FFFFFF1F2C02000000000001000300CAEE
      E400000000FFFF00000000000200000001000000000500417269616C000A0000
      00020000000000020000000100020000000000FFFFFF00000000020000000000
      000000002508000006004D656D6F3130000200DA0000007B000000E000000014
      00000003000F0001000000000000000000FFFFFF1F2C02000000000001000C00
      CDE0E8ECE5EDEEE2E0EDE8E500000000FFFF0000000000020000000100000000
      0500417269616C000A000000020000000000020000000100020000000000FFFF
      FF0000000002000000000000000000AE08000006004D656D6F3131000200BA01
      00007B000000600000001400000003000F0001000000000000000000FFFFFF1F
      2C02000000000001000A00CAEEEBE8F7E5F1F2E2EE00000000FFFF0000000000
      0200000001000000000500417269616C000A0000000200000000000200000001
      00020000000000FFFFFF00000000020000000000000000003109000006004D65
      6D6F31320002001A0200007B000000600000001400000003000F000100000000
      0000000000FFFFFF1F2C02000000000001000400D6E5EDE000000000FFFF0000
      0000000200000001000000000500417269616C000A0000000200000000000200
      00000100020000000000FFFFFF0000000002000000000000000000B509000006
      004D656D6F31330002007A0200007B000000600000001400000003000F000100
      0000000000000000FFFFFF1F2C02000000000001000500D1F3ECECE000000000
      FFFF00000000000200000001000000000500417269616C000A00000002000000
      0000020000000100020000000000FFFFFF000000000200000000000000FEFEFF
      000000000000000000000000FC00000000000000000000000000000000580059
      63A833F235E34030F78E305241E340}
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = fmDataModule.query_dovidka_1
    Left = 32
    Top = 264
  end
end
