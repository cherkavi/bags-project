unit DataModule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, IBCustomDataSet, IBQuery, IBDatabase,stdctrls,clipbrd,grids,comobj,CheckLst;

type
  TfmDataModule = class(TDataModule)
    DataBase_main: TIBDatabase;
    Transaction_main: TIBTransaction;
    Query_temp: TIBQuery;
    query_assortment: TIBQuery;
    query_people: TIBQuery;
    query_points: TIBQuery;
    query_point_0_view: TIBQuery;
    query_assortment_view: TIBQuery;
    Query_transfer_source: TIBQuery;
    Query_transfer_destination: TIBQuery;
    query_dovidka_1: TIBQuery;
    query_expenses: TIBQuery;
    query_points_sale_skip: TIBQuery;
    query_PayDesk_preambule: TIBQuery;
    query_PayDesk_commodity: TIBQuery;
    Query_PayDesk_Money: TIBQuery;
    Query_Buying: TIBQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  function add_chr_39(s:string):string;
  function load_from_query_field_to_stringlist(query:TibQuery;field:string;var stringlist:Tstringlist):cardinal;
  function load_from_query_field_to_combobox(query:TibQuery;field:string;combobox:Tcombobox):cardinal;
  function load_from_query_field_to_stringgrid(query:TIBQuery;var stringgrid:TStringGrid;header_not_fill:boolean):String;
  
  function delete_record(query:TibQuery;s:array of string):string;
  function insert_record(query:TibQuery;s:array of string):string;
  function update_record(query:TibQuery;table_name:string;s_new:array of string;s_old:array of string):string;
  function open_query_for_where(query:TibQuery;selected_fields:string;table_name:string;parametrs_where:array of string;left_join_fields:string;order_by_fields:string):string;
  function get_name_by_id(query:TIBQuery;table_name:string;searching_field_name:string;searching_string:string;result_field_name:string):string;

  function load_to_combobox_from_table_from_field(query:TibQuery;combobox_for_load:TCombobox;table_name:string;field_name:string;where_string:string='';order_by_string:string=''):string;
  function load_to_combobox_from_table_from_fields(query:TibQuery;combobox_for_load:TCombobox;table_name:string;fields_name:array of string;delimeter:string;where_string:string='';order_by_string:string=''):string;
  function load_to_stringgrid_from_table(query:TIbQuery;var stringgrid:Tstringgrid;table_name:string;field_name:array of string;where_string:string;header_for_stringgrid:array of string):string;
  function load_to_strings_from_table_from_field(query:TibQuery;strings_for_load:TStrings;table_name:string;field_name:string;where_string:string='';order_by_string:string=''):string;
  function load_to_stringlist_from_table_from_field(query:TibQuery;stringlist_for_load:TStringlist;table_name:string;field_name:string;where_string:string='';order_by_string:string=''):string;
  function load_to_stringlist_from_table_from_field_where_in(query:TIBQuery;string_list_for_load:Tstringlist;table_name:string;field_name,field_in_name:string;where_in:tstringlist;order_by:string):string;
  function load_to_string_comma_determinate_do_from_table_from_field_where_in(query:TIBQuery;var string_load:string;table_name:string;field_name,field_out:string;where_in:tstringlist;order_by:string):string;

  function change_order(query:TIBQuery;order_field:string):string;
  function get_max_id(query:TIBQuery;table_name,field_name:string;var result_value:integer;where_string:string=''):string;
  function id_exists(table_name,field_name,field_value:string;query:TIBQuery):integer;
  function get_record_count(query:TibQuery):integer;
  function calculate_sum_from_query_from_field(query:TIBQuery;field_name:string):real;

  procedure clear_stringgrid(grid:TStringGrid);
  procedure query_to_excel(dataset: TDataSet);
  procedure checklistbox_clear(checklistbox:TCheckListBox);
  procedure checklistbox_invert(checklistbox:TChecklistBox);
  function get_record_count_into_table(table_name: string;query: TibQuery): integer;  
  end;

TControl_SQL_Values=class
   public
   function add_chr_39(s:string):string;// добавление символа ' для строк
   function change_chr_34_to_chr_39(s:string):string; // замена символа " на ''
   function change_chr_44_to_chr_46(s:string):string; // замена для float , на .
   function check(s:string):string;
end;

TASSORTMENT=class
   public
   field_kod:string;
   field_name:string;
   field_note:string;
   field_price:string;
   field_valid:string;
   field_price_buying:string;
   constructor create;
   procedure clear;
   function check_length:string;
   function load_by_kod(kod:string;query:TIBQuery):boolean;
   function delete_by_kod(kod:string;query:TIBQuery):string;
   function save(query:TIBQuery):string;
   function delete_valid_to_zero(kod:string;query:TIBQuery):string;
   procedure copy_from(destination:TAssortment);
   procedure copy_to(source:TAssortment);
   function isUniqueName(query:TIBQuery):boolean;
end;
TCommodity=class
   public
   field_kod:string;
   field_assortment_kod:string;
   field_date_in_out:string;
   field_man_kod:string;
   field_note:string;
   field_operation_kod:string;
   field_point_kod:string;
   field_quantity:string;
   field_writer:string;
   field_write_date:string;
   procedure clear;
   constructor create;
   function load_by_kod(kod:string;query:TIBQuery):boolean;
   function delete_by_kod(kod:string;query:TIBQuery):string;
   function save(query:TIBQuery):string;
   function get_assortment_name(query:TIBQuery):string;
   function get_assortment_price(query:TIBQuery):string;
end;
TOperation=class
   public
   field_kod:string;
   field_name:string;
   field_note:string;
   procedure clear;
   function load_by_kod(kod:string;query:TIBQuery):boolean;
   function delete_by_kod(kod:string;query:TIBQuery):string;
   function save(query:TIBQuery):string;
end;
TPeople=class
   public
   field_kod:string;
   field_familiya:string;
   field_imya:string;
   field_otchestvo:string;
   field_date_begin:string;
   field_passport:string;
   field_ident_kod:string;
   field_post_kod:string;
   field_phone:string;
   field_home:string;
   procedure clear;
   function load_by_kod(kod:string;query:TIBQuery):boolean;
   function delete_by_kod(kod:string;query:TIBQuery):string;
   function save(query:TIBQuery):string;
   function get_post_name(query:TIBQuery):string;
   function check_length:string;
   procedure copy_from_skip_kod(source:TPeople);
   function get_balance(people_kod:string;date_in_out:string;query:TIBQuery):real;
end;
TPoints=class
   public
   field_kod:string;
   field_name:string;
   field_address:string;
   field_rayon:string;
   field_arenda:string;
   procedure clear;
   function check_length:string;
   function load_by_kod(kod:string;query:TIBQuery):boolean;
   function delete_by_kod(kod:string;query:TIBQuery):string;
   function save(query:TIBQuery):string;
end;
TPosts=class
   public
   field_kod:string;
   field_name:string;
   procedure clear;
   function load_by_kod(kod:string;query:TIBQuery):boolean;
   function delete_by_kod(kod:string;query:TIBQuery):string;
   function save(query:TIBQuery):string;
end;
TExpenses=class
   public
   field_kod:string;
   field_name:string;
   field_sign:string;
   procedure clear;
   function check_length:string;
   function load_by_kod(kod:string;query:TIBQuery):boolean;
   function delete_by_kod(kod:string;query:TIBQuery):string;
   function save(query:TIBQuery):string;
end;
TMoney=class
   public
   field_kod:string;
   field_kod_point:string;
   field_kod_expenses:string;
   field_amount:string;
   field_kod_man:string;
   field_kod_writer:string;
   field_date_writer:string;
   field_date_in_out:string;
   field_note:string;
   constructor create;
   procedure clear;
   function load_by_kod(kod:string;query:TIBQuery):boolean;
   function delete_by_kod(kod:string;query:TIBQuery):string;
   function save(query:TIBQuery):string;
end;
// класс для разделения пользователей
TAccess=class
   public
   field_hdd_serial:cardinal;
   field_hdd_must_by_serial:cardinal;
   field_user_kod:string;
   field_application_title:string;
   field_application_color:TColor;
   constructor create;
   procedure clear;
   procedure copy_to(var destination:TAccess);
end;


var
  fmDataModule: TfmDataModule;
  control_sql_values:Tcontrol_sql_values;
implementation

{$R *.DFM}
function each_element_not_empty(s:array of string):integer;overload;
var
i,predel_low,predel_high:integer;
flag:integer;
begin
flag:=0;
predel_low:=low(s);
predel_high:=high(s);
for i:=predel_low to predel_high
do begin
   if trim(s[i])<>''
   then flag:=flag+1;
   end;
result:=flag;
end;

function each_element_not_empty(s:tstringlist):integer;overload;
var
i:integer;
flag:integer;
begin
flag:=0;
for i:=0 to s.count-1
do begin
   if trim(s.Strings[i])<>''
   then flag:=flag+1;
   end;
result:=flag;
end;

// функц_я подвоєння знаку chr(39) для застосування строки в TQuery.sql.text
function TfmDataModule.add_chr_39(s:string):string;
var
k:integer;
begin
k:=pos(chr(39),s);
if k>0
then begin
     s:=copy(s,1,k-1)+chr(39)+chr(39)+add_chr_39(copy(s,k+1,length(s)-k));
     add_chr_39:=s;
     end
else add_chr_39:=s;
end;

function is_expression(s:string):boolean;
begin
s:=trim(s);
if (s='<>') or (s='=') or (s='<') or (s='>')
then is_expression:=true
else is_expression:=false;
end;

// маючи 'ID' потр_бного елементу отримати його 'NAME'
function TfmDataModule.get_name_by_id(query:TIBQuery;table_name:string;searching_field_name:string;searching_string:string;result_field_name:string):string;
var
string_temp:string;
result_string:string;
begin
result_string:='';
try
   query.SQL.Clear;
   searching_string:=ansiuppercase(trim(searching_string));
   if (searching_string[1]=chr(39)) and (searching_string[length(searching_string)]=chr(39))
   then begin
        searching_string:=control_sql_values.add_chr_39(copy(searching_string,2,length(searching_string)-2));
        string_temp:='SELECT '+ result_field_name+' FROM '+table_name+' WHERE TRIM_NEW(RUPPER('+searching_field_name+'))='+chr(39)+searching_string+chr(39)
        end
   else string_temp:='SELECT '+ result_field_name+' FROM '+table_name+' WHERE '+searching_field_name+'='+searching_string;
   query.sql.add(string_temp);
   //clipboard.astext:=string_temp;
   query.open;
   result_string:=query.fieldbyname(result_field_name).asstring;
except
   clipboard.astext:=query.sql.text;
end;
get_name_by_id:=result_string;
end;

// проверка существования поля с ключом table_name.field_name=field_value
function TfmDataModule.id_exists(table_name, field_name,field_value: string;
  query: TIBQuery): integer;
begin
try
   query.sql.clear;
   query.sql.text:='SELECT '+field_name+' FROM '+table_name+' WHERE '+field_name+'='+field_value;
   query.open;
   result:=query.recordcount;
except
   result:=-1
end;
end;

// функция получения максимального ID
function TfmDataModule.get_max_id(query:TIBQuery;table_name,field_name:string;var result_value:integer;where_string:string=''):string;
begin
try
   query.sql.clear;
   query.sql.add('SELECT MAX('+field_name+')    FROM '+table_name+chr(13)+chr(10));
   if where_string<>''
   then begin
        query.sql.add('WHERE '+where_string);
        end;
   query.open;
   if query.recordcount=0
   then result_value:=0
   else result_value:=query.Fields[0].asinteger;
   result:='';
except
   on e:exception
   do begin
      result_value:=0;
      result:=e.message;
      end;
end;
end;

// процедура установки/установки на противоположную значения ORDER BY в запросе
function TfmDataModule.change_order(query:TIBQuery;order_field:string):string;
var
sql_text:string;
temp_string:string;
string_tail:string;
separator:integer;
position_order_field:integer;
begin
try
   // нужно получить данные о сортировке из query.sql.text, это последняя часть и может быть расположена на разных строках
   temp_string:=query.sql.text;
   if trim(temp_string)=''
   then raise Exception.create('empty query');
   temp_string:=ansiuppercase(temp_string);
   separator:=pos('ORDER BY',temp_string);
   if query.active=true
   then sql_text:=query.sql.text
   else sql_text:='';
   if separator=0
   then begin
        try
           // если поля ORDER BY не было, тогда мы его просто добавляем
           temp_string:=temp_string+chr(13)+chr(10)+'ORDER BY '+order_field+' DESC';
           query.SQL.text:=temp_string;
           query.open;
        except
           // ошибка при создании текста запроса - возвращаем все назад, как и было
           clipboard.astext:=query.sql.text;
           query.SQL.text:=sql_text;
           if sql_text<>''
           then query.open;
           raise Exception.create('Error in create query text');
        end;
        end
   else begin
        // если ORDER BY есть, то нужно проверить нужно ли делать обратную сортировку, исходя из нужного поля
        string_tail:=copy(temp_string,separator,length(temp_string)-separator);
        position_order_field:=pos(ansiuppercase(order_field),string_tail);
        if position_order_field=0
        then begin
             // данного поля в тексте нет, нужно вставить его в ORDER BY
             try
                // если поля ORDER BY не было, тогда мы его просто добавляем
                temp_string:=copy(temp_string,1,separator-1)+' ORDER BY '+order_field+' DESC';
                query.SQL.text:=temp_string;
                query.open;
             except
                // ошибка при создании текста запроса - возвращаем все назад, как и было
                query.SQL.text:=sql_text;
                if sql_text<>''
                then query.open;
                raise Exception.create('Error in create query text');
             end;
             end
        else begin
             // данное поле есть, нужно выбрать сортировку
             if pos(' DESC',string_tail)<>0
             then begin
                  // данного поля в тексте нет, нужно вставить его в ORDER BY
                  try
                     // если поля ORDER BY не было, тогда мы его просто добавляем
                     temp_string:=copy(temp_string,1,separator-1)+' ORDER BY '+order_field+' ASC';
                     query.SQL.text:=temp_string;
                     query.open;
                  except
                     // ошибка при создании текста запроса - возвращаем все назад, как и было
                     query.SQL.text:=sql_text;
                     if sql_text<>''
                     then query.open;
                     raise Exception.create('Error in create query text');
                  end;
                  end
             else begin
                  // данного поля в тексте нет, нужно вставить его в ORDER BY
                  try
                     // если поля ORDER BY не было, тогда мы его просто добавляем
                     temp_string:=copy(temp_string,1,separator-1)+' ORDER BY '+order_field+' DESC';
                     query.SQL.text:=temp_string;
                     query.open;
                  except
                     // ошибка при создании текста запроса - возвращаем все назад, как и было
                     query.SQL.text:=sql_text;
                     if sql_text<>''
                     then query.open;
                     raise Exception.create('Error in create query text');
                  end;
                  end;
             end;
        end;
   result:='';
except
   on e:exception
   do begin
      result:=e.message;
      end;
end;
end;


// Процедура открытия запроса на основе данных
//                                          <компонент>    <текст в блоке Select..From>  <имя таблицы>      <триады параметров>            <блок Left Join> <блок Order By>
function TfmDataModule.open_query_for_where(query:TibQuery;selected_fields:string;table_name:string;parametrs_where:array of string;left_join_fields:string;order_by_fields:string):string;
label labelEnd;
var
i,predel_low,predel_high:integer;
s:string;
s_1,s_2,s_3:string;
flag_begin_where:boolean;
begin
// проверки нормальности передачи параметров для создания запроса
if not(assigned(query))
then begin
     open_query_for_where:='Error component query';
     goto labelEnd;
     end;
if table_name=''
then begin
     open_query_for_where:='Error name field is empty';
     goto labelEnd;
     end;
predel_low:=low(parametrs_where);
predel_high:=high(parametrs_where);
if ((predel_high-predel_low+1)/3)<>trunc(((predel_high-predel_low+1)/3))
then begin
     open_query_for_where:='Error number paramets in query';
     goto labelEnd;
     end;

// начало сборки запроса
if predel_high-predel_low=0
then begin
     // значит параметра Where нет, но, возможно, будет Left_join_fields
     s:='SELECT '+selected_fields+' FROM '+table_name+' '+chr(13)+chr(10)+left_join_fields;
     end
else begin
     s:='SELECT '+selected_fields+' FROM '+table_name+chr(13)+chr(10)+left_join_fields+chr(13)+chr(10)+' WHERE '+chr(13)+chr(10);
     end;

flag_begin_where:=true;
for i:=1 to trunc(((predel_high-predel_low+1)/3))
do begin
   //parametrs_where[predel_low+(i-1)*3]+parametrs_where[predel_low+(i-1)*3+1]+parametrs_where[predel_low+(i-1)*3+2];
   if is_expression(parametrs_where[predel_low+(i-1)*3+1])
   then begin
        // сборка запроса с помощью оператора отношения
        s_1:=parametrs_where[predel_low+(i-1)*3];
        s_2:=parametrs_where[predel_low+(i-1)*3+1];
        s_3:=parametrs_where[predel_low+(i-1)*3+2];

        if flag_begin_where=true
        then begin
             // если условие в блоке WHERE - первое, то есть перед ним не нужно AND
             // проверка на наличие текстового поля в условии <field_form_base><operator>chr(39)<value>chr(39)
             if (s_2[1]=chr(39)) and (s_2[length(s_2)]=chr(39))
             then begin
                  s:=s+' TRIM_NEW(RUPPER('+s_1+')) '+s_2+' '+s_3+chr(13)+chr(10);
                  end
             else begin
                  s:=s+' '+s_1+' '+s_2+' '+s_3+chr(13)+chr(10);
                  end;
             flag_begin_where:=false
             end
        else begin
             if (s_2[1]=chr(39)) and (s_2[length(s_2)]=chr(39))
             then begin
                  s:=s+'AND TRIM_NEW(RUPPER('+s_1+')) '+s_2+' '+s_3+chr(13)+chr(10);
                  end
             else begin
                  s:=s+'AND '+s_1+' '+s_2+' '+s_3+chr(13)+chr(10);
                  end;
             end;
        end
   else begin
        // сборка запроса с помощью оператора BETWEEN
        if flag_begin_where=true
        then begin
             s:=s+parametrs_where[predel_low+(i-1)*3]+' BETWEEN '+parametrs_where[predel_low+(i-1)*3+1]+' AND '+parametrs_where[predel_low+(i-1)*3+2]+chr(13)+chr(10);
             flag_begin_where:=false
             end
        else begin
             s:=s+' AND '+parametrs_where[predel_low+(i-1)*3]+' BETWEEN '+parametrs_where[predel_low+(i-1)*3+1]+' AND '+parametrs_where[predel_low+(i-1)*3+2]+chr(13)+chr(10);
             end;
        end;
   end;
s:=s+chr(13)+chr(10)+order_by_fields;
flag_begin_where:=false;
try
   query.SQL.Clear;
   query.sql.add(s);
   //clipboard.astext:=s;
   query.open;
   flag_begin_where:=true;
except
   flag_begin_where:=false;
end;
if flag_begin_where=false
then begin
     open_query_for_where:='Error text query ';
     goto labelEnd;
     end;

open_query_for_where:='';
labelEnd:;
end;


//функция изменения данных
// <компонент> с которым будет отработан запрос, <имя таблицы> в которой будут изменения, пары "имя поля" "значение" которые нужно установить, пары "имя поля" "значения" которые будут поставлены в условие
function TfmDataModule.update_record(query:TibQuery;table_name:string;s_new:array of string;s_old:array of string):string;
label labelEnd;
var
s_old_high_count:cardinal;
s_new_high_count:cardinal;
i:cardinal;
s_temp1:string;
flag_begin:boolean;
begin
// определение пределов
//s_old_low_count:=0;
s_old_high_count:=high(s_old);
//s_new_low_count:=0;
s_new_high_count:=high(s_new);
if (s_old_high_count=0) or (s_new_high_count=0)
then begin
     update_record:='Ошибка передачи параметров запроса';
     goto labelEnd;
     end
else begin
     if s_old_high_count/2=trunc(s_old_high_count/2)
     then begin
          update_record:='Ошибка передачи параметров запроса для изменения';
          goto labelEnd;
          end;
     if s_new_high_count/2=trunc(s_new_high_count/2)
     then begin
          update_record:='Ошибка передачи параметров запроса для отбора записей, которые будут изменяться';
          goto labelEnd;
          end;
     s_temp1:='UPDATE '+table_name+chr(13)+chr(10)+'SET ';
     if query.transaction.active
     then query.transaction.commit;
     query.transaction.startTransaction;

     flag_begin:=true;
     for i:=1 to trunc((s_new_high_count+1)/2)
     do begin
        if flag_begin=true
        then begin
             if (trim(s_new[(i-1)*2+1])=chr(39)+chr(39)) or
             (trim(s_new[(i-1)*2+1])='')
             then begin
                  s_temp1:=s_temp1+s_new[(i-1)*2]+' =null'+chr(13)+chr(10);
                  end
             else begin
                  s_temp1:=s_temp1+s_new[(i-1)*2]+'='+control_sql_values.check(s_new[(i-1)*2+1])+chr(13)+chr(10);
                  end;
             flag_begin:=false;
             end
        else begin
             if (trim(s_new[(i-1)*2+1])=chr(39)+chr(39)) or
             (trim(s_new[(i-1)*2+1])='')
             then begin
                  s_temp1:=s_temp1+','+s_new[(i-1)*2]+' = null'+chr(13)+chr(10);
                  end
             else begin
                  s_temp1:=s_temp1+','+s_new[(i-1)*2]+'='+control_sql_values.check(s_new[(i-1)*2+1])+chr(13)+chr(10);
                  end;
             end;
        end;
     s_temp1:=s_temp1+chr(13)+chr(10)+'WHERE ';
     flag_begin:=true;
     for i:=1 to trunc((s_old_high_count+1)/2)
     do begin
        if flag_begin=true
        then begin
             s_temp1:=s_temp1+s_old[(i-1)*2]+'='+s_old[(i-1)*2+1];
             flag_begin:=false;
             end
        else begin
             s_temp1:=s_temp1+' and '+s_old[(i-1)*2]+'='+s_old[(i-1)*2+1]
             end;
        end;
     //showmessage(s_temp1);
     //clipboard.astext:=s_temp1;
     // отработка запроса
     try
        query.sql.Clear;
        //clipboard.astext:=s_temp1;
        query.sql.add(s_temp1);
        query.ExecSQL;
        update_record:='';
        if query.transaction.active
        then query.transaction.commit;
        //fmdatamodule.Transaction_main.commit
     except
        on e:exception
        do begin
           clipboard.astext:=s_temp1;
           if query.transaction.active
           then query.transaction.rollback;
           update_record:=' Ошибка при выполнении запроса '+chr(13)+chr(10)+e.message;
           end;
     end;
     end;
labelEnd:;
end;

// функция добавления данных
//insert_record(fmDataModule.query_temp,['S_FORM_VLASN','KOD',edit_kod,'NAME',chr(39)+edit_name+chr(39)]);
function TfmDataModule.insert_record(query:TibQuery;s:array of string):string;
var
low_count,high_count,i:cardinal;
s_temp1,s_temp2:string;
flag_begin:boolean;
begin
low_count:=0;
high_count:=high(s);
flag_begin:=true;
if high_count<>0
then begin
     if trunc((high_count-low_count-1)/2)=(high_count-low_count-1)/2
     then begin
          insert_record:='Ошибка передачи параметров для запроса'
          end
     else begin
          if query.transaction.Active
          then query.transaction.Commit;
          query.transaction.StartTransaction;
          s_temp1:='INSERT INTO '+s[low_count]+chr(13)+chr(10)+' (';
          s_temp2:='VALUES (';
          for i:=1 to trunc(high_count/2)
          do begin
             if flag_begin=true
             then begin
                  s_temp1:=s_temp1+s[1+(i-1)*2];
                  if (trim(s[1+(i-1)*2+1])=chr(39)+chr(39)) or (trim(s[1+(i-1)*2+1])='')
                  then s_temp2:=s_temp2+'null'
                  else s_temp2:=s_temp2+control_sql_values.check(s[1+(i-1)*2+1]);
                  flag_begin:=false;
                  end
             else begin
                  s_temp1:=s_temp1+','+s[1+(i-1)*2];
                  if (trim(s[1+(i-1)*2+1])=chr(39)+chr(39)) or (trim(s[1+(i-1)*2+1])='')
                  then s_temp2:=s_temp2+',null'
                  else s_temp2:=s_temp2+','+control_sql_values.check(s[1+(i-1)*2+1]);
                  end;
             end;
          s_temp1:=s_temp1+')'+chr(13)+chr(10);
          s_temp2:=s_temp2+')'+chr(13)+chr(10);
          s_temp1:=s_temp1+s_temp2;
          insert_record:='';
          try
             query.sql.Clear;
             query.SQL.Add(s_temp1);
             //clipboard.astext:=s_temp1;
             query.execsql;
             if query.transaction.Active
             then query.transaction.Commit;
          except
             on e:exception
             do begin
                clipboard.astext:=s_temp1;
                if query.transaction.Active
                then query.transaction.rollback;
                insert_record:=e.message;
                end;
          end;
          end;
     end
else begin
     insert_record:='Нет записей для добавления'
     end;
end;

// функция удаления данных из таблицы
//delete_record(fmDataModule.query_temp,['S_FORM_VLASN','KOD',listbox_kod.Items.Strings[listbox_kod.itemindex],'NAME',chr(39)+listbox_name.Items.Strings[listbox_name.itemindex]+chr(39)]);
// данные принимаются в виде динамического массива, у которого первым идет имя таблицы, потом попарно <имя поля> <значение>
function TfmDataModule.delete_record(query:TibQuery;s:array of string):string;
var
low_count,high_count,i:cardinal;
s_temp:string;
flag_begin:boolean;
begin
low_count:=0;
high_count:=high(s);
flag_begin:=true;
if high_count<>0
then begin
     if trunc((high_count-low_count-1)/2)=(high_count-low_count-1)/2
     then begin
          delete_record:='Ошибка передачи параметров для запроса'
          end
     else begin
          if query.transaction.active
          then query.transaction.commit;
          query.transaction.StartTransaction;
          s_temp:='DELETE FROM '+s[low_count]+chr(13)+chr(10)+' WHERE ';
          for i:=1 to trunc(high_count/2)
          do begin
             if flag_begin=true
             then begin
                  //trim(s[1+(i-1)*2+1])=chr(39)+chr(39)) or (
                  if (trim(s[1+(i-1)*2+1])='')
                  then begin
                       //s_temp:=s_temp+s[1+(i-1)*2]+' is null'+chr(13)+chr(10);
                       //flag_begin:=false;
                       end
                  else begin
                       s_temp:=s_temp+s[1+(i-1)*2]+'='+s[1+(i-1)*2+1]+'  '+chr(13)+chr(10);
                       flag_begin:=false;
                       end;
                  end
             else begin
                  //trim(s[1+(i-1)*2+1])=chr(39)+chr(39)) or
                  if (trim(s[1+(i-1)*2+1])='')
                  then begin
                       //s_temp:=s_temp+' AND '+s[1+(i-1)*2]+' is null  '+chr(13)+chr(10);
                       end
                  else begin
                       s_temp:=s_temp+' AND '+s[1+(i-1)*2]+'='+s[1+(i-1)*2+1]+'  '+chr(13)+chr(10);
                       end;
                  end;
             end;
          end;
     //запрос находится в переменной S_Temp  -- showmessage(s_temp);
     delete_record:='';
     try
        query.sql.Clear;
        //clipboard.astext:=s_temp;
        query.SQL.Add(s_temp);
        query.execsql;
        if query.transaction.active
        then query.transaction.commit;
     except
        on e:exception
        do begin
           if query.transaction.active
           then query.transaction.commit;
           delete_record:=e.message;
           end;
     end;
     end
else begin
     delete_record:='Нет данных для удаления из таблицы'
     end;
end;

// взятие из запроса одного столбца с данными в виде stringlist
// получить столбец с данными из запроса в виде stringlist
// функция загрузки из <TIBquery> с именем поля <Field> данных в <Stringlist>
function TfmDataModule.load_from_query_field_to_stringlist(query:TibQuery;field:string;var stringlist:Tstringlist):cardinal;
var
n:cardinal;
begin
n:=0;
if (query.recordcount<>0) and (assigned(stringlist))
then begin
     stringlist.clear;
     query.First;
     while not(query.Eof)
     do begin
        if query.FieldByName(field).isnull=false
        then stringlist.Add(trim(query.fieldbyname(field).asstring))
        else stringlist.add('');
        query.Next;
        inc(n);
        end;
     load_from_query_field_to_stringlist:=n;
     end
else begin
     load_from_query_field_to_stringlist:=0;
     end;
end;

// функц_я загрузки(завантаження, наповнення) в ComboBox _з таблиц_, та _з поля
// <TComboBox> <Table_name> <field_name from Table> <Find String>
function TfmDataModule.load_to_combobox_from_table_from_field(query:TibQuery;combobox_for_load:TCombobox;table_name:string;field_name:string;where_string:string='';order_by_string:string=''):string;
var
s_temp:string;
stringlist_temp:tstringlist;
begin
try
query.SQL.Clear;
combobox_for_load.clear;
stringlist_temp:=tstringlist.create;
where_string:=trim(where_string);
if where_string=''
then begin
     // блок для повної загрузки данних
     if order_by_string<>''
     then s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' ORDER BY '+order_by_string
     else s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' ORDER BY '+table_name+'.'+field_name;
     //clipboard.astext:=s_temp;
     query.sql.add(s_temp);
     query.Open;

     fmDataModule.load_from_query_field_to_stringlist(fmDataModule.Query_temp,field_name,stringlist_temp);
     combobox_for_load.items.Assign(stringlist_temp);
     if stringlist_temp.count>0
     then begin
          FreeAndNil(stringlist_temp);
          load_to_combobox_from_table_from_field:='';
          end
     else begin
          FreeAndNil(stringlist_temp);
          load_to_combobox_from_table_from_field:='Nothing';
          end;
     end
else begin
     // блок для в_дб_ркової загрузки данних
     //where s_org.short_name_obj like "%%";
     if order_by_string<>''
     then s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' WHERE '+ansiuppercase(where_string)+' ORDER BY '+order_by_string
     else s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' WHERE '+ansiuppercase(where_string)+' ORDER BY '+table_name+'.'+field_name;;
     //clipboard.astext:=s_temp;
     query.sql.add(s_temp);
     query.Open;

     fmDataModule.load_from_query_field_to_stringlist(fmDataModule.Query_temp,field_name,stringlist_temp);
     combobox_for_load.items.Assign(stringlist_temp);
     if stringlist_temp.count>0
     then begin
          FreeAndNil(stringlist_temp);
          load_to_combobox_from_table_from_field:='';
          end
     else begin
          FreeAndNil(stringlist_temp);
          load_to_combobox_from_table_from_field:='Nothing';
          end;
     end
except
on e:exception
do begin
   clipboard.astext:=query.sql.text;
   showmessage('TfmDataModule.load_to_combobox_from_table_from_field ERROR'+chr(13)+chr(10)+e.message);
   end;
end;
end;


function TControl_SQL_Values.add_chr_39(s:string):string;
var
k:integer;
begin
k:=pos(chr(39),s);
if k>0
then begin
     s:=copy(s,1,k-1)+chr(39)+chr(39)+add_chr_39(copy(s,k+1,length(s)-k));
     add_chr_39:=s;
     end
else add_chr_39:=s;
end;

function TControl_SQL_Values.change_chr_34_to_chr_39(s: string): string;
var
k:integer;
begin
k:=pos(chr(34),s);
if k>0
then begin
     s:=copy(s,1,k-1)+chr(39)+chr(39)+change_chr_34_to_chr_39(copy(s,k+1,length(s)-k));
     change_chr_34_to_chr_39:=s;
     end
else change_chr_34_to_chr_39:=s;
end;

function TControl_SQL_Values.change_chr_44_to_chr_46(s: string): string;
var
i:integer;
temp_string:string;
begin
temp_string:=s;
for i:=1 to length(temp_string)
do begin
   if temp_string[i]=chr(44)
   then temp_string[i]:=chr(46)
   end;
result:=temp_string;
end;

function TControl_SQL_Values.check(s: string): string;
var
temp_string:string;
begin
temp_string:=trim(s);
if (temp_string[1]=chr(39)) and (temp_string[length(temp_string)]=chr(39))
then begin
     // значение VARCHAR
     temp_string:=copy(s,2,length(temp_string)-2);
     result:=chr(39)+add_chr_39(change_chr_34_to_chr_39(temp_string))+chr(39);
     end
else begin
     // значение INT, FLOAT, DOUBLE, NUMERIC, BOOLEAN, BLOB
     result:=change_chr_44_to_chr_46(s);
     end;
end;


procedure TfmDataModule.DataModuleCreate(Sender: TObject);
begin
control_sql_values:=TControl_sql_values.create;
end;

function TfmDataModule.get_record_count(query: TibQuery): integer;
var
counter:integer;
begin
try
   if query.active=true
   then begin
        // открыт dataset - возвращаем кол-во, предварительно
        counter:=0;
        query.First;
        while not(query.eof)
        do begin
           inc(counter);
           query.next;
           end;
        result:=counter;
        end
   else begin
        // возможные варианты - закрыт dataset - возвращаем -1
        result:=-1;
        end;
except
on e:exception
do begin
   result:=-1;
   end;
end;
end;

function TfmDataModule.load_from_query_field_to_combobox(query: TibQuery;
  field: string; combobox: Tcombobox): cardinal;
var
n:cardinal;
begin
n:=0;
combobox.Items.Clear;
if (query.recordcount<>0) and (assigned(combobox))
then begin
     query.First;
     while not(query.Eof)
     do begin
        if query.FieldByName(field).isnull=false
        then combobox.Items.Add(trim(query.fieldbyname(field).asstring))
        else combobox.Items.add('');
        query.Next;
        inc(n);
        end;
     load_from_query_field_to_combobox:=n;
     end
else begin
     load_from_query_field_to_combobox:=0;
     end;
end;

function TfmDataModule.calculate_sum_from_query_from_field(query: TIBQuery;
  field_name: string): real;
var
   return_result:real;
begin
   return_result:=0;
   if query.recordcount>0
   then begin
        query.First;
        while(not(query.eof))
        do begin
           try
              return_result:=return_result+query.fieldbyname(field_name).asfloat;
           except

           end;
           query.next;
           end;
        end
   else begin
        // нет записей
        end;
   result:=return_result;
end;

{ TASSORTMENT }

function TASSORTMENT.check_length: string;
begin
   try
      if length(self.field_name)>100
      then raise Exception.create('Наименование');
      if length(self.field_note)>255
      then raise Exception.create('Примечание');
      result:='';
   except
      on e:exception
      do begin
         result:=e.Message;
         end;
   end;
end;

procedure TASSORTMENT.clear;
begin
   self.field_kod:='';
   self.field_name:='';
   self.field_note:='';
   self.field_price:='0';
   self.field_valid:='';
   self.field_price_buying:='0';
end;

procedure TASSORTMENT.copy_from(destination: TAssortment);
begin
   self.field_kod:=destination.field_kod;
   self.field_name:=destination.field_name;
   self.field_note:=destination.field_note;
   self.field_price:=destination.field_price;
   self.field_valid:=destination.field_valid;
   self.field_price_buying:=destination.field_price_buying;
end;

procedure TASSORTMENT.copy_to(source: TAssortment);
begin
   source.field_kod:=self.field_kod;
   source.field_name:=self.field_name;
   source.field_note:=self.field_note;
   source.field_price:=self.field_price;
   source.field_valid:=self.field_valid;
   source.field_price_buying:=self.field_price_buying;
end;

constructor TASSORTMENT.create;
begin
   self.clear;
end;

function TASSORTMENT.delete_by_kod(kod: string; query: TIBQuery): string;
begin
   result:=fmdatamodule.delete_record(query,['ASSORTMENT','KOD',kod]);
end;

function TASSORTMENT.delete_valid_to_zero(kod: string;
  query: TIBQuery): string;
begin
   if fmdatamodule.id_exists('ASSORTMENT','KOD',kod,query)>0
   then begin
        // код найден - изменение
        result:=fmdatamodule.update_record(query,'ASSORTMENT',['VALID','0'],['KOD',kod]);
        end
   else begin
        // код не найден
        result:='record not found';
        end;
end;


function TASSORTMENT.isUniqueName(query:TIBQuery): boolean;
begin
   // есть ли записи в базе, согласно данным
   if fmdatamodule.id_exists('ASSORTMENT','NAME',chr(39)+trim(self.field_name)+chr(39),query)>0
   then result:=false
   else result:=true;
end;

function TASSORTMENT.load_by_kod(kod: string; query: TIBQuery): boolean;
begin
try
   self.clear;
   query.sql.text:='SELECT * FROM ASSORTMENT WHERE KOD='+kod;
   query.Open;
   if query.recordcount>0
   then begin
        self.field_kod:=query.fieldbyname('KOD').asstring;
        self.field_name:=query.fieldbyname('NAME').asstring;
        self.field_note:=query.fieldbyname('NOTE').asstring;
        self.field_price:=query.fieldbyname('PRICE').asstring;
        self.field_valid:=query.fieldbyname('VALID').asstring;
        self.field_price_buying:=query.fieldbyname('PRICE_BUYING').asstring;
        result:=true;
        end
   else begin
        result:=false;
        end;
except
   result:=false;
end;
end;

function TASSORTMENT.save(query: TIBQuery): string;
var
   flag_update:boolean;
   temp_value:integer;
begin
   flag_update:=false;
   if trim(self.field_kod)=''
   then begin
        // дать значение для поля KOD
        //fmdatamodule.get_max_id(query,'ASSORTMENT','KOD',temp_value);
        //self.field_kod:=inttostr(temp_value+1);
        end
   else begin
        // проверить новое значение на UPDATE
        if fmdatamodule.id_exists('ASSORTMENT','KOD',self.field_kod,query)>0
        then begin
             flag_update:=true;
             end
        else begin
             flag_update:=false;
             end;
        end;
   if flag_update=true
   then begin
        result:=fmdatamodule.update_record(query,'ASSORTMENT',
                                           ['NAME',chr(39)+trim(self.field_name)+chr(39),
                                            'PRICE',self.field_price,
                                            'VALID',self.field_valid,
                                            'NOTE',chr(39)+self.field_note+chr(39),
                                            'PRICE_BUYING',self.field_price_buying],
                                           ['KOD',self.field_kod]);
        end
   else begin
        result:=fmdatamodule.insert_record(query,
                                           ['ASSORTMENT',
                                            'KOD',self.field_kod,
                                            'NAME',chr(39)+trim(self.field_name)+chr(39),
                                            'PRICE',self.field_price,
                                            'PRICE_BUYING',self.field_price_buying,
                                            'VALID',self.field_valid,
                                            'NOTE',chr(39)+self.field_note+chr(39)]);
        end;
end;

{ TCommodity }

procedure TCommodity.clear;
begin
   self.field_kod:='';
   self.field_assortment_kod:='';
   self.field_date_in_out:='';
   self.field_man_kod:='';
   self.field_note:='';
   self.field_operation_kod:='';
   self.field_point_kod:='';
   self.field_quantity:='';
   self.field_writer:='';
   self.field_write_date:='';
end;

constructor TCommodity.create;
begin
   self.clear;
end;

function TCommodity.delete_by_kod(kod: string; query: TIBQuery): string;
begin
   result:=fmdatamodule.delete_record(query,['COMMODITY','KOD',kod]);
end;

function TCommodity.get_assortment_name(query: TIBQuery): string;
begin
   result:=fmDataModule.get_name_by_id(query,'ASSORTMENT','KOD',self.field_assortment_kod,'NAME');
end;

function TCommodity.get_assortment_price(query: TIBQuery): string;
begin
   result:=fmDataModule.get_name_by_id(query,'ASSORTMENT','KOD',self.field_assortment_kod,'PRICE');
end;

function TCommodity.load_by_kod(kod: string; query: TIBQuery): boolean;
begin
try
   self.clear;
   query.sql.text:='SELECT * FROM COMMODITY WHERE KOD='+kod;
   query.open;
   if query.recordcount>0
   then begin
        self.field_kod:=query.fieldbyname('KOD').asstring;
        self.field_assortment_kod:=query.fieldbyname('ASSORTMENT_KOD').asstring;
        self.field_quantity:=query.fieldbyname('QUANTITY').asstring;
        self.field_operation_kod:=query.fieldbyname('OPERATION_KOD').asstring;
        self.field_date_in_out:=query.fieldbyname('DATE_IN_OUT').asstring;
        self.field_point_kod:=query.fieldbyname('POINT_KOD').asstring;
        self.field_man_kod:=query.fieldbyname('MAN_KOD').asstring;
        self.field_note:=query.fieldbyname('NOTE').asstring;
        self.field_writer:=query.fieldbyname('WRITER').asstring;
        self.field_write_date:=query.fieldbyname('WRITE_DATE').asstring;
        result:=true;
        end
   else begin
        result:=false;
        end;
except
   result:=false;
end;
end;

function TCommodity.save(query: TIBQuery): string;
var
   flag_update:boolean;
   temp_value:integer;
begin
   flag_update:=false;
   if trim(self.field_kod)=''
   then begin
        // получить максимальное значение кода
        //fmdatamodule.get_max_id(query,'COMMODITY','KOD',temp_value);
        //self.field_kod:=inttostr(temp_value+1);
        end
   else begin
        // проверка на наличие кода в базе - что делать INSERT или UPDATE
        if fmdatamodule.id_exists('COMMODITY','KOD',self.field_kod,query)>0
        then begin
             flag_update:=true;
             end
        else begin
             flag_update:=false;
             end;
        end;
   if flag_update=true
   then begin
        result:=fmdatamodule.update_record(query,'COMMODITY',[
                                           'ASSORTMENT_KOD',self.field_assortment_kod,
                                           'QUANTITY',self.field_quantity,
                                           'OPERATION_KOD',self.field_operation_kod,
                                           'DATE_IN_OUT',chr(39)+Self.field_date_in_out+chr(39),
                                           'POINT_KOD',self.field_point_kod,
                                           'MAN_KOD',self.field_man_kod,
                                           'NOTE',chr(39)+self.field_note+chr(39),
                                           'WRITER',self.field_writer,
                                           'WRITE_DATE',chr(39)+self.field_write_date+chr(39)],
                                           ['KOD',self.field_kod]);
        end
   else begin
        result:=fmdatamodule.insert_record(query,['COMMODITY',
                                                  'KOD',self.field_kod,
                                                  'ASSORTMENT_KOD',self.field_assortment_kod,
                                                  'QUANTITY',self.field_quantity,
                                                  'OPERATION_KOD',self.field_operation_kod,
                                                  'DATE_IN_OUT',chr(39)+Self.field_date_in_out+chr(39),
                                                  'POINT_KOD',self.field_point_kod,
                                                  'MAN_KOD',self.field_man_kod,
                                                  'NOTE',chr(39)+self.field_note+chr(39),
                                                  'WRITER',self.field_writer,
                                                  'WRITE_DATE',chr(39)+self.field_write_date+chr(39)
                                                  ]);
        end;
end;

{ TOperation }

procedure TOperation.clear;
begin
   self.field_kod:='';
   self.field_name:='';
   self.field_note:='';
end;

function TOperation.delete_by_kod(kod: string; query: TIBQuery): string;
begin
   result:=fmdatamodule.delete_record(query,['OPERATION','KOD',kod]);
end;

function TOperation.load_by_kod(kod: string; query: TIBQuery): boolean;
begin
try
   self.clear;
   query.sql.text:='SELECT * FROM OPERATION WHERE KOD='+kod;
   query.Open;
   if query.recordcount>0
   then begin
        self.field_kod:=query.fieldbyname('KOD').asstring;
        self.field_name:=query.fieldbyname('NAME').asstring;
        self.field_note:=query.fieldbyname('NOTE').asstring;
        result:=true;
        end
   else begin
        result:=false;
        end;
except
   result:=false;
end;
end;

function TOperation.save(query: TIBQuery): string;
var
   temp_value:integer;
   flag_update:boolean;
begin
   flag_update:=false;
   if trim(self.field_kod)=''
   then begin
        // назначить максимальное число OPERATION.KOD
        //fmdatamodule.get_max_id(query,'OPERATION','KOD',temp_value);
        //self.field_kod:=inttostr(temp_value+1);
        end
   else begin
        // проверить на повторы - INSERT или UPDATE
        if fmdatamodule.id_exists('OPERATION','KOD',self.field_kod,query)>0
        then begin
             flag_update:=true;
             end
        else begin
             flag_update:=false;
             end;
        end;
   if flag_update=true
   then begin
        result:=fmdatamodule.update_record(query,'OPERATION',
                                                  [
                                                  'NAME',chr(39)+self.field_name+chr(39),
                                                  'NOTE',chr(39)+self.field_note+chr(39)
                                                  ],
                                                  [
                                                  'KOD',self.field_kod
                                                  ]
                                                  );
        end
   else begin
        result:=fmdatamodule.insert_record(query,['OPERATION',
                                                  'KOD',self.field_kod,
                                                  'NAME',chr(39)+self.field_name+chr(39),
                                                  'NOTE',chr(39)+self.field_note+chr(39)
                                                  ]);
        end;
end;

{ TPeople }

function TPeople.check_length: string;
var
   temp_value:string;
begin
   try
      if length(self.field_familiya)>50
      then raise Exception.create('Фамилия');
      if length(self.field_imya)>50
      then raise Exception.create('Имя');
      if length(self.field_otchestvo)>50
      then raise Exception.create('Отчество');
      if length(self.field_passport)>20
      then raise Exception.create('Паспортные данные');
      if length(self.field_ident_kod)>20
      then raise Exception.create('Идентификационный код');
      if length(self.field_phone)>30
      then raise Exception.create('Телефон');
      if length(self.field_home)>150
      then raise Exception.create('Место проживания');
      result:='';
   except
      on e:exception
      do result:=e.message;
   end;
end;

procedure TPeople.clear;
begin
   self.field_kod:='';
   self.field_familiya:='';
   self.field_imya:='';
   self.field_otchestvo:='';
   self.field_date_begin:='';
   self.field_date_begin:='';
   self.field_passport:='';
   self.field_ident_kod:='';
   self.field_post_kod:='';
   self.field_phone:='';
   self.field_home:='';
end;


procedure TPeople.copy_from_skip_kod(source: TPeople);
begin
   self.field_familiya:=source.field_familiya;
   self.field_imya:=source.field_imya;
   self.field_otchestvo:=source.field_otchestvo;
   self.field_date_begin:=source.field_date_begin;
   self.field_passport:=source.field_passport;
   self.field_ident_kod:=source.field_ident_kod;
   self.field_post_kod:=source.field_post_kod;
   self.field_phone:=source.field_phone;
   self.field_home:=source.field_home;
end;

function TPeople.delete_by_kod(kod: string; query: TIBQuery): string;
begin
   result:=fmdatamodule.delete_record(query,['PEOPLE',kod]);
end;

function TPeople.get_balance(people_kod, date_in_out: string;
  query: TIBQuery): real;
begin
   try
      query.sql.clear;
      query.sql.add('SELECT SUM(MONEY.AMOUNT*(EXPENSES.SIGN_SELLER)) AMOUNT');
      query.sql.add('FROM MONEY');
      query.sql.add('INNER JOIN PEOPLE ON PEOPLE.KOD=MONEY.KOD_MAN AND PEOPLE.KOD='+people_kod);
      query.sql.add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
      query.sql.add('      AND EXPENSES.KOD IN (1,2,3,6,7,9,11)');
      query.sql.add('WHERE MONEY.DATE_IN_OUT<='+chr(39)+date_in_out+chr(39));
      query.open;
      result:=query.fieldbyname('AMOUNT').asfloat;
   except
      result:=0;
   end;
end;

function TPeople.get_post_name(query: TIBQuery): string;
begin
   result:=fmdatamodule.get_name_by_id(query,'POSTS','KOD',self.field_post_kod,'NAME');
end;

function TPeople.load_by_kod(kod: string; query: TIBQuery): boolean;
begin
try
   self.clear;
   query.sql.text:='SELECT * FROM PEOPLE WHERE KOD='+kod;
   query.open;
   if query.recordcount>0
   then begin
        self.field_kod:=query.fieldbyname('KOD').asstring;
        self.field_familiya:=query.fieldbyname('FAMILIYA').asstring;
        self.field_imya:=query.fieldbyname('IMYA').asstring;
        self.field_otchestvo:=query.fieldbyname('OTCHESTVO').asstring;
        self.field_date_begin:=query.fieldbyname('DATE_BEGIN').asstring;
        self.field_passport:=query.fieldbyname('PASSPORT').asstring;
        self.field_ident_kod:=query.fieldbyname('IDENT_KOD').asstring;
        self.field_post_kod:=query.fieldbyname('POST_KOD').asstring;
        self.field_phone:=query.fieldbyname('PHONE').asstring;
        self.field_home:=query.fieldbyname('HOME').asstring;
        result:=true;
        end
   else begin
        result:=false;
        end;
except
   result:=false;
end;
end;

function TPeople.save(query: TIBQuery): string;
var
   temp_value:integer;
   flag_update:boolean;
begin
   flag_update:=false;
   if trim(self.field_kod)=''
   then begin
        // назначить максимальное число
        //fmdatamodule.get_max_id(query,'PEOPLE','KOD',temp_value);
        //self.field_kod:=inttostr(temp_value+1);
        end
   else begin
        // что дальше делать UPDATE или INSERT
        if fmdatamodule.id_exists('PEOPLE','KOD',self.field_kod,query)>0
        then begin
             flag_update:=true
             end
        else begin
             flag_update:=false;
             end;
        end;
   if flag_update=true
   then begin
        // UPDATE
        result:=fmdatamodule.update_record(query,'PEOPLE',
                                           ['FAMILIYA',chr(39)+self.field_familiya+chr(39),
                                            'IMYA',chr(39)+self.field_imya+chr(39),
                                            'OTCHESTVO',chr(39)+self.field_otchestvo+chr(39),
                                            'DATE_BEGIN',chr(39)+self.field_date_begin+chr(39),
                                            'PASSPORT',chr(39)+self.field_passport+chr(39),
                                            'IDENT_KOD',self.field_ident_kod,
                                            'POST_KOD',chr(39)+self.field_post_kod+chr(39),
                                            'PHONE',chr(39)+self.field_phone+chr(39),
                                            'HOME',chr(39)+self.field_home+chr(39)
                                            ],
                                           ['KOD',self.field_kod]);
        end
   else begin
        //INSERT
        result:=fmdatamodule.insert_record(query,['PEOPLE',
                                            'KOD',self.field_kod,
                                            'FAMILIYA',chr(39)+self.field_familiya+chr(39),
                                            'IMYA',chr(39)+self.field_imya+chr(39),
                                            'OTCHESTVO',chr(39)+self.field_otchestvo+chr(39),
                                            'DATE_BEGIN',chr(39)+self.field_date_begin+chr(39),
                                            'PASSPORT',chr(39)+self.field_passport+chr(39),
                                            'IDENT_KOD',self.field_ident_kod,
                                            'POST_KOD',chr(39)+self.field_post_kod+chr(39),
                                            'PHONE',chr(39)+self.field_phone+chr(39),
                                            'HOME',chr(39)+self.field_home+chr(39)
                                            ])
        end;
end;

{ TPoints }

function TPoints.check_length: string;
begin
   try
      if length(self.field_name)>100
      then raise Exception.create('Наименование');
      if length(self.field_address)>255
      then raise Exception.create('Адрес');
      if length(self.field_rayon)>50
      then raise Exception.create('Район');
      result:='';
   except
      on e:exception
      do begin
         result:=e.message;
         end;
   end;
end;

procedure TPoints.clear;
begin
   self.field_kod:='';
   self.field_name:='';
   self.field_address:='';
   self.field_rayon:='';
   self.field_arenda:='';
end;

function TPoints.delete_by_kod(kod: string; query: TIBQuery): string;
begin
   result:=fmdatamodule.delete_record(query,['POINTS','KOD',kod]);
end;

function TPoints.load_by_kod(kod: string; query: TIBQuery): boolean;
begin
try
   self.clear;
   query.sql.text:='SELECT * FROM POINTS WHERE KOD='+kod;
   query.Open;
   if query.recordcount>0
   then begin
        self.field_kod:=query.fieldbyname('KOD').asstring;
        self.field_name:=query.fieldbyname('NAME').asstring;
        self.field_address:=query.fieldbyname('ADDRESS').asstring;
        self.field_rayon:=query.fieldbyname('RAYON').asstring;
        self.field_arenda:=query.fieldbyname('ARENDA').asstring;
        result:=true;
        end
   else begin
        result:=false;
        end;
except
   result:=false;
end;
end;

function TPoints.save(query: TIBQuery): string;
var
   temp_value:integer;
   flag_update:boolean;
begin
   flag_update:=false;
   if trim(self.field_kod)=''
   then begin
        // взять максимальное значение
        fmdatamodule.get_max_id(query,'POINTS','KOD',temp_value);
        self.field_kod:=inttostr(temp_value+1);
        end
   else begin
        // проверить на UPDATE или INSERT
        if fmdatamodule.id_exists('POINTS','KOD',self.field_kod,query)>0
        then begin
             flag_update:=true;
             end
        else begin
             flag_update:=false;
             end;
        end;
   if flag_update=true
   then begin
        result:=fmdatamodule.update_record(query,'POINTS',
                                           [
                                            'NAME',chr(39)+self.field_name+chr(39),
                                            'ADDRESS',chr(39)+self.field_address+chr(39),
                                            'RAYON',chr(39)+self.field_rayon+chr(39),
                                            'ARENDA',self.field_arenda
                                            ],
                                           ['KOD',self.field_kod]);
        end
   else begin
        result:=fmdatamodule.insert_record(query,
                                           ['POINTS',
                                            'KOD',self.field_kod,
                                            'NAME',chr(39)+self.field_name+chr(39),
                                            'ADDRESS',chr(39)+self.field_address+chr(39),
                                            'RAYON',chr(39)+self.field_rayon+chr(39),
                                            'ARENDA',self.field_arenda
                                            ]);
        end;
end;

{ TPosts }

procedure TPosts.clear;
begin
   self.field_kod:='';
   self.field_name:='';
end;

function TPosts.delete_by_kod(kod: string; query: TIBQuery): string;
begin
   result:=fmdatamodule.delete_record(query,['POSTS','KOD',kod]);
end;

function TPosts.load_by_kod(kod: string; query: TIBQuery): boolean;
begin
try
   self.clear;
   query.sql.text:='SELECT * FROM POSTS WHERE KOD='+kod;
   query.Open;
   if query.recordcount>0
   then begin
        self.field_kod:=query.fieldbyname('KOD').asstring;
        self.field_name:=query.fieldbyname('NAME').asstring;
        result:=true;
        end
   else begin
        result:=false;
        end;
except
   result:=false;
end;
end;

function TPosts.save(query: TIBQuery): string;
var
   temp_value:integer;
   flag_update:boolean;
begin
   flag_update:=false;
   if trim(self.field_kod)=''
   then begin
        // получить максимальное значение
        //fmdatamodule.get_max_id(query,'POSTS','KOD',temp_value);
        //self.field_kod:=inttostr(temp_value+1);
        end
   else begin
        // какая операция UPDATE или INSERT ?
        if fmdatamodule.id_exists('POSTS','KOD',self.field_kod,query)>0
        then begin
             flag_update:=true;
             end
        else begin
             flag_update:=false;
             end;
        end;
   if flag_update=true
   then begin
        result:=fmdatamodule.update_record(query,'POSTS',
                                           ['NAME',chr(39)+self.field_name+chr(39)],
                                           ['KOD',self.field_kod]);
        end
   else begin
        result:=fmdatamodule.insert_record(query,['POSTS',
                                           'KOD',self.field_kod,
                                           'NAME',chr(39)+self.field_name+chr(39)]);
        end;
end;

{ TCommodity_Temp }


{ TExpenses }

function TExpenses.check_length: string;
begin
   try
      if length(self.field_name)>50
      then raise Exception.create('Наименование');
      result:='';
   except
      on e:exception
      do begin
         result:=e.message;
         end;
   end;
end;

procedure TExpenses.clear;
begin
   self.field_kod:='';
   self.field_name:='';
   self.field_sign:='1';
end;

function TExpenses.delete_by_kod(kod: string; query: TIBQuery): string;
begin
   result:=fmDataModule.delete_record(query,['EXPENSES','KOD',kod]);
end;

function TExpenses.load_by_kod(kod: string; query: TIBQuery): boolean;
begin
try
   self.clear;
   query.sql.clear;
   query.sql.text:='SELECT * FROM EXPENSES WHERE KOD='+kod;
   query.Open;
   if query.RecordCount>0
   then begin
        self.field_kod:=query.fieldbyname('KOD').asstring;
        self.field_name:=query.fieldbyname('NAME').asstring;
        self.field_sign:=query.fieldbyname('SIGN').asstring;
        result:=true;
        end
   else begin
        result:=false;
        end;
except
   result:=false;
end;
end;

function TExpenses.save(query: TIBQuery): string;
var
   flag_update:boolean;
   temp_value:integer;
begin
   flag_update:=false;
   temp_value:=0;
   if trim(self.field_kod)=''
   then begin
        // получить код
        //fmDataModule.get_max_id(query,'EXPENSES','KOD',temp_value);
        //self.field_kod:=inttostr(temp_value+1);
        end
   else begin
        // проверить на UPDATE
        if fmDataModule.id_exists('EXPENSES','KOD',self.field_kod,query)>0
        then begin
             flag_update:=true;
             end
        else begin
             flag_update:=false;
             end;
        end;
   if flag_update=true
   then begin
        result:=fmDataModule.update_record(query,'EXPENSES',['NAME',chr(39)+self.field_name+chr(39),'SIGN',self.field_sign],['KOD',self.field_kod]);
        end
   else begin
        result:=fmDataModule.insert_record(query,['EXPENSES','KOD',self.field_kod,'NAME',chr(39)+self.field_name+chr(39),'SIGN',self.field_sign]);
        end;
end;

{ TMoney }

procedure TMoney.clear;
begin
   self.field_kod:='';
   self.field_kod_point:='';
   self.field_kod_expenses:='';
   self.field_amount:='';
   self.field_kod_man:='';
   self.field_kod_writer:='';
   self.field_date_writer:='';
   self.field_date_in_out:='';
   self.field_note:='';
end;

constructor TMoney.create;
begin
   self.clear;
end;

function TMoney.delete_by_kod(kod: string; query: TIBQuery): string;
begin
   result:=fmDataModule.delete_record(query,['MONEY','KOD',kod]);
end;

function TMoney.load_by_kod(kod: string; query: TIBQuery): boolean;
begin
try
   self.clear;
   query.sql.clear;
   query.sql.text:='SELECT * FROM MONEY WHERE KOD='+kod;
   query.Open;
   if query.recordcount>0
   then begin
        self.field_kod:=query.fieldbyname('KOD').asstring;
        self.field_kod_point:=query.fieldbyname('KOD_POINT').asstring;
        self.field_kod_expenses:=query.fieldbyname('KOD_EXPENSES').asstring;
        self.field_amount:=query.fieldbyname('AMOUNT').asstring;
        self.field_kod_man:=query.fieldbyname('KOD_MAN').asstring;
        self.field_kod_writer:=query.fieldbyname('KOD_WRITER').asstring;
        self.field_date_writer:=query.fieldbyname('DATE_WRITE').asstring;
        self.field_date_in_out:=query.fieldbyname('DATE_IN_OUT').asstring;
        self.field_note:=query.fieldbyname('NOTE').asstring;
        result:=true;
        end
   else begin
        result:=false;
        end;
except
   result:=false;
end;
end;

function TMoney.save(query: TIBQuery): string;
var
   flag_update:boolean;
   temp_value:integer;
begin
   flag_update:=false;
   temp_value:=0;
   if trim(self.field_kod)=''
   then begin
        // присвоить максимальное значение
        //fmDataModule.get_max_id(query,'MONEY','KOD',temp_value);
        //self.field_kod:=inttostr(temp_value+1);
        end
   else begin
        // проверка на INSERT или на UPDATE
        if fmDataModule.id_exists('MONEY','KOD',self.field_kod,query)>0
        then begin
             flag_update:=true;
             end
        else begin
             flag_update:=false;
             end;
        end;
   // если нет примечания, то назначить примечанию пустую строку
   if self.field_note=''
   then self.field_note:=' ';
   if flag_update=true
   then begin
        result:=fmDataModule.update_record(query,'MONEY',
                                           ['KOD_POINT',self.field_kod_point,
                                           'KOD_EXPENSES',self.field_kod_expenses,
                                           'AMOUNT',Self.field_amount,
                                           'KOD_MAN',self.field_kod_man,
                                           'KOD_WRITER',self.field_kod_writer,
                                           'DATE_WRITE',chr(39)+self.field_date_writer+chr(39),
                                           'DATE_IN_OUT',chr(39)+self.field_date_in_out+chr(39),
                                           'NOTE',chr(39)+self.field_note+chr(39)
                                           ],['KOD',self.field_kod]);
        end
   else begin
        result:=fmDataModule.insert_record(query,['MONEY',
                                           'KOD',self.field_kod,
                                           'KOD_POINT',self.field_kod_point,
                                           'KOD_EXPENSES',self.field_kod_expenses,
                                           'AMOUNT',Self.field_amount,
                                           'KOD_MAN',self.field_kod_man,
                                           'KOD_WRITER',self.field_kod_writer,
                                           'DATE_WRITE',chr(39)+self.field_date_writer+chr(39),
                                           'DATE_IN_OUT',chr(39)+self.field_date_in_out+chr(39),
                                           'NOTE',chr(39)+self.field_note+chr(39)
                                           ]);
        end;
end;


{ TAccess }

procedure TAccess.clear;
begin
   self.field_user_kod:='';
end;

procedure TAccess.copy_to(var destination: TAccess);
begin
   destination.field_user_kod:=self.field_user_kod;
end;

constructor TAccess.create;
begin
   self.clear;
end;

function TfmDataModule.load_to_stringgrid_from_table(query: TIbQuery;
  var stringgrid: Tstringgrid; table_name: string;
  field_name: array of string; where_string: string;
  header_for_stringgrid: array of string): string;
var
   row_counter,column_counter:integer;
   select_string:string;
begin
   try
      select_string:='';
      for column_counter:=low(field_name) to high(field_name)
      do begin
         if column_counter<>high(field_name)
         then select_string:=select_string+field_name[column_counter]+','
         else select_string:=select_string+field_name[column_counter];
         end;
      query.sql.clear;
      query.sql.add('SELECT '+select_string);
      query.sql.add('FROM '+table_name);
      if trim(where_string)<>''
      then begin
           query.sql.add('WHERE '+where_string);
           end;
      query.open;
      stringgrid.colcount:=high(field_name)+1;
      for column_counter:=0 to stringgrid.colcount-1
      do stringgrid.Cols[column_counter].clear;

      if high(header_for_stringgrid)>0
      then begin
           stringgrid.rowcount:=self.get_record_count(query)+1;
           query.first;
           for column_counter:=low(header_for_stringgrid) to high(header_for_stringgrid)
           do begin
              stringgrid.Cells[column_counter,0]:=header_for_stringgrid[column_counter];
              end;
           row_counter:=1;
           end
      else begin
           stringgrid.rowcount:=self.get_record_count(query);
           query.first;
           row_counter:=0;
           end;
      while not(query.eof)
      do begin
         for column_counter:=0 to query.fields.count-1
         do stringgrid.Cells[column_counter,row_counter]:=query.Fields[column_counter].asstring;
         inc(row_counter);
         query.next;
         end;


      result:='';
   except
      on e:exception
      do begin
         result:=e.Message;
         end;
   end;
end;


function TfmDataModule.load_to_strings_from_table_from_field(
  query: TibQuery; strings_for_load: TStrings; table_name, field_name,
  where_string, order_by_string: string): string;
var
s_temp:string;
stringlist_temp:tstringlist;
begin
try
query.SQL.Clear;
strings_for_load.Clear;
stringlist_temp:=tstringlist.create;
where_string:=trim(where_string);
if where_string=''
then begin
     // блок для повної загрузки данних
     if order_by_string<>''
     then s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' ORDER BY '+order_by_string
     else s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' ORDER BY '+table_name+'.'+field_name;
     //clipboard.astext:=s_temp;
     query.sql.add(s_temp);
     query.Open;

     fmDataModule.load_from_query_field_to_stringlist(fmDataModule.Query_temp,field_name,stringlist_temp);
     strings_for_load.Assign(stringlist_temp);
     if stringlist_temp.count>0
     then begin
          FreeAndNil(stringlist_temp);
          load_to_strings_from_table_from_field:='';
          end
     else begin
          FreeAndNil(stringlist_temp);
          load_to_strings_from_table_from_field:='Nothing';
          end;
     end
else begin
     // блок для в_дб_ркової загрузки данних
     //where s_org.short_name_obj like "%%";
     if order_by_string<>''
     then s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' WHERE '+ansiuppercase(where_string)+' ORDER BY '+order_by_string
     else s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' WHERE '+ansiuppercase(where_string)+' ORDER BY '+table_name+'.'+field_name;;
     //clipboard.astext:=s_temp;
     query.sql.add(s_temp);
     query.Open;

     fmDataModule.load_from_query_field_to_stringlist(fmDataModule.Query_temp,field_name,stringlist_temp);
     strings_for_load.Assign(stringlist_temp);
     if stringlist_temp.count>0
     then begin
          FreeAndNil(stringlist_temp);
          load_to_strings_from_table_from_field:='';
          end
     else begin
          FreeAndNil(stringlist_temp);
          load_to_strings_from_table_from_field:='Nothing';
          end;
     end
except
on e:exception
do begin
   clipboard.astext:=query.sql.text;
   showmessage('TfmDataModule.load_to_strings_from_table_from_field ERROR'+chr(13)+chr(10)+e.message);
   end;
end;
end;


function TfmDataModule.load_to_stringlist_from_table_from_field(
  query: TibQuery; stringlist_for_load: TStringlist; table_name,
  field_name, where_string, order_by_string: string): string;
var
s_temp:string;
stringlist_temp:tstringlist;
begin
try
query.SQL.Clear;
stringlist_for_load.Clear;
stringlist_temp:=tstringlist.create;
where_string:=trim(where_string);
if where_string=''
then begin
     // блок для повної загрузки данних
     if order_by_string<>''
     then s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' ORDER BY '+order_by_string
     else s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' ORDER BY '+table_name+'.'+field_name;
     //clipboard.astext:=s_temp;
     query.sql.add(s_temp);
     query.Open;

     fmDataModule.load_from_query_field_to_stringlist(fmDataModule.Query_temp,field_name,stringlist_temp);
     stringlist_for_load.Assign(stringlist_temp);
     if stringlist_temp.count>0
     then begin
          FreeAndNil(stringlist_temp);
          load_to_stringlist_from_table_from_field:='';
          end
     else begin
          FreeAndNil(stringlist_temp);
          load_to_stringlist_from_table_from_field:='Nothing';
          end;
     end
else begin
     // блок для в_дб_ркової загрузки данних
     //where s_org.short_name_obj like "%%";
     if order_by_string<>''
     then s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' WHERE '+ansiuppercase(where_string)+' ORDER BY '+order_by_string
     else s_temp:='SELECT DISTINCT RUPPER('+table_name+'.'+field_name+') '+field_name+' FROM '+table_name+' WHERE '+ansiuppercase(where_string)+' ORDER BY '+table_name+'.'+field_name;;
     //clipboard.astext:=s_temp;
     query.sql.add(s_temp);
     query.Open;

     fmDataModule.load_from_query_field_to_stringlist(fmDataModule.Query_temp,field_name,stringlist_temp);
     stringlist_for_load.Assign(stringlist_temp);
     if stringlist_temp.count>0
     then begin
          FreeAndNil(stringlist_temp);
          load_to_stringlist_from_table_from_field:='';
          end
     else begin
          FreeAndNil(stringlist_temp);
          load_to_stringlist_from_table_from_field:='Nothing';
          end;
     end
except
on e:exception
do begin
   clipboard.astext:=query.sql.text;
   showmessage('TfmDataModule.load_to_strings_from_table_from_field ERROR'+chr(13)+chr(10)+e.message);
   end;
end;
end;

function TfmDataModule.load_to_stringlist_from_table_from_field_where_in(
  query: TIBQuery; string_list_for_load: Tstringlist; table_name,
  field_name,field_in_name: string; where_in:tstringlist;order_by:string): string;
var
   control_sql_values:TControl_SQL_values;
   index:integer;
   where_string:string;
begin
   control_sql_values:=Tcontrol_sql_values.create;
   for index:=0 to where_in.count-1
   do begin
      if index<>where_in.count-1
      then begin
           where_string:=where_string+control_sql_values.check(where_in.Strings[index] )+',';
           end
      else begin
           where_string:=where_string+control_sql_values.check(where_in.Strings[index])+' ';
           end;
      end;
   if where_string<>''
   then where_string:=' RUPPER('+table_name+'.'+field_in_name+') IN ('+where_string+')';
   self.load_to_stringlist_from_table_from_field(query,string_list_for_load,table_name,field_name,where_string,order_by);
end;

// загрузка в String, разделенный запятой данных, используя TAB
function TfmDataModule.load_to_string_comma_determinate_do_from_table_from_field_where_in(
  query: TIBQuery; var string_load:string; table_name,
  field_name, field_out: string; where_in: tstringlist;
  order_by: string): string;
var
   temp_stringlist:tstringlist;
   index:integer;
   temp_string:string;
begin
   temp_stringlist:=tstringlist.create;
   temp_string:='';
   self.load_to_stringlist_from_table_from_field_where_in(query,temp_stringlist,table_name,field_name,field_out,where_in,order_by);
   for index:=0 to temp_stringlist.count-1
   do begin
      if temp_stringlist.count-1<>index
      then begin
           temp_string:=temp_string+temp_stringlist.Strings[index]+', '
           end
      else begin
           temp_string:=temp_string+temp_stringlist.Strings[index]+''
           end;
      end;
   string_load:=temp_string;
end;

function TfmDataModule.load_to_combobox_from_table_from_fields(
  query: TibQuery; combobox_for_load: TCombobox; table_name: string;
  fields_name: array of string; delimeter, where_string,
  order_by_string: string): string;
var
   fields:string;
   low_limit,counter:integer;
begin
   try
      for counter:=low(fields_name) to high(fields_name)
      do begin
         if counter<>high(fields_name)
         then begin
              fields:=fields+fields_name[counter]+','
              end
         else begin
              fields:=fields+fields_name[counter];
              end;
         end;
      query.SQL.clear;
      query.sql.text:='SELECT '+fields+' FROM '+table_name+' ';
      if trim(where_string)<>''
      then begin
           query.sql.text:=query.sql.text+where_string+' ';
           end;
      if trim(order_by_string)<>''
      then begin
           query.sql.text:=query.sql.text+order_by_string+' ';
           end;
      query.Open;
      combobox_for_load.Clear;
      while not(query.eof)
      do begin
         fields:='';
         for counter:=low(fields_name) to high(fields_name)
         do begin
            fields:=fields+query.FieldByName(fields_name[counter]).asstring;
            if high(fields_name)<>counter
            then fields:=fields+delimeter;
            end;
         combobox_for_load.Items.Add(fields);
         query.next;
         end;
   except
      on e:exception
      do begin
         combobox_for_load.Clear;
         result:='TfmDataModule.load_to_combobox_from_table_from_fields: '+e.Message;
         end;
   end;

end;

function TfmDataModule.load_from_query_field_to_stringgrid(query: TIBQuery;
  var stringgrid: TStringGrid;header_not_fill:boolean): String;
var
   column_counter,row_counter:integer;
begin
try
   // подсчет строк
   row_counter:=self.get_record_count(query);
   if header_not_fill=true
   then begin
        row_counter:=row_counter+1;
        end;
   // подсчет столбцов
   for column_counter:=0 to stringgrid.colcount-1
   do begin
      stringgrid.Cols[column_counter].Clear;
      end;
   // задаем размерность StringGrid
   stringgrid.colcount:=query.Fields.Count;
   stringgrid.rowcount:=row_counter;
   // заполняем объект
   if header_not_fill=true
   then begin
        row_counter:=1;
        end;
   query.first;
   while(not(query.Eof))
   do begin
      for column_counter:=0 to query.Fields.count-1
      do begin
         stringgrid.Cells[column_counter,row_counter]:=query.fields[column_counter].AsString;
         end;
      row_counter:=row_counter+1;
      query.next;
      end;
except
   on e:exception
   do result:='TfmDataModule.load_from_query_field_to_stringgrid: '+e.message;
end;
end;

procedure TfmDataModule.clear_stringgrid(grid: TStringGrid);
var
   counter:integer;
begin
   for counter:=0 to grid.colcount-1
   do begin
      grid.Cols[counter].Clear;
      end;
end;


procedure TfmDataModule.query_to_excel(dataset: TDataSet);
var
   excel:variant;
   row_counter:integer;
   col_counter:integer;
begin
   excel:=CreateOleObject('Excel.Application');
   excel.Application.EnableEvents:=false;
   excel.workbooks.add;
   excel.visible:=false;
   dataset.First;
   row_counter:=1;
   while not(dataset.eof)
   do begin
      for col_counter:=0 to dataset.Fields.count-1
      do begin
         excel.worksheets[1].Cells.item[row_counter,col_counter+1].value:=dataset.Fields[col_counter].AsString;
         end;
      inc(row_counter);
      dataset.Next;
      end;
   excel.visible:=true;
end;

procedure TfmDataModule.checklistbox_clear(checklistbox: TCheckListBox);
var
   counter:integer;
begin
   for counter:=0 to checklistbox.Items.count-1
   do begin
      checklistbox.Checked[counter]:=false;
      end;
end;

procedure TfmDataModule.checklistbox_invert(checklistbox: TChecklistBox);
var
   counter:integer;
begin
   for counter:=0 to checklistbox.Items.count-1
   do begin
      checklistbox.Checked[counter]:=not(checklistbox.checked[counter]);
      end;
end;

function TfmDataModule.get_record_count_into_table(table_name: string;
  query: TibQuery): integer;
var
counter:integer;
var
    query_string:string;
    return_value:integer;
begin
     return_value:=0;
     try
        query.SQL.text:='SELECT COUNT(*) FROM '+table_name;
        query.Open;
        return_value:=query.Fields[0].AsInteger;
     except
         on e:exception
         do begin
            return_value:=0;
            end;
     end;
     result:=return_value;
end;

end.
