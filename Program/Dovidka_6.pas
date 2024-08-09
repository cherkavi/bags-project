unit Dovidka_6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, Grids,dataModule,
  FR_Class,IBQuery,db;

type
  TfmDovidka_6 = class(TForm)
    stringgrid_main: TStringGrid;
    edit_date_begin: TdxDateEdit;
    Label1: TLabel;
    button_show: TButton;
    edit_date_end: TdxDateEdit;
    Report: TfrReport;
    procedure FormCreate(Sender: TObject);
    procedure button_showClick(Sender: TObject);
    procedure ReportGetValue(const ParName: String; var ParValue: Variant);
    procedure ReportManualBuild(Page: TfrPage);
  private
    { Private declarations }
  public
    { Public declarations }
    global_row_counter:integer;
    function query_execute(date_begin,date_end:string;query:TIBQuery):boolean;
    procedure stringgrid_clear(stringgrid:TStringgrid);
    procedure query_to_grid(query:TIBQuery;stringgrid:TStringGrid);
  end;

var
  fmDovidka_6: TfmDovidka_6;

implementation

{$R *.DFM}

procedure TfmDovidka_6.FormCreate(Sender: TObject);
begin
   self.edit_date_begin.date:=Date;
   self.edit_date_end.date:=Date;
end;

procedure TfmDovidka_6.button_showClick(Sender: TObject);
var
   query_recordcount:integer;
begin
   if ((self.edit_date_begin.text<>'') and (self.edit_date_end.text<>'')) or (self.edit_date_begin.date>self.edit_date_end.date)
   then begin
        if query_execute(self.edit_date_begin.text,self.edit_date_end.text,fmDataModule.query_dovidka_1)=true
        then begin
             self.query_to_grid(fmDataModule.query_dovidka_1,self.stringgrid_main);
             report.ShowReport;
             end
        else begin
             showmessage('Нет данных для отображения');
             end;
        end
   else begin
        showmessage('Введите пожалуйста корректные даты');
        end;
end;

function TfmDovidka_6.query_execute(date_begin, date_end: string;
  query: TIBQuery): boolean;
begin
   query.SQL.clear;
   query.sql.add('SELECT MONEY.DATE_IN_OUT,');
   query.sql.add('       POINTS.NAME POINTS_NAME,');
   query.sql.add('       SELLER.FAMILIYA,');
   query.sql.add('       EXPENSES.NAME EXPENSES_NAME,');
   query.sql.add('       MONEY.AMOUNT*EXPENSES.SIGN AMOUNT');
   query.sql.add('FROM MONEY');
   query.sql.add('LEFT JOIN POINTS ON POINTS.KOD=MONEY.KOD_POINT');
   query.sql.add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
   query.sql.add('LEFT JOIN PEOPLE SELLER ON SELLER.KOD=MONEY.KOD_MAN');
   query.sql.add('WHERE MONEY.DATE_IN_OUT BETWEEN '+chr(39)+date_begin+chr(39)+' AND '+chr(39)+date_end+chr(39));
   query.sql.add('AND MONEY.KOD_EXPENSES IN (1,2,4,5,6,8,9)');
   query.sql.add('ORDER BY MONEY.DATE_IN_OUT,');
   query.sql.add('       POINTS.NAME,');
   query.sql.add('       SELLER.FAMILIYA,');
   query.sql.add('       MONEY.AMOUNT DESC');
   query.open;
   if query.recordcount>0
   then result:=true
   else result:=false;
end;

procedure TfmDovidka_6.stringgrid_clear(stringgrid: TStringgrid);
var
   column_counter:integer;
begin
     for column_counter:=0 to stringgrid.colcount-1
     do begin
        stringgrid.Cols[column_counter].Clear;
        end;
end;

// --------------------
procedure TfmDovidka_6.query_to_grid(query: TIBQuery;
  stringgrid: TStringGrid);

function get_string_from_field(field:TField):string;
begin
   if field.IsNull
   then begin
        result:=format('%.2f',[0]);
        end
   else begin
        result:=format('%.2f',[field.asfloat]);
        end;
end;
function get_string_from_float(value:real):string;
begin
   result:=format('%.2f',[value]);
end;

var
   i,query_recordcount,row_counter:integer;
   DATE_IN_OUT,POINTS_NAME,FAMILIYA,EXPENSES_NAME,AMOUNT:string;
   date_in_out_sum,points_name_sum,familiya_sum:real;

procedure show_header_date_in_out;
begin
   DATE_IN_OUT:=query.Fieldbyname('DATE_IN_OUT').asstring;
   stringgrid.Cells[0,row_counter]:='HEADER_DATE_IN_OUT';
   stringgrid.cells[1,row_counter]:=DATE_IN_OUT;
   date_in_out_sum:=0;
   inc(row_counter);
end;
procedure show_header_points_name;
begin
   POINTS_NAME:=query.fieldbyname('POINTS_NAME').asstring;
   stringgrid.Cells[0,row_counter]:='HEADER_POINTS_NAME';
   stringgrid.cells[1,row_counter]:=POINTS_NAME;
   points_name_sum:=0;
   inc(row_counter);
end;

procedure show_header_familiya;
begin
   FAMILIYA:=query.fieldbyname('FAMILIYA').asstring;
   stringgrid.Cells[0,row_counter]:='HEADER_FAMILIYA';
   stringgrid.cells[1,row_counter]:=FAMILIYA;
   familiya_sum:=0;
   inc(row_counter);
end;
procedure show_data;
var
   temp_value:real;
begin
   EXPENSES_NAME:=query.fieldbyname('EXPENSES_NAME').asstring;
   AMOUNT:=get_string_from_field(query.fieldbyname('AMOUNT'));
   temp_value:=query.fieldbyname('AMOUNT').asfloat;
   date_in_out_sum:=date_in_out_sum+temp_value;
   points_name_sum:=points_name_sum+temp_value;
   familiya_sum:=familiya_sum+temp_value;
   stringgrid.Cells[0,row_counter]:='DATA';
   stringgrid.cells[1,row_counter]:=EXPENSES_NAME;
   stringgrid.cells[2,row_counter]:=AMOUNT;
   inc(row_counter);
end;
procedure show_footer_familiya;
begin
   stringgrid.Cells[0,row_counter]:='FOOTER_FAMILIYA';
   stringgrid.cells[1,row_counter]:=FAMILIYA;
   stringgrid.cells[2,row_counter]:=get_string_from_float(familiya_sum);
   inc(row_counter);
end;
procedure show_footer_points_name;
begin
   stringgrid.Cells[0,row_counter]:='FOOTER_POINTS_NAME';
   stringgrid.cells[1,row_counter]:=POINTS_NAME;
   stringgrid.cells[2,row_counter]:=get_string_from_float(points_name_sum);
   points_name_sum:=0;
   inc(row_counter);
end;
procedure show_footer_date_in_out;
begin
   stringgrid.Cells[0,row_counter]:='FOOTER_DATE_IN_OUT';
   stringgrid.cells[1,row_counter]:=DATE_IN_OUT;
   stringgrid.cells[2,row_counter]:=get_string_from_float(date_in_out_sum);
   date_in_out_sum:=0;
   inc(row_counter);
end;


begin
   self.stringgrid_clear(stringgrid);
   // назначить размерность
   query_recordcount:=fmDataModule.get_record_count(query);
   stringgrid.colcount:=3;
   stringgrid.rowcount:=query_recordcount*2+20;
   row_counter:=0;date_in_out_sum:=0;points_name_sum:=0;familiya_sum:=0;
   DATE_IN_OUT:='';POINTS_NAME:='';FAMILIYA:='';EXPENSES_NAME:='';AMOUNT:='';
   query.First;
   for i:=0 to query_recordcount-1
   do begin
      if DATE_IN_OUT<>query.FieldByName('DATE_IN_OUT').asstring
      then begin
           if DATE_IN_OUT<>''
           then begin
                show_footer_familiya;
                show_footer_points_name;
                show_footer_date_in_out;
                end;
           show_header_date_in_out;
           show_header_points_name;
           show_header_familiya;
           end;
      if POINTS_NAME<>query.fieldbyname('POINTS_NAME').asstring
      then begin
           if POINTS_NAME<>''
           then begin
                show_footer_familiya;
                show_footer_points_name;
                end;
           show_header_points_name;
           show_header_familiya;
           end;
      if FAMILIYA<>query.fieldbyname('FAMILIYA').asstring
      then begin
           if FAMILIYA<>''
           then begin
                show_footer_familiya;
                end;
           show_header_familiya;
           end;
      show_data;
      query.next;
      end;
   show_footer_familiya;
   show_footer_points_name;
   show_footer_date_in_out;
   self.stringgrid_main.rowcount:=row_counter;
end;

procedure TfmDovidka_6.ReportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if parname='DATE_BEGIN'
   then parvalue:=self.edit_date_begin.text;
   if parname='DATE_END'
   then parvalue:=self.edit_date_end.text;
   if parname='DATE_IN_OUT'
   then parvalue:=self.stringgrid_main.Cells[1,self.global_row_counter];
   if parname='POINTS_NAME'
   then parvalue:=self.stringgrid_main.Cells[1,self.global_row_counter];
   if parname='FAMILIYA'
   then parvalue:=self.stringgrid_main.Cells[1,self.global_row_counter];
   if parname='FAMILIYA_SUM'
   then parvalue:=self.stringgrid_main.Cells[2,self.global_row_counter];
   if parname='POINTS_NAME_SUM'
   then parvalue:=self.stringgrid_main.Cells[2,self.global_row_counter];
   if parname='DATE_IN_OUT_SUM'
   then parvalue:=self.stringgrid_main.Cells[2,self.global_row_counter+1];
   if parname='DATE_IN_OUT_FOOTER'
   then parvalue:=self.stringgrid_main.Cells[1,self.global_row_counter+1];
   if parname='EXPENSES'
   then parvalue:=self.stringgrid_main.Cells[1,self.global_row_counter];
   if parname='AMOUNT'
   then parvalue:=self.stringgrid_main.Cells[2,self.global_row_counter];

end;

procedure TfmDovidka_6.ReportManualBuild(Page: TfrPage);
var
   row_counter:integer;
begin
   for row_counter:=0 to self.stringgrid_main.rowcount-1
   do begin
      self.global_row_counter:=row_counter;
      page.ShowBandByName(self.stringgrid_main.Cells[0,row_counter]);
      end;
end;

end.
