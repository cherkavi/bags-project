unit Buying;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, dxExEdtr, dxEdLib, dxCntner, dxEditor, Grids, DBGrids,
  ExtCtrls,dataModule,IBQuery, Menus;

type
  TfmBuying = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    combobox_expenses: TComboBox;
    edit_amount: TdxCalcEdit;
    combobox_people: TComboBox;
    edit_date: TdxDateEdit;
    edit_note: TEdit;
    button_add: TButton;
    button_delete: TButton;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure button_deleteClick(Sender: TObject);
    procedure button_addClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure combobox_peopleChange(Sender: TObject);
    procedure edit_dateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    procedure show_data(people_kod,date_in_out:string;query:TIBQuery);
    procedure load_startup_data;
    function get_people_code_from_combobox:string;
  end;

var
  fmBuying: TfmBuying;

implementation

{$R *.DFM}

{ TfmBuying }

procedure TfmBuying.load_startup_data;
begin
   fmDataModule.load_to_combobox_from_table_from_field(fmDataModule.query_temp,self.combobox_expenses,'EXPENSES','NAME','','KOD');
   fmDataModule.load_to_combobox_from_table_from_fields(fmDataModule.query_temp,self.combobox_people,'PEOPLE',['KOD','FAMILIYA','IMYA'],' ','','KOD');
   self.edit_date.date:=date;
   self.edit_note.text:='';
end;

procedure TfmBuying.show_data(people_kod,date_in_out: string; query: TIBQuery);
begin
if (people_kod<>'') and (date_in_out<>'')
then begin
     query.sql.Clear;
     query.sql.Add('SELECT MONEY.DATE_IN_OUT,');
     query.sql.Add('       SELLER.FAMILIYA,');
     query.sql.Add('       SELLER.IMYA,');
     query.sql.Add('       EXPENSES.NAME EXPENSES_NAME,');
     query.sql.Add('       MONEY.AMOUNT,');
     query.sql.Add('       MONEY.KOD,');
     query.sql.Add('       MONEY.NOTE');
     query.sql.Add('FROM MONEY');
     query.sql.Add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
     query.sql.Add('INNER JOIN PEOPLE SELLER ON SELLER.KOD=MONEY.KOD_MAN AND SELLER.KOD='+people_kod);
     query.sql.Add('WHERE MONEY.DATE_IN_OUT = '+chr(39)+date_in_out+chr(39));
     query.sql.Add('AND MONEY.KOD_EXPENSES IN (1,2,3,4,5,6,7,8,9,10,12)');
     query.sql.Add('AND MONEY.KOD_POINT IS NULL');
     query.sql.Add('ORDER BY MONEY.DATE_IN_OUT,');
     query.sql.Add('       SELLER.FAMILIYA,');
     query.sql.Add('       MONEY.AMOUNT DESC');
     query.open;
     end
else begin
     // не выбран работник или дата
     query.close;
     end;
end;

procedure TfmBuying.button_deleteClick(Sender: TObject);
var
   money_record:DataModule.TMoney;
   temp_string:string;
begin
   if self.DBGrid1.datasource.dataset.fieldbyname('KOD').asstring<>''
   then begin
        money_record:=DataModule.Tmoney.create;
        temp_string:=money_record.delete_by_kod(self.DBGrid1.datasource.dataset.fieldbyname('KOD').asstring,fmDataModule.query_temp);
        if temp_string<>''
        then begin
             showmessage('Ошибка удаления данных '+chr(13)+chr(10)+temp_string);
             end
        else begin
             end;
        freeandnil(money_record);
        self.show_data(self.get_people_code_from_combobox,self.edit_date.text,fmDataModule.Query_Buying);
        end;
end;

procedure TfmBuying.button_addClick(Sender: TObject);
var
   money_record:dataModule.TMoney;
   temp_float:real;
   temp_string:string;
begin
   try
      if self.combobox_expenses.text=''
      then raise Exception.create('Выберите пожалуйста статью расходов');
      if self.combobox_people.text=''
      then raise Exception.create('Выберите пожалуйста работника');
      if self.edit_date.text=''
      then raise Exception.create('Задайте дату операции');
      try
         temp_float:=strtofloat(self.edit_amount.text);
      except
         raise Exception.create('Введите числовое значение для поля "Сумма"');
      end;
      if temp_float<0
      then raise Exception.create('Введите положительное число для поля "Сумма"');
      money_record:=dataModule.TMoney.create;
      money_record.clear;
      money_record.field_kod_expenses:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'EXPENSES','NAME',chr(39)+self.combobox_expenses.text+chr(39),'KOD');;
      money_record.field_amount:=self.edit_amount.text;
      money_record.field_kod_man:=self.get_people_code_from_combobox;
      money_record.field_kod_writer:='1';
      money_record.field_date_writer:=datetimetostr(now);
      money_record.field_date_in_out:=self.edit_date.text;
      money_record.field_note:=self.edit_note.text;
      temp_string:=money_record.save(fmDataModule.query_temp);
      if temp_string<>''
      then begin
           showmessage('Ошибка добавления данных '+chr(13)+chr(10)+temp_string);
           end
      else begin
           //self.combobox_expenses.itemindex:=-1;
           //self.combobox_people.itemindex:=-1;
           self.edit_amount.text:='0';
           self.edit_note.text:='';
           end;
      freeandnil(money_record);
      self.show_data(self.get_people_code_from_combobox,self.edit_date.text,fmDataModule.Query_Buying);
   except
      on e:Exception
      do begin
         showmessage(e.message);
         end;
   end;
end;

procedure TfmBuying.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
   self.load_startup_data;
   self.show_data(self.get_people_code_from_combobox,self.edit_date.text,fmdataModule.query_buying);
end;

procedure TfmBuying.N1Click(Sender: TObject);
begin
   self.button_delete.Click;
end;

procedure TfmBuying.FormShow(Sender: TObject);
begin
   self.DBGrid1.DataSource.DataSet.close;
end;

function TfmBuying.get_people_code_from_combobox: string;
var
   position:integer;
   return_string:string;
begin
   position:=0;
   return_string:='';
   if self.combobox_people.text<>''
   then begin
        position:=pos(' ',self.combobox_people.text);
        if position>0
        then begin
             return_string:=copy(self.combobox_people.text,1,position-1);
             end
        else begin
             // не могу расшифровать строку
             end;
        end
   else begin
        // не выбран работник
        end;
   result:=return_string;
end;

procedure TfmBuying.combobox_peopleChange(Sender: TObject);
begin
   self.show_data(self.get_people_code_from_combobox,self.edit_date.text,fmdataModule.query_buying);
end;

procedure TfmBuying.edit_dateChange(Sender: TObject);
begin
   self.show_data(self.get_people_code_from_combobox,self.edit_date.text,fmdataModule.query_buying);
end;

end.
