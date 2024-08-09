unit PayDesk;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxCntner, dxEditor, dxEdLib, ExtCtrls, Grids, DBGrids, Db,dataModule;

type
  TfmPayDesk = class(TForm)
    Panel1: TPanel;
    edit_point_name: TdxEdit;
    Edit_Date_sale: TdxEdit;
    Edit_seller_familiya: TdxEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit_kod: TdxEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit_seller_name: TdxEdit;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    dbgrid_commodity: TDBGrid;
    DBGrid_money: TDBGrid;
    DataSource_commodity: TDataSource;
    DataSource_money: TDataSource;
    button_add: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Label6: TLabel;
    Edit_commodity_suma: TdxMaskEdit;
    Label7: TLabel;
    Edit_money_suma: TdxEdit;
    edit_balance: TdxEdit;
    button_edit: TButton;
    button_delete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure button_addClick(Sender: TObject);
    procedure button_editClick(Sender: TObject);
    procedure button_deleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    point_kod:integer;
    date_cells:string;
    man_kod:integer;
    procedure create_query_text;
    procedure show_commodity;
    procedure show_money;
    procedure show_balance;
  end;

var
  fmPayDesk: TfmPayDesk;

implementation

uses PayDesk_Edit;

{$R *.DFM}

{ TfmPayDesk }

procedure TfmPayDesk.show_commodity;
begin
   fmDataModule.query_PayDesk_commodity.ParamByName('POINT_KOD').asinteger:=self.point_kod;
   fmDataModule.query_PayDesk_commodity.ParamByName('DATE_SELLS').asstring:=self.date_cells;
   fmDataModule.query_PayDesk_commodity.ParamByName('MAN_KOD').asinteger:=self.man_kod;
   fmDataModule.query_PayDesk_commodity.Open;
   self.Edit_commodity_suma.text:=format('%.2f',[fmDataModule.calculate_sum_from_query_from_field(fmDataModule.query_PayDesk_commodity,'SUMA')]);
end;

procedure TfmPayDesk.show_money;
begin
   fmDataModule.Query_PayDesk_Money.ParamByName('POINT_KOD').asinteger:=self.point_kod;
   fmDataModule.Query_PayDesk_Money.ParamByName('DATE_SELLS').asstring:=self.date_cells;
   fmDataModule.Query_PayDesk_Money.ParamByName('MAN_KOD').asinteger:=self.man_kod;
   fmDataModule.Query_PayDesk_Money.open;
   self.Edit_money_suma.text:=format('%.2f',[fmDataModule.calculate_sum_from_query_from_field(fmDataModule.query_PayDesk_Money,'AMOUNT')]);
end;

procedure TfmPayDesk.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
   create_query_text;
end;

procedure TfmPayDesk.create_query_text;
begin
   fmDataModule.query_PayDesk_commodity.SQL.clear;
   fmDataModule.query_PayDesk_commodity.SQL.add('SELECT  COMMODITY.ASSORTMENT_KOD,');
   fmDataModule.query_PayDesk_commodity.SQL.add('        ASSORTMENT.NAME,');
   fmDataModule.query_PayDesk_commodity.SQL.add('        SUM(COMMODITY.QUANTITY)*(-1) QUANTITY,');
   fmDataModule.query_PayDesk_commodity.SQL.add('        ASSORTMENT.PRICE PRICE,');
   fmDataModule.query_PayDesk_commodity.SQL.add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE*(-1) SUMA');
   fmDataModule.query_PayDesk_commodity.SQL.add('FROM COMMODITY');
   fmDataModule.query_PayDesk_commodity.SQL.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
   fmDataModule.query_PayDesk_commodity.SQL.add('WHERE 1=1');
   fmDataModule.query_PayDesk_commodity.SQL.add('AND COMMODITY.operation_kod=1');
   fmDataModule.query_PayDesk_commodity.SQL.add('AND COMMODITY.POINT_KOD=:POINT_KOD');
   fmDataModule.query_PayDesk_commodity.SQL.add('AND COMMODITY.date_in_out =:DATE_SELLS');
   fmDataModule.query_PayDesk_commodity.SQL.add('AND COMMODITY.man_kod=:MAN_KOD');
   fmDataModule.query_PayDesk_commodity.SQL.add('GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRICE');
   fmDataModule.query_PayDesk_commodity.SQL.add('HAVING SUM(COMMODITY.QUANTITY)<>0');
   fmDataModule.query_PayDesk_commodity.SQL.add('ORDER BY COMMODITY.ASSORTMENT_KOD');

   fmDataModule.query_PayDesk_money.sql.clear;
   fmDataModule.query_PayDesk_money.sql.add('SELECT');
   fmDataModule.query_PayDesk_money.sql.add('        MONEY.KOD,');
   fmDataModule.query_PayDesk_money.sql.add('        EXPENSES.NAME,');
   fmDataModule.query_PayDesk_money.sql.add('        EXPENSES.KOD EXPENSES_KOD,');
   fmDataModule.query_PayDesk_money.sql.add('        MONEY.NOTE,');
   fmDataModule.query_PayDesk_money.sql.add('        MONEY.AMOUNT*EXPENSES.SIGN AMOUNT');
   fmDataModule.query_PayDesk_money.sql.add('FROM MONEY');
   fmDataModule.query_PayDesk_money.sql.add('--INNER JOIN POINTS ON POINTS.KOD=MONEY.KOD_POINT');
   fmDataModule.query_PayDesk_money.sql.add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
   fmDataModule.query_PayDesk_money.sql.add('--INNER JOIN PEOPLE PEOPLE_SELLER ON PEOPLE_SELLER.KOD=MONEY.KOD_MAN');
   fmDataModule.query_PayDesk_money.sql.add('--LEFT JOIN PEOPLE PEOPLE_WRITER ON PEOPLE_WRITER.KOD=MONEY.KOD_WRITER');
   fmDataModule.query_PayDesk_money.sql.add('WHERE');
   fmDataModule.query_PayDesk_money.sql.add('    MONEY.KOD_POINT=:POINT_KOD');
   fmDataModule.query_PayDesk_money.sql.add('AND MONEY.KOD_MAN=:MAN_KOD');
   fmDataModule.query_PayDesk_money.sql.add('AND MONEY.DATE_IN_OUT=:DATE_SELLS');
end;

procedure TfmPayDesk.FormShow(Sender: TObject);
begin
   self.show_commodity;
   self.show_money;
   self.show_balance;
end;

procedure TfmPayDesk.button_addClick(Sender: TObject);
var
   money:dataModule.TMoney;
   temp_string:string;
begin
   fmPayDesk_Edit:=TfmPayDesk_Edit.create(self);
   fmPayDesk_Edit.edit_point.text:=self.edit_point_name.Text;
   fmPayDesk_Edit.Edit_kod_man.text:=self.Edit_kod.text;
   fmPayDesk_Edit.Edit_Date_in_out.text:=self.Edit_Date_sale.text;
   if fmPayDesk_Edit.showmodal=mrOk
   then begin
        // сохранение введенных измененеий
        money:=dataModule.TMoney.Create;
        money.field_kod_point:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.edit_point_name.text+chr(39),'KOD');
        money.field_kod_expenses:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'EXPENSES','NAME',chr(39)+fmPayDesk_Edit.combobox_expenses.text+chr(39),'KOD');
        money.field_amount:=format('%.2f',[strtofloat(fmPayDesk_edit.Edit_Amount.text)]);
        money.field_kod_man:=self.Edit_kod.text;
        money.field_kod_writer:='1';
        money.field_date_writer:=datetimetostr(now);
        money.field_date_in_out:=self.Edit_Date_sale.text;
        money.field_note:=fmPayDesk_edit.edit_note.text;
        temp_string:=money.save(fmDataModule.Query_temp);
        if temp_string=''
        then begin
             //fmDataModule.Transaction_main.active:=false;
             //fmDataModule.Transaction_main.active:=true;
             if money.field_kod_expenses='2'// нужно начислить з/п
             then begin
                  money.field_kod:='';
                  money.field_amount:=floattostr((strtofloat(money.field_amount)*(-0.07)));
                  money.field_kod_expenses:='7';
                  money.field_note:='';
                  temp_string:=money.save(fmDataModule.query_temp);
                  if temp_string<>''
                  then showmessage('Ошибка сохранения З/П');
                  end;
             self.show_commodity;
             self.show_money;
             self.show_balance;
             end
        else begin
             showmessage(' Ошибка сохранения данных '+chr(13)+chr(10)+temp_string);
             end;
        freeandnil(money);
        end
   else begin
        // отказ от сохранений
        end;
   freeandnil(fmPayDesk_Edit);
end;

procedure TfmPayDesk.button_editClick(Sender: TObject);
var
   money:dataModule.TMoney;
   temp_string:string;
begin
   fmPayDesk_Edit:=TfmPayDesk_Edit.create(self);

   money:=dataModule.TMoney.Create;
   money.load_by_kod(self.DBGrid_money.datasource.dataset.fieldbyname('KOD').asstring,fmDataModule.query_temp);
   fmPayDesk_Edit.edit_point.text:=self.edit_point_name.Text;
   fmPayDesk_Edit.Edit_kod_man.text:=self.Edit_kod.text;
   fmPayDesk_Edit.Edit_Date_in_out.text:=self.Edit_Date_sale.text;
   fmPayDesk_edit.Edit_Amount.text:=money.field_amount;
   fmPayDesk_edit.combobox_expenses.itemindex:=fmPayDesk_edit.combobox_expenses.Items.IndexOf(fmDataModule.get_name_by_id(fmDataModule.Query_temp,'EXPENSES','KOD',money.field_kod_expenses,'NAME'));
   fmPayDesk_edit.edit_note.text:=money.field_note;
   if fmPayDesk_Edit.showmodal=mrOk
   then begin
        // сохранение введенных измененеий
        money.field_kod_point:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.edit_point_name.text+chr(39),'KOD');
        money.field_kod_expenses:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'EXPENSES','NAME',chr(39)+fmPayDesk_Edit.combobox_expenses.text+chr(39),'KOD');
        money.field_amount:=fmPayDesk_edit.Edit_Amount.text;
        money.field_kod_man:=self.Edit_kod.text;
        money.field_kod_writer:='1';
        money.field_date_writer:=datetimetostr(now);
        money.field_date_in_out:=self.Edit_Date_sale.text;
        money.field_note:=fmPayDesk_edit.edit_note.text;
        temp_string:=money.save(fmDataModule.Query_temp);
        if temp_string=''
        then begin
             //fmDataModule.Transaction_main.active:=false;
             //fmDataModule.Transaction_main.active:=true;
             self.show_commodity;
             self.show_money;
             self.show_balance;
             end
        else begin
             showmessage(' Ошибка сохранения данных '+chr(13)+chr(10)+temp_string);
             end;
        end
   else begin
        // отказ от сохранений
        end;
   freeandnil(money);
   freeandnil(fmPayDesk_Edit);
end;

procedure TfmPayDesk.button_deleteClick(Sender: TObject);
var
   money:dataModule.TMoney;
begin
   money:=dataModule.TMoney.create;
   money.delete_by_kod(self.DBGrid_money.datasource.dataset.fieldbyname('KOD').asstring,fmDataModule.Query_temp);
   freeandnil(money);
   //fmDataModule.Transaction_main.active:=false;
   //fmDataModule.Transaction_main.active:=true;
   self.show_commodity;
   self.show_money;
   self.show_balance;
end;

procedure TfmPayDesk.show_balance;
var
   suma:real;
begin
   suma:=0;
   self.DBGrid_money.DataSource.dataset.First;
   while not(self.DBGrid_money.DataSource.dataset.Eof)
   do begin
      if self.DBGrid_money.DataSource.dataset.fieldbyname('EXPENSES_KOD').asinteger in [1,2,4,5,6,8]
      then suma:=suma+self.DBGrid_money.DataSource.dataset.fieldbyname('AMOUNT').asfloat;
      self.DBGrid_money.DataSource.dataset.Next;
      end;
   self.edit_balance.text:=format('%.2f',[suma]);
end;

end.
