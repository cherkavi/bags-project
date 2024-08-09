unit dovidka_11;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls,dataModule,ibquery,clipbrd,comobj;

type
  TfmDovidka_11 = class(TForm)
    ListBox_depositor: TListBox;
    Label1: TLabel;
    button_add_to_list: TButton;
    Button_delete_from_list: TButton;
    button_execute: TButton;
    StringGrid1: TStringGrid;
    procedure Button_delete_from_listClick(Sender: TObject);
    procedure button_add_to_listClick(Sender: TObject);
    procedure button_executeClick(Sender: TObject);
  private
    { Private declarations }
    // получить номер вкладчика из строки - номер стоит в начале строки и отделен символом "точка"
    function get_depositor_people_kod(string_value:string):string;
    // проверка на наличия кода вкладчика в listbox-е
    function is_depositor_into_listbox(people_kod:string):boolean;
  public
    { Public declarations }
    // добавить вкладчика в listbox по коду в базе
    procedure add_depositor_into_listbox(people_kod:string);
    // удалить вкладчика из listbox по коду в базе
    procedure delete_depositor_from_listbox(people_kod:string);
    // вывод данных в StringGrid
    procedure data_into_stringgrid(listbox:TlistBox;stringgrid:TStringGrid;query:TibQuery);
  end;

var
  fmDovidka_11: TfmDovidka_11;

implementation

uses People_depositors;

{$R *.DFM}
procedure StringGrid_to_Excel(caption: string;
                              stringgrid: TStringgrid);
var
   Excel:variant;
   row_counter,column_counter:integer;
begin
     if stringgrid.rowcount>0
     then begin
          try
             // создать Variant
             Excel := CreateOleObject('Excel.Application');
             excel:=CreateOleObject('Excel.Application');
             excel.workbooks.add;
             excel.visible:=false;
             // установка текстового формата вывода данных
             for column_counter:=0 to stringgrid.colcount-1
             do begin
                excel.worksheets[1].cells.numberformat:='@';
                end;
             excel.worksheets[1].Cells.item[1,1].value:=caption;
             // вывод данных
             for row_counter:=0 to stringgrid.rowcount-1
             do begin
                for column_counter:=0 to stringgrid.colcount-1
                do begin
                   try
                       excel.worksheets[1].Cells.item[row_counter+2,column_counter+1].value:=strtofloat(stringgrid.Cells[column_counter,row_counter]);
                   except
                       excel.worksheets[1].Cells.item[row_counter+2,column_counter+1].value:=stringgrid.Cells[column_counter,row_counter];
                   end;

                   end;
                end;
             excel.visible:=true;

          except
             on e:exception
             do begin
                if excel<>null
                then begin
                     try
                        excel.visible:=true;
                     except
                        on e2:exception
                        do begin
                           end;
                     end;
                     end;
                showmessage('Произошла ошибка при попытке вывода в Excel-файл:'+chr(13)+chr(10)+e.message);
                end;
          end;

          end
     else begin
          // нечего выводить в Excel
          end;
end;

procedure TfmDovidka_11.add_depositor_into_listbox(people_kod: string);
begin
   if self.is_depositor_into_listbox(people_kod)
   then begin
        // вкладчик уже есть в списке
        end
   else begin
        self.ListBox_depositor.Items.Add( people_kod+'.'
                                         +fmDataModule.get_name_by_id(fmdataModule.query_temp,'PEOPLE','KOD',people_kod,'FAMILIYA')
                                         +'   '
                                         +fmDataModule.get_name_by_id(fmdataModule.query_temp,'PEOPLE','KOD',people_kod,'IMYA'));
        end;
end;

procedure TfmDovidka_11.delete_depositor_from_listbox(people_kod: string);
var
   counter:integer;
begin
    for counter:=0 to self.ListBox_depositor.Items.count-1
    do begin
       if self.get_depositor_people_kod(self.ListBox_depositor.Items.Strings[counter])=people_kod
       then begin
            self.ListBox_depositor.Items.Delete(counter);
            break;
            end;
       end;
end;

function TfmDovidka_11.get_depositor_people_kod(string_value: string): string;
var
   temp_position:integer;
   return_value:string;
begin
    return_value:='';
    temp_position:=pos('.',string_value);
    if temp_position>0
    then begin
         return_value:=copy(string_value,1,temp_position-1);
         end
    else begin
         return_value:='';
         end;
    result:=return_value;
end;

function TfmDovidka_11.is_depositor_into_listbox(
  people_kod: string): boolean;
var
    counter:integer;
    return_value:boolean;
begin
    return_value:=false;
    for counter:=0 to self.ListBox_depositor.Items.count-1
    do begin
       if self.get_depositor_people_kod(self.listbox_depositor.items.strings[counter])=people_kod
       then begin
            return_value:=true;
            break;
            end;
       end;
    result:=return_value;
end;

procedure TfmDovidka_11.Button_delete_from_listClick(Sender: TObject);
var
   temp_value:string;
   counter:integer;
begin
   for counter:=0 to self.listbox_depositor.items.count-1
   do begin
      if self.ListBox_depositor.selected[counter]=true
      then begin
           self.delete_depositor_from_listbox(self.get_depositor_people_kod(self.listbox_depositor.items.strings[counter]));
           break;
           end;
      end;
end;

procedure TfmDovidka_11.button_add_to_listClick(Sender: TObject);
begin
    fmPeople_depositors:=TfmPeople_depositors.create(self);
    fmPeople_depositors.button_ok.caption:='Добавить';
    fmPeople_depositors.button_cancel.caption:='Отменить';
    if fmPeople_depositors.showmodal=mrOk
    then begin
         self.add_depositor_into_listbox(fmPeople_depositors.field_people_kod);
         end;
    freeAndNil(fmPeople_depositors);
end;

procedure TfmDovidka_11.data_into_stringgrid(listbox: TlistBox;
                                             stringgrid: TStringGrid;
                                             query:TibQuery);
function get_current_balance(kod_people:string):string;
var
   return_value:string;
begin
try
    query.sql.clear;
    query.sql.add('SELECT sum(MONEY.AMOUNT) AMOUNT');
    query.sql.add('FROM MONEY');
    query.sql.add('WHERE MONEY.KOD_POINT IS NULL');
    query.sql.add('    AND MONEY.KOD_EXPENSES IN (6,1)');
    query.sql.add('    AND MONEY.KOD_MAN IN ('+kod_people+')');
    //clipboard.astext:=query.sql.text;
    query.open;
    if query.recordcount>0
    then begin
         return_value:=query.fieldbyname('AMOUNT').asstring;
         end
    else begin
         return_value:='0';
         end;
except
    on e:exception
    do begin
       return_value:='0';
       end;
end;
    result:=return_value;
end;

function get_balance:string;
var
    return_value:string;
begin
    return_value:='0';
    try
        query.sql.clear;
        query.sql.Add('SELECT');
        query.sql.Add('      SUM(MONEY.AMOUNT*EXPENSES.SIGN) AMOUNT');
        query.sql.Add('FROM MONEY');
        query.sql.Add('LEFT JOIN POINTS ON POINTS.KOD=MONEY.KOD_POINT');
        query.sql.Add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
        query.sql.Add('WHERE');
        query.sql.Add('MONEY.KOD_EXPENSES IN (1,2,4,5,6,8,10,12)');
        query.Open;
        if query.recordcount>0
        then begin
             return_value:=query.fieldbyname('AMOUNT').asstring;
             end
        else begin
             return_value:='0';
             end;
    except
        on e:exception
        do begin
           return_value:='0';
           end;
    end;
    result:=return_value;
end;

var
    counter:integer;
    temp_string:string;
    temp_real:real;
begin
    // проверка на наличие вкладчиков
    if listbox.items.count>0
    then begin
         // задать размерность StringGrid
         stringgrid.colcount:=listbox.items.count+2;
         stringgrid.rowcount:=5;
         // очистка StringGrid
         for counter:=0 to stringgrid.colcount-1
         do stringgrid.cols[counter].clear;
         // вывод заголовка
         for counter:=0 to listbox.Items.count-1
         do begin
            temp_string:=fmDataModule.get_name_by_id(query,
                                                     'PEOPLE',
                                                     'KOD',
                                                     self.get_depositor_people_kod(listbox.Items.Strings[counter]),
                                                     'FAMILIYA');
            stringgrid.Cells[counter,0]:=temp_string;
            end;
         stringgrid.cells[listbox.items.count,0]:='Сумма';

         // вывод "текущего баланса"
         temp_real:=0;
         for counter:=0 to listbox.Items.count-1
         do begin
            stringgrid.Cells[counter,1]:=get_current_balance(self.get_depositor_people_kod(listbox.Items.Strings[counter]));
            temp_real:=temp_real+strtofloat(stringgrid.Cells[counter,1]);
            end;
         stringgrid.cells[listbox.items.count,1]:=floattostr(temp_real);
         stringgrid.cells[listbox.items.count+1,1]:='текущий баланс';

         // вывод "общей суммы"
         stringgrid.cells[listbox.items.count,2]:=get_balance();
         stringgrid.cells[listbox.items.count+1,2]:='сумма общей кассы';

         // вывод "дельта"
         temp_real:=(
                    ( strtofloat(stringgrid.cells[listbox.items.count,2])
                     -strtofloat(stringgrid.cells[listbox.items.count,1]))
                     /listbox.items.count);
         for counter:=0 to listbox.items.count-1
         do begin
            stringgrid.cells[counter,3]:=floattostr(temp_real);
            end;
         stringgrid.cells[listbox.items.count+1,3]:='дельта';

         // вывод "итоговой суммы"
         temp_real:=strtofloat(stringgrid.cells[listbox.items.count,2])-strtofloat(stringgrid.cells[listbox.items.count,1]);
         for counter:=0 to listbox.items.count-1
         do begin
            stringgrid.cells[counter,4]:=floattostr( strtofloat(stringgrid.cells[counter,1])
                                                    +strtofloat(stringgrid.cells[counter,3]));
            end;
         stringgrid.cells[listbox.items.count+1,4]:='Итоговая сумма';
         end
    else begin
         showmessage('Необходимо наличие вкладчиков - "Добавить в список"');
         end;
end;

procedure TfmDovidka_11.button_executeClick(Sender: TObject);
begin
    self.data_into_stringgrid(self.ListBox_depositor,
                              self.StringGrid1,
                              fmDataModule.query_temp);
    StringGrid_to_Excel('Балансы вкладчиков',self.stringGrid1);
end;

end.
