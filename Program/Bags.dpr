program Bags;

uses
  Forms,
  Main in 'Main.pas' {fmMain},
  DataModule in 'DataModule.pas' {fmDataModule: TDataModule},
  Assortment in 'Assortment.pas' {fmASSORTMENT},
  Assortment_Edit in 'Assortment_Edit.pas' {fmAssortment_Edit},
  People in 'People.pas' {fmPEOPLE},
  People_Edit in 'People_Edit.pas' {fmPeople_edit},
  Points in 'Points.pas' {fmPOINTS},
  Points_Edit in 'Points_Edit.pas' {fmPoints_Edit},
  Commodity_to_main in 'Commodity_to_main.pas' {fmCommodity_to_Main},
  Commodity_to_main_transaction in 'Commodity_to_main_transaction.pas' {fmCommodity_to_main_transaction},
  Commodity_Transfer in 'Commodity_Transfer.pas' {fmCommodity_Transfer},
  Commodity_Transfer_Transaction in 'Commodity_Transfer_Transaction.pas' {fmCommodity_Transfer_Transaction},
  Points_sale_preambule in 'Points_sale_preambule.pas' {fmPoints_sale_preambule},
  Point_Sale_Transaction in 'Point_Sale_Transaction.pas' {fmPoint_Sale_Transaction},
  Dovidka_12 in 'Dovidka_12.pas' {fmDovidka_12},
  Expenses in 'Expenses.pas' {fmExpenses},
  Expenses_Edit in 'Expenses_Edit.pas' {fmExpenses_Edit},
  Points_Sale_Skip in 'Points_Sale_Skip.pas' {fmPoints_Sale_Skip},
  PayDesk_Edit in 'PayDesk_Edit.pas' {fmPayDesk_Edit},
  Charge_off in 'Charge_off.pas' {fmCharge_Off},
  Charge_off_Edit in 'Charge_off_Edit.pas' {fmCharge_Off_Edit},
  Buying in 'Buying.pas' {fmBuying},
  Dovidka_1 in 'Dovidka_1.pas' {fmDovidka_1},
  Dovidka_2 in 'Dovidka_2.pas' {fmDovidka_2},
  Dovidka_3 in 'Dovidka_3.pas' {fmDovidka_3},
  Dovidka_4 in 'Dovidka_4.pas' {fmDovidka_4},
  Dovidka_5 in 'Dovidka_5.pas' {fmDovidka_5},
  Dovidka_6 in 'Dovidka_6.pas' {fmDovidka_6},
  Dovidka_7 in 'Dovidka_7.pas' {fmDovidka_7},
  Dovidka_1_3 in 'Dovidka_1_3.pas' {fmDovidka_1_3},
  Dovidka_2_3 in 'Dovidka_2_3.pas' {fmDovidka_2_3},
  Dovidka_7_3 in 'Dovidka_7_3.pas' {fmDovidka_7_3},
  dovidka_9_3 in 'dovidka_9_3.pas' {fmDovidka_9_3},
  Dovidka_3_2 in 'Dovidka_3_2.pas' {fmDovidka_3_2},
  Sell_from_Storehouse in 'Sell_from_Storehouse.pas' {fmSell_from_Storehouse},
  Sell_from_Storehouse_transaction in 'Sell_from_Storehouse_transaction.pas' {fmSell_from_Storehouse_transaction},
  Points_sale in 'Points_sale.pas' {fmPoints_sale},
  Rediscount in 'Rediscount.pas' {fmRediscount},
  StartUp in 'StartUp.pas' {fmStartUp},
  GetMail in 'GetMail.pas' {fmGetMail},
  SenderObject in 'SenderObject.pas',
  Rediscount_list in 'Rediscount_list.pas' {fmRediscount_list},
  Dovidka_1_2 in 'Dovidka_1_2.pas' {fmDovidka_1_2},
  Dovidka_2_2 in 'Dovidka_2_2.pas' {fmDovidka_2_2},
  Dovidka_7_2 in 'Dovidka_7_2.pas' {fmDovidka_7_2},
  dovidka_10_2 in 'dovidka_10_2.pas' {fmDovidka_10_2},
  Browser_dovidka in 'Browser_dovidka.pas' {fmBrowser_dovidka},
  Dovidka_8 in 'dovidka_8.pas' {fmDovidka_8},
  Dovidka_8_2 in 'dovidka_8_2.pas' {fmDovidka_8_2},
  dovidka_8_3 in 'dovidka_8_3.pas' {fmDovidka_8_3},
  Dovidka_9 in 'Dovidka_9.pas' {fmDovidka_9},
  Dovidka_10 in 'dovidka_10.pas' {fmDovidka_10},
  StringGrid_Shell in 'StringGrid_Shell.pas',
  Rediscount_edit_file in 'Rediscount_edit_file.pas' {fmRediscount_edit_file},
  Rediscount_edit_file_add in 'Rediscount_edit_file_add.pas' {fmRediscount_edit_file_add},
  dovidka_11 in 'dovidka_11.pas' {fmDovidka_11},
  People_depositors in 'People_depositors.pas' {fmPeople_depositors},
  GetCom in 'GetCom.pas' {fmGetCom},
  Dovidka_4_2 in 'Dovidka_4_2.pas' {fmDovidka_4_2},
  Dovidka_13 in 'Dovidka_13.pas' {fmDovidka_13},
  Dovidka_14 in 'Dovidka_14.pas' {fmDovidka_14};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmDataModule, fmDataModule);
  Application.CreateForm(TfmStartUp, fmStartUp);
  Application.CreateForm(TfmGetCom, fmGetCom);
  Application.CreateForm(TfmDovidka_4_2, fmDovidka_4_2);
  Application.CreateForm(TfmDovidka_13, fmDovidka_13);
  Application.CreateForm(TfmDovidka_14, fmDovidka_14);
  Application.Run;
end.
