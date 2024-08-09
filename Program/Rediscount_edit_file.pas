unit Rediscount_edit_file;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids,DataModule,inifiles,ibQuery;

type
  TfmRediscount_edit_file = class(TForm)
    edit_path_to_file: TEdit;
    StringGrid_main: TStringGrid;
    Label1: TLabel;
    button_edit: TButton;
    button_change: TButton;
    procedure button_editClick(Sender: TObject);
    procedure button_changeClick(Sender: TObject);
    procedure StringGrid_mainDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function load_to_stringgrid_data_not_in_assortment:boolean;
    function is_data_in_assortment_name(value:string;query:TibQuery):boolean;
    function change_into_ini_file(path_to_ini:string;source,destination:string):boolean;
  end;

var
  fmRediscount_edit_file: TfmRediscount_edit_file;

implementation

uses Rediscount_edit_file_add;

{$R *.DFM}

{ TfmRediscount_edit_file }

function TfmRediscount_edit_file.is_data_in_assortment_name(value: string;
  query: TibQuery): boolean;
var
   return_value:boolean;
begin
   return_value:=false;
   try
      query.sql.clear;
      query.sql.Add('SELECT NAME FROM ASSORTMENT WHERE ASSORTMENT.NAME LIKE '+chr(39)+value+chr(39));
      query.open;
      if query.recordcount>0
      then return_value:=true
      else return_value:=false;
   except
      on e:exception
      do begin
         return_value:=false;
         end;
   end;
   result:=return_value;
end;

function TfmRediscount_edit_file.load_to_stringgrid_data_not_in_assortment:boolean;
var
   temp_stringlist:Tstringlist;
   max_count:integer;
   counter:integer;
   ini_file:Tinifile;
   temp_value:string;
   return_value:boolean;
begin
   return_value:=true;
   temp_stringlist:=Tstringlist.create;
   // чтение данных из файла, как из INI, используя ячейки: DATA.max_length   key(1..max_length)
   if fileexists(self.edit_path_to_file.text)
   then begin
        // чтение данных из файла и проверка по базе, добавление в StringList если не найдена позиция
        ini_file:=Tinifile.create(self.edit_path_to_file.text);
        max_count:=ini_file.ReadInteger('DATA','max_length',0);
        temp_stringlist.clear;
        for counter:=0 to max_count
        do begin
           temp_value:=trim(ini_file.ReadString('DATA','key'+inttostr(counter),''));
           if temp_value<>''
           then begin
                if is_data_in_assortment_name(temp_value,fmDataModule.query_temp)=false
                then begin
                     temp_stringlist.add(temp_value);
                     end;
                end;
           end;
        ini_file.Free;
        end
   else begin
        // файл не существует
        end;
   // очистка StringGrid
   for counter:=0 to self.StringGrid_main.colcount-1
   do self.StringGrid_main.cols[counter].clear;
   if temp_stringlist.Count>0
   then begin
        // данные найдены
        self.StringGrid_main.rowcount:=temp_stringlist.Count+1;
        self.StringGrid_main.FixedRows:=1;
        self.StringGrid_main.Cells[0,0]:='Ошибочные данные';
        self.StringGrid_main.Cells[1,0]:='Данные для замены';
        for counter:=0 to temp_stringlist.count-1
        do begin
           self.StringGrid_main.Cells[0,counter+1]:=temp_stringlist.strings[counter];
           end;
        return_value:=true;
        end
   else begin
        // данные не найдены
        return_value:=false;
        end;
   result:=return_value;
end;

procedure TfmRediscount_edit_file.button_editClick(Sender: TObject);
var
   position:integer;
begin
    position:=self.StringGrid_main.Selection.top;
    if position>0
    then begin
         fmRediscount_edit_file_add:=TfmRediscount_edit_file_add.create(self);
         fmRediscount_edit_file_add.edit_source.text:=self.StringGrid_main.Cells[0,position];
         if fmRediscount_edit_file_add.showmodal=mrOk
         then begin
              // пользователь согласился на изменения
              self.StringGrid_main.Cells[1,position]:=fmRediscount_edit_file_add.edit_destination.text;
              end
         else begin
              // действие отменено пользователем
              end;
         freeAndNil(fmRediscount_edit_file_add);
         end;
end;

procedure TfmRediscount_edit_file.button_changeClick(Sender: TObject);
var
   counter:integer;
begin
   if self.StringGrid_main.rowcount>1
   then begin
        try
           // проверка на заполненность всех полей
           for counter:=1 to self.StringGrid_main.rowcount-1
           do begin
              if trim(self.StringGrid_main.Cells[1,counter])=''
              then raise Exception.create('Не все поля заполенены - действие отменено');
              end;
           for counter:=1 to self.StringGrid_main.rowcount-1
           do begin
              if self.change_into_ini_file(self.edit_path_to_file.text,
                                        self.stringgrid_main.cells[0,counter],
                                        self.stringgrid_main.cells[1,counter])=false
              then begin
                   raise Exception.create('Ошибка при изменении данных - действие отменено');
                   end;
              end;
           showmessage('Замена произведена');
           self.modalresult:=mrOk;
        except
           on e:exception
           do begin
              showmessage(e.message);
              end;
        end;
        end
   else begin
        // нечего заменять
        end;
end;

function TfmRediscount_edit_file.change_into_ini_file(path_to_ini, source,
  destination: string): boolean;
var
   return_value:boolean;
   max_counter:integer;
   ini_file:Tinifile;
   counter:integer;
   temp_value:string;
begin
   return_value:=false;
   if fileexists(path_to_ini)
   then begin
        // файл найден - анализ файла
        ini_file:=TInifile.Create(path_to_ini);
        max_counter:=ini_file.readinteger('DATA','max_length',0);
        for counter:=1 to max_counter
        do begin
           temp_value:=ini_file.readstring('DATA','key'+inttostr(counter),'');
           if temp_value=source
           then begin
                ini_file.WriteString('DATA','key'+inttostr(counter),destination);
                end;
           end;
        ini_file.UpdateFile;
        freeandnil(ini_file);
        return_value:=true;
        end
   else begin
        // файл не найден
        return_value:=false;
        end;
   result:=return_value;
end;

procedure TfmRediscount_edit_file.StringGrid_mainDblClick(Sender: TObject);
begin
    self.button_edit.click;
end;

end.
