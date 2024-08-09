unit Sell_from_Storehouse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, Db, Grids, DBGrids,
  ExtCtrls,datamodule,IBQuery,ClipBrd;

type
  TfmSell_from_Storehouse = class(TForm)
    GroupBox_storehouse: TGroupBox;
    Splitter1: TSplitter;
    GroupBox_sell_commodity: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid_storehouse: TDBGrid;
    DBGrid_sell_commodity: TDBGrid;
    DataSource_storehouse: TDataSource;
    DataSource_sell_commodity: TDataSource;
    ComboBox_points: TComboBox;
    Label1: TLabel;
    Edit_date_storehouse: TdxDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    edit_filter_storehouse_name: TEdit;
    edit_filter_sell_commodity: TEdit;
    Label4: TLabel;
    CheckBox_in_step: TCheckBox;
    button_sell: TButton;
    button_sell_skip: TButton;
    procedure ComboBox_pointsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edit_filter_storehouse_nameChange(Sender: TObject);
    procedure CheckBox_in_stepClick(Sender: TObject);
    procedure button_sell_skipClick(Sender: TObject);
    procedure button_sellClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:DataModule.TAccess;
    storehouse_kod:string;
    procedure load_startup_data;
    procedure show_storehouse(query:TIBQuery;filter_name:string='');
    procedure show_commodity(query:TIBQuery;filter_name:string='');
    procedure set_filter(edit_up,edit_down:TEdit;Sender:TObject;step_in:boolean);
  end;

var
  fmSell_from_Storehouse: TfmSell_from_Storehouse;

implementation

uses Sell_from_Storehouse_transaction;

{$R *.DFM}

{ TfmSell_from_Storehouse }

procedure TfmSell_from_Storehouse.load_startup_data;
begin
   access:=DataModule.TAccess.create;
   fmDataModule.load_to_combobox_from_table_from_field(fmDataModule.query_temp,self.ComboBox_points,'POINTS','NAME','KOD<=2','KOD');
   self.ComboBox_points.itemindex:=0;
   self.storehouse_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.ComboBox_points.text+chr(39),'KOD');
   self.Edit_date_storehouse.date:=Date;
   fmdatamodule.Query_transfer_source.sql.clear;
   fmdatamodule.Query_transfer_destination.sql.clear;
   // show data
   show_storehouse(fmDataModule.Query_transfer_source,'');
   show_commodity(fmDataModule.Query_transfer_destination,'');
end;

procedure TfmSell_from_Storehouse.show_storehouse(query: TIBQuery;
  filter_name: string='');
var
   control_sql_values:DataModule.TControl_sql_values;
begin
   query.sql.clear;
   query.sql.Add('SELECT');
   query.sql.Add('        ASSORTMENT.KOD ASSORTMENT_KOD,');
   query.sql.Add('        ASSORTMENT.NAME ASSORTMENT_NAME,');
   query.sql.Add('        SUM(COMMODITY.QUANTITY) QUANTITY,');
   query.sql.Add('        ASSORTMENT.PRICE PRICE,');
   query.sql.Add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA,');
   query.sql.Add('        ASSORTMENT.PRICE_BUYING PRICE_BUYING,');
   query.sql.Add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE_BUYING SUMA_BUYING');
   query.sql.Add('FROM COMMODITY');
   query.sql.Add('INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD AND POINTS.KOD='+self.storehouse_kod);
   query.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
   query.sql.Add('WHERE  1=1');
   if trim(filter_name)<>''
   then begin
        control_sql_values:=DataModule.TControl_sql_values.Create;
        query.sql.add('AND ASSORTMENT.NAME LIKE '+control_sql_values.check(chr(39)+'%'+filter_name+'%'+chr(39)));
        freeandnil(control_sql_values);
        end;
   query.sql.Add('AND COMMODITY.DATE_IN_OUT <='+chr(39)+self.Edit_date_storehouse.text+chr(39));
   query.sql.Add('GROUP BY');
   query.sql.Add('        ASSORTMENT.KOD,');
   query.sql.Add('        ASSORTMENT.NAME,');
   query.sql.Add('        ASSORTMENT.PRICE,');
   query.sql.Add('        ASSORTMENT.PRICE_BUYING');
   query.sql.Add('HAVING SUM(COMMODITY.QUANTITY)>0');
   query.sql.Add('ORDER BY ASSORTMENT.PRICE');

   try
      query.open;
   except
      on e:exception
      do begin
         showmessage('Ќарушено соединение с базой данных');
         clipboard.astext:=e.message+chr(13)+chr(10)+query.sql.text;
         end;
   end;
end;

procedure TfmSell_from_Storehouse.show_commodity(query: TIBQuery;
  filter_name: string='');
var
   control_sql_values:DataModule.TControl_sql_values;

begin
   query.sql.clear;
   query.sql.Add('SELECT');
   query.sql.Add('       ASSORTMENT.KOD ASSORTMENT_KOD,');
   query.sql.Add('       COMMODITY.KOD COMMODITY_KOD,');
   query.sql.Add('       MONEY.KOD MONEY_KOD,');
   query.sql.Add('       ASSORTMENT.NAME ASSORTMENT_NAME,');
   query.sql.Add('       MONEY.AMOUNT MONEY_AMOUNT,');
   query.sql.Add('       WRITER.FAMILIYA WRITER_FAMILIYA,');
   query.sql.Add('       MONEY.DATE_WRITE MONEY_DATE_WRITE,');
   query.sql.Add('       ASSORTMENT.PRICE ASSORTMENT_PRICE,');
   query.sql.Add('       ASSORTMENT.PRICE_BUYING ASSORTMENT_PRICE_BUYING,');
   query.sql.Add('       MONEY.NOTE NOTE');
   query.sql.Add('FROM COMMODITY');
   query.sql.Add('INNER JOIN MONEY ON MONEY.DATE_IN_OUT=COMMODITY.DATE_IN_OUT');
   query.sql.Add('                AND MONEY.DATE_WRITE=COMMODITY.WRITE_DATE');
   query.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD');
   if trim(filter_name)<>''
   then begin
        control_sql_values:=DataModule.TControl_sql_values.Create;
        query.sql.add('AND ASSORTMENT.NAME LIKE '+control_sql_values.check(chr(39)+'%'+filter_name+'%'+chr(39)));
        freeandnil(control_sql_values);
        end;
   query.sql.Add('INNER JOIN PEOPLE WRITER ON WRITER.KOD=COMMODITY.WRITER');
   query.sql.Add('WHERE COMMODITY.OPERATION_KOD=6');
   query.sql.Add('  AND COMMODITY.DATE_IN_OUT='+chr(39)+self.Edit_date_storehouse.text+chr(39));
   query.sql.Add('  AND COMMODITY.POINT_KOD='+self.storehouse_kod);
   query.sql.Add('ORDER BY ASSORTMENT.PRICE,ASSORTMENT.NAME');

   try
      //clipboard.astext:=query.sql.text;
      query.open;
   except
      on e:exception
      do begin
         showmessage('Ќарушено соединение с базой данных');
         clipboard.astext:=e.message+chr(13)+chr(10)+query.sql.text;
         end;
   end;
end;

procedure TfmSell_from_Storehouse.ComboBox_pointsChange(Sender: TObject);
begin
   self.storehouse_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.ComboBox_points.text+chr(39),'KOD');
   self.set_filter(self.edit_filter_storehouse_name,self.edit_filter_sell_commodity,self.edit_filter_storehouse_name,self.CheckBox_in_step.Checked);
end;

procedure TfmSell_from_Storehouse.FormCreate(Sender: TObject);
begin
   self.load_startup_data;
end;

procedure TfmSell_from_Storehouse.set_filter(edit_up, edit_down: TEdit;
  Sender: TObject; step_in: boolean);
var
   color_filter_set,color_filter_unset:TColor;
begin
   color_filter_set:=clRed;
   color_filter_unset:=clWindow;
   if Sender is TEdit
   then begin
        if trim(TEdit(Sender).text)<>''
        then begin
             // edit UP ?
             if TEdit(Sender)=edit_up
             then begin
                  // set filter UP
                  show_storehouse(fmDataModule.Query_transfer_source,edit_up.text);
                  edit_up.color:=color_filter_set;
                  // step in?
                  if step_in=true
                  then begin
                       edit_down.text:=edit_up.text;
                       edit_down.color:=color_filter_set;
                       // set filter DOWN
                       show_commodity(fmDataModule.Query_transfer_destination,edit_down.text);
                       end;
                  end;
             // Edit Down ?
             if TEdit(Sender)=edit_down
             then begin
                  // set filter DOWN
                  show_commodity(fmDataModule.Query_transfer_destination,edit_down.text);
                  edit_down.color:=color_filter_set;
                  // step in?
                  if step_in=true
                  then begin
                       edit_up.text:=edit_down.text;
                       edit_up.color:=color_filter_set;
                       // set filter UP
                       show_storehouse(fmDataModule.Query_transfer_source,edit_up.text);
                       end;
                  end;
             end
        else begin
             // skip filter UP ?
             if TEdit(Sender)=edit_up
             then begin
                  edit_up.color:=color_filter_unset;
                  // skip filter UP
                  show_storehouse(fmDataModule.Query_transfer_source,'');
                  show_commodity(fmDataModule.Query_transfer_destination,'');
                  // step in ?
                  if step_in=true
                  then begin
                       edit_down.color:=color_filter_unset;
                       edit_down.text:='';
                       // skip filter DOWN
                       show_commodity(fmDataModule.Query_transfer_destination,'');
                       end;
                  end;
             // skip filter DOWN ?
             if TEdit(Sender)=edit_down
             then begin
                  edit_down.color:=color_filter_unset;
                  // skip filter DOWN
                  show_commodity(fmDataModule.Query_transfer_destination,'');
                  // step in ?
                  if step_in=true
                  then begin
                       edit_up.color:=color_filter_unset;
                       edit_up.text:='';
                       // skip filter UP
                       show_storehouse(fmDataModule.Query_transfer_source,'');
                       end;
                  end;
             end;
        end;
   if Sender is TCheckBox
   then begin
        if TCheckBox(Sender).Checked=true
        then begin
             if trim(edit_up.text)=''
             then begin
                  edit_up.text:=edit_down.text;
                  if trim(edit_down.text)=''
                  then begin
                       edit_down.color:=color_filter_unset;
                       edit_up.color:=color_filter_unset;
                       show_storehouse(fmDataModule.Query_transfer_source,'');
                       show_commodity(fmDataModule.Query_transfer_destination,'');
                       end
                  else begin
                       edit_down.color:=color_filter_set;
                       edit_up.color:=color_filter_set;
                       show_storehouse(fmDataModule.Query_transfer_source,edit_up.text);
                       show_commodity(fmDataModule.Query_transfer_destination,edit_down.text);
                       end;
                  end
             else begin
                  edit_down.text:=edit_up.text;
                  edit_down.color:=color_filter_set;
                  edit_up.color:=color_filter_set;

                  show_storehouse(fmDataModule.Query_transfer_source,edit_up.text);
                  show_commodity(fmDataModule.Query_transfer_destination,edit_down.text);
                  end;
             end
        else begin
             // removing flag IN_STEP
             edit_down.text:='';
             edit_down.color:=color_filter_unset;
             show_commodity(fmDataModule.Query_transfer_destination,'');
             end;
        end;
end;

procedure TfmSell_from_Storehouse.edit_filter_storehouse_nameChange(
  Sender: TObject);
begin
   self.set_filter(self.edit_filter_storehouse_name,self.edit_filter_sell_commodity,sender,self.CheckBox_in_step.Checked);
end;

procedure TfmSell_from_Storehouse.CheckBox_in_stepClick(Sender: TObject);
begin
     self.set_filter(self.edit_filter_storehouse_name,self.edit_filter_sell_commodity,sender,self.CheckBox_in_step.Checked);
end;

procedure TfmSell_from_Storehouse.button_sell_skipClick(Sender: TObject);
var
   money:DataModule.TMoney;
   commodity:Datamodule.TCommodity;
   temp_string:string;
begin
   if self.DBGrid_sell_commodity.DataSource.dataset.FieldByName('MONEY_KOD').asstring<>''
   then begin
        if messagedlg('¬ы уверены в отмене продажи',mtConfirmation,mbOKCancel,0)=mrOK
        then begin
             money:=DataModule.TMoney.create;
             commodity:=dataModule.TCommodity.create;
             money.load_by_kod(self.DBGrid_sell_commodity.DataSource.dataset.FieldByName('MONEY_KOD').asstring,fmDataModule.query_temp);
             try
                fmDataModule.query_temp.sql.clear;
                fmDataModule.query_temp.sql.Add('SELECT COMMODITY.KOD KOD FROM COMMODITY');
                fmDataModule.query_temp.sql.add('WHERE COMMODITY.POINT_KOD='+money.field_kod_point);
                fmDataModule.query_temp.sql.add(' AND COMMODITY.DATE_IN_OUT='+chr(39)+money.field_date_in_out+chr(39));
                fmDataModule.query_temp.sql.add(' AND COMMODITY.WRITE_DATE='+chr(39)+money.field_date_writer+chr(39));
                fmDataModule.query_temp.sql.add(' AND COMMODITY.QUANTITY=-'+money.field_note);
                fmDataModule.query_temp.Open;
                if fmDataModule.query_temp.recordcount>0
                then begin
                     temp_string:=fmDataModule.Query_temp.fieldbyname('KOD').asstring;
                     temp_string:=commodity.delete_by_kod(temp_string,fmDataModule.query_temp);
                     if temp_string<>''
                     then begin
                          // удаление не прошло
                          showmessage('ќшибка удалени€ данных');
                          clipboard.astext:='COMMODITY.SAVE_TO_DATEBASE ERROR'+chr(13)+chr(10)+temp_string;
                          end
                     else begin
                          temp_string:=money.delete_by_kod(money.field_kod,fmDataModule.query_temp);
                          if temp_string<>''
                          then begin
                               // удаление не прошло
                               showmessage('ќшибка удалени€ данных, обратитесь к разработчику');
                               clipboard.astext:='MONEY.SAVE_TO_DATEBASE ERROR'+chr(13)+chr(10)+temp_string;
                               end
                          else begin
                               // удаление прошло успешно
                               end;
                          end;
                     end
                else begin
                     showmessage('ƒанные не могу быть удалены');
                     end;
             except
                showmessage('ќшибка удалени€ данных');
             end;

             self.set_filter(self.edit_filter_storehouse_name,self.edit_filter_sell_commodity,self.edit_filter_storehouse_name,self.CheckBox_in_step.Checked);
             freeandnil(Commodity);
             freeandnil(money);
             end
        else begin

             end;
        end;
end;

procedure TfmSell_from_Storehouse.button_sellClick(Sender: TObject);
var
   commodity:datamodule.TCommodity;
   money:datamodule.TMoney;
   write_datetime:string;
   temp_string:string;
   current_kod,prior_current_kod:string;
begin
current_kod:=self.DBGrid_storehouse.DataSource.dataset.FieldByName('ASSORTMENT_KOD').asstring;
self.DBGrid_storehouse.DataSource.dataset.prior;
prior_current_kod:=self.DBGrid_storehouse.DataSource.dataset.FieldByName('ASSORTMENT_KOD').asstring;
self.DBGrid_storehouse.DataSource.dataset.next;
if self.DBGrid_storehouse.DataSource.dataset.FieldByName('ASSORTMENT_KOD').asstring<>''
then begin
     fmSell_from_storehouse_transaction:=tfmSell_from_storehouse_transaction.create(self);
     commodity:=dataModule.TCommodity.create;
     money:=dataModule.TMoney.create;
     fmSell_from_storehouse_transaction.edit_name.text:=self.DBGrid_storehouse.DataSource.dataset.FieldByName('ASSORTMENT_NAME').asstring;
     fmSell_from_storehouse_transaction.Edit_price.text:=self.DBGrid_storehouse.DataSource.dataset.FieldByName('PRICE').asstring;
     fmSell_from_storehouse_transaction.Edit_summa_price.text:='';
     fmSell_from_storehouse_transaction.Edit_price_buying.text:=self.DBGrid_storehouse.DataSource.dataset.FieldByName('PRICE_BUYING').asstring;
     fmSell_from_storehouse_transaction.Edit_summa_price.text:='';
     fmSell_from_storehouse_transaction.Edit_summa_buying.text:='';
     fmSell_from_storehouse_transaction.Edit_price_balance.text:='';
     fmSell_from_storehouse_transaction.Edit_price_buying_balance.text:='';

     fmSell_from_storehouse_transaction.Edit_price_current.text:=self.DBGrid_storehouse.DataSource.dataset.FieldByName('PRICE').asstring;
     fmSell_from_storehouse_transaction.Edit_summa_current.text:='';

     fmSell_from_storehouse_transaction.Edit_quantity_current.MaxValue:=self.DBGrid_storehouse.DataSource.dataset.FieldByName('QUANTITY').asinteger;
     fmSell_from_storehouse_transaction.Edit_quantity_current.MinValue:=1;

     fmSell_from_storehouse_transaction.Edit_quantity_current.value:=1;
     fmSell_from_storehouse_transaction.Edit_price_current.text:=self.DBGrid_storehouse.DataSource.dataset.FieldByName('PRICE').asstring;
     fmSell_from_storehouse_transaction.Edit_summa_current.text:=self.DBGrid_storehouse.DataSource.dataset.FieldByName('PRICE').asstring;
     fmSell_from_storehouse_transaction.set_values;
     if fmSell_from_storehouse_transaction.showmodal=mrOk
     then begin
          write_datetime:=datetimetostr(now);
          // списываем товар с точки
          commodity.field_assortment_kod:=self.DBGrid_storehouse.datasource.dataset.fieldbyname('ASSORTMENT_KOD').asstring;
          commodity.field_date_in_out:=self.Edit_date_storehouse.text;
          commodity.field_man_kod:='1';// код продавшего access.man_kod
          commodity.field_note:='';
          commodity.field_operation_kod:='6';// продажа товара со склада
          commodity.field_point_kod:=self.storehouse_kod;
          commodity.field_quantity:='-'+fmSell_from_storehouse_transaction.Edit_quantity_current.text;
          commodity.field_writer:='1';// код записавшего access.man_kod
          commodity.field_write_date:=write_datetime;
          // записываем приход денег
          temp_string:=commodity.save(fmDataModule.query_temp);
          if temp_string<>''
          then begin
               showmessage('”тер€но соединение с базой');
               clipboard.astext:='Commodity.save_to_database ERROR'+chr(13)+chr(10)+temp_string;
               end
          else begin
               money.field_kod_point:=self.storehouse_kod;
               money.field_kod_expenses:='2';// выручка в кассу
               money.field_amount:=fmSell_from_storehouse_transaction.Edit_summa_current.text;
               money.field_kod_man:='1';// код продавшего access.man_kod
               money.field_kod_writer:='1';// код продавшего access.man_kod
               money.field_date_writer:=write_datetime;
               money.field_date_in_out:=self.Edit_date_storehouse.text;
               money.field_note:=fmSell_from_storehouse_transaction.Edit_quantity_current.text;// вводим кол-во продаваемого товара
               temp_string:=money.save(fmdatamodule.query_temp);
               if temp_string<>''
               then begin
                    showmessage('”тер€но соединение с базой - критическа€ ошибка, обратитесь к разработчику');
                    clipboard.astext:='Money.save_to_database ERROR'+chr(13)+chr(10)+temp_string;
                    end
               else begin
                    // все данные успешно сохранены
                    end;
               end;
          // обновление данных
          show_storehouse(fmDataModule.Query_transfer_source,self.edit_filter_storehouse_name.text);
          show_commodity(fmDataModule.Query_transfer_destination,self.edit_filter_sell_commodity.text);
          if self.DBGrid_storehouse.DataSource.dataset.locate('ASSORTMENT_KOD',current_kod,[])=false
          then begin
               self.DBGrid_storehouse.DataSource.dataset.locate('ASSORTMENT_KOD',prior_current_kod,[])
               end;
          if self.DBGrid_sell_commodity.DataSource.dataset.locate('ASSORTMENT_KOD',current_kod,[])=false
          then begin
               self.DBGrid_sell_commodity.DataSource.dataset.locate('ASSORTMENT_KOD',prior_current_kod,[])
               end;
          end
     else begin
          // отказ от записи продажи
          end;
     freeandnil(money);
     freeandnil(commodity);
     freeandnil(fmSell_from_storehouse_transaction);
     end
else begin
     // нет выбранной позиции
     end;
end;

end.
