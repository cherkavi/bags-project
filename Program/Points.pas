unit Points;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Grids, DBGrids, ExtCtrls,datamodule, Menus;

type
  TfmPOINTS = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    edit_filter_name: TEdit;
    edit_filter_address: TEdit;
    button_filter: TButton;
    button_all: TButton;
    Label1: TLabel;
    Label2: TLabel;
    button_add: TButton;
    Button_edit: TButton;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    Excel1: TMenuItem;
    procedure button_filterClick(Sender: TObject);
    procedure button_allClick(Sender: TObject);
    procedure button_addClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button_editClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    procedure set_filter(name,address:string);
  end;

var
  fmPOINTS: TfmPOINTS;

implementation

uses Points_Edit;

{$R *.DFM}

{ TfmPOINTS }

procedure TfmPOINTS.set_filter(name, address: string);
var
   where_string:string;
begin
   where_string:='';
   if (trim(name)='') and (trim(address)='')
   then begin
        // нет фильтра
        end
   else begin
        // фильтр есть
        if trim(name)<>''
        then begin
             where_string:=' WHERE RUPPER(NAME) LIKE '+chr(39)+'%'+name+'%'+chr(39)
             end;
        if trim(address)<>''
        then begin
             if where_string<>''
             then where_string:=where_string+' AND '
             else where_string:=' WHERE ';
             where_string:=where_string+' RUPPER(ADDRESS) LIKE '+chr(39)+'%'+address+'%'+chr(39)
             end;
        end;
   fmdatamodule.query_points.SQL.clear;
   fmdatamodule.query_points.sql.add('SELECT KOD,NAME,ADDRESS,RAYON,ARENDA');
   fmdatamodule.query_points.sql.add('FROM POINTS');
   fmdatamodule.query_points.sql.add(where_string);
   fmdatamodule.query_points.sql.add('ORDER BY KOD');
   fmdatamodule.query_points.open;
end;

procedure TfmPOINTS.button_filterClick(Sender: TObject);
begin
   self.set_filter(self.edit_filter_name.text,self.edit_filter_address.text);
end;

procedure TfmPOINTS.button_allClick(Sender: TObject);
begin
   self.set_filter('','');
end;

procedure TfmPOINTS.button_addClick(Sender: TObject);
var
   temp_string:string;
begin
   fmpoints_edit:=TfmPoints_edit.create(self);
   if fmpoints_edit.ShowModal=mrOk
   then begin
        // сохранение изменений
        temp_string:=fmpoints_edit.points_record.save(fmdatamodule.query_temp);
        if temp_string<>''
        then begin
             showmessage(' Данные не сохранены '+chr(13)+chr(10)+temp_string);
             end
        else begin
             fmdatamodule.Transaction_main.active:=false;
             fmdatamodule.transaction_main.Active:=true;
             self.set_filter('','');
             fmdatamodule.query_points.locate('KOD',fmpoints_edit.points_record.field_kod,[]);
             end;
        end
   else begin
        // изменения отменены пользователем
        end;
   freeandnil(fmpoints_edit);
end;

procedure TfmPOINTS.FormShow(Sender: TObject);
begin
   self.button_all.click
end;

procedure TfmPOINTS.Button_editClick(Sender: TObject);
var
   temp_string:string;
begin
   if fmdatamodule.query_points.FieldByName('KOD').asstring<>''
   then begin
        fmpoints_edit:=TfmPoints_edit.Create(self);
        fmpoints_edit.points_record.field_kod:=fmdatamodule.query_points.fieldbyname('KOD').asstring;
        fmpoints_edit.points_record.field_name:=fmdatamodule.query_points.fieldbyname('NAME').asstring;
        fmpoints_edit.points_record.field_address:=fmdatamodule.query_points.fieldbyname('ADDRESS').asstring;
        if fmpoints_edit.ShowModal=mrOk
        then begin
             temp_string:=fmpoints_edit.points_record.save(fmdatamodule.query_temp);
             if temp_string<>''
             then begin
                  showmessage('Данные не сохранены '+chr(13)+chr(10)+temp_string);
                  end
             else begin
                  // данные сохранены - refresh grid
                  fmdatamodule.Transaction_main.active:=false;
                  fmdatamodule.transaction_main.Active:=true;
                  self.set_filter('','');
                  fmdatamodule.query_points.locate('KOD',fmpoints_edit.points_record.field_kod,[]);
                  end;
             end
        else begin
             // сохранение отменено пользователем
             end;
        freeandnil(fmpoints_edit);
        end;
end;

procedure TfmPOINTS.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
end;

procedure TfmPOINTS.Excel1Click(Sender: TObject);
begin
   cursor:=crHourGlass;
   fmdatamodule.query_to_excel(self.DBGrid1.DataSource.DataSet);
   cursor:=crDefault;
end;

end.
