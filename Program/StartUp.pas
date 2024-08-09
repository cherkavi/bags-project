unit StartUp;

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,inifiles;

type
  Tinifile_element=class
  public
     field_database_number:integer;
     field_path:string;
     field_title:string;
     field_color:string;
     field_serial_number:integer;
     field_rediscount_path:string;
     field_rediscount_max:integer;
     field_rediscount_name:string;
     constructor create();
     procedure clear;
     function get_color:TColor;
  end;
  TfmStartUp = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    button_enter: TButton;
    RadioButton_bags: TRadioButton;
    RadioButton_glove: TRadioButton;
    RadioButton_purse: TRadioButton;
    RadioButton_tree: TRadioButton;
    RadioButton_new: TRadioButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure button_enterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    field_path_to_ini:string;
    field_element_count:integer;
    field_inifile_elements:array of tinifile_element;
    // чтение кол-ва элементов из ini-файла
    function get_element_count(path_to_ini:string):integer;
    // загрузка значений из ini-файла в объект Tinifile_element
    function load_all_elements_from_ini_file(path_to_ini:string;element_count:integer):boolean;
    function get_index_element_by_name(name_element:string):integer;
  end;

var
  fmStartUp: TfmStartUp;

implementation

uses Main;

{$R *.DFM}

procedure TfmStartUp.FormActivate(Sender: TObject);
begin
{      ini_file:=tinifile.Create(extractfilepath(paramstr(0))+'bags.ini');
      if fileexists(ini_file.FileName)
      then begin
           fmdatamodule.DataBase_main.DatabaseName:=ini_file.ReadString('DATABASE','PATH','bags.gdb')
           end
      else begin
           fmdatamodule.DataBase_main.DatabaseName:='bags.gdb';
           end;
      freeandnil(ini_file);}
end;

procedure TfmStartUp.FormCreate(Sender: TObject);
begin
   self.field_path_to_ini:=extractfilepath(paramstr(0))+'bags.ini';
   // чтение кол-ва элементов из ini-файла
   self.field_element_count:=self.get_element_count(self.field_path_to_ini);
   // загрузка значений из ini-файла в объект Tinifile_element
   self.load_all_elements_from_ini_file(self.field_path_to_ini,self.field_element_count);
end;



function TfmStartUp.get_element_count(path_to_ini: string): integer;
var
   ini_file:tinifile;
   return_value:integer;
begin
   ini_file:=tinifile.create(path_to_ini);
   if ini_file.ValueExists('SYSTEM','DATABASE_COUNT')
   then begin
        return_value:=ini_file.ReadInteger('SYSTEM','DATABASE_COUNT',-1);
        end
   else begin
        return_value:=-1;
        end;
   freeandnil(ini_file);
   result:=return_value;
end;

function TfmStartUp.load_all_elements_from_ini_file(path_to_ini: string;
  element_count: integer): boolean;
var
   ini_file:Tinifile;
   return_value:boolean;
   i:integer;
begin
   if element_count>0
   then begin
        ini_file:=tinifile.create(path_to_ini);
        setLength(self.field_inifile_elements,self.field_element_count);
        for i:=0 to self.field_element_count-1
        do begin
           self.field_inifile_elements[i]:=TIniFile_element.create();
           field_inifile_elements[i].field_database_number:=i+1;
           field_inifile_elements[i].field_path:=ini_file.ReadString('DATABASE'+IntToStr(i+1),'PATH','');
           field_inifile_elements[i].field_title:=ini_file.ReadString('DATABASE'+IntToStr(i+1),'TITLE','');
           field_inifile_elements[i].field_color:=ini_file.ReadString('DATABASE'+IntToStr(i+1),'COLOR','');
           field_inifile_elements[i].field_rediscount_path:=ini_file.ReadString('SYSTEM','REDISCOUNT_PATH','');
           field_inifile_elements[i].field_rediscount_max:=ini_file.ReadInteger('SYSTEM','REDISCOUNT_MAX',0);
           field_inifile_elements[i].field_rediscount_name:=ini_file.ReadString('DATABASE'+IntToStr(i+1),'REDISCOUNT_NAME','');
           end;
        freeandnil(ini_file);
        end
   else begin
        return_value:=false;
        end;
end;

{ Tinifile_element }

procedure Tinifile_element.clear;
begin
   self.field_path:='';
   self.field_title:='';
   self.field_color:='';
   self.field_rediscount_path:='';
   self.field_rediscount_max:=0;
end;

constructor Tinifile_element.create;
begin
   self.clear;
end;

function Tinifile_element.get_color: TColor;
var
   return_value:TColor;
   temp_string:string;
begin
   return_value:=clGray;
   temp_string:=trim(ansiuppercase(Self.field_color));
   while(true)
   do begin
      if temp_string='BLACK'
      then begin
           return_value:=clBlack;
           break;
           end;
      if temp_string='MAROON'
      then begin
           return_value:=clMaroon;
           break;
           end;
      if temp_string='GREEN'
      then begin
           return_value:=clGreen;
           break;
           end;
      if temp_string='OLIVE'
      then begin
           return_value:=clOlive;
           break;
           end;
      if temp_string='NAVY'
      then begin
           return_value:=clNavy;
           break;
           end;
      if temp_string='PURPLE'
      then begin
           return_value:=clPurple;
           break;
           end;
      if temp_string='TEAL'
      then begin
           return_value:=clTeal;
           break;
           end;
      if temp_string='AQUA'
      then begin
           return_value:=clAqua;
           break;
           end;
      if temp_string='RED'
      then begin
           return_value:=clRED;
           break;
           end;
      if temp_string='BLUE'
      then begin
           return_value:=clBlue;
           break;
           end;
      if temp_string='GREEN'
      then begin
           return_value:=clGreen;
           break;
           end;

      break;
      end;
{   'BLACK':clBlack;
  clBtnFace = TColor(COLOR_BTNFACE or $80000000);
  clTeal = TColor($808000);
  clGray = TColor($808080);
  clSilver = TColor($C0C0C0);
  clRed = TColor($0000FF);
  clLime = TColor($00FF00);
  clYellow = TColor($00FFFF);
  clBlue = TColor($FF0000);
  clFuchsia = TColor($FF00FF);
  clLtGray = TColor($C0C0C0);
  clDkGray = TColor($808080);
  clWhite = TColor($FFFFFF);
  clNone = TColor($1FFFFFFF);
  clDefault = TColor($20000000);}
    result:=return_value;
end;
procedure TfmStartUp.button_enterClick(Sender: TObject);
var
   index:integer;
begin
   fmMain:=TfmMain.create(self);
   if self.RadioButton_bags.checked
   then begin
        index:=self.get_index_element_by_name(radiobutton_bags.Caption);
        fmmain.field_path_to_database:=self.field_inifile_elements[index].field_path;
        fmmain.field_application_title:=self.field_inifile_elements[index].field_title;
        fmmain.field_application_color:=self.field_inifile_elements[index].get_color;
        fmmain.field_rediscount_path:=self.field_inifile_elements[index].field_rediscount_path;
        fmmain.field_rediscount_max:=self.field_inifile_elements[index].field_rediscount_max;
        fmmain.field_database_number:=self.field_inifile_elements[index].field_database_number;
        fmmain.field_rediscount_name:=self.field_inifile_elements[index].field_rediscount_name;
        fmmain.ShowModal;
        self.field_inifile_elements[index].field_rediscount_max:=fmmain.field_rediscount_max;
        end;
   if self.RadioButton_glove.checked
   then begin
        index:=self.get_index_element_by_name(radiobutton_glove.Caption);
        fmmain.field_path_to_database:=self.field_inifile_elements[index].field_path;
        fmmain.field_application_title:=self.field_inifile_elements[index].field_title;
        fmmain.field_application_color:=self.field_inifile_elements[index].get_color;
        fmmain.field_rediscount_path:=self.field_inifile_elements[index].field_rediscount_path;
        fmmain.field_rediscount_max:=self.field_inifile_elements[index].field_rediscount_max;
        fmmain.field_database_number:=self.field_inifile_elements[index].field_database_number;
        fmmain.field_rediscount_name:=self.field_inifile_elements[index].field_rediscount_name;
        fmmain.ShowModal;
        self.field_inifile_elements[index].field_rediscount_max:=fmmain.field_rediscount_max;
        end;
   if self.RadioButton_purse.Checked
   then begin
        index:=self.get_index_element_by_name(radiobutton_purse.Caption);
        fmmain.field_path_to_database:=self.field_inifile_elements[index].field_path;
        fmmain.field_application_title:=self.field_inifile_elements[index].field_title;
        fmmain.field_application_color:=self.field_inifile_elements[index].get_color;
        fmmain.field_rediscount_path:=self.field_inifile_elements[index].field_rediscount_path;
        fmmain.field_rediscount_max:=self.field_inifile_elements[index].field_rediscount_max;
        fmmain.field_database_number:=self.field_inifile_elements[index].field_database_number;
        fmmain.field_rediscount_name:=self.field_inifile_elements[index].field_rediscount_name;
        fmmain.ShowModal;
        self.field_inifile_elements[index].field_rediscount_max:=fmmain.field_rediscount_max;
        end;
   if self.RadioButton_tree.Checked
   then begin
        index:=self.get_index_element_by_name(radiobutton_tree.Caption);
        fmmain.field_path_to_database:=self.field_inifile_elements[index].field_path;
        fmmain.field_application_title:=self.field_inifile_elements[index].field_title;
        fmmain.field_application_color:=self.field_inifile_elements[index].get_color;
        fmmain.field_rediscount_path:=self.field_inifile_elements[index].field_rediscount_path;
        fmmain.field_rediscount_max:=self.field_inifile_elements[index].field_rediscount_max;
        fmmain.field_database_number:=self.field_inifile_elements[index].field_database_number;
        fmmain.field_rediscount_name:=self.field_inifile_elements[index].field_rediscount_name;
        fmmain.ShowModal;
        self.field_inifile_elements[index].field_rediscount_max:=fmmain.field_rediscount_max;
        end;
   if self.radiobutton_new.checked
   then begin
        index:=self.get_index_element_by_name(radiobutton_new.Caption);
        fmmain.field_path_to_database:=self.field_inifile_elements[index].field_path;
        fmmain.field_application_title:=self.field_inifile_elements[index].field_title;
        fmmain.field_application_color:=self.field_inifile_elements[index].get_color;
        fmmain.field_rediscount_path:=self.field_inifile_elements[index].field_rediscount_path;
        fmmain.field_rediscount_max:=self.field_inifile_elements[index].field_rediscount_max;
        fmmain.field_database_number:=self.field_inifile_elements[index].field_database_number;
        fmmain.field_rediscount_name:=self.field_inifile_elements[index].field_rediscount_name;
        fmmain.ShowModal;
        self.field_inifile_elements[index].field_rediscount_max:=fmmain.field_rediscount_max;
        end;
   freeandnil(fmMain);
end;

function TfmStartUp.get_index_element_by_name(
  name_element: string): integer;
var
   i:integer;
   return_value:integer;
begin
   return_value:=-1;
   for i:=0 to high(self.field_inifile_elements)
   do begin
      if ansiuppercase(self.field_inifile_elements[i].field_title)=ansiuppercase(name_element)
      then begin
           return_value:=i;
           break;
           end;
      end;
   result:=return_value;
end;

end.
