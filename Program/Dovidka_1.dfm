object fmDovidka_1: TfmDovidka_1
  Left = 545
  Top = 214
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '������� ������ �� ������'
  ClientHeight = 281
  ClientWidth = 232
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
    Left = 95
    Top = 195
    Width = 31
    Height = 13
    Caption = '����'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edit_date: TdxDateEdit
    Left = 8
    Top = 211
    Width = 217
    TabOrder = 0
    Date = -700000
  end
  object button_show: TButton
    Left = 8
    Top = 235
    Width = 216
    Height = 33
    Caption = '����������'
    TabOrder = 1
    OnClick = button_showClick
  end
  object CheckListBox_points: TCheckListBox
    Left = 0
    Top = 0
    Width = 225
    Height = 177
    ItemHeight = 13
    TabOrder = 2
  end
  object button_clear: TButton
    Left = 0
    Top = 176
    Width = 113
    Height = 17
    Caption = '��������'
    TabOrder = 3
    OnClick = button_clearClick
  end
  object button_invert: TButton
    Left = 112
    Top = 176
    Width = 113
    Height = 17
    Caption = '�������������'
    TabOrder = 4
    OnClick = button_invertClick
  end
  object report: TfrReport
    Dataset = frDBDataSet1
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbPrint, pbExit, pbPageSetup]
    StoreInDFM = True
    Title = '������� ������ �� �������� ������'
    RebuildPrinter = False
    OnGetValue = reportGetValue
    Left = 32
    Top = 235
    ReportForm = {
      190000002D0C0000190000000010004850204C617365724A6574203130323000
      FFFFFFFFFF09000000340800009A0B0000000000000000000000000000000000
      0000FFFF00000000FFFF000000000000000000000000030400466F726D000F00
      0080DC000000780000007C0100002C010000040000000200DA0000000C005265
      706F72745469746C65310002010000000010000000F60200008E000000300000
      0001000000000000000000FFFFFF1F00000000000000000000000000FFFF0000
      00000002000000010000000000000001000000C8000000140000000100000000
      00000200510100000B004D617374657244617461310002010000000006010000
      F6020000110000003000050001000000000000000000FFFFFF1F000000000C00
      66724442446174615365743100000000000000FFFF0000000000020000000100
      00000000000001000000C800000014000000010000000000000200BE0100000D
      004D6173746572466F6F746572310002010000000020010000F6020000200000
      003000060001000000000000000000FFFFFF1F00000000000000000000000000
      FFFF000000000002000000010000000000000001000000C80000001400000001
      00000000000000008202000005004D656D6F310002002C00000016000000AC02
      00006B0000000300000001000000000000000000FFFFFF1F2C02000000000003
      001B00C8EDF4EEF0ECE0F6E8FF20EE20EDE0EBE8F7E8E820F2EEE2E0F0E00D13
      00EFEE20F2EEF7EAE0EC3A205B504F494E54535D0D1200EDE020E4E0F2F33A5B
      444154455F454E445D00000000FFFF0000000000020000000100000000050041
      7269616C000C000000020000000000020000000100020000000000FFFFFF0000
      0000020000000000000000002F03000005004D656D6F320002001E0000000601
      00004C0000001100000003000F0001000000000000000000FFFFFF1F2C020000
      00000001002F005B666D446174614D6F64756C652E71756572795F646F766964
      6B615F312E224153534F52544D454E545F4B4F44225D00000000FFFF00000000
      000200000001000000000500417269616C00080000000000000000000A000000
      0100020000000000FFFFFF0000000002000000000000000000D203000005004D
      656D6F330002006A00000006010000BA0000001100000003000F000100000000
      0000000000FFFFFF1F2C020000000000010025005B666D446174614D6F64756C
      652E71756572795F646F7669646B615F312E224E414D45225D00000000FFFF00
      000000000200000001000000000500417269616C000800000000000000000000
      0000000100020000000000FFFFFF000000000200000000000000000079040000
      05004D656D6F34000200BA01000006010000600000001100000003000F000100
      0000000000000000FFFFFF1F2C020000000000010029005B666D446174614D6F
      64756C652E71756572795F646F7669646B615F312E225155414E54495459225D
      00000000FFFF00000000000200000001000000000500417269616C0008000000
      0000000000000A0000000100020000000000FFFFFF0000000002000000000000
      0000001D05000005004D656D6F350002001A0200000601000060000000110000
      0003000F0001000000000000000000FFFFFF1F2C020000000000010026005B66
      6D446174614D6F64756C652E71756572795F646F7669646B615F312E22505249
      4345225D00000000FFFF00000000000200000001000000000500417269616C00
      080000000000000000000A0000000100020000000000FFFFFF00000000020000
      00000000000000C005000005004D656D6F360002007A02000006010000600000
      001100000003000F0001000000000000000000FFFFFF1F2C0200000000000100
      25005B666D446174614D6F64756C652E71756572795F646F7669646B615F312E
      2253554D41225D00000000FFFF00000000000200000001000000000500417269
      616C00080000000000000000000A0000000100020000000000FFFFFF00000000
      020000000000000000006A06000005004D656D6F370002007802000028010000
      60000000140000000300000001000000000000000000FFFFFF1F2C0200000000
      0001002C005B53554D285B666D446174614D6F64756C652E71756572795F646F
      7669646B615F312E2253554D41225D295D00000000FFFF000000000002000000
      01000000000500417269616C000A000000000000000000000000000100020000
      000000FFFFFF0000000002000000000000000000F706000005004D656D6F3800
      0200EC010000280100007C000000140000000300000001000000000000000000
      FFFFFF1F2C02000000000001000F00C8F2EEE3EE20EDE020F1F3ECECF33A0000
      0000FFFF00000000000200000001000000000500417269616C000A0000000200
      00000000000000000100020000000000FFFFFF00000000020000000000000000
      007807000005004D656D6F390002001E000000860000004C0000001400000003
      000F0001000000000000000000FFFFFF1F2C02000000000001000300CAEEE400
      000000FFFF00000000000200000001000000000500417269616C000A00000002
      0000000000020000000100020000000000FFFFFF000000000200000000000000
      00000308000006004D656D6F31300002006A00000086000000BA000000140000
      0003000F0001000000000000000000FFFFFF1F2C02000000000001000C00CDE0
      E8ECE5EDEEE2E0EDE8E500000000FFFF00000000000200000001000000000500
      417269616C000A000000020000000000020000000100020000000000FFFFFF00
      000000020000000000000000008C08000006004D656D6F3131000200BA010000
      86000000600000001400000003000F0001000000000000000000FFFFFF1F2C02
      000000000001000A00CAEEEBE8F7E5F1F2E2EE00000000FFFF00000000000200
      000001000000000500417269616C000A00000002000000000002000000010002
      0000000000FFFFFF00000000020000000000000000000F09000006004D656D6F
      31320002001A02000086000000600000001400000003000F0001000000000000
      000000FFFFFF1F2C02000000000001000400D6E5EDE000000000FFFF00000000
      000200000001000000000500417269616C000A00000002000000000002000000
      0100020000000000FFFFFF00000000020000000000000000009309000006004D
      656D6F31330002007A02000086000000600000001400000003000F0001000000
      000000000000FFFFFF1F2C02000000000001000500D1F3ECECE000000000FFFF
      00000000000200000001000000000500417269616C000A000000020000000000
      020000000100020000000000FFFFFF0000000002000000000000000000420A00
      0006004D656D6F31340002007401000028010000600000001400000003000000
      01000000000000000000FFFFFF1F2C020000000000010030005B53554D285B66
      6D446174614D6F64756C652E71756572795F646F7669646B615F312E22515541
      4E54495459225D295D00000000FFFF0000000000020000000100000000050041
      7269616C000A000000000000000000000000000100020000000000FFFFFF0000
      000002000000000000000000CE0A000006004D656D6F3135000200E800000028
      0100007C000000140000000300000001000000000000000000FFFFFF1F2C0200
      0000000001000D00CEE1F9E5E520EAEEEB2DE2EE3A00000000FFFF0000000000
      0200000001000000000500417269616C000A0000000200000000000000000001
      00020000000000FFFFFF0000000002000000000000000000570B000006004D65
      6D6F31360002002401000086000000960000001400000003000F000100000000
      0000000000FFFFFF1F2C02000000000001000A00CFF0E8ECE5F7E0EDE8E50000
      0000FFFF00000000000200000001000000000500417269616C000A0000000200
      00000000020000000100020000000000FFFFFF00000000020000000000000000
      00FB0B000006004D656D6F313700020024010000060100009600000011000000
      03000F0001000000000000000000FFFFFF1F2C020000000000010025005B666D
      446174614D6F64756C652E71756572795F646F7669646B615F312E224E4F5445
      225D00000000FFFF00000000000200000001000000000500417269616C000800
      0000000000000000000000000100020000000000FFFFFF000000000200000000
      000000FEFEFF000000000000000000000000FC00000000000000000000000000
      00000058005963A833F235E3408F1B432E1C51E340}
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = fmDataModule.query_dovidka_1
    Left = 72
    Top = 235
  end
end
