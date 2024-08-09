object fmDataModule: TfmDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 425
  Top = 336
  Height = 430
  Width = 710
  object DataBase_main: TIBDatabase
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=win1251')
    LoginPrompt = False
    DefaultTransaction = Transaction_main
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 56
    Top = 16
  end
  object Transaction_main: TIBTransaction
    Active = False
    DefaultDatabase = DataBase_main
    AutoStopAction = saNone
    Left = 56
    Top = 72
  end
  object Query_temp: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 56
    Top = 136
  end
  object query_assortment: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT KOD,NAME,PRICE,NOTE'
      'FROM ASSORTMENT'
      'WHERE VALID>0')
    Left = 192
    Top = 16
  end
  object query_people: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 192
    Top = 72
  end
  object query_points: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 192
    Top = 136
  end
  object query_point_0_view: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 192
    Top = 192
  end
  object query_assortment_view: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 192
    Top = 256
  end
  object Query_transfer_source: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 320
    Top = 192
  end
  object Query_transfer_destination: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 320
    Top = 256
  end
  object query_dovidka_1: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT  COMMODITY.ASSORTMENT_KOD,'
      '        ASSORTMENT.NAME,'
      '        SUM(COMMODITY.QUANTITY) QUANTITY,'
      '        ASSORTMENT.PRICE PRICE,'
      '        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA'
      'FROM COMMODITY'
      
        'INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD' +
        ' AND ASSORTMENT.VALID=1'
      'WHERE 1=1 '
      'AND COMMODITY.POINT_KOD='
      'AND COMMODITY.date_in_out <='#39'18.09.2007'#39
      
        'GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRI' +
        'CE'
      'HAVING SUM(COMMODITY.QUANTITY)<>0'
      'ORDER BY COMMODITY.ASSORTMENT_KOD')
    Left = 48
    Top = 360
  end
  object query_expenses: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 320
    Top = 136
  end
  object query_points_sale_skip: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 312
    Top = 72
  end
  object query_PayDesk_preambule: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 312
    Top = 16
  end
  object query_PayDesk_commodity: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 440
    Top = 16
  end
  object Query_PayDesk_Money: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 440
    Top = 72
  end
  object Query_Buying: TIBQuery
    Database = DataBase_main
    Transaction = Transaction_main
    BufferChunks = 1000
    CachedUpdates = False
    Left = 440
    Top = 136
  end
end
