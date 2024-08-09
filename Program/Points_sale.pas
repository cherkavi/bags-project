unit Points_sale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, ComCtrls, ExtCtrls, Db,
  Grids, DBGrids,IBQuery,DataModule,clipbrd, Menus;

type
  TSeller_commodity=class
  public
     private
     field_seller_kod,
     field_date_in_out,
     field_point_kod:string;
     seller_blance_begin:real;
     seller_amount_begin:real;
     public
     column_number,
     column_expenses_name,
     column_amount,
     column_note,
     column_expenses_kod,
     column_expenses_sign:integer;
     column_expenses_sign_seller:integer;

     field_stringgrid:Tstringgrid;
     field_seller_balance:TdxEdit;
     field_seller_amount:TdxEdit;
     field_flag_change:boolean;
     constructor create(stringgrid:TstringGrid;seller_amount,seller_balance:TdxEdit;seller_kod,date_in_out,point_kod:string);
     procedure clear;
     function load_data_from_database(seller_kod,date_in_out,point_kod:string;query:TIBQuery):boolean;overload;
     function load_data_from_database(query:TIBQuery):boolean;overload;

     function delete_data_from_database(seller_kod,date_in_out,point_kod:string;query:TIBQuery):string;overload;
     function delete_data_from_database(query:TIBQuery):string;overload;

     function save_data_to_database(seller_kod,date_in_out,point_kod:string;query:TIBQuery):string;overload;
     function save_data_to_database(query:TIBQuery):string;overload;

     procedure append_to_stringgrid(expenses_kod,expenses_name,amount,note,expenses_sign,expenses_sign_seller:string);
     procedure replace_to_stringgrid(index:integer;expenses_kod,expenses_name,amount,note,expenses_sign,expenses_sign_seller:string);
     procedure delete_from_stringgrid(index: integer);
     // подсчет баланса продавца
     function calculate_balance:real;
     // подсчет суммы
     function calculate_amount:real;
  end;
  TfmPoints_sale = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    dbGrid_source: TDBGrid;
    DataSource_source: TDataSource;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    DBGrid_destination_commodity: TDBGrid;
    DataSource_destination_commodity: TDataSource;
    edit_point_name: TEdit;
    Label1: TLabel;
    edit_date_in_out: TdxDateEdit;
    Label2: TLabel;
    edit_filter_source_commodity: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit_filter_destination_commodity: TEdit;
    button_sell: TButton;
    button_sell_skip: TButton;
    edit_seller: TEdit;
    Label5: TLabel;
    CheckBox_step_in: TCheckBox;
    Panel3: TPanel;
    StringGrid_expenses: TStringGrid;
    button_expenses_add: TButton;
    button_expenses_delete: TButton;
    Panel4: TPanel;
    StringGrid_expenses_current: TStringGrid;
    Panel5: TPanel;
    Label6: TLabel;
    edit_seller_give_money: TdxCalcEdit;
    button_save: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Edit_expenses_summa: TdxEdit;
    Edit_seller_balance: TdxEdit;
    Button_calculate: TButton;
    PopupMenu_expenses: TPopupMenu;
    delete1: TMenuItem;
    edit_filter_source_commodity_note: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Edit_filter_destination_commodity_note: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edit_filter_source_commodityKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure CheckBox_step_inClick(Sender: TObject);
    procedure button_sellClick(Sender: TObject);
    procedure button_sell_skipClick(Sender: TObject);
    procedure button_expenses_deleteClick(Sender: TObject);
    procedure button_expenses_addClick(Sender: TObject);
    procedure Button_calculateClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure button_saveClick(Sender: TObject);
    procedure delete1Click(Sender: TObject);
    procedure StringGrid_expensesDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:DataModule.TAccess;
    point_kod:string;
    seller_kod:string;
    operator_kod:string;
    date_in_out:string;
    seller_balance:real;
    stringgrid_column_amount:integer;
    seller_commodity:TSeller_commodity;
    procedure point_source_commodity(query: TIBquery;name,note:string);overload;
    procedure point_source_commodity(query: TIBquery);overload;
    procedure point_destination_commodity(query:TIBQuery;name,note:string);overload;
    procedure point_destination_commodity(query:TIBQuery);overload;
    procedure set_filter(edit_up,edit_up2,edit_down,edit_down2: TEdit; Sender: TObject; step_in: boolean);
    function float_from_stringgrid_column(stringgrid:Tstringgrid;column_index:integer):real;
    procedure refresh_expenses;
  end;

var
  fmPoints_sale: TfmPoints_sale;

implementation

uses Point_Sale_Transaction, PayDesk_Edit;

{$R *.DFM}

procedure TfmPoints_sale.FormCreate(Sender: TObject);
begin
   self.stringgrid_column_amount:=2;
   access:=DataModule.TAccess.create;
end;

procedure TfmPoints_sale.point_destination_commodity(query: TIBQuery; name,note: string);
var
   control_sql_values:datamodule.Tcontrol_sql_values;
begin
   // продажа по текущему дню
   control_sql_values:=dataModule.TControl_SQL_Values.create;
   query.SQL.clear;
   query.sql.Add('SELECT');
   query.sql.Add('        COMMODITY.KOD COMMODITY_KOD,');
   query.sql.Add('        PEOPLE.FAMILIYA,');
   query.sql.Add('        COMMODITY.ASSORTMENT_KOD COMMODITY_ASSORTMENT_KOD,');
   query.sql.Add('        ASSORTMENT.NAME ASSORTMENT_NAME,');
   query.sql.Add('        ASSORTMENT.NOTE ASSORTMENT_NOTE,');
   query.sql.Add('        COMMODITY.QUANTITY*(-1) QUANTITY,');
   query.sql.Add('        ASSORTMENT.PRICE PRICE,');
   query.sql.Add('        COMMODITY.QUANTITY*ASSORTMENT.PRICE*(-1) SUMA');
   query.sql.Add('FROM COMMODITY');
   query.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
   if trim(name)<>''
   then begin
        query.sql.add('AND ASSORTMENT.NAME LIKE '+control_sql_values.check(chr(39)+'%'+name+'%'+chr(39)));
        end;
   if trim(note)<>''
   then begin
        query.sql.add('AND ASSORTMENT.NOTE LIKE '+control_sql_values.check(chr(39)+'%'+note+'%'+chr(39)));
        end;
   query.sql.Add('INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD');
   query.sql.Add('INNER JOIN PEOPLE ON PEOPLE.KOD=COMMODITY.MAN_KOD');
   query.sql.Add('WHERE 1=1');
   query.sql.Add('AND COMMODITY.OPERATION_KOD=1');
   query.sql.Add('AND COMMODITY.DATE_IN_OUT ='+chr(39)+self.edit_date_in_out.text+chr(39));
   query.sql.Add('AND COMMODITY.POINT_KOD='+self.point_kod);
   query.sql.Add('AND COMMODITY.MAN_KOD='+self.seller_kod);
   query.sql.Add('ORDER BY assortment.PRICE');
   try
      //clipboard.astext:=query.sql.text;
      query.open;
   except
      on e:exception
      do begin
         showmessage('Утеряно соединение с базой');
         clipboard.astext:=query.sql.text;
         end;
   end;
   freeandnil(control_sql_values);
end;

procedure TfmPoints_sale.point_source_commodity(query: TIBquery;name,note:string);
var
   control_sql_values:datamodule.Tcontrol_sql_values;
begin
   // количество товара на торговой точке
   control_sql_values:=dataModule.TControl_SQL_Values.create;
   query.SQL.clear;
   query.sql.Add('SELECT');
   query.sql.Add('        POINTS.NAME POINTS_NAME,');
   query.sql.Add('        ASSORTMENT.NAME ASSORTMENT_NAME,');
   query.sql.Add('        ASSORTMENT.KOD ASSORTMENT_KOD,');
   query.sql.Add('        ASSORTMENT.NOTE ASSORTMENT_NOTE,');
   query.sql.Add('        SUM(COMMODITY.QUANTITY) QUANTITY,');
   query.sql.Add('        ASSORTMENT.PRICE PRICE,');
   query.sql.Add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA,');
   query.sql.Add('        ASSORTMENT.PRICE_BUYING,');
   query.sql.Add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE_BUYING SUMA_BUYING');
   query.sql.Add('FROM COMMODITY');
   query.sql.Add('INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD');
   query.sql.Add('                 AND POINTS.KOD='+self.point_kod);
   query.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD');
   query.sql.Add('                     AND ASSORTMENT.VALID=1');
   if trim(name)<>''
   then begin
        query.sql.add('                AND ASSORTMENT.NAME LIKE '+control_sql_values.check(chr(39)+'%'+name+'%'+chr(39)));
        end;
   if trim(note)<>''
   then begin
        query.sql.add('                AND ASSORTMENT.NOTE LIKE '+control_sql_values.check(chr(39)+'%'+note+'%'+chr(39)));
        end;
   query.sql.Add('WHERE  1=1');
   query.sql.Add('AND COMMODITY.DATE_IN_OUT <='+chr(39)+self.date_in_out+chr(39));
   query.sql.Add('GROUP BY POINTS.NAME,');
   query.sql.Add('         ASSORTMENT.NAME,');
   query.sql.Add('         ASSORTMENT.KOD,');
   query.sql.Add('         ASSORTMENT.NOTE,');
   query.sql.Add('         ASSORTMENT.PRICE,');
   query.sql.Add('         ASSORTMENT.PRICE_BUYING');
   query.sql.Add('HAVING SUM(COMMODITY.QUANTITY)>0');
   query.sql.Add('ORDER BY POINTS.NAME,ASSORTMENT.PRICE');
   try
      query.open;
   except
      on e:exception
      do begin
         showmessage('Утеряно соединение с базой');
         clipboard.astext:=query.sql.text;
         end;
   end;
   freeandnil(control_sql_values);
end;

procedure TfmPoints_sale.set_filter(edit_up, edit_up2, edit_down,edit_down2: TEdit;
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
             // установить фильтр
             if TEdit(Sender)=edit_up
             then begin
                  // Set Filter UP
                  self.point_source_commodity(fmDataModule.Query_transfer_source,self.edit_filter_source_commodity.text,self.edit_filter_source_commodity_note.text);
                  edit_up.color:=color_filter_set;
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_down.text:=edit_up.text;
                       edit_down.color:=color_filter_set;
                       // Set Filter Down
                       self.point_destination_commodity(fmDataModule.Query_transfer_destination,self.Edit_filter_destination_commodity.text,self.Edit_filter_destination_commodity_note.text);
                       end;
                  end;
             // установить фильтр
             if TEdit(Sender)=edit_up2
             then begin
                  // Set Filter UP
                  self.point_source_commodity(fmDataModule.Query_transfer_source,self.edit_filter_source_commodity.text,self.edit_filter_source_commodity_note.text);
                  edit_up2.color:=color_filter_set;
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_down2.text:=edit_up2.text;
                       edit_down2.color:=color_filter_set;
                       // Set Filter Down
                       self.point_destination_commodity(fmDataModule.Query_transfer_destination,self.Edit_filter_destination_commodity.text,self.Edit_filter_destination_commodity_note.text);
                       end;
                  end;

             if TEdit(Sender)=edit_down
             then begin
                  // Set Filter Down
                  self.point_destination_commodity(fmDataModule.Query_transfer_destination,self.Edit_filter_destination_commodity.text,self.Edit_filter_destination_commodity_note.text);
                  edit_down.color:=color_filter_set;
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_up.text:=edit_down.text;
                       edit_up.color:=color_filter_set;
                       // Set Filter UP
                       self.point_source_commodity(fmDataModule.Query_transfer_source,self.edit_filter_source_commodity.text,self.edit_filter_source_commodity_note.text);
                       end;
                  end;
             if TEdit(Sender)=edit_down2
             then begin
                  // Set Filter Down
                  self.point_destination_commodity(fmDataModule.Query_transfer_destination,self.Edit_filter_destination_commodity.text,self.Edit_filter_destination_commodity_note.text);
                  edit_down2.color:=color_filter_set;
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_up2.text:=edit_down2.text;
                       edit_up2.color:=color_filter_set;
                       // Set Filter UP
                       self.point_source_commodity(fmDataModule.Query_transfer_source,self.edit_filter_source_commodity.text,self.edit_filter_source_commodity_note.text);
                       end;
                  end;

             end
        else begin
             if TEdit(Sender)=edit_up
             then begin
                  edit_up.color:=color_filter_unset;
                  // Clear Filter UP
                  self.point_source_commodity(fmDataModule.Query_transfer_source);
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_down.color:=color_filter_unset;
                       edit_down.text:='';
                       // Clear Filter Down
                       self.point_destination_commodity(fmDataModule.Query_transfer_destination);
                       end;
                  end;
             if TEdit(Sender)=edit_up2
             then begin
                  edit_up2.color:=color_filter_unset;
                  // Clear Filter UP
                  self.point_source_commodity(fmDataModule.Query_transfer_source);
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_down2.color:=color_filter_unset;
                       edit_down2.text:='';
                       // Clear Filter Down
                       self.point_destination_commodity(fmDataModule.Query_transfer_destination);
                       end;
                  end;

             if TEdit(Sender)=edit_down
             then begin
                  edit_down.color:=color_filter_unset;
                  // Clear Filter Down
                  self.point_destination_commodity(fmDataModule.Query_transfer_destination);
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_up.color:=color_filter_unset;
                       edit_up.text:='';
                       // Clear Filter UP
                       self.point_source_commodity(fmDataModule.Query_transfer_source);
                       end;
                  end;
             if TEdit(Sender)=edit_down2
             then begin
                  edit_down2.color:=color_filter_unset;
                  // Clear Filter Down
                  self.point_destination_commodity(fmDataModule.Query_transfer_destination);
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_up2.color:=color_filter_unset;
                       edit_up2.text:='';
                       // Clear Filter UP
                       self.point_source_commodity(fmDataModule.Query_transfer_source);
                       end;
                  end;

             end;
        end;
   if Sender is TCheckBox
   then begin
        self.set_filter(edit_up,edit_up2,edit_down,edit_down2,self.edit_filter_source_commodity_note,self.CheckBox_step_in.checked);
        {if TCheckBox(Sender).Checked=true
        then begin
             if trim(edit_up.text)=''
             then begin
                  edit_up.text:=edit_down.text;
                  if trim(edit_down.text)=''
                  then begin
                       edit_down.color:=color_filter_unset;
                       edit_up.color:=color_filter_unset;
                       // Clear Filter UP
                       // Clear Filter Down
                       self.point_source_commodity(fmDataModule.Query_transfer_source);
                       self.point_destination_commodity(fmDataModule.Query_transfer_destination);
                       end
                  else begin
                       edit_down.color:=color_filter_set;
                       edit_up.color:=color_filter_set;
                       // Set Filter UP
                       // Set Filter Down
                       self.point_source_commodity(fmDataModule.Query_transfer_source,self.edit_filter_source_commodity.text,self.edit_filter_source_commodity_note.text);
                       self.point_destination_commodity(fmDataModule.Query_transfer_destination,self.Edit_filter_destination_commodity.text,self.Edit_filter_destination_commodity_note.text);
                       end;
                  end
             else begin
                  edit_down.text:=edit_up.text;
                  edit_down.color:=color_filter_set;
                  edit_up.color:=color_filter_set;
                  // Set Filter UP
                  // Set Filter Down
                  self.point_source_commodity(fmDataModule.Query_transfer_source,self.edit_filter_source_commodity.text,self.edit_filter_source_commodity_note.text);
                  self.point_destination_commodity(fmDataModule.Query_transfer_destination,self.Edit_filter_destination_commodity.text,self.Edit_filter_destination_commodity_note.text);
                  end;
             end
        else begin
             // removing flag IN_STEP
             edit_down.text:='';
             edit_down.color:=color_filter_unset;
             // Clear Filter Down
             self.point_destination_commodity(fmDataModule.Query_transfer_destination);
             end;}
        end;
end;

procedure TfmPoints_sale.FormShow(Sender: TObject);
var
   koef_of_sells:real;
begin
     //koef_of_sells:=0.10;//koef_of_sells:=0.07;
     // загрузка доступного товара по точке
     self.point_source_commodity(fmDataModule.Query_transfer_source);
     // загрузка проданного товара
     self.point_destination_commodity(fmDataModule.Query_transfer_destination);
     // загрузка баланса продавца
     self.Edit_seller_balance.text:=format('%.2f',[Self.seller_balance]);
     try
        seller_commodity:=TSeller_commodity.create(self.StringGrid_expenses_current,self.Edit_expenses_summa,self.Edit_seller_balance,self.seller_kod,self.date_in_out,self.point_kod);
        // загрузка расходов/приходов
        seller_commodity.load_data_from_database(fmDataModule.query_temp);

     except
        seller_commodity:=nil;
     end;
     // загрузка статей расходов/приходов
     fmdataModule.load_to_stringgrid_from_table(fmDataModule.query_temp,
                                                self.stringgrid_expenses,
                                                'EXPENSES',
                                                ['NAME','KOD','SIGN','SIGN_SELLER'],
                                                'KOD IN (1,2,3,4,5,6,7,8,9,10,11)',
                                                ['Наименование статьи прихода/расхода',
                                                'expenses_kod',
                                                'expenses_sign',
                                                'expenses_sign_seller']);
     self.stringgrid_expenses.ColWidths[1]:=-1;
     self.stringgrid_expenses.ColWidths[2]:=-1;
     self.stringgrid_expenses.ColWidths[3]:=-1;

     // если есть продажи, но нет выручки в кассу, тогда подсчитать доходы и з/п
     if (fmDataModule.Query_transfer_destination.recordcount>0) and
        (self.StringGrid_expenses_current.Cols[1].IndexOf('Выручка в кассу')=-1)
     then begin
          seller_commodity.append_to_stringgrid('2','Выручка в кассу',
          floattostr(fmDataModule.calculate_sum_from_query_from_field(fmDataModule.Query_transfer_destination,'SUMA')),'','1','1');
          end;
     // если есть продажи, но нет зарплаты, тогда подсчитать доходы и з/п
     {if (fmDataModule.Query_transfer_destination.recordcount>0) and
        (self.StringGrid_expenses_current.Cols[1].IndexOf('Зароботная плата')=-1)
     then begin
          seller_commodity.append_to_stringgrid('9','Зароботная плата',
          floattostr(fmDataModule.calculate_sum_from_query_from_field(fmDataModule.Query_transfer_destination,'SUMA')*koef_of_sells),'','-1','1');
          end;}
     // загрузка баланса расхода/прихода
     self.Edit_expenses_summa.text:=format('%.2f',[Seller_commodity.calculate_amount]);
end;

procedure TfmPoints_sale.edit_filter_source_commodityKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   self.set_filter(self.edit_filter_source_commodity,self.edit_filter_source_commodity_note,self.Edit_filter_destination_commodity,self.Edit_filter_destination_commodity_note,sender,self.CheckBox_step_in.checked);
end;

procedure TfmPoints_sale.CheckBox_step_inClick(Sender: TObject);
begin
   self.set_filter(self.edit_filter_source_commodity,self.edit_filter_source_commodity_note,self.Edit_filter_destination_commodity,self.Edit_filter_destination_commodity_note,sender,self.CheckBox_step_in.checked);
end;

procedure TfmPoints_sale.button_sellClick(Sender: TObject);
var
   commodity:DataModule.TCommodity;
   write_date:string;
   temp_string:string;
   current_kod,prev_current_kod:string;
   move_next:boolean;
begin
   // задание данных для возможного позиционирования после осуществления продажи
   move_next:=false;
   if self.dbGrid_source.DataSource.DataSet.FindPrior
   then begin
        //есть предыдущая позиция
        self.dbGrid_source.datasource.dataset.Prior;
        prev_current_kod:=self.dbGrid_source.datasource.dataset.FieldByName('ASSORTMENT_KOD').asstring;
        move_next:=true;
        end
   else begin
        // нет предыдущей позиции, нужно будет переместиться на следующую
        end;

   if move_next=true
   then self.dbGrid_source.datasource.dataset.next;

   current_kod:=self.dbGrid_source.datasource.dataset.FieldByName('ASSORTMENT_KOD').asstring;
   if self.dbGrid_source.datasource.dataset.FieldByName('ASSORTMENT_KOD').asstring<>''
   then begin
        fmPoint_Sale_Transaction:=TfmPoint_Sale_Transaction.create(self);
        fmPoint_Sale_Transaction.edit_points.text:=self.edit_point_name.text;
        fmPoint_Sale_Transaction.edit_seller.text:=self.edit_seller.text;
        fmPoint_Sale_Transaction.edit_date.text:=self.edit_date_in_out.text;
        fmPoint_Sale_Transaction.Edit_kod.text:=self.dbGrid_source.datasource.dataset.FieldByName('ASSORTMENT_KOD').asstring; // код
        fmPoint_Sale_Transaction.Edit_name.text:=self.dbGrid_source.datasource.dataset.FieldByName('ASSORTMENT_NAME').asstring; // Наименование
        fmPoint_Sale_Transaction.Edit_price.text:=self.dbGrid_source.datasource.dataset.FieldByName('PRICE').asstring; // Цена
        fmPoint_Sale_Transaction.Edit_quantity.maxvalue:=strtoint(self.dbGrid_source.datasource.dataset.FieldByName('QUANTITY').asstring);
        fmPoint_Sale_Transaction.Edit_quantity.minvalue:=1;
        fmPoint_Sale_Transaction.Edit_quantity.intValue:=1;
        if fmPoint_Sale_Transaction.Edit_quantity.maxvalue=1
        then fmPoint_Sale_Transaction.Edit_quantity.readonly:=true;
        fmPoint_Sale_Transaction.Edit_suma.text:=self.dbGrid_source.datasource.dataset.FieldByName('PRICE').asstring; //Сумма
        if fmPoint_Sale_Transaction.showmodal=mrOk
        then begin
             write_date:=datetimetostr(now);
             commodity:=DataModule.TCommodity.create;
             commodity.field_assortment_kod:=fmPoint_Sale_Transaction.Edit_kod.text;
             commodity.field_date_in_out:=self.date_in_out;
             commodity.field_man_kod:=self.seller_kod;
             commodity.field_note:='';
             commodity.field_operation_kod:='1';
             commodity.field_point_kod:=self.point_kod;
             commodity.field_quantity:='-'+fmPoint_Sale_Transaction.Edit_quantity.text;
             commodity.field_writer:='1';// кто записал
             commodity.field_write_date:=write_date;
             temp_string:=commodity.save(fmDataModule.query_temp);
             if temp_string<>''
             then begin
                  showmessage('Ошибка ввода продаж');
                  clipboard.astext:='COMMODITY.SAVE ERROR'+chr(13)+chr(10)+temp_string;
                  end;
             self.point_source_commodity(fmDataModule.Query_transfer_source,self.edit_filter_source_commodity.text,self.edit_filter_source_commodity_note.text);
             self.point_destination_commodity(fmDataModule.Query_transfer_destination,self.Edit_filter_destination_commodity.text,self.Edit_filter_destination_commodity_note.text);
             self.refresh_expenses;
             if self.dbGrid_source.datasource.dataset.Locate('ASSORTMENT_KOD',current_kod,[])
             then begin
                  // курсор установлен на текущую метку
                  end
             else begin
                  // курсор не установлен - товар не найден, то есть данный товар весь продан
                  if move_next
                  then begin
                       self.dbGrid_source.datasource.dataset.Locate('ASSORTMENT_KOD',prev_current_kod,[])
                       end
                  else begin

                       self.dbGrid_source.datasource.dataset.First;
                       end;
                  end;
             self.button_save.enabled:=true;
             freeandnil(commodity);
             end
        else begin
             // пользователь отказался от внесения изменений
             end;
        end;
end;

procedure TfmPoints_sale.button_sell_skipClick(Sender: TObject);
var
   commodity:datamodule.TCommodity;
   temp_string:string;
begin
   if self.DBGrid_destination_commodity.DataSource.dataset.FieldByName('COMMODITY_KOD').asstring<>''
   then begin
        if messagedlg('Вы уверены в отмене продажи?',mtConfirmation,[mbYes, mbNo], 0) = mrYes
        then begin
             // удаление записи
             commodity:=datamodule.TCommodity.create;
             temp_string:=commodity.delete_by_kod(self.DBGrid_destination_commodity.DataSource.dataset.FieldByName('COMMODITY_KOD').asstring,fmDataModule.query_temp);
             if temp_string<>''
             then begin
                  showmessage('Ошибка удаления данных');
                  clipboard.astext:='COMMODITY.DELETE ERROR '+chr(13)+chr(10)+temp_string;
                  end
             else begin
                  // удаление прошло удачно
                  end;
             self.point_source_commodity(fmDataModule.Query_transfer_source,self.edit_filter_source_commodity.text,self.edit_filter_source_commodity_note.text);
             self.point_destination_commodity(fmDataModule.Query_transfer_destination,self.Edit_filter_destination_commodity.text,self.Edit_filter_destination_commodity_note.text);
             self.refresh_expenses;
             freeandnil(commodity);
             self.button_save.Enabled:=true;
             end
        else begin
             // отказ пользователя от изменений
             end;
        end;
end;

{ TSeller_commodity }

procedure TSeller_commodity.append_to_stringgrid(expenses_kod,
  expenses_name, amount,note,expenses_sign,expenses_sign_seller: string);
var
   temp_expenses_kod:integer;
begin
   if self.field_stringgrid.rowcount=2
   then begin
        if self.field_stringgrid.Cells[self.column_number,1]=''
        then begin
             // первая запись, таблица пуста
             end
        else begin
             //вторая запись
             self.field_stringgrid.Rowcount:=self.field_stringgrid.rowcount+1;
             end;
        end
   else begin
        self.field_stringgrid.Rowcount:=self.field_stringgrid.rowcount+1;
        end;
   self.field_stringgrid.Cells[self.column_number,self.field_stringgrid.rowcount-1]:=inttostr(self.field_stringgrid.rowcount-1);
   self.field_stringgrid.Cells[self.column_expenses_name,self.field_stringgrid.rowcount-1]:=expenses_name;
   self.field_stringgrid.Cells[self.column_amount,self.field_stringgrid.rowcount-1]:=amount;
   self.field_stringgrid.Cells[self.column_note,self.field_stringgrid.rowcount-1]:=note;
   self.field_stringgrid.Cells[self.column_expenses_kod,self.field_stringgrid.rowcount-1]:=expenses_kod;
   self.field_stringgrid.Cells[self.column_expenses_sign,self.field_stringgrid.rowcount-1]:=expenses_sign;
   self.field_stringgrid.Cells[self.column_expenses_sign_seller,self.field_stringgrid.rowcount-1]:=expenses_sign_seller;
   self.field_seller_balance.text:=format('%.2f',[self.seller_blance_begin+self.calculate_balance]);
   {try
      temp_expenses_kod:=strtoint(expenses_kod);
      if temp_expenses_kod in [1,3]
      then begin
           self.field_seller_balance.text:=
           format('%.2f',[strtofloat(self.field_seller_balance.text)-strtofloat(amount)]);
           end;
      if temp_expenses_kod in [6,7,10]
      then begin
           self.field_seller_balance.text:=
           format('%.2f',[strtofloat(self.field_seller_balance.text)+strtofloat(amount)]);
           end;
   except
      on e:Exception
      do begin
         showmessage('Error');
         clipboard.astext:=e.Message;
         self.field_seller_balance.text:='';
         end;
   end;}
   self.field_flag_change:=true;
end;

procedure TSeller_commodity.clear;
var
   i:integer;
begin
   self.field_seller_kod:='';
   self.field_date_in_out:='';
   self.field_point_kod:='';
   for i:=0 to self.field_stringgrid.colcount-1
   do begin
      self.field_stringgrid.Cols[i].Clear;
      end;
end;

constructor TSeller_commodity.create(stringgrid:TstringGrid;seller_amount,seller_balance:TdxEdit;seller_kod,date_in_out,point_kod:string);
begin
   column_number:=0;
   column_expenses_name:=1;
   column_amount:=2;
   column_note:=3;
   column_expenses_kod:=4;
   column_expenses_sign:=5;
   column_expenses_sign_seller:=6;

   if stringgrid=nil
   then raise Exception.create('Error in create Object Seller_Commodity')
   else self.field_stringgrid:=stringgrid;
   if seller_balance=nil
   then raise Exception.create('Error in create Object Seller_Commodity Seller Balance not assigned')
   else self.field_seller_balance:=seller_balance;
   if seller_amount=nil
   then raise Exception.create('Error in create Object Seller_Commodity Seller Balance not assigned')
   else self.field_seller_amount:=seller_amount;

   self.clear;
   self.field_seller_kod:=seller_kod;
   self.field_date_in_out:=date_in_out;
   self.field_point_kod:=point_kod;
   self.field_flag_change:=false;
   try
      self.seller_blance_begin:=strtofloat(self.field_seller_balance.text);
   except
      self.seller_blance_begin:=0;
   end;
   try
      self.seller_amount_begin:=strtofloat(self.field_seller_amount.text);
   except
      self.seller_amount_begin:=0;
   end;

end;

function TSeller_commodity.delete_data_from_database(query:TIBQuery): string;
begin
   self.delete_data_from_database(self.field_seller_kod,self.field_date_in_out,self.field_point_kod,query);
end;

function TSeller_commodity.delete_data_from_database(seller_kod,
  date_in_out, point_kod: string;query:TIBQuery): string;
begin
   if query.Transaction.active
   then query.Transaction.Commit;
   query.Transaction.StartTransaction;
   query.SQL.clear;
   query.SQL.Add('DELETE');
   query.SQL.Add('FROM MONEY');
   query.SQL.Add('WHERE');
   query.SQL.Add('    MONEY.KOD_POINT='+point_kod);
   query.SQL.Add('AND MONEY.KOD_MAN='+seller_kod);
   query.SQL.Add('AND MONEY.DATE_IN_OUT='+chr(39)+date_in_out+chr(39));
   try
      query.ExecSQL;
      query.Transaction.Commit;
      result:='';
   except
      on e:exception
      do begin
         result:=e.message;
         end;
   end;
end;

procedure TSeller_commodity.delete_from_stringgrid(index: integer);
var
   column_counter,row_counter,temp_expenses_kod:integer;
begin
if index<self.field_stringgrid.RowCount
then begin
     // подсчет баланса продавца
     {if self.field_stringgrid.Cells[self.column_expenses_kod,index]<>''
     then begin
          try
             temp_expenses_kod:=strtoint(self.field_stringgrid.Cells[self.column_expenses_kod,index]);
             if temp_expenses_kod in [1,3]
             then begin
                  self.field_seller_balance.text:=
                  format('%.2f',[strtofloat(self.field_seller_balance.text)+strtofloat(self.field_stringgrid.Cells[self.column_amount,index])]);
                  end;
             if temp_expenses_kod in [6,7,10]
             then begin
                  self.field_seller_balance.text:=
                  format('%.2f',[strtofloat(self.field_seller_balance.text)-strtofloat(self.field_stringgrid.Cells[self.column_amount,index])]);
                  end;
          except
             on e:Exception
             do begin
                showmessage('Error');
                clipboard.astext:=e.Message;
                self.field_seller_balance.text:='';
                end;
          end;
          end;}
     if index=self.field_stringgrid.rowcount-1
     then begin
          // индекс первый
          if (index=1) and (self.field_stringgrid.rowcount=2)
          then begin
               // индекс первый, полей больше нет
               for column_counter:=0 to self.field_stringgrid.colcount-1
               do begin
                  self.field_stringgrid.Cells[column_counter,1]:='';
                  end;
               end
          else begin
               // индекс последний - просто удаляем
               for column_counter:=0 to self.field_stringgrid.colcount-1
               do begin
                  self.field_stringgrid.Cells[column_counter,index]:='';
                  end;
               // переназначение размерности
               self.field_stringgrid.rowcount:=self.field_stringgrid.rowcount-1;
               end;
          end
     else begin
          // очистка удаляемого поля
          for column_counter:=0 to self.field_stringgrid.colcount-1
          do begin
             self.field_stringgrid.Cells[column_counter,index]:='';
             end;
          // сдвиг значений на одно вверх
          for row_counter:=index+1 to self.field_stringgrid.rowcount-1
          do begin
             for column_counter:=0 to self.field_stringgrid.colcount-1
             do begin
                self.field_stringgrid.Cells[column_counter,row_counter-1]:=self.field_stringgrid.Cells[column_counter,row_counter];
                end
             end;
          // переназначение размерности
          self.field_stringgrid.rowcount:=self.field_stringgrid.rowcount-1;
          end;
     // пересчитать в 1 колонке данные
     for row_counter:=1 to self.field_stringgrid.rowcount-1
     do begin
        if trim(self.field_stringgrid.Cells[self.column_expenses_name,row_counter])<>''
        then self.field_stringgrid.Cells[0,row_counter]:=inttostr(row_counter);
        end;
     self.field_seller_balance.text:=format('%.2f',[self.seller_blance_begin+self.calculate_balance]);
     self.field_flag_change:=true;
     end
else begin
     // индекс для удаления за пределами
     end;
end;


function TSeller_commodity.load_data_from_database(seller_kod, date_in_out,
  point_kod: string;query:TIBQuery): boolean;
var
   i:integer;
   recordcount:integer;
begin
   query.SQL.clear;
   query.SQL.Add('SELECT');
   query.SQL.Add('        MONEY.KOD KOD,');
   query.SQL.Add('        EXPENSES.NAME NAME,');
   query.SQL.Add('        MONEY.AMOUNT AMOUNT,');
   query.SQL.Add('        EXPENSES.KOD EXPENSES_KOD,');
   query.SQL.Add('        MONEY.NOTE MONEY_NOTE,');
   query.SQL.Add('        EXPENSES.SIGN EXPENSES_SIGN,');
   query.SQL.Add('        EXPENSES.SIGN_SELLER EXPENSES_SIGN_SELLER');
   query.SQL.Add('FROM MONEY');
   query.SQL.Add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
   query.SQL.Add('WHERE');
   query.SQL.Add('    MONEY.KOD_POINT='+point_kod);
   query.SQL.Add('AND MONEY.KOD_MAN='+seller_kod);
   query.SQL.Add('AND MONEY.DATE_IN_OUT='+chr(39)+date_in_out+chr(39));
   query.SQL.Add('ORDER BY MONEY.KOD');
   query.open;

   for i:=0 to self.field_stringgrid.colcount-1
   do begin
      self.field_stringgrid.Cols[i].clear;
      end;
   self.field_stringgrid.rowcount:=2;
   self.field_stringgrid.Cells[self.column_number,0]:='№';
   self.field_stringgrid.Cells[self.column_expenses_name,0]:='Статья';
   self.field_stringgrid.Cells[self.column_amount,0]:='Сумма';
   self.field_stringgrid.Cells[self.column_note,0]:='Примечание';
   self.field_stringgrid.Cells[self.column_expenses_kod,0]:='Код';
   self.field_stringgrid.Cells[self.column_expenses_sign,0]:='Знак';
   self.field_stringgrid.ColWidths[self.column_expenses_kod]:=-1;
   self.field_stringgrid.ColWidths[self.column_expenses_sign]:=-1;
   self.field_stringgrid.ColWidths[self.column_expenses_sign_seller]:=-1;
   if query.recordcount>0
   then begin
        recordcount:=0;
        while not(query.eof)
        do begin
           inc(recordcount);
           query.next;
           end;
        self.field_stringgrid.RowCount:=recordcount+1;
        query.first;

        for i:=1 to recordcount
        do begin
           self.field_stringgrid.Cells[self.column_number,i]:=inttostr(i);
           self.field_stringgrid.Cells[self.column_expenses_name,i]:=query.fieldbyname('NAME').asstring;
           self.field_stringgrid.Cells[self.column_amount,i]:=format('%.2f',[query.fieldbyname('AMOUNT').asfloat]);
           self.field_stringgrid.Cells[self.column_note,i]:=query.fieldbyname('MONEY_NOTE').asstring;
           self.field_stringgrid.Cells[self.column_expenses_kod,i]:=query.fieldbyname('EXPENSES_KOD').asstring;
           self.field_stringgrid.Cells[self.column_expenses_sign,i]:=query.fieldbyname('EXPENSES_SIGN').asstring;
           self.field_stringgrid.Cells[self.column_expenses_sign_seller,i]:=query.fieldbyname('EXPENSES_SIGN_SELLER').asstring;
           query.next;
           end;
        self.seller_blance_begin:=self.seller_blance_begin-self.calculate_balance;
        result:=true;
        end
   else begin
        // грузить нечего
        result:=false;
        end;
end;

function TSeller_commodity.load_data_from_database(query:TIBQuery): boolean;
begin
   result:=self.load_data_from_database(self.field_seller_kod,self.field_date_in_out,self.field_point_kod,query);
end;

function TSeller_commodity.save_data_to_database(query:TIBQuery): string;
begin
   result:=self.save_data_to_database(self.field_seller_kod,self.field_date_in_out,self.field_point_kod,query);
end;

procedure TSeller_commodity.replace_to_stringgrid(index: integer;
  expenses_kod, expenses_name, amount, note,expenses_sign,expenses_sign_seller: string);
var
   temp_expenses_kod:integer;
begin
     // подсчет баланса продавца
     {if self.field_stringgrid.Cells[self.column_expenses_kod,index]<>''
     then begin
          try
             // убираем составляющую, которая заложена, та которую будут изменять
             temp_expenses_kod:=strtoint(self.field_stringgrid.Cells[self.column_expenses_kod,index]);
             if temp_expenses_kod in [1,3]
             then begin
                  self.field_seller_balance.text:=
                  format('%.2f',[strtofloat(self.field_seller_balance.text)
                                -strtofloat(self.field_stringgrid.Cells[self.column_amount,index])]);
                  end;
             if temp_expenses_kod in [6,7,10]
             then begin
                  self.field_seller_balance.text:=
                  format('%.2f',[strtofloat(self.field_seller_balance.text)
                                +strtofloat(self.field_stringgrid.Cells[self.column_amount,index])]);
                  end;
             // добавляем составляющую, которая будет заложена
             temp_expenses_kod:=strtoint(expenses_kod);
             if temp_expenses_kod in [1,3]
             then begin
                  self.field_seller_balance.text:=
                  format('%.2f',[strtofloat(self.field_seller_balance.text)
                                -strtofloat(amount)]);
                  end;
             if temp_expenses_kod in [6,7,10]
             then begin
                  self.field_seller_balance.text:=
                  format('%.2f',[strtofloat(self.field_seller_balance.text)
                                +strtofloat(amount)]);
                  end;

          except
             on e:Exception
             do begin
                showmessage('Error');
                clipboard.astext:=e.Message;
                self.field_seller_balance.text:='';
                end;
          end;
          end;}

   self.field_stringgrid.Cells[self.column_expenses_name,index]:=expenses_name;
   self.field_stringgrid.Cells[self.column_amount,index]:=amount;
   self.field_stringgrid.Cells[self.column_note,index]:=note;
   self.field_stringgrid.Cells[self.column_expenses_kod,index]:=expenses_kod;
   self.field_stringgrid.Cells[self.column_expenses_sign,index]:=expenses_sign;
   self.field_stringgrid.Cells[self.column_expenses_sign_seller,index]:=expenses_sign_seller;

   self.field_seller_balance.text:=format('%.2f',[self.seller_blance_begin+self.calculate_balance]);
   self.field_flag_change:=true;
end;

function TSeller_commodity.save_data_to_database(seller_kod, date_in_out,
  point_kod: string;query:TIBQuery): string;
var
   temp_string:string;
   money:dataModule.Tmoney;
   datetime_write:string;
   row_counter:integer;
begin
   temp_string:=self.delete_data_from_database(seller_kod,date_in_out,point_kod,query);
   if temp_string=''
   then begin
        // данные удалены, записываем данные в таблицу
        datetime_write:=datetimetostr(now);
        money:=dataModule.TMoney.Create;
        for row_counter:=1 to self.field_stringgrid.rowcount-1
        do begin
           if self.field_stringgrid.Cells[self.column_expenses_kod,row_counter]<>''
           then begin
                money.clear;
                money.field_kod_point:=point_kod;
                money.field_kod_expenses:=self.field_stringgrid.Cells[self.column_expenses_kod,row_counter];
                money.field_amount:=self.field_stringgrid.Cells[self.column_amount,row_counter];
                money.field_kod_man:=seller_kod;
                money.field_kod_writer:='1';// код записавшего данные
                money.field_date_writer:=datetime_write;
                money.field_date_in_out:=date_in_out;
                money.field_note:=self.field_stringgrid.Cells[self.column_note,row_counter];
                temp_string:=money.save(fmDataModule.Query_temp);
                if temp_string<>''
                then break;
                end;
           end;
        result:=temp_string;
        self.field_flag_change:=false;
        freeandnil(money);
        end
   else begin
        // ошибка при удалении данных
        result:='DELETE ERROR'+chr(13)+chr(10)+temp_string;
        end;
end;



procedure TfmPoints_sale.button_expenses_deleteClick(Sender: TObject);
var
   i:integer;
begin
   self.seller_commodity.delete_from_stringgrid(self.StringGrid_expenses_current.Selection.Top);
   // подсчет общей кассы
   self.Edit_expenses_summa.text:=format('%.2f',[Seller_commodity.calculate_amount]);
   self.button_save.enabled:=true;
end;

procedure TfmPoints_sale.button_expenses_addClick(Sender: TObject);
begin
   fmPayDesk_edit:=TfmPayDesk_edit.create(self);
   fmPayDesk_edit.edit_point.text:=self.edit_point_name.text;
   fmPayDesk_edit.Edit_kod_man.text:=self.edit_seller.text;
   fmPayDesk_edit.Edit_Date_in_out.text:=self.date_in_out;
   fmPayDesk_edit.combobox_expenses.itemindex:=fmPayDesk_edit.combobox_expenses.items.IndexOf(self.StringGrid_expenses.Cells[0,self.StringGrid_expenses.selection.top]);
   //fmPayDesk_edit.edit_amount.SetFocus;
   if fmPayDesk_Edit.ShowModal=mrOk
   then begin
        // добавить в объект
        self.seller_commodity.append_to_stringgrid(
        self.StringGrid_expenses.Cells[1,self.StringGrid_expenses.Cols[0].IndexOf(fmPayDesk_edit.combobox_expenses.Text)],
        self.StringGrid_expenses.Cells[0,self.StringGrid_expenses.Cols[0].IndexOf(fmPayDesk_edit.combobox_expenses.Text)],
        fmPayDesk_Edit.Edit_Amount.text,
        fmPayDesk_edit.edit_note.text,
        self.StringGrid_expenses.Cells[2,self.StringGrid_expenses.Cols[0].IndexOf(fmPayDesk_edit.combobox_expenses.Text)],
        self.StringGrid_expenses.Cells[3,self.StringGrid_expenses.Cols[0].IndexOf(fmPayDesk_edit.combobox_expenses.Text)]);
        // подсчет общей кассы
        self.Edit_expenses_summa.text:=format('%.2f',[Seller_commodity.calculate_amount]);
        end
   else begin
        end;
   freeandnil(fmPayDesk_edit);
   //
end;

function TfmPoints_sale.float_from_stringgrid_column(
  stringgrid: Tstringgrid; column_index: integer): real;
var
   row_counter:integer;
   summa:real;
begin
   summa:=0;
   for row_counter:=0 to stringgrid.rowcount-1
   do begin
      try
         summa:=summa+strtofloat(stringgrid.Cells[column_index,row_counter]);
      except
         summa:=summa+0;
      end;
      end;
   result:=summa;
end;

procedure TfmPoints_sale.Button_calculateClick(Sender: TObject);
begin
   try
      if strtofloat(self.edit_seller_give_money.text)<Seller_commodity.calculate_amount
      then begin
           self.seller_commodity.append_to_stringgrid('1','Выдача денег из кассы',format('%.2f',[Seller_commodity.calculate_amount-strtofloat(self.edit_seller_give_money.text)]),'недостача','-1','-1');
           // подсчет общей кассы
           self.Edit_expenses_summa.text:=format('%.2f',[Seller_commodity.calculate_amount]);
           // подсчет денег по продавцу
           self.button_save.Enabled:=true;
           end
      else begin
           if strtofloat(self.edit_seller_give_money.text)>Seller_commodity.calculate_amount
           then begin
                showmessage('Проверьте продажи, превышение продаж на '+format('%.2f',[strtofloat(self.edit_seller_give_money.text)-Seller_commodity.calculate_amount]));
                end
           end;
   except
      on e:exception
      do begin
         showmessage('Ошибка при подсчете');
         clipboard.astext:=e.message;
         end;
   end;
end;

procedure TfmPoints_sale.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   temp_string:string;
begin
   if self.seller_commodity.field_flag_change=true
   then begin
        if messagedlg('Сохранить сделанные изменения ?',mtConfirmation,[mbYes,mbNo],0)=mrYes
        then begin
             // пользователь сохранил изменения
             temp_string:=self.seller_commodity.save_data_to_database(fmDataModule.query_temp);
             if temp_string<>''
             then begin
                  showmessage('Ошибка при сохранении данных');
                  clipboard.astext:=temp_string;
                  end;
             end
        else begin
             // пользователь отказался от сохранения изменений
             end;
        end;
   canclose:=true;
end;

procedure TfmPoints_sale.button_saveClick(Sender: TObject);
var
   temp_string:string;
begin
   temp_string:=self.seller_commodity.save_data_to_database(fmDataModule.query_temp);
   if temp_string<>''
   then begin
        showmessage('Ошибка при сохранении данных');
        clipboard.astext:=temp_string;
        end
   else begin
        button_save.Enabled:=false;
        end;
   self.point_source_commodity(fmDataModule.Query_transfer_source,self.edit_filter_source_commodity.text,self.edit_filter_source_commodity_note.text);
   self.point_destination_commodity(fmDataModule.Query_transfer_destination,self.Edit_filter_destination_commodity.text,self.Edit_filter_destination_commodity_note.text);
end;

procedure TfmPoints_sale.refresh_expenses;
var
   koef_of_sells:real;
begin
   koef_of_sells:=0.1;//koef_of_sells=0.07
   // добавляем выручку в кассу
   if (self.StringGrid_expenses_current.Cols[1].IndexOf('Выручка в кассу')=-1)
   then begin
        seller_commodity.append_to_stringgrid('2','Выручка в кассу',
        floattostr(fmDataModule.calculate_sum_from_query_from_field(fmDataModule.Query_transfer_destination,'SUMA')),'','1','1');
        end
   else begin
        seller_commodity.replace_to_stringgrid(self.StringGrid_expenses_current.Cols[1].IndexOf('Выручка в кассу'),
        '2','Выручка в кассу',
        floattostr(fmDataModule.calculate_sum_from_query_from_field(fmDataModule.Query_transfer_destination,'SUMA')),'','1','1');
        end;
   // добавляем зароботную плату
   {if (self.StringGrid_expenses_current.Cols[1].IndexOf('Зароботная плата')=-1)
   then begin
        seller_commodity.append_to_stringgrid('9','Зароботная плата',
        floattostr(fmDataModule.calculate_sum_from_query_from_field(fmDataModule.Query_transfer_destination,'SUMA')*koef_of_sells),'','-1','1');
        end
   else begin
        seller_commodity.replace_to_stringgrid(self.StringGrid_expenses_current.Cols[1].IndexOf('Зароботная плата'),'9','Зароботная плата',
        floattostr(fmDataModule.calculate_sum_from_query_from_field(fmDataModule.Query_transfer_destination,'SUMA')*koef_of_sells),'','-1','1');
        end;}
   // подсчет общей кассы
   self.Edit_expenses_summa.text:=format('%.2f',[Seller_commodity.calculate_amount]);
   // подсчет денег по продавцу

end;

// Подсчет баланса продавца
function TSeller_commodity.calculate_balance: real;
var
   row_counter:integer;
   suma:real;
   control_expenses_kod:integer;
   //koef_of_sells:real;
begin
   //koef_of_sells:=0.10;//koef_of_sells:=0.07;
   for row_counter:=1 to self.field_stringgrid.rowcount-1
   do begin
      try
         control_expenses_kod:=strtoint(self.field_stringgrid.Cells[self.column_expenses_kod,row_counter]);
         if control_expenses_kod in [1,2,3,6,7,9,11]
         then begin
              suma:= suma
                    +strtofloat(self.field_stringgrid.cells[Self.column_amount,row_counter])
                    *strtofloat(self.field_stringgrid.cells[Self.column_expenses_sign_seller,row_counter])
              end;
      except
         suma:=suma+0;
      end;
      end;
   result:=suma;
end;

// Подсчет общей суммы
function TSeller_commodity.calculate_amount: real;
var
   row_counter:integer;
   suma:real;
   control_expenses_kod:integer;
   koef_of_sells:real;
begin
   suma:=0;
   for row_counter:=1 to self.field_stringgrid.rowcount-1
   do begin
      try
         control_expenses_kod:=strtoint(self.field_stringgrid.Cells[self.column_expenses_kod,row_counter]);
         if control_expenses_kod in [1,2,4,5,6,8,10]
         then begin
              suma:=suma+strtofloat(self.field_stringgrid.cells[Self.column_amount,row_counter])*strtofloat(self.field_stringgrid.cells[Self.column_expenses_sign,row_counter])
              end;
      except
         suma:=suma+0;
      end;
      end;
   result:=suma;
end;

procedure TfmPoints_sale.delete1Click(Sender: TObject);
begin
   self.button_expenses_delete.Click;
end;

procedure TfmPoints_sale.point_destination_commodity(query: TIBQuery);
begin
   // продажа по текущему дню
   control_sql_values:=dataModule.TControl_SQL_Values.create;
   query.SQL.clear;
   query.sql.Add('SELECT');
   query.sql.Add('        COMMODITY.KOD COMMODITY_KOD,');
   query.sql.Add('        PEOPLE.FAMILIYA,');
   query.sql.Add('        COMMODITY.ASSORTMENT_KOD COMMODITY_ASSORTMENT_KOD,');
   query.sql.Add('        ASSORTMENT.NAME ASSORTMENT_NAME,');
   query.sql.Add('        ASSORTMENT.NOTE ASSORTMENT_NOTE,');
   query.sql.Add('        COMMODITY.QUANTITY*(-1) QUANTITY,');
   query.sql.Add('        ASSORTMENT.PRICE PRICE,');
   query.sql.Add('        COMMODITY.QUANTITY*ASSORTMENT.PRICE*(-1) SUMA');
   query.sql.Add('FROM COMMODITY');
   query.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
   query.sql.Add('INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD');
   query.sql.Add('INNER JOIN PEOPLE ON PEOPLE.KOD=COMMODITY.MAN_KOD');
   query.sql.Add('WHERE 1=1');
   query.sql.Add('AND COMMODITY.OPERATION_KOD=1');
   query.sql.Add('AND COMMODITY.DATE_IN_OUT ='+chr(39)+self.edit_date_in_out.text+chr(39));
   query.sql.Add('AND COMMODITY.POINT_KOD='+self.point_kod);
   query.sql.Add('AND COMMODITY.MAN_KOD='+self.seller_kod);
   query.sql.Add('ORDER BY assortment.PRICE');
   try
      //clipboard.astext:=query.sql.text;
      query.open;
   except
      on e:exception
      do begin
         showmessage('Утеряно соединение с базой');
         clipboard.astext:=query.sql.text;
         end;
   end;
end;

procedure TfmPoints_sale.point_source_commodity(query: TIBquery);
begin
   // количество товара на торговой точке
   query.SQL.clear;
   query.sql.Add('SELECT');
   query.sql.Add('        POINTS.NAME POINTS_NAME,');
   query.sql.Add('        ASSORTMENT.NAME ASSORTMENT_NAME,');
   query.sql.Add('        ASSORTMENT.KOD ASSORTMENT_KOD,');
   query.sql.Add('        ASSORTMENT.NOTE ASSORTMENT_NOTE,');
   query.sql.Add('        SUM(COMMODITY.QUANTITY) QUANTITY,');
   query.sql.Add('        ASSORTMENT.PRICE PRICE,');
   query.sql.Add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA,');
   query.sql.Add('        ASSORTMENT.PRICE_BUYING,');
   query.sql.Add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE_BUYING SUMA_BUYING');
   query.sql.Add('FROM COMMODITY');
   query.sql.Add('INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD');
   query.sql.Add('                 AND POINTS.KOD='+self.point_kod);
   query.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD');
   query.sql.Add('                     AND ASSORTMENT.VALID=1');
   query.sql.Add('WHERE  1=1');
   query.sql.Add('AND COMMODITY.DATE_IN_OUT <='+chr(39)+self.date_in_out+chr(39));
   query.sql.Add('GROUP BY POINTS.NAME,');
   query.sql.Add('         ASSORTMENT.NAME,');
   query.sql.Add('         ASSORTMENT.KOD,');
   query.sql.Add('         ASSORTMENT.NOTE,');
   query.sql.Add('         ASSORTMENT.PRICE,');
   query.sql.Add('         ASSORTMENT.PRICE_BUYING');
   query.sql.Add('HAVING SUM(COMMODITY.QUANTITY)>0');
   query.sql.Add('ORDER BY POINTS.NAME,ASSORTMENT.PRICE');
   try
      query.open;
   except
      on e:exception
      do begin
         showmessage('Утеряно соединение с базой');
         clipboard.astext:=query.sql.text;
         end;
   end;
end;
procedure TfmPoints_sale.StringGrid_expensesDblClick(Sender: TObject);
begin
   self.button_expenses_add.click;
end;

end.
