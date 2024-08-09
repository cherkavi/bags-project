unit Dovidka_3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,datamodule,
  StdCtrls, FR_Class, FR_DSet, FR_DBSet, Db, Grids, DBGrids, ExtCtrls,
  ComCtrls,ibQuery;

type
  TfmDovidka_3 = class(TForm)
    frDBDataSet1: TfrDBDataSet;
    Report: TfrReport;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid: TDBGrid;
    DataSource1: TDataSource;
    button_show: TButton;
    GroupBox1: TGroupBox;
    checkbox_range: TCheckBox;
    edit_date_begin: TDateTimePicker;
    Edit_date_end: TDateTimePicker;
    label_begin: TLabel;
    Label_end: TLabel;
    stringgrid_main: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure button_showClick(Sender: TObject);
    procedure ReportGetValue(const ParName: String; var ParValue: Variant);
    procedure checkbox_rangeClick(Sender: TObject);
    procedure ReportManualBuild(Page: TfrPage);
  private
    { Private declarations }
    field_row_counter:integer;
    // отработка запроса к базе данных
    function execute_query(query:TibQuery):boolean;
    // загрузка данных из запроса в StringGrid
    function fill_stringgrid_from_query(stringgrid:TStringGrid;query:TibQuery):boolean;
    // очистка StringGrid
    procedure clear_stringgrid(var stringgrid:TStringGrid);
  public
    { Public declarations }
    procedure load_startup_data;
    procedure set_visible(array_of_TControl:array of TControl;value:boolean);
    procedure set_enabled(array_of_TControl:array of TControl;value:boolean);

  end;

var
  fmDovidka_3: TfmDovidka_3;

implementation

{$R *.DFM}

{ TfmDovidka_3 }


procedure TfmDovidka_3.load_startup_data;
begin
   fmDataModule.query_people.sql.clear;
   fmDatamodule.query_people.SQL.text:='SELECT * FROM PEOPLE';
   fmDataModule.query_people.open;
   self.edit_date_begin.DateTime:=(date-31);
   self.edit_date_end.datetime:=(date);
end;

procedure TfmDovidka_3.FormShow(Sender: TObject);
begin
   self.load_startup_data;
end;

function TfmDovidka_3.execute_query(query:TibQuery):boolean;
var
   return_value:boolean;
begin
   return_value:=false;
   if self.DBGrid.DataSource.dataset.FieldByName('KOD').asstring<>''
   then begin
        // PEOPLE.KOD exists
        query.SQL.clear;
        query.sql.add('SELECT MONEY.DATE_IN_OUT,');
        query.sql.add('       POINTS.NAME POINTS_NAME,');
        query.sql.add('       EXPENSES.NAME EXPENSES_NAME,');
        query.sql.add('       MONEY.AMOUNT*(EXPENSES.SIGN_SELLER) AMOUNT');
        query.sql.add('FROM MONEY');
        query.sql.add('LEFT JOIN POINTS ON POINTS.KOD=MONEY.KOD_POINT');
        query.sql.add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
        query.sql.add('WHERE MONEY.KOD_MAN='+self.DBGrid.DataSource.dataset.FieldByName('KOD').asstring);
        if self.checkbox_range.checked
        then begin
             query.sql.add('AND MONEY.DATE_IN_OUT<='+chr(39)+datetostr(self.edit_date_end.date)+chr(39));
             end;
        query.sql.add('AND MONEY.KOD_EXPENSES IN (1,2,3,6,7,9,11)');
        query.sql.add('ORDER BY MONEY.DATE_IN_OUT,POINTS.NAME,EXPENSES.NAME');

        query.open;
        if query.recordcount>0
        then begin
             // data present
             return_value:=true
             end
        else begin
             // no data present
             return_value:=false;
             end;
        end
   else begin
        // no PEOPLE.KOD
        end;
    result:=return_value;
end;

procedure TfmDovidka_3.button_showClick(Sender: TObject);
begin
     if self.execute_query(fmDataModule.query_dovidka_1)
     then begin
          if(self.fill_stringgrid_from_query(self.stringgrid_main,fmDataModule.query_dovidka_1))
          then begin
               self.Report.ShowReport;
               end
          else begin
               showmessage('ќшибка вывода данных');
               end;
          end
     else begin
          showmessage('Ќет данных дл€ отображени€');
          end;
end;

procedure TfmDovidka_3.ReportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='PEOPLE'
   then ParValue:=self.DBGrid.DataSource.DataSet.fieldbyname('FAMILIYA').asstring+'  '
                 +self.DBGrid.DataSource.DataSet.fieldbyname('IMYA').asstring+'  '
                 +self.DBGrid.DataSource.DataSet.fieldbyname('OTCHESTVO').asstring+'  ';
   if ParName='REPORT_DATE'
   then begin
        if self.checkbox_range.checked
        then begin
             ParValue:='за период с '+datetostr(self.edit_date_begin.date)+' по '+datetostr(self.edit_date_end.date);
             end
        else begin
             ParValue:=datetostr(date);
             end;
        end;
   if parname='DATE_IN_OUT'
   then begin
        parvalue:=self.stringgrid_main.Cells[1,self.field_row_counter];
        end;
   if parname='POINTS_NAME'
   then begin
        parvalue:=self.stringgrid_main.Cells[2,self.field_row_counter];
        end;
   if parname='EXPENSES_NAME'
   then begin
        parvalue:=self.stringgrid_main.Cells[3,self.field_row_counter];
        end;
   if parname='AMOUNT'
   then begin
        parvalue:=self.stringgrid_main.Cells[4,self.field_row_counter];
        end;
   if parname='AMOUNT_ALL'
   then begin
        parvalue:=self.stringgrid_main.Cells[4,self.field_row_counter];
        end;

end;

procedure TfmDovidka_3.checkbox_rangeClick(Sender: TObject);
begin
   if self.checkbox_range.Checked
   then begin
        self.set_visible([ self.edit_date_begin,
                           self.edit_date_end,
                           self.label_begin,
                           self.label_end
                         ],
                         true);
        end
   else begin
        self.set_visible([ self.edit_date_begin,
                           self.edit_date_end,
                           self.label_begin,
                           self.label_end
                         ],
                         false);
        end;
end;

procedure TfmDovidka_3.set_enabled(array_of_TControl: array of TControl;
                                   value: boolean);
var
   counter:integer;
begin
   for counter:=0 to high(array_of_TControl)
   do begin
      array_of_TControl[counter].Enabled:=value;
      end;
end;

procedure TfmDovidka_3.set_visible(array_of_TControl: array of TControl;
                                   value: boolean);
var
   counter:integer;
begin
   for counter:=0 to high(array_of_TControl)
   do begin
      TControl(array_of_TControl[counter]).Visible:=value;
      end;
end;


function TfmDovidka_3.fill_stringgrid_from_query(stringgrid: TStringGrid;
                                                 query: TibQuery): boolean;
var
    return_value:boolean;
    row_count:integer;
    col_count:integer;
    col_counter:integer;
    row_counter:integer;
    field_amount_all:double;

    procedure calculate_amount;
    begin
         field_amount_all:=field_amount_all+query.fieldbyname('AMOUNT').asFloat;
    end;

    procedure out_data;
    begin
          stringgrid.Cells[0,row_counter]:='DATA';
          stringgrid.cells[1,row_counter]:=query.fieldbyname('DATE_IN_OUT').asstring;
          stringgrid.cells[2,row_counter]:=query.fieldbyname('POINTS_NAME').asstring;
          stringgrid.cells[3,row_counter]:=query.fieldbyname('EXPENSES_NAME').asstring;
          stringgrid.cells[4,row_counter]:=query.fieldbyname('AMOUNT').asstring;
          inc(row_counter);
    end;

    procedure out_footer;
    begin
         stringgrid.Cells[0,row_counter]:='FOOTER';
         stringgrid.cells[4,row_counter]:=floattostr(field_amount_all);
         inc(row_counter);
    end;
begin
    return_value:=false;
    try
       row_count:=fmDataModule.get_record_count(query)+1; // +1 - for footer
       col_count:=5; // Column(0) for detecting field type
       self.clear_stringgrid(stringgrid);

       stringgrid.rowcount:=row_count;
       stringgrid.colcount:=col_count;
       field_amount_all:=0;
       query.first;
       row_counter:=0;
       col_counter:=0;

       while not(query.Eof)
       do begin
          if(self.checkbox_range.Checked)
          then begin
               if(self.edit_date_begin.DateTime<=query.FieldByName('DATE_IN_OUT').AsDateTime)
               then begin
                    out_data;
                    end;
               end
          else begin
               out_data;
               end;
          calculate_amount;
          query.next;
          end;
       out_footer;
       stringgrid.rowcount:=row_counter;
       return_value:=true;
    except
        on e:exception
        do begin
           return_value:=false;
           end;
    end;
    result:=return_value;
end;

procedure TfmDovidka_3.clear_stringgrid(var stringgrid: TStringGrid);
var
    column_counter:integer;
begin
    for column_counter:=0 to stringgrid.colcount-1
    do begin
       stringgrid.Cols[column_counter].clear;
       end;
end;

procedure TfmDovidka_3.ReportManualBuild(Page: TfrPage);
var
   band_name:string;
   counter:integer;
begin
     page.showbandbyname('HEADER');
     for counter:=0 to stringgrid_main.rowcount-1
     do begin
        self.field_row_counter:=counter;
        band_name:=stringgrid_main.cells[0,counter];
        {if band_name='NAZVA_FILII'
        then page.showbandbyname('NAZVA_FILII');}
        //(page.findobject(memo_field) as tfrMemoView).Font.Style:=[fsItalic];
        page.showbandbyname(band_name);
        end;
end;

end.
