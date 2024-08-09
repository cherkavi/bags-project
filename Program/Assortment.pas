unit Assortment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,datamodule,
  Db, StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, Grids, DBGrids,
  ExtCtrls,clipbrd, Menus, FR_BarC, FR_Class, FR_Desgn;

type
  TfmASSORTMENT = class(TForm)
    panel_filter: TPanel;
    panel_button: TPanel;
    panel_data: TPanel;
    edit_filter_name: TEdit;
    button_filter: TButton;
    DBGrid: TDBGrid;
    button_add: TButton;
    Button_edit: TButton;
    Button_delete: TButton;
    edit_filter_price_begin: TdxCalcEdit;
    edit_filter_price_end: TdxCalcEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DataSource1: TDataSource;
    button_all: TButton;
    PopupMenu: TPopupMenu;
    button_print_bar_code: TButton;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    report: TfrReport;
    frBarCodeObject1: TfrBarCodeObject;
    edit_filter_note: TEdit;
    Label5: TLabel;
    N4: TMenuItem;
    Excel1: TMenuItem;
    procedure button_allClick(Sender: TObject);
    procedure button_addClick(Sender: TObject);
    procedure Button_editClick(Sender: TObject);
    procedure Button_deleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edit_filter_nameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edit_filter_price_beginKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edit_filter_price_endKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure button_filterClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure reportGetValue(const ParName: String; var ParValue: Variant);
    procedure button_print_bar_codeClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure edit_filter_noteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Excel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    startup_assortment_kod:string;
    access:dataModule.Taccess;
    current_assortment_kod:string;
    procedure set_filter(name,price_begin,price_end,note:string);
  end;

var
  fmASSORTMENT: TfmASSORTMENT;

implementation

uses Assortment_Edit;

{$R *.DFM}

procedure TfmASSORTMENT.set_filter(name, price_begin, price_end,note: string);
var
   sql_add_where:string;
   name_temp,note_temp:string;
   price_begin_temp,price_end_temp:string;
   control_sql_values:datamodule.Tcontrol_sql_values;
   color_set_filter,color_unset_filter:Tcolor;
   limit_up,limit_down:real;
begin
   color_set_filter:=clRed;
   color_unset_filter:=clWindow;
   sql_add_where:='';
   try
      limit_up:=strtofloat(price_end);
   except
      limit_up:=0;
   end;
   try
      limit_down:=strtofloat(price_begin);
   except
      limit_down:=0;
   end;
   control_sql_values:=datamodule.tcontrol_sql_values.Create;
   if (trim(name)='') and (limit_down=0) and (limit_up=0) and (trim(note)='')
   then begin
        // фильтр отменен - начальные значение
        sql_add_where:='';
        self.edit_filter_name.color:=color_unset_filter;
        self.edit_filter_price_begin.color:=color_unset_filter;
        self.edit_filter_price_end.color:=color_unset_filter;
        self.edit_filter_note.color:=color_unset_filter;
        end
   else begin
        if trim(name)<>''
        then begin
             name_temp:=control_sql_values.check(chr(39)+'%'+name+'%'+chr(39));
             sql_add_where:=' AND RUPPER(NAME) LIKE '+ansiuppercase(name_temp);
             self.edit_filter_name.color:=color_set_filter;
             end
        else begin
             self.edit_filter_name.color:=color_unset_filter;
             end;
        if limit_up>0
        then begin
             price_begin_temp:=control_sql_values.check(price_begin);
             price_end_temp:=control_sql_values.check(price_end);
             sql_add_where:=' AND PRICE BETWEEN '+price_begin_temp+' AND '+price_end_temp;
             self.edit_filter_price_begin.color:=color_set_filter;
             self.edit_filter_price_end.color:=color_set_filter;
             end
        else begin
             self.edit_filter_price_begin.color:=color_unset_filter;
             self.edit_filter_price_end.color:=color_unset_filter;
             end;
        if trim(note)<>''
        then begin
             note_temp:=control_sql_values.check(chr(39)+'%'+note+'%'+chr(39));
             sql_add_where:=' AND RUPPER(NOTE) LIKE '+ansiuppercase(note_temp);
             self.edit_filter_note.color:=color_set_filter;
             end
        else begin
             self.edit_filter_note.color:=color_unset_filter;
             end;

        end;
    try
       fmdatamodule.query_assortment.SQL.Clear;
       fmdatamodule.query_assortment.SQL.add('SELECT KOD,NAME,PRICE,NOTE,PRICE_BUYING');
       fmdatamodule.query_assortment.SQL.add('FROM ASSORTMENT');
       fmdatamodule.query_assortment.SQL.add('WHERE VALID>0');
       fmdatamodule.query_assortment.sql.add(sql_add_where);
       fmdatamodule.query_assortment.SQL.add('ORDER BY PRICE');
       fmdatamodule.query_assortment.open;
    except
       on e:exception
       do begin
          clipboard.astext:='Error in open QUERY '+chr(13)+chr(10)+fmdatamodule.query_assortment.sql.text;
          showmessage('Error in open Query');
          end;
    end;
end;

procedure TfmASSORTMENT.button_allClick(Sender: TObject);
begin
   self.set_filter('','0','0','');
end;

procedure TfmASSORTMENT.button_addClick(Sender: TObject);
var
   assortment_record:DataModule.TAssortment;
   temp_string:string;
   //added_kod:string;
begin
   assortment_record:=Datamodule.Tassortment.create;
   fmAssortment_edit:=TfmAssortment_edit.create(self);
   if fmAssortment_edit.showmodal=mrOk
   then begin
        // внести изменения в базу данных
        assortment_record.copy_from(fmAssortment_edit.assortment_record);
        assortment_record.field_valid:='1';
        temp_string:=assortment_record.save(fmdatamodule.query_temp);
        //added_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'ASSORTMENT','NAME',chr(39)+assortment_record.field_name+chr(39),'KOD');
        if temp_string<>''
        then begin
             showmessage('Данные не сохранены'+chr(13)+chr(10)+temp_string);
             end
        else begin
             fmdatamodule.Transaction_main.active:=false;
             fmdatamodule.Transaction_main.active:=true;
             self.set_filter('','0','0','');
             fmDataModule.query_assortment.Locate('NAME',assortment_record.field_name,[]);
             end;
        end
   else begin
        // изменения не нужно фиксировать в базе
        end;
end;

procedure TfmASSORTMENT.Button_editClick(Sender: TObject);
var
   assortment_record:datamodule.Tassortment;
   temp_string:string;
begin
   if fmdatamodule.query_assortment.FieldByName('KOD').asstring<>''
   then begin
        assortment_record:=datamodule.tassortment.create;
        if assortment_record.load_by_kod(fmdatamodule.query_assortment.FieldByName('KOD').asstring,fmdatamodule.query_temp)
        then begin
             fmAssortment_edit:=TfmAssortment_edit.Create(self);
             fmAssortment_edit.assortment_record.copy_from(assortment_record);
             fmAssortment_edit.flag_edit:=true;
             if fmAssortment_edit.ShowModal=mrOk
             then begin
                  // зафиксировать изменения
                  assortment_record.copy_from(fmAssortment_edit.assortment_record);
                  temp_string:=assortment_record.save(fmdatamodule.query_temp);
                  if temp_string<>''
                  then begin
                       showmessage('Данные не сохранены');
                       clipboard.astext:=temp_string;
                       end
                  else begin
                       fmdatamodule.Transaction_main.Active:=false;
                       fmdatamodule.Transaction_main.active:=true;
                       self.set_filter('','0','0','');
                       fmdatamodule.query_assortment.locate('KOD',assortment_record.field_kod,[]);
                       self.current_assortment_kod:=assortment_record.field_kod;
                       end;
                  end
             else begin
                  // пользователь отказался от изменений
                  end;
             freeandnil(fmAssortment_edit);
             end;
        freeandnil(assortment_record);
        end;
end;

procedure TfmASSORTMENT.Button_deleteClick(Sender: TObject);
var
   assortment_record:datamodule.tassortment;
   temp_string:string;
begin
   if fmdatamodule.query_assortment.fieldbyname('KOD').asstring<>''
   then begin
        assortment_record:=datamodule.tassortment.create;
        temp_string:=assortment_record.delete_valid_to_zero(fmdatamodule.query_assortment.fieldbyname('KOD').asstring,fmdatamodule.query_temp);
        if temp_string<>''
        then begin
             showmessage('Товар не удален');
             clipboard.astext:=temp_string;
             end
        else begin
             fmdatamodule.Transaction_main.Active:=false;
             fmdatamodule.Transaction_main.active:=true;
             self.set_filter('','0','0','');
             end;
        end;
end;

procedure TfmASSORTMENT.FormShow(Sender: TObject);
begin
button_all.Click;
if self.startup_assortment_kod<>''
then begin
     self.DBGrid.DataSource.dataset.Locate('KOD',self.startup_assortment_kod,[]);
     end;
end;

procedure TfmASSORTMENT.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
   self.startup_assortment_kod:='';
end;

procedure TfmASSORTMENT.edit_filter_nameKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   self.button_filter.Click;
end;

procedure TfmASSORTMENT.edit_filter_price_beginKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   self.button_filter.Click;
end;

procedure TfmASSORTMENT.edit_filter_price_endKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   self.button_filter.Click;
end;

procedure TfmASSORTMENT.button_filterClick(Sender: TObject);
begin
   self.set_filter(self.edit_filter_name.text,self.edit_filter_price_begin.text,self.edit_filter_price_end.text,self.edit_filter_note.text);
end;

procedure TfmASSORTMENT.N1Click(Sender: TObject);
begin
   self.button_print_bar_code.click;
end;

procedure TfmASSORTMENT.N2Click(Sender: TObject);
begin
   self.Button_edit.Click;
end;

procedure TfmASSORTMENT.N3Click(Sender: TObject);
begin
   self.button_add.click;
end;

procedure TfmASSORTMENT.reportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if parname='BAR_CODE_DATA'
   then begin
        parvalue:=self.DBGrid.DataSource.DataSet.FieldByName('NAME').asstring;
        end;
   if parname='PRICE'
   then begin
        parvalue:=self.DBGrid.DataSource.DataSet.FieldByName('PRICE').asstring;
        end;
   if parname='NOTE'
   then begin
        parvalue:=self.DBGrid.DataSource.DataSet.FieldByName('NOTE').asstring
        end;
end;

procedure TfmASSORTMENT.button_print_bar_codeClick(Sender: TObject);
begin
   if dbgrid.DataSource.dataset.FieldByName('NAME').asstring<>''
   then begin
        report.title:='Печать штрих-кодов для '+dbgrid.DataSource.dataset.FieldByName('NAME').asstring;
        report.PrepareReport;
        report.ShowReport;
        end;
end;

procedure TfmASSORTMENT.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
    self.current_assortment_kod:=self.DBGrid.DataSource.DataSet.fieldbyname('KOD').asstring;
end;

procedure TfmASSORTMENT.edit_filter_noteKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   self.button_filter.Click;
end;

procedure TfmASSORTMENT.Excel1Click(Sender: TObject);
begin
   cursor:=crHourGlass;
   fmdatamodule.query_to_excel(self.DBGrid.DataSource.DataSet);
   cursor:=crDefault;
end;

end.
