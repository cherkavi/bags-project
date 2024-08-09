unit Rediscount_list;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls,inifiles,datamodule, StdCtrls,StringGrid_shell, Menus;

type
  TRediscountFile=class
  public
     field_date:string;
     field_user:string;
     field_points_number:string;
     field_man_number:string;
     field_max_length:string;
     field_filename:string;
     field_name:string;
     procedure clear;
     procedure load_from_file(path_to_file:string);
     constructor create(path_to_file:string);
     function get_people_name:string;
     function get_points_name:string;
  end;
  TfmRediscount_list = class(TForm)
    Panel2: TPanel;
    button_select: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    StringGrid_main: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure button_selectClick(Sender: TObject);
    procedure StringGrid_mainDblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    // получение всех файлов в подкаталоге
    procedure view_directory(path:string;extension:string;var Stringlist:TStringlist);
  public
    { Public declarations }
    column_field_date:integer;
    column_field_user:integer;
    column_field_points_number:integer;
    column_field_man_number:integer;
    column_field_max_length:integer;
    column_field_filename:integer;
    column_field_name:integer;

    // путь к папке, в которой лежат переучеты
    field_path_to_rediscount:string;
    // путь к файлу, в котром лежит искомый переучет
    field_path_to_file:string;
    // загрузка данных в StringGrid
    procedure load_data_to_stringgrid_from_path(path_to_rediscount:string;stringgrid:TStringGrid);
    procedure load_startupdata;
  end;

var
  fmRediscount_list: TfmRediscount_list;

implementation

{$R *.DFM}

{ TRediscountFile }

procedure TRediscountFile.clear;
begin
     field_date:='';
     field_user:='';
     field_points_number:='';
     field_man_number:='';
     field_max_length:='';
     field_filename:='';
     field_name:='';
end;

constructor TRediscountFile.create(path_to_file: string);
begin
     self.clear;
     self.load_from_file(path_to_file);
end;

function TRediscountFile.get_points_name: string;
begin
//table_name:string;searching_field_name:string;searching_string:string;result_field_name:string):string;
   result:=fmdatamodule.get_name_by_id(fmDataModule.Query_temp,'POINTS','KOD',self.field_points_number,'NAME');
end;

function TRediscountFile.get_people_name: string;
begin
result:=trim(fmdatamodule.get_name_by_id(fmDataModule.Query_temp,'PEOPLE','KOD',self.field_man_number,'FAMILIYA')+' '
            +fmdatamodule.get_name_by_id(fmDataModule.Query_temp,'PEOPLE','KOD',self.field_man_number,'IMYA'));
end;

procedure TRediscountFile.load_from_file(path_to_file:string);
var
   inifile:tinifile;
begin
   if fileexists(path_to_file)
   then begin
        inifile:=tinifile.create(path_to_file);
        self.field_date:=inifile.ReadString('DATE','value','');
        self.field_user:=inifile.ReadString('USER_NAME','value','');
        self.field_points_number:=inttostr(inifile.ReadInteger('POINTS_NUMBER','value',0));
        self.field_man_number:=inttostr(inifile.ReadInteger('MAN_NUMBER','value',0));
        self.field_max_length:=inttostr(inifile.ReadInteger('DATA','max_length',0));
        self.field_filename:=path_to_file;
        self.field_name:=inifile.ReadString('NAME','value','');
        freeandnil(inifile);
        end
   else begin
        // file not exists
        end;
end;

procedure TfmRediscount_list.FormShow(Sender: TObject);
begin
   // загрузка данных в StringGrid;
   self.load_startupdata;
   self.load_data_to_stringgrid_from_path(self.field_path_to_rediscount,self.StringGrid_main);
end;

// получение всех данных о директории
procedure TfmRediscount_list.view_directory(path:string;extension:string;var Stringlist:TStringlist);
var
   mask:string;
   SR:TSearchRec;
   Edit_path:string;
begin
   Edit_path:=path;
   stringlist.Clear;
   if trim(extension)=''
   then extension:='*';
   if FindFirst(Edit_path+'*.'+extension,faAnyFile,SR)=0
   then begin
        repeat
           if (SR.name<>'.') and (SR.name<>'..')
           then stringlist.Add(SR.name);
        until FindNext(SR)<>0
        end;
   FindClose(SR);
//rename
end;

procedure TfmRediscount_list.load_data_to_stringgrid_from_path(
  path_to_rediscount: string; stringgrid: TStringGrid);
var
   row_counter,column_counter:integer;
   stringlist:tstringlist;
   rediscountfile:TRediscountfile;
begin
   // очистка
   for column_counter:=0 to stringgrid.colcount-1
   do stringgrid.Cols[column_counter].Clear;
   // назначение размерности полей
   row_counter:=0;
   stringlist:=tstringlist.create;
   self.view_directory(path_to_rediscount,'dat',stringlist);
   stringgrid.rowcount:=stringlist.count+1;
   stringgrid.colcount:=7;
   stringgrid.FixedRows:=1;
   // шапка StringGrid
   stringgrid.Cells[column_field_date,0]:='Дата';
   stringgrid.Cells[column_field_points_number,0]:='Торговая точка';
   stringgrid.Cells[column_field_man_number,0]:='Продавец';
   stringgrid.Cells[column_field_max_length,0]:='Кол-во записей';
   stringgrid.Cells[column_field_name,0]:='Название';
   stringgrid.Cells[column_field_filename,0]:='Имя файла';
   stringgrid.Cells[column_field_user,0]:='Пользователь';

   stringgrid.ColWidths[column_field_date]:=50;
   stringgrid.ColWidths[column_field_points_number]:=100;
   stringgrid.ColWidths[column_field_man_number]:=150;
   stringgrid.ColWidths[column_field_max_length]:=50;
   stringgrid.ColWidths[column_field_name]:=100;
   stringgrid.ColWidths[column_field_filename]:=200;
   stringgrid.ColWidths[column_field_user]:=100;

   // заполнение данными
   if stringgrid.rowcount>1
   then rediscountfile:=trediscountfile.create(stringlist.Strings[0]);
   for row_counter:=1 to stringgrid.rowcount-1
   do begin
      rediscountfile.clear;
      rediscountfile.load_from_file(path_to_rediscount+stringlist.strings[row_counter-1]);
      stringgrid.Cells[column_field_date,row_counter]:=rediscountfile.field_date;
      stringgrid.Cells[column_field_points_number,row_counter]:=rediscountfile.get_points_name;
      stringgrid.Cells[column_field_man_number,row_counter]:=rediscountfile.get_people_name;
      stringgrid.Cells[column_field_max_length,row_counter]:=rediscountfile.field_max_length;
      stringgrid.Cells[column_field_name,row_counter]:=rediscountfile.field_name;
      stringgrid.Cells[column_field_filename,row_counter]:=rediscountfile.field_filename;
      stringgrid.Cells[column_field_user,row_counter]:=rediscountfile.field_user;
      end;
   freeandnil(rediscountfile);
end;


procedure TfmRediscount_list.load_startupdata;
begin
     column_field_date:=0;
     column_field_points_number:=1;
     column_field_man_number:=2;
     column_field_max_length:=3;
     column_field_name:=4;
     column_field_filename:=5;
     column_field_user:=6;
end;

procedure TfmRediscount_list.button_selectClick(Sender: TObject);
begin
   if self.StringGrid_main.selection.top>=1
   then begin
        self.field_path_to_file:=self.StringGrid_main.Cells[self.column_field_filename,self.StringGrid_main.selection.top];
        modalresult:=mrOk;
        end;
end;


procedure TfmRediscount_list.StringGrid_mainDblClick(Sender: TObject);
begin
   self.button_select.click;
end;

procedure TfmRediscount_list.N1Click(Sender: TObject);
var
   temp_stringgrid:TStringGrid_shell;
begin
   temp_stringgrid:=TStringGrid_shell.create(self.StringGrid_main);
   temp_stringgrid.sort_by_column_without_header(temp_stringgrid.get_click_column);
   freeandnil(temp_stringgrid);
end;

end.
