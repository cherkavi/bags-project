unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,datamodule,
  StdCtrls,IniFiles;

type
  TfmMain = class(TForm)
    GroupBox2: TGroupBox;
    button_commodity_to_main: TButton;
    button_commodity_transfer: TButton;
    GroupBox3: TGroupBox;
    button_points_sale: TButton;
    GroupBox4: TGroupBox;
    button_assortment: TButton;
    button_people: TButton;
    button_points: TButton;
    button_expenses: TButton;
    GroupBox5: TGroupBox;
    Button_buying: TButton;
    button_sell_from_storehouse: TButton;
    button_points_sale_skip: TButton;
    button_charge_off: TButton;
    GroupBox6: TGroupBox;
    button_rediscount: TButton;
    GroupBox7: TGroupBox;
    button_getmail: TButton;
    button_browser_dovidka: TButton;
    button_get_com: TButton;
    procedure FormShow(Sender: TObject);
    procedure button_assortmentClick(Sender: TObject);
    procedure button_peopleClick(Sender: TObject);
    procedure button_pointsClick(Sender: TObject);
    procedure button_commodity_to_mainClick(Sender: TObject);
    procedure button_commodity_transferClick(Sender: TObject);
    procedure button_points_saleClick(Sender: TObject);
    procedure button_dovidka_1Click(Sender: TObject);
    procedure button_dovidka_2Click(Sender: TObject);
    procedure button_expensesClick(Sender: TObject);
    procedure button_points_sale_skipClick(Sender: TObject);
    procedure Button_Dovidka_3Click(Sender: TObject);
    procedure Button_Dovidka_4Click(Sender: TObject);
    procedure button_charge_offClick(Sender: TObject);
    procedure button_dovidka_5Click(Sender: TObject);
    procedure button_dovidka_6Click(Sender: TObject);
    procedure Button_buyingClick(Sender: TObject);
    procedure button_dovidka_7Click(Sender: TObject);
    procedure button_dovidka_8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure button_dovidka_1_2Click(Sender: TObject);
    procedure button_dovidka_2_2Click(Sender: TObject);
    procedure button_dovidka_7_2Click(Sender: TObject);
    procedure button_dovidka_8_2Click(Sender: TObject);
    procedure button_dovidka_3_2Click(Sender: TObject);
    procedure button_dovidka_4_2Click(Sender: TObject);
    procedure button_sell_from_storehouseClick(Sender: TObject);
    procedure button_rediscountClick(Sender: TObject);
    procedure button_getmailClick(Sender: TObject);
    procedure button_dovidka_1_3Click(Sender: TObject);
    procedure button_dovidka_2_3Click(Sender: TObject);
    procedure Button_dovidka_7_3Click(Sender: TObject);
    procedure Button_dovidka_8_3Click(Sender: TObject);
    procedure button_browser_dovidkaClick(Sender: TObject);
    procedure button_get_comClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    field_database_number:integer;
    field_path_to_database:string;
    field_application_title:string;
    field_application_color:TColor;
    field_rediscount_path:string;
    field_rediscount_max:integer;
    field_rediscount_name:string;
    function getHDDSerialNumber_integer(path:string): cardinal;
    function use_universal_key:boolean;
  end;

var
  fmMain: TfmMain;

implementation

uses Assortment, People, Points, Commodity_to_main, Commodity_Transfer,
  Points_sale_preambule, Dovidka_1, Dovidka_2, Expenses, Points_Sale_Skip,
  Dovidka_3, Dovidka_4, Charge_off, Dovidka_5, Dovidka_6,
  Buying, Dovidka_7, Dovidka_8, Dovidka_1_2, Dovidka_2_2, Dovidka_7_2,
  Dovidka_3_2, Dovidka_4_2, Dovidka_8_2, Sell_from_Storehouse, Rediscount,
  GetMail, Dovidka_1_3, Dovidka_2_3, Dovidka_7_3, dovidka_8_3,
  Browser_dovidka, GetCom;

{$R *.DFM}

function TfmMain.getHDDSerialNumber_integer(path:string): cardinal;
var
  VolumeName,
  FileSystemName : array [0..MAX_PATH-1] of Char;
  VolumeSerialNo : DWord;
  MaxComponentLength,FileSystemFlags: Cardinal;
begin
  GetVolumeInformation(pchar(path),VolumeName,MAX_PATH,@VolumeSerialNo,
  MaxComponentLength,FileSystemFlags, FileSystemName,MAX_PATH);
  result:=VolumeSerialNo;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
   try
      application.title:=self.field_application_title;
      self.color:=self.field_application_color;
      if fmdatamodule.DataBase_main.Connected
      then fmdatamodule.DataBase_main.connected:=false;
      fmdatamodule.DataBase_main.Params.Clear;
      fmdatamodule.database_main.Params.Add('user_name=SYSDBA');
      fmdatamodule.database_main.Params.Add('password=masterkey');
      fmdatamodule.database_main.Params.Add('lc_ctype=win1251');
      fmdatamodule.DataBase_main.LoginPrompt:=false;
      fmdatamodule.DataBase_main.DatabaseName:=self.field_path_to_database;
      fmdatamodule.DataBase_main.Connected:=true;
   except
      on e:exception
      do begin
         showmessage(' Не могу присоединиться к базе данных ');
         self.close;
         end;
   end;
end;

procedure TfmMain.button_assortmentClick(Sender: TObject);
begin
if self.access.field_hdd_serial=self.access.field_hdd_must_by_serial
then fmassortment:=tfmassortment.create(self);
self.access.copy_to(fmassortment.access);
fmassortment.showmodal;
freeandnil(fmassortment);
end;

procedure TfmMain.button_peopleClick(Sender: TObject);
begin
fmpeople:=TfmPeople.create(self);
self.access.copy_to(fmpeople.access);
fmpeople.showmodal;
freeandnil(fmpeople);
end;

procedure TfmMain.button_pointsClick(Sender: TObject);
begin
fmpoints:=TfmPoints.create(self);
self.access.copy_to(fmpoints.access);
fmpoints.showmodal;
freeandnil(fmpoints);
end;

procedure TfmMain.button_commodity_to_mainClick(Sender: TObject);
begin
if self.access.field_hdd_serial=self.access.field_hdd_must_by_serial
then fmCommodity_to_main:=TfmCommodity_to_main.create(self);
self.access.copy_to(fmCommodity_to_main.access);

if fmDataModule.get_record_count_into_table('COMMODITY',fmDataModule.Query_temp)<85000
then fmCommodity_to_main.showmodal
else showmessage('Error table (primary key is fall) ');
freeandnil(fmCommodity_to_main);
end;

procedure TfmMain.button_commodity_transferClick(Sender: TObject);
begin
fmCommodity_transfer:=TfmCommodity_Transfer.create(self);
self.access.copy_to(fmCommodity_transfer.access);
if fmDataModule.get_record_count_into_table('COMMODITY',fmDataModule.Query_temp)<85000
then fmCommodity_transfer.showmodal
else showmessage('Error table (primary key is fall) ');
freeandnil(fmCommodity_Transfer);
end;

procedure TfmMain.button_points_saleClick(Sender: TObject);
begin
if self.access.field_hdd_serial=self.access.field_hdd_must_by_serial
then fmPoints_sale_preambule:=TfmPoints_sale_preambule.create(self);
self.access.copy_to(fmPoints_Sale_preambule.access);
//showmessage(floattostr(now));
if fmDataModule.get_record_count_into_table('COMMODITY',fmDataModule.Query_temp)<85000
then fmPoints_Sale_preambule.showmodal
else showmessage('Error table (primary key is fall) ');
end;

procedure TfmMain.button_dovidka_1Click(Sender: TObject);
begin
fmdovidka_1:=TfmDovidka_1.create(self);
fmDovidka_1.showmodal;
freeandnil(fmDovidka_1);
end;

procedure TfmMain.button_dovidka_2Click(Sender: TObject);
begin
fmdovidka_2:=TfmDovidka_2.create(self);
fmDovidka_2.showmodal;
freeandnil(fmDovidka_2);
end;

procedure TfmMain.button_expensesClick(Sender: TObject);
begin
fmExpenses:=TfmExpenses.create(self);
fmExpenses.showmodal;
freeandnil(fmExpenses);
end;

procedure TfmMain.button_points_sale_skipClick(Sender: TObject);
begin
fmpoints_sale_skip:=TfmPoints_Sale_Skip.create(self);
fmpoints_sale_skip.showmodal;
freeandnil(fmPoints_Sale_skip);
end;

procedure TfmMain.Button_Dovidka_3Click(Sender: TObject);
begin
fmDovidka_3:=TfmDovidka_3.create(self);
fmDovidka_3.showmodal;
freeandnil(fmDovidka_3);
end;

procedure TfmMain.Button_Dovidka_4Click(Sender: TObject);
begin
fmdovidka_4:=TfmDovidka_4.create(self);
fmDovidka_4.showmodal;
freeandnil(fmDovidka_4);
end;

procedure TfmMain.button_charge_offClick(Sender: TObject);
begin
fmCharge_off:=TfmCharge_off.create(self);
fmCharge_off.showmodal;
freeandnil(fmCharge_off);
end;

procedure TfmMain.button_dovidka_5Click(Sender: TObject);
begin
   fmDovidka_5:=TfmDovidka_5.create(self);
   fmDovidka_5.showmodal;
   freeandnil(fmDovidka_5);
end;

procedure TfmMain.button_dovidka_6Click(Sender: TObject);
begin
   fmDovidka_6:=TfmDovidka_6.create(self);
   fmDovidka_6.showmodal;
   freeandnil(fmDovidka_6);
end;

procedure TfmMain.Button_buyingClick(Sender: TObject);
begin
   fmBuying:=TfmBuying.create(self);
   fmBuying.showmodal;
   freeandnil(fmBuying);
end;

procedure TfmMain.button_dovidka_7Click(Sender: TObject);
begin
   fmDovidka_7:=TfmDovidka_7.create(self);
   fmDovidka_7.showmodal;
   freeandnil(fmDovidka_7);
end;

procedure TfmMain.button_dovidka_8Click(Sender: TObject);
begin
   fmDovidka_8:=TfmDovidka_8.create(self);
   fmDovidka_8.showmodal;
   freeandnil(fmDovidka_8);
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
   // берем серийный номер с диска 'C:\' для уникальной идентификации
   self.access.field_hdd_serial:=self.getHDDSerialNumber_integer('c:\');
   // номер, который должен быть для уникальной идентификации
   if self.use_universal_key
   then begin
        self.access.field_hdd_must_by_serial:=self.getHDDSerialNumber_integer('c:\')
        end
   else begin
        // уникальный номер HDD
        self.access.field_hdd_must_by_serial:=1888072095;
        end;
end;

procedure TfmMain.button_dovidka_1_2Click(Sender: TObject);
begin
fmdovidka_1_2:=TfmDovidka_1_2.create(self);
fmDovidka_1_2.showmodal;
freeandnil(fmDovidka_1_2);
end;

procedure TfmMain.button_dovidka_2_2Click(Sender: TObject);
begin
fmdovidka_2_2:=TfmDovidka_2_2.create(self);
fmDovidka_2_2.showmodal;
freeandnil(fmDovidka_2_2);

end;

procedure TfmMain.button_dovidka_7_2Click(Sender: TObject);
begin
fmdovidka_7_2:=TfmDovidka_7_2.create(self);
fmDovidka_7_2.showmodal;
freeandnil(fmDovidka_7_2);

end;

procedure TfmMain.button_dovidka_8_2Click(Sender: TObject);
begin
fmdovidka_8_2:=TfmDovidka_8_2.create(self);
fmDovidka_8_2.showmodal;
freeandnil(fmDovidka_8_2);

end;

procedure TfmMain.button_dovidka_3_2Click(Sender: TObject);
begin
fmdovidka_3_2:=TfmDovidka_3_2.create(self);
fmDovidka_3_2.showmodal;
freeandnil(fmDovidka_3_2);

end;

procedure TfmMain.button_dovidka_4_2Click(Sender: TObject);
begin
fmdovidka_4_2:=TfmDovidka_4_2.create(self);
fmDovidka_4_2.showmodal;
freeandnil(fmDovidka_4_2);
end;

procedure TfmMain.button_sell_from_storehouseClick(Sender: TObject);
begin
fmSell_from_StoreHouse:=TfmSell_from_StoreHouse.create(self);
fmSell_from_StoreHouse.showmodal;
freeandnil(fmSell_from_StoreHouse);
end;

procedure TfmMain.button_rediscountClick(Sender: TObject);
begin
   fmRediscount:=TfmRediscount.create(self);
   fmRediscount.field_path_to_rediscount:=self.field_rediscount_path;
   fmRediscount.showmodal;
   freeandnil(fmRediscount);
end;
// нужно ли контролировать действительность серийного номера HDD и Контрольной цифры
function TfmMain.use_universal_key: boolean;
var
   ini_file:Tinifile;
   return_value:boolean;
begin
   return_value:=false;
   ini_file:=Tinifile.Create(extractfilepath(paramstr(0))+'bags.ini');
   if ini_file.SectionExists('SYSTEM_DEBUG')
   then begin
        return_value:=true;
        end;
   result:=return_value;
end;

procedure TfmMain.button_getmailClick(Sender: TObject);
var
   inifile:Tinifile;
begin
   fmgetmail:=tfmgetmail.create(self);
   // передача параметров в файл
   fmgetmail.field_rediscount_path:=self.field_rediscount_path;
   fmgetmail.field_rediscount_max:=self.field_rediscount_max;
   fmgetmail.field_rediscount_name:=self.field_rediscount_name;
   fmgetmail.showmodal;
   // записать максимальное кол-во файлов по переучету в файл
   inifile:=Tinifile.Create(extractfilepath(paramstr(0))+'bags.ini');
   inifile.WriteInteger('SYSTEM','REDISCOUNT_MAX',fmgetmail.field_rediscount_max);
   inifile.UpdateFile;
   self.field_rediscount_max:=fmgetmail.field_rediscount_max;
   freeandnil(inifile);
   freeandnil(fmgetmail);
end;

procedure TfmMain.button_dovidka_1_3Click(Sender: TObject);
begin
   fmdovidka_1_3:=Tfmdovidka_1_3.create(self);
   fmdovidka_1_3.showmodal;
   freeAndNil(fmDovidka_1_3);
end;

procedure TfmMain.button_dovidka_2_3Click(Sender: TObject);
begin
   fmdovidka_2_3:=Tfmdovidka_2_3.create(self);
   fmdovidka_2_3.showmodal;
   freeAndNil(fmDovidka_2_3);
end;

procedure TfmMain.Button_dovidka_7_3Click(Sender: TObject);
begin
   fmdovidka_7_3:=Tfmdovidka_7_3.create(self);
   fmdovidka_7_3.showmodal;
   freeAndNil(fmDovidka_7_3);
end;

procedure TfmMain.Button_dovidka_8_3Click(Sender: TObject);
begin
   fmdovidka_8_3:=Tfmdovidka_8_3.create(self);
   fmdovidka_8_3.showmodal;
   freeAndNil(fmDovidka_8_3);
end;

procedure TfmMain.button_browser_dovidkaClick(Sender: TObject);
begin
   fmBrowser_dovidka:=TfmBrowser_dovidka.create(self);
   fmBrowser_dovidka.showmodal;
   freeAndNil(fmBrowser_dovidka);
end;

procedure TfmMain.button_get_comClick(Sender: TObject);
var
   inifile:Tinifile;
begin
   fmgetcom:=TfmGetCom.create(self);
   fmgetcom.field_rediscount_path:=self.field_rediscount_path;
   fmgetcom.field_rediscount_max:=self.field_rediscount_max;
   fmgetcom.field_rediscount_name:=self.field_rediscount_name;
   fmgetcom.field_ini_file_name:=extractfilepath(paramstr(0))+'bags.ini';
   fmgetcom.showmodal;
   inifile:=Tinifile.Create(extractfilepath(paramstr(0))+'bags.ini');
   inifile.WriteInteger('SYSTEM','REDISCOUNT_MAX',fmgetCom.field_rediscount_max);
   inifile.UpdateFile;
   self.field_rediscount_max:=fmgetcom.field_rediscount_max;
   freeandnil(inifile);
   freeandnil(fmgetcom);

end;

end.
