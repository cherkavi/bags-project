unit People;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, Grids, DBGrids, ExtCtrls,datamodule,clipbrd, Menus;

type
  TfmPEOPLE = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    button_add: TButton;
    button_edit: TButton;
    button_filter: TButton;
    button_all: TButton;
    combobox_filter_post: TComboBox;
    edit_filter_familiya: TEdit;
    edit_filter_imya: TEdit;
    edit_filter_passport: TEdit;
    edit_filter_ident_kod: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    Excel1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure button_allClick(Sender: TObject);
    procedure button_filterClick(Sender: TObject);
    procedure button_addClick(Sender: TObject);
    procedure button_editClick(Sender: TObject);
    procedure combobox_filter_postChange(Sender: TObject);
    procedure edit_filter_familiyaChange(Sender: TObject);
    procedure edit_filter_imyaChange(Sender: TObject);
    procedure edit_filter_passportChange(Sender: TObject);
    procedure edit_filter_ident_kodChange(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    people_record:datamodule.tpeople;
    procedure load_data_to_combobox;
    procedure set_filter(posada,familiya,imya,passport,ident_kod:string);
  end;

var
  fmPEOPLE: TfmPEOPLE;

implementation

uses People_Edit;

{$R *.DFM}

{ TfmPEOPLE }

procedure TfmPEOPLE.load_data_to_combobox;
begin
   fmdatamodule.load_to_combobox_from_table_from_field(fmdatamodule.query_temp,self.combobox_filter_post,'POSTS','NAME');
   self.combobox_filter_post.Items.add('');
end;

procedure TfmPEOPLE.set_filter(posada,familiya,imya,passport,
  ident_kod:string);
var
   where_string:string;
   posada_kod:string;
   control_sql_values:datamodule.TControl_SQL_values;
begin
   where_string:='';
   if (trim(posada)='') and (trim(familiya)='') and (trim(imya)='')
   then begin
        // отмена применени€ фильтра
        end
   else begin
        control_sql_values:=datamodule.TControl_SQL_Values.create;
        familiya:=control_sql_values.add_chr_39(control_sql_values.change_chr_34_to_chr_39(familiya));
        imya:=control_sql_values.add_chr_39(control_sql_values.change_chr_34_to_chr_39(imya));
        if posada<>''
        then begin
             posada_kod:=fmdatamodule.get_name_by_id(fmdatamodule.query_temp,'POSTS','NAME',chr(39)+posada+chr(39),'KOD');
             if posada_kod<>''
             then begin
                  // фильтр на должность
                  where_string:=' POST_KOD='+posada_kod;
                  end
             else begin
                  // должность не найдена
                  end;
             end;
        if trim(familiya)<>''
        then begin
             if where_string<>''
             then begin
                  where_string:=where_string+' AND '+chr(13)+chr(10);
                  end;
             where_string:=' RUPPER(FAMILIYA) LIKE '+chr(39)+'%'+ansiuppercase(familiya)+'%'+chr(39);
             end;
        if trim(imya)<>''
        then begin
             if where_string<>''
             then begin
                  where_string:=where_string+' AND '+chr(13)+chr(10);
                  end;
             where_string:=' RUPPER(IMYA) LIKE '+chr(39)+'%'+ansiuppercase(imya)+'%'+chr(39);
             end;
        if where_string<>''
        then where_string:=' WHERE '+where_string;
        freeandnil(control_sql_values);
        end;
   fmdatamodule.query_people.sql.clear;
   fmdatamodule.query_people.sql.add('');
   fmdatamodule.query_people.sql.add('SELECT PEOPLE.KOD,');
   fmdatamodule.query_people.sql.add('       PEOPLE.FAMILIYA,');
   fmdatamodule.query_people.sql.add('       PEOPLE.IMYA,');
   fmdatamodule.query_people.sql.add('       PEOPLE.OTCHESTVO,');
   fmdatamodule.query_people.sql.add('       PEOPLE.DATE_BEGIN,');
   fmdatamodule.query_people.sql.add('       PEOPLE.PASSPORT,');
   fmdatamodule.query_people.sql.add('       PEOPLE.IDENT_KOD,');
   fmdatamodule.query_people.sql.add('       POSTS.NAME POSTS_NAME,');
   fmdatamodule.query_people.sql.add('       PEOPLE.PHONE PHONE,');
   fmdatamodule.query_people.sql.add('       PEOPLE.HOME HOME,');
   fmdatamodule.query_people.sql.add('       PEOPLE.POST_KOD');
   fmdatamodule.query_people.sql.add('FROM PEOPLE');
   fmdatamodule.query_people.sql.add('LEFT JOIN POSTS ON POSTS.KOD=PEOPLE.POST_KOD');
   fmdatamodule.query_people.sql.add(where_string);
   //clipboard.astext:=fmdatamodule.query_people.sql.text;
   fmdatamodule.query_people.open;

end;

procedure TfmPEOPLE.FormCreate(Sender: TObject);
begin
   self.people_record:=datamodule.TPeople.create;
   self.access:=dataModule.TAccess.create;   
end;

procedure TfmPEOPLE.FormShow(Sender: TObject);
begin
   self.load_data_to_combobox;
   self.button_all.click;
end;

procedure TfmPEOPLE.button_allClick(Sender: TObject);
begin
   self.set_filter('','','','','');
   self.combobox_filter_post.itemindex:=self.combobox_filter_post.Items.IndexOf('');
end;

procedure TfmPEOPLE.button_filterClick(Sender: TObject);
begin
   self.set_filter(self.combobox_filter_post.text,self.edit_filter_familiya.text,self.edit_filter_imya.Text,self.edit_filter_passport.text,self.edit_filter_ident_kod.text);
end;

procedure TfmPEOPLE.button_addClick(Sender: TObject);
var
   temp_string:string;
begin
   fmpeople_edit:=tfmpeople_edit.create(self);
   if fmpeople_edit.showmodal=mrOk
   then begin
        // пользователь внес изменени€, будет зарегестрирован новый пользователь
        temp_string:=fmpeople_edit.people_record.save(fmDatamodule.query_temp);
        if temp_string<>''
        then begin
             showmessage('ƒанные не сохранены'+chr(13)+chr(10)+temp_string);
             end
        else begin
             //данные сохранены
             fmdatamodule.Transaction_main.active:=false;
             fmdatamodule.Transaction_main.active:=true;
             self.button_all.click;
             fmdatamodule.query_people.locate('KOD',fmpeople_edit.people_record.field_kod,[]);
             end;
        end
   else begin
        // пользователь отменил изменени€
        end;
   freeandnil(fmpeople_edit);
end;

procedure TfmPEOPLE.button_editClick(Sender: TObject);
var
   temp_string:string;
begin
if fmdatamodule.query_people.FieldByName('KOD').asstring<>''
then begin
     fmpeople_edit:=tfmpeople_edit.create(self);
     fmpeople_edit.people_record.field_kod:=fmdatamodule.query_people.fieldbyname('KOD').asstring;
     fmpeople_edit.people_record.field_familiya:=fmdatamodule.query_people.fieldbyname('FAMILIYA').asstring;
     fmpeople_edit.people_record.field_imya:=fmdatamodule.query_people.fieldbyname('IMYA').asstring;
     fmpeople_edit.people_record.field_otchestvo:=fmdatamodule.query_people.fieldbyname('OTCHESTVO').asstring;
     fmpeople_edit.people_record.field_date_begin:=fmdatamodule.query_people.fieldbyname('DATE_BEGIN').asstring;
     fmpeople_edit.people_record.field_passport:=fmdatamodule.query_people.fieldbyname('PASSPORT').asstring;
     fmpeople_edit.people_record.field_ident_kod:=fmdatamodule.query_people.fieldbyname('IDENT_KOD').asstring;
     fmpeople_edit.people_record.field_post_kod:=fmdatamodule.query_people.fieldbyname('POST_KOD').asstring;
     fmpeople_edit.people_record.field_phone:=fmDataModule.query_people.fieldbyname('PHONE').asstring;
     fmpeople_edit.people_record_to_form(fmpeople_edit.people_record);
     if fmpeople_edit.showmodal=mrok
     then begin
          temp_string:=fmpeople_edit.people_record.save(fmdatamodule.query_temp);
          if temp_string<>''
          then begin
               showmessage('ƒанные не изменены'+chr(13)+chr(10)+temp_string);
               end
          else begin
               //данные изменены
               fmdatamodule.Transaction_main.active:=false;
               fmdatamodule.Transaction_main.active:=true;
               self.button_all.click;
               fmdatamodule.query_people.locate('KOD',fmpeople_edit.people_record.field_kod,[]);
               end;
          end
     else begin
          // отменено пользователем
          end;
     end;
end;

procedure TfmPEOPLE.combobox_filter_postChange(Sender: TObject);
begin
button_filter.Click;
end;

procedure TfmPEOPLE.edit_filter_familiyaChange(Sender: TObject);
begin
button_filter.Click;
end;

procedure TfmPEOPLE.edit_filter_imyaChange(Sender: TObject);
begin
button_filter.Click;
end;

procedure TfmPEOPLE.edit_filter_passportChange(Sender: TObject);
begin
button_filter.Click;
end;

procedure TfmPEOPLE.edit_filter_ident_kodChange(Sender: TObject);
begin
button_filter.Click;
end;

procedure TfmPEOPLE.Excel1Click(Sender: TObject);
begin
   cursor:=crHourGlass;
   fmdatamodule.query_to_excel(self.DBGrid1.DataSource.DataSet);
   cursor:=crDefault;
end;

end.
