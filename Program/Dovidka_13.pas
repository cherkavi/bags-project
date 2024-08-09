unit Dovidka_13;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,dataModule,
  Db, Grids, DBGrids, StdCtrls,ibQuery,comobj,clipbrd;

type
  TfmDovidka_13 = class(TForm)
    combobox_points: TComboBox;
    Label1: TLabel;
    button_execute: TButton;
    grid_main: TDBGrid;
    DataSource1: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure button_executeClick(Sender: TObject);
  private
    { Private declarations }
    // получить дату последнего переучета по торговой точке
    function get_date_last_rediscount(point_name:string):TDateTime;
    // получить COMMODITY.KOD последнего переучета в базе данных
    function get_kod_last_rediscount(point_name:string):String;
    // получить сумму по товару на торговой точке COMMODITY.KOD<=commodity_last_kod
    function get_amount_rediscount(query:TibQuery;point_kod:string;commodity_last_kod:string):real;
    // получить сумму всех продаж после COMMODITY.KOD
    // получить сумму всех довозов после COMMODITY.KOD
    // получить сумму всех списаний после COMMODITY.KOD
    // получить сумму всех положительных перемещений после COMMODITY.KOD
    // получить сумму всех отрицательных перемещений после COMMODITY.KOD
       // получить сумму по коду операции, знаку и COMMODITY.KOD
    function get_amount_on_operation_sign_commodity(query:TibQuery;
                                                    kod_point:string;
                                                    kod_operation:string;
                                                    positive_sign:boolean;
                                                    date_in_out:TDateTime):real;

    // получить сумму по EXPENSES(статьям через запятую) прихода-ухода, по PEOPLE.KOD, по дате "до(включая)"] или "после"(
    function get_amount_on_expenses_people_date(query:TibQuery;
                                                kod_people:string;
                                                kod_expenses:string;
                                                date_in_out:TDateTime;
                                                is_before:boolean):real;
    function get_fio_from_kod(query:TibQuery;kod_people:string):string;
    procedure load_points;
    procedure load_people;

    procedure show_report;
  public
    { Public declarations }
    // загрузка первоначальных данных
    procedure load_data;
  end;

var
  fmDovidka_13: TfmDovidka_13;

implementation

{$R *.DFM}

{ TfmDovidka_13 }

procedure TfmDovidka_13.load_data;
begin
    self.load_points;
    self.load_people;
end;

procedure TfmDovidka_13.load_people;
var
   query:TibQuery;
begin
    try
       query:=TibQuery(self.grid_main.DataSource.DataSet);
       query.sql.text:='SELECT * FROM PEOPLE WHERE POST_KOD=3 ORDER BY KOD';
       query.open;
    except
       showmessage('Ошибка загрузки данных по работникам');
    end;
end;

procedure TfmDovidka_13.load_points;
begin
    try
       fmDataModule.query_temp.sql.text:='SELECT * FROM POINTS WHERE KOD>2';
       fmDataModule.query_temp.open;
       fmDataModule.load_from_query_field_to_combobox(fmDataModule.query_temp,'NAME',self.combobox_points);
       self.combobox_points.itemindex:=0;
    except
        on e:exception
        do begin
           showmessage('Ошибка загрузки данных');
           end;
    end;
end;

procedure TfmDovidka_13.FormShow(Sender: TObject);
begin
    self.load_data;
end;

function TfmDovidka_13.get_date_last_rediscount(point_name: string): TDateTime;
var
   point_kod:string;
   return_value:TDateTime;
begin
    return_value:=0;
    try
        // получить код торговой точки
        point_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+point_name+chr(39),'KOD');
        // получить дату последней записи в таблице COMMODITY.NOTE='REDISCOUNT' and COMMODITY.POINT_KOD=''
        fmDataModule.query_temp.sql.clear;
        fmDataModule.query_temp.sql.Add('SELECT * FROM COMMODITY');
        fmDataModule.query_temp.sql.Add('WHERE');
        fmDataModule.query_temp.sql.Add('COMMODITY.OPERATION_KOD=7 AND');
        fmDataModule.query_temp.sql.Add('COMMODITY.POINT_KOD='+point_kod);
        fmDataModule.query_temp.sql.Add('ORDER BY COMMODITY.KOD DESC');
        fmDataModule.query_temp.open;
        if fmDataModule.query_temp.recordcount>0
        then begin
             fmDataModule.query_temp.First;
             return_value:=fmDataModule.Query_temp.fieldbyname('DATE_IN_OUT').AsDateTime;
             end
        else begin
             return_value:=0;
             end;
    except
        on e:exception
        do begin
           return_value:=0;
           end;
    end;
    result:=return_value;
end;

function TfmDovidka_13.get_kod_last_rediscount(
  point_name: string): String;
var
   point_kod:string;
   return_value:String;
begin
    return_value:='';
    try
        // получить код торговой точки
        point_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+point_name+chr(39),'KOD');
        // получить дату последней записи в таблице COMMODITY.NOTE='REDISCOUNT' and COMMODITY.POINT_KOD=''
        fmDataModule.query_temp.sql.clear;
        fmDataModule.query_temp.sql.Add('SELECT * FROM COMMODITY');
        fmDataModule.query_temp.sql.Add('WHERE');
        fmDataModule.query_temp.sql.Add('COMMODITY.OPERATION_KOD=7 AND');
        fmDataModule.query_temp.sql.Add('COMMODITY.POINT_KOD='+point_kod);
        fmDataModule.query_temp.sql.Add('ORDER BY COMMODITY.KOD DESC');
        fmDataModule.query_temp.open;
        if fmDataModule.query_temp.recordcount>0
        then begin
             fmDataModule.query_temp.First;
             return_value:=fmDataModule.Query_temp.fieldbyname('KOD').AsString;
             end
        else begin
             return_value:='';
             end;
    except
        on e:exception
        do begin
           return_value:='';
           end;
    end;
    result:=return_value;
end;

function TfmDovidka_13.get_amount_on_operation_sign_commodity(query:TibQuery;
                                                              kod_point:string;
                                                              kod_operation: string;
                                                              positive_sign: boolean;
//                                                              commodity_kod: string): real;
                                                              date_in_out:TDateTime):real;
var
    return_value:real;
begin
    return_value:=0;
    try
        query.sql.clear;
        query.sql.add('SELECT QUANTITY,ASSORTMENT.PRICE');
        query.sql.add('FROM COMMODITY');
        query.sql.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
        query.sql.add('WHERE COMMODITY.OPERATION_KOD='+kod_operation);
        query.sql.add('AND COMMODITY.POINT_KOD='+kod_point);
        if positive_sign=true
        then begin
             query.sql.add('AND COMMODITY.QUANTITY>=0');
             end
        else begin
             query.sql.add('AND COMMODITY.QUANTITY<0');
             end;
        //query.sql.add('AND COMMODITY.KOD>'+commodity_kod);
        query.sql.add('AND COMMODITY.DATE_IN_OUT>'+chr(39)+DateToStr(date_in_out)+chr(39));
        clipboard.astext:=query.sql.text;
        query.open;
        if query.recordcount>0
        then begin
             // данные есть
             while not(query.Eof)
             do begin
                return_value:=return_value+query.fieldbyname('QUANTITY').asinteger*query.fieldbyname('PRICE').asfloat;
                query.next;
                end;
             end
        else begin
             // нет данных для отображения
             return_value:=0;
             end;
    except
       on e:exception
       do begin
          return_value:=0;
          end;
    end;
    result:=return_value;
end;


procedure TfmDovidka_13.button_executeClick(Sender: TObject);
begin
    show_report;
end;

procedure TfmDovidka_13.show_report;
var
    excel:variant;
    rediscount_kod_commodity:string;
    kod_people:string;
    kod_point:string;
    rediscount_date:TDatetime;
    rediscount_people_kod:string;
begin
    try
       screen.cursor:=crHourGlass;
       rediscount_kod_commodity:=self.get_kod_last_rediscount(self.combobox_points.text);
       kod_point:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_points.text+chr(39),'KOD');
       kod_people:=self.grid_main.DataSource.dataset.fieldbyname('KOD').asstring;
       rediscount_date:=self.get_date_last_rediscount(self.combobox_points.text);
       rediscount_people_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'COMMODITY','KOD',rediscount_kod_commodity,'MAN_KOD');

       excel:=CreateOleObject('Excel.Application');
       excel.Application.EnableEvents:=true;
       excel.workbooks.add;
       excel.visible:=false;
       //excel.worksheets[1].Cells.item[row_counter,col_counter+1].value:=
       // вывести заголовок
       excel.worksheets[1].columns[1].Columnwidth:=45;
       excel.worksheets[1].columns[2].Columnwidth:=18;
       excel.worksheets[1].columns[3].Columnwidth:=47;
       excel.worksheets[1].columns[4].Columnwidth:=7;

       excel.worksheets[1].Cells.item[1,1].value:='Текущий баланс продавца по торговой точке';
       excel.worksheets[1].Cells.item[1,1].font.bold:=true;
       excel.worksheets[1].Cells.item[1,1].font.size:=12;
       excel.worksheets[1].Cells.item[2,1].value:='Торговая точка:';
       excel.worksheets[1].Cells.item[2,1].font.bold:=true;

       excel.worksheets[1].Cells.item[2,2].value:=self.combobox_points.text;

       excel.worksheets[1].Cells.item[2,3].value:='Продавец:';
       excel.worksheets[1].Cells.item[2,3].font.bold:=true;
       excel.worksheets[1].Cells.item[2,3].HorizontalAlignment:=4;

       excel.worksheets[1].Cells.item[2,4].value:=self.grid_main.DataSource.DataSet.FieldByName('FAMILIYA').asString+' '+self.grid_main.DataSource.DataSet.FieldByName('IMYA').asString+'  '+self.grid_main.DataSource.DataSet.FieldByName('OTCHESTVO').asString;
       excel.worksheets[1].Cells.item[2,4].font.bold:=true;

       // вывести часть, касательно товара на торговой точке
           // вывести дату переучета и сумму по товару
       excel.worksheets[1].Cells.item[4,1].value:='Дата переучета:';
       excel.worksheets[1].Cells.item[4,2].value:=DatetoStr(self.get_date_last_rediscount(self.combobox_points.text));
       excel.worksheets[1].cells.item[4,3].value:='(переучет на продавце: '+self.get_fio_from_kod(fmDataModule.query_temp,rediscount_people_kod)+')';
       excel.worksheets[1].cells.item[4,3].font.bold:=true;
       excel.worksheets[1].Cells.item[5,1].value:='Сумма по товару после переучета:';
       excel.worksheets[1].Cells.item[5,2].value:=self.get_amount_rediscount(fmDataModule.query_temp,kod_point,rediscount_kod_commodity);
           // вывести продажи после переучета
       excel.worksheets[1].Cells.item[6,1].value:='Продажи после переучета (после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+'):';
       excel.worksheets[1].cells.item[6,2].value:=self.get_amount_on_operation_sign_commodity(fmDataModule.query_temp,
                                                                                              kod_point,
                                                                                              '1',
                                                                                              false,
                                                                                              rediscount_date);
           // вывести довозы после переучета
       excel.worksheets[1].Cells.item[7,1].value:='Довозы после переучета(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+'):';
       excel.worksheets[1].cells.item[7,2].value:=self.get_amount_on_operation_sign_commodity(fmDataModule.query_temp,
                                                                                              kod_point,
                                                                                              '2',
                                                                                              true,
                                                                                              rediscount_date);
           // списание товара
       excel.worksheets[1].cells.item[8,1].value:='Списание(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+'):';
       excel.worksheets[1].cells.item[8,2].value:=self.get_amount_on_operation_sign_commodity(fmDataModule.query_temp,
                                                                                              kod_point,
                                                                                              '3',
                                                                                              true,
                                                                                              rediscount_date);

           // вывести перемещения положительные после переучета
       excel.worksheets[1].cells.item[9,1].value:='Положительные перемещения(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+'):';
       excel.worksheets[1].cells.item[9,2].value:=self.get_amount_on_operation_sign_commodity(fmDataModule.query_temp,
                                                                                              kod_point,
                                                                                              '4',
                                                                                              true,
                                                                                              rediscount_date);

           // вывести перемещения отрицательные после переучета
       excel.worksheets[1].cells.item[10,1].value:='Отрицательные перемещения(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+'):';
       excel.worksheets[1].cells.item[10,2].value:=self.get_amount_on_operation_sign_commodity(fmDataModule.query_temp,
                                                                                              kod_point,
                                                                                              '4',
                                                                                              false,
                                                                                              rediscount_date);

       // вывести часть, касательно финансовой части продавца
       excel.worksheets[1].Cells.item[5,3].value:='Баланс продавца после переучета(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+'):';
       excel.worksheets[1].Cells.item[5,4].value:=self.get_amount_on_expenses_people_date(fmDataModule.query_temp,
                                                                                          kod_people,
                                                                                          '1,2,3,6,7,9,11',
                                                                                          rediscount_date,
                                                                                          true
                                                                                          );
       excel.worksheets[1].Cells.item[6,3].value:='Выручка в кассу(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+')';
       excel.worksheets[1].Cells.item[6,4].value:=self.get_amount_on_expenses_people_date(fmDataModule.query_temp,
                                                                                          kod_people,
                                                                                          '2',
                                                                                          rediscount_date,
                                                                                          false
                                                                                          );
       excel.worksheets[1].Cells.item[7,3].value:='Зарплата(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+')';
       excel.worksheets[1].Cells.item[7,4].value:=self.get_amount_on_expenses_people_date(fmDataModule.query_temp,
                                                                                          kod_people,
                                                                                          '7',
                                                                                          rediscount_date,
                                                                                          false
                                                                                          );
       excel.worksheets[1].Cells.item[8,3].value:='Деньги в кассу(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+')';
       excel.worksheets[1].Cells.item[8,4].value:=self.get_amount_on_expenses_people_date(fmDataModule.query_temp,
                                                                                          kod_people,
                                                                                          '6',
                                                                                          rediscount_date,
                                                                                          false
                                                                                          );
       excel.worksheets[1].Cells.item[9,3].value:='Выдача денег(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+')';
       excel.worksheets[1].Cells.item[9,4].value:=self.get_amount_on_expenses_people_date(fmDataModule.query_temp,
                                                                                          kod_people,
                                                                                          '1',
                                                                                          rediscount_date,
                                                                                          false
                                                                                          );
       excel.worksheets[1].Cells.item[10,3].value:='Штраф(после '+DatetoStr(self.get_date_last_rediscount(self.combobox_points.text))+')';
       excel.worksheets[1].Cells.item[10,4].value:=self.get_amount_on_expenses_people_date(fmDataModule.query_temp,
                                                                                          kod_people,
                                                                                          '3',
                                                                                          rediscount_date,
                                                                                          false
                                                                                          );

       excel.visible:=true;
       screen.cursor:=crDefault;
    except
       on e:exception
       do begin
          screen.cursor:=crDefault;
          showmessage('Ошибка вывода данных в файл:'+e.message);
          end;
    end;

end;

function TfmDovidka_13.get_amount_rediscount(query:TibQuery;point_kod:string;commodity_last_kod: string): real;
var
    return_value:real;
begin
    return_value:=0;
    try
        query.sql.clear;
        query.sql.add('SELECT  SUM(COMMODITY.QUANTITY) QUANTITY,');
        query.sql.add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE AMOUNT');
        query.sql.add('FROM COMMODITY');
        query.sql.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
        query.sql.add('WHERE 1=1');
        query.sql.add('and commodity.point_kod='+point_kod);
        query.sql.add('AND COMMODITY.kod<='+commodity_last_kod);
        query.sql.add('GROUP BY COMMODITY.ASSORTMENT_KOD,');
        query.sql.add('         ASSORTMENT.NAME,');
        query.sql.add('         ASSORTMENT.NOTE,');
        query.sql.add('         ASSORTMENT.PRICE');
        query.sql.add('HAVING SUM(COMMODITY.QUANTITY)<>0');
        query.sql.add('ORDER BY ASSORTMENT.PRICE');
        query.open;
        if query.recordcount>0
        then begin
             // данные есть
             while not(query.Eof)
             do begin
                return_value:=return_value+query.fieldbyname('AMOUNT').asfloat;
                query.next;
                end;
             end
        else begin
             // нет данных для отображения
             return_value:=0;
             end;
    except
       on e:exception
       do begin
          return_value:=0;
          end;
    end;
    result:=return_value;
end;

function TfmDovidka_13.get_amount_on_expenses_people_date(query: TibQuery;
                                                          kod_people,
                                                          kod_expenses:string;
                                                          date_in_out: TDateTime;
                                                          is_before: boolean): real;
var
    return_value:real;
begin
    return_value:=0;
    try
        query.sql.clear;
        query.sql.add('SELECT SUM(MONEY.AMOUNT*(EXPENSES.SIGN_SELLER)) AMOUNT');
        query.sql.add('FROM MONEY');
        query.sql.add('INNER JOIN PEOPLE ON PEOPLE.KOD=MONEY.KOD_MAN');
        query.sql.add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
        query.sql.add('WHERE PEOPLE.KOD='+kod_people);
        query.sql.add('AND EXPENSES.KOD IN ('+kod_expenses+')');
        if(is_before)
        then begin
             query.sql.add('AND MONEY.DATE_IN_OUT<='+chr(39)+DateToStr(date_in_out)+chr(39));
             end
        else begin
             query.sql.add('AND MONEY.DATE_IN_OUT>'+chr(39)+DateToStr(date_in_out)+chr(39));
             end;
        clipboard.astext:=query.sql.text;
        query.open;
        if query.recordcount>0
        then begin
             // данные есть
             return_value:=query.fieldbyname('AMOUNT').asfloat;
             end
        else begin
             // нет данных для отображения
             return_value:=0;
             end;
    except
       on e:exception
       do begin
          return_value:=0;
          end;
    end;
    result:=return_value;
end;

function TfmDovidka_13.get_fio_from_kod(query: TibQuery;
  kod_people: string): string;
var
    return_value:string;
begin
    return_value:='';
    try
       query.sql.text:='SELECT * FROM PEOPLE WHERE KOD='+kod_people;
       query.open;
       if query.RecordCount>0
       then begin
            return_value:=query.fieldbyname('FAMILIYA').asString+' '+query.fieldbyname('IMYA').asString+' '+query.fieldbyname('OTCHESTVO').asString+' ';
            end;
    except

    end;

    result:=return_value;
end;

end.
