unit Points_Sale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids,IBQuery,datamodule;

type
  TfmPoints_sale = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edit_points: TEdit;
    edit_date: TEdit;
    Label_source: TLabel;
    Label_destination: TLabel;
    grid_source: TStringGrid;
    grid_destination: TStringGrid;
    button_down: TButton;
    Button_up: TButton;
    label_source_sum: TLabel;
    label_destination_sum: TLabel;
    Label3: TLabel;
    edit_seller: TEdit;
    button_ok: TButton;
    label_destination_sum_add: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure button_downClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button_upClick(Sender: TObject);
    procedure button_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    seller_kod:string;
    point_kod:string;
    operator_kod:string;
    sells_sum:real;
    access:dataModule.Taccess;
    procedure data_from_query_to_grid(query:TIBQuery;grid:TstringGrid);
    procedure grid_set_headers(grid:Tstringgrid);
    function calculate_sum(grid:TstringGrid;column_suma:integer):real;
    procedure add_commodity_to_grid(assortment_kod,name,price:string;quantity:integer;grid:TStringgrid);
    procedure delete_commodity_from_grid(assortment_kod:string;quantity:integer;grid:TstringGrid);
    procedure delete_rows_from_grid(grid:TstringGrid;delete_index:integer);
    procedure check_for_fixed_column(grid:TstringGrid);
    function grid_to_commodity(grid:TstringGrid;query:TIBQuery):integer;
  end;

var
  fmPoints_sale: TfmPoints_sale;

implementation

uses Point_Sale_Transaction;

{$R *.DFM}

{ TfmPoints_sale }

procedure TfmPoints_sale.data_from_query_to_grid(query: TIBQuery;
  grid: TstringGrid);
var
   row_count,row_counter:integer;
begin
   if query.RecordCount>0
   then begin
        query.First;row_count:=0;
        while not(query.Eof)
        do begin
           query.Next;
           inc(row_count);
           end;
        grid.rowcount:=row_count+1;
        query.first;
        for row_counter:=1 to grid.rowcount-1
        do begin
           grid.Cells[0,row_counter]:=query.fieldbyname('ASSORTMENT_KOD').asstring;// Код
           grid.Cells[1,row_counter]:=query.fieldbyname('NAME').asstring;// Наименование
           grid.Cells[2,row_counter]:=query.fieldbyname('QUANTITY').asstring; // Количество
           grid.Cells[3,row_counter]:=query.fieldbyname('PRICE').asstring; // Цена
           grid.Cells[4,row_counter]:=query.fieldbyname('SUMA').asstring; // Сумма
           query.next;
           end;
        end
   else begin
        grid.rowcount:=1;
        end;
end;

procedure TfmPoints_sale.grid_set_headers(grid: Tstringgrid);
begin
grid.Cells[0,0]:='Код';
grid.Cells[1,0]:='Наименование';
grid.Cells[2,0]:='Кол-во';
grid.Cells[3,0]:='Цена';
grid.Cells[4,0]:='Сумма';
end;

procedure TfmPoints_sale.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
   self.grid_set_headers(self.grid_source);
   self.grid_set_headers(self.grid_destination);
   self.sells_sum:=0;
end;

procedure TfmPoints_sale.button_downClick(Sender: TObject);
var
   row_source:integer;
begin
   row_source:=self.grid_source.Selection.top;
   if (self.grid_source.Selection.top>0) and (self.grid_source.Cells[0,row_source]<>'') and (row_source<>0)
   then begin
        //self.grid_source.cells[0,self.grid_source.Selection.top];
        fmPoint_Sale_Transaction:=TfmPoint_Sale_Transaction.create(self);
        fmPoint_Sale_Transaction.edit_seller.text:=self.edit_seller.text;
        fmPoint_Sale_Transaction.edit_points.text:=self.edit_points.text;
        fmPoint_Sale_Transaction.edit_date.text:=self.edit_date.text;
        fmPoint_Sale_Transaction.Edit_kod.text:=self.grid_source.cells[0,row_source]; // код
        fmPoint_Sale_Transaction.Edit_name.text:=self.grid_source.cells[1,row_source]; // Наименование
        fmPoint_Sale_Transaction.Edit_price.text:=self.grid_source.cells[3,row_source]; // Цена
        fmPoint_Sale_Transaction.Edit_quantity.maxvalue:=strtoint(self.grid_source.cells[2,row_source]);
        fmPoint_Sale_Transaction.Edit_quantity.minvalue:=1;
        fmPoint_Sale_Transaction.Edit_quantity.intValue:=1;
        if fmPoint_Sale_Transaction.Edit_quantity.maxvalue=1
        then fmPoint_Sale_Transaction.Edit_quantity.readonly:=true;
        fmPoint_Sale_Transaction.Edit_suma.text:=self.grid_source.cells[3,row_source]; //Сумма
        if fmPoint_Sale_Transaction.showmodal=mrOk
        then begin
             // внести изменения
             self.add_commodity_to_grid(self.grid_source.cells[0,row_source],self.grid_source.cells[1,row_source],self.grid_source.cells[3,row_source],fmPoint_Sale_Transaction.Edit_quantity.IntValue,self.grid_destination);
             self.delete_commodity_from_grid(self.grid_source.cells[0,row_source],fmPoint_Sale_Transaction.Edit_quantity.IntValue,self.grid_source);
             // подсчет остатков
             label_source_sum.caption:=format('%.2f',[self.calculate_sum(self.grid_source,4)]);
             label_destination_sum.caption:=format('%.2f',[self.calculate_sum(self.grid_destination,4)]);// Сумма
             // проверка Grid на 2 строки
             self.check_for_fixed_column(self.grid_source);
             self.check_for_fixed_column(self.grid_destination);
             end
        else begin
             // пользователь отказался от изменений
             
             end;
        freeandnil(fmPoint_Sale_Transaction);
        end
   else begin
        showmessage('Выберите пожалуйста запись для переноса в продажи')
        end;
end;

function TfmPoints_sale.calculate_sum(grid: TstringGrid;
  column_suma: integer): real;
var
   row_counter:integer;
   suma:real;
begin
   suma:=0;
   for row_counter:=1 to grid.RowCount-1
   do begin
      try
         suma:=suma+strtofloat(grid.cells[column_suma,row_counter])
      except
         suma:=suma;
      end;
      end;
   result:=suma;
end;

procedure TfmPoints_sale.FormShow(Sender: TObject);
begin
   label_source_sum.caption:=format('%.2f',[self.calculate_sum(self.grid_source,4)]);
   label_destination_sum.caption:=format('%.2f',[self.calculate_sum(self.grid_destination,4)]);// Сумма
   if self.sells_sum<>0
   then begin
        self.label_destination_sum_add.Caption:='('+format('%.2f',[self.sells_sum])+')';
        end
   else begin
        self.Label_destination_sum_add.Visible:=false;
        end;
end;

procedure TfmPoints_sale.add_commodity_to_grid(assortment_kod,name,price: string;
  quantity: integer; grid: TStringgrid);
var
   row_counter:integer;
   row_destination:integer;
begin
   // проверка на наличие данного кода
   row_destination:=0;
   for row_counter:=1 to grid.rowcount-1
   do begin
      if trim(grid.Cells[0,row_counter])=trim(assortment_kod)
      then begin
           row_destination:=row_counter;
           break;
           end;
      end;
   if row_destination=0
   then begin
        // добавляем запись для новой позиции
        if (grid.rowcount=2) and (grid.cells[0,1]='')
        then begin
             // вторая строка пустая - первая загрузка
             end
        else begin
             grid.rowcount:=grid.rowcount+1;
             end;
        grid.Cells[0,grid.rowcount-1]:=assortment_kod;
        grid.Cells[1,grid.rowcount-1]:=name;
        grid.Cells[2,grid.rowcount-1]:=inttostr(quantity);
        grid.Cells[3,grid.rowcount-1]:=price;
        try
           grid.Cells[4,grid.rowcount-1]:=format('%.2f',[strtofloat(price)*quantity]);
        except
           grid.Cells[2,grid.rowcount-1]:=inttostr(1);
           grid.Cells[4,grid.rowcount-1]:=price;
        end;
        end
   else begin
        // добавляем в row_destination - повторный выбор позиции
        grid.Cells[2,grid.rowcount-1]:=inttostr(quantity+strtoint(grid.Cells[2,grid.rowcount-1]));
        try
           grid.Cells[4,grid.rowcount-1]:=format('%.2f',[strtofloat(price)*strtoint(grid.Cells[2,grid.rowcount-1])]);
        except
           grid.Cells[2,grid.rowcount-1]:=inttostr(1);
           grid.Cells[4,grid.rowcount-1]:=price;
        end;
        end;
end;

procedure TfmPoints_sale.delete_commodity_from_grid(assortment_kod: string;
  quantity: integer; grid: TstringGrid);
var
   row_counter:integer;
   quantity_all:integer;
begin
   for row_counter:=1 to grid.rowcount-1
   do begin
      if trim(grid.Cells[0,row_counter])=trim(assortment_kod)
      then begin
           quantity_all:=strtoint(grid.cells[2,row_counter]);
           if quantity_all<=quantity
           then begin
                self.delete_rows_from_grid(grid,row_counter);
                end
           else begin
                grid.Cells[2,row_counter]:=inttostr(quantity_all-quantity);
                try
                   grid.Cells[4,row_counter]:=format('%.2f',[strtoint(grid.Cells[2,row_counter])*strtofloat(grid.Cells[3,row_counter])]);
                except
                   grid.Cells[4,row_counter]:='';
                end;
                end;
           break;
           end;
      end;
end;

procedure TfmPoints_sale.delete_rows_from_grid(grid: TstringGrid;
  delete_index: integer);
var
   column_counter,row_counter:integer;
begin
if delete_index<grid.RowCount
then begin
     if delete_index=grid.rowcount-1
     then begin
          // индекс последний - просто удаляем
          for column_counter:=0 to grid.colcount-1
          do begin
             grid.Cells[column_counter,delete_index]:='';
             end;
          // переназначение размерности
          grid.rowcount:=grid.rowcount-1;
          end
     else begin
          // очистка удаляемого поля
          for column_counter:=0 to grid.colcount-1
          do begin
             grid.Cells[column_counter,delete_index]:='';
             end;
          // сдвиг значений на одно вверх
          for row_counter:=delete_index+1 to grid.rowcount-1
          do begin
             for column_counter:=0 to grid.colcount-1
             do begin
                grid.Cells[column_counter,row_counter-1]:=grid.Cells[column_counter,row_counter];
                end
             end;
          // переназначение размерности
          grid.rowcount:=grid.rowcount-1;
          end;
     end
else begin
     // индекс для удаления за пределами
     end;
end;

procedure TfmPoints_sale.check_for_fixed_column(grid: TstringGrid);
begin
   if grid.rowcount=1
   then begin
        grid.rowcount:=2;
        grid.FixedRows:=1;
        end;
end;

procedure TfmPoints_sale.Button_upClick(Sender: TObject);
var
   row_source:integer;
begin
   row_source:=self.grid_destination.Selection.top;
   if (self.grid_destination.Selection.top>0) and (self.grid_destination.Cells[0,row_source]<>'') and (row_source<>0)
   then begin
        // внести изменения
        self.add_commodity_to_grid(self.grid_destination.cells[0,row_source],
                                 self.grid_destination.cells[1,row_source],
                                 self.grid_destination.cells[3,row_source],
                                 strtoint(self.grid_destination.cells[2,row_source]),
                                 self.grid_source);
        self.delete_commodity_from_grid(self.grid_destination.cells[0,row_source],
                                      strtoint(self.grid_destination.cells[2,row_source]),
                                      self.grid_destination);
        // подсчет остатков
        label_source_sum.caption:=format('%.2f',[self.calculate_sum(self.grid_source,4)]);
        label_destination_sum.caption:=format('%.2f',[self.calculate_sum(self.grid_destination,4)]);// Сумма
        // проверка Grid на 2 строки
        self.check_for_fixed_column(self.grid_source);
        self.check_for_fixed_column(self.grid_destination);
        end;
end;

procedure TfmPoints_sale.button_okClick(Sender: TObject);
var
   result_temp:integer;
begin
   result_temp:=self.grid_to_commodity(self.grid_destination,fmDataModule.query_temp);
   if result_temp>=0
   then begin
        modalResult:=mrOk;
        end
   else begin
        showmessage('Критическая ошибка в сохранении продаж - обратитесь к разработчику'+chr(13)+chr(10)+' Не были сохранены '+inttostr(result_temp)+' записи');
        end;
end;

function TfmPoints_sale.grid_to_commodity(grid: TstringGrid;
  query: TIBQuery): integer;
var
   commodity:DataModule.TCommodity;
   row_counter:integer;
   return_result:integer;
   write_date:string;
begin
   // проверка на пустые данные
   return_result:=0;
   if (grid.rowcount=2) and (trim(grid.Cells[0,1])='')
   then begin
        result:=mrOk;
        end
   else begin
        commodity:=DataModule.TCommodity.Create;
        write_date:=datetimetostr(now);
        for row_counter:=1 to grid.rowcount-1
        do begin
           commodity.clear;
           commodity.field_assortment_kod:=grid.cells[0,row_counter];// Код
           commodity.field_date_in_out:=self.edit_date.text;
           commodity.field_man_kod:=self.seller_kod;
           commodity.field_note:='';
           commodity.field_operation_kod:='1';
           commodity.field_point_kod:=self.point_kod;
           commodity.field_quantity:='-'+grid.Cells[2,row_counter];
           commodity.field_writer:=operator_kod;
           commodity.field_write_date:=write_date;
           if commodity.save(query)<>''
           then return_result:=return_result-1;
           end;
        freeandnil(commodity);
        end;
   result:=return_result;
end;

end.
