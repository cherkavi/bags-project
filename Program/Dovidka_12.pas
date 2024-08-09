unit Dovidka_12;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DataModule,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, FR_DSet, FR_DBSet,
  FR_Class,clipbrd, Grids,IBQuery;

type
  TfmDovidka_12 = class(TForm)
    button_show: TButton;
    report: TfrReport;
    frDBDataSet_main: TfrDBDataSet;
    stringgrid_main: TStringGrid;
    report_sub: TfrReport;
    frDBDataSet_sub: TfrDBDataSet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    edit_date_begin: TdxDateEdit;
    edit_date_end: TdxDateEdit;
    checkbox_date_begin: TCheckBox;
    GroupBox2: TGroupBox;
    edit_date_begin_display: TdxDateEdit;
    edit_date_end_display: TdxDateEdit;
    Label5: TLabel;
    Label6: TLabel;
    combobox_points: TComboBox;
    Label3: TLabel;
    procedure button_showClick(Sender: TObject);
    procedure reportGetValue(const ParName: String; var ParValue: Variant);
    procedure reportManualBuild(Page: TfrPage);
    procedure checkbox_date_beginClick(Sender: TObject);
    procedure reportObjectClick(View: TfrView);
    procedure reportMouseOverObject(View: TfrView; var Cursor: TCursor);
    procedure edit_date_endChange(Sender: TObject);
    procedure edit_date_beginChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    // �������� ������������ �������� �����
    procedure load_points_name;
  public
    { Public declarations }
    row_counter:integer;
    all_people_post:string;
    procedure load_data;
    function execute_query:boolean;
    function execute_sub_query(query,query_temp:TibQuery;string_date,string_point_name,string_expenses:string):boolean;
    procedure query_to_grid(query:TIBQuery;Stringgrid:Tstringgrid);
    // ��� ���������� left mouse click �� ������ - ���������� ����������� - �������� ����������������� ������
    procedure report_main_click(string_value:string);
    // �������� �� StringGrid � ������� � StringGrid ������������ �������� ����� ��� ������ ������
    function get_points_name(stringgrid:TstringGrid;position_column,position_row:integer):string;
    // �������� �� StringGrid � ������� � StringGrid ���� ��� ������ ������
    function get_date(stringgrid:TstringGrid;position_column,position_row:integer):string;
    // �������� �� StringGrid � ������� � StringGrid ���� ��� ������ ������
    function get_expenses(position_column:integer):string;
    // �������� �� ��������� ��������� ����������� � �������� ������
    procedure check_display_interval;
    // ��������� ������ �����������, ������� ������ ������, �� �� ������ ��� ���� ������
    procedure set_display_interval(with_check:boolean=true);

  end;

var
  fmDovidka_12: TfmDovidka_12;

implementation

{$R *.DFM}

procedure TfmDovidka_12.load_data;
begin
   self.all_people_post:='��� ���������';
   self.edit_date_begin.date:=Date;
   self.edit_date_end.date:=date;
   self.set_display_interval;
   self.load_points_name;
end;


procedure TfmDovidka_12.button_showClick(Sender: TObject);
begin
   self.check_display_interval;
   if self.execute_query=true
   then begin
        query_to_grid(fmDataModule.query_dovidka_1,self.StringGrid_main);
        report.ShowReport;
        end
   else begin
        showmessage(' �� ������� ������� ������ �� ������� ');
        end;
end;

procedure TfmDovidka_12.reportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='DATE_END'
   then begin
        if self.checkbox_date_begin.Checked
        then begin
             ParValue:='�� ���� '+self.edit_date_end.text;
             end
        else begin
             ParValue:='�� ������ c '+self.edit_date_begin.text+' �� '+self.edit_date_end.text;
             end;
        end;
   if ParName='DATE_DISPLAY'
   then begin
        ParValue:=' ������ ����������� ������ - � '+self.edit_date_begin_display.text+' �� '+self.edit_date_end_display.text;
        end;
   if ParName='POINT_NAME'
   then begin
        parvalue:=self.combobox_points.Text;
        end;
   if parname='DATE_IN_OUT'
   then parvalue:=self.stringgrid_main.Cells[1,self.row_counter];
   if parname='POINTS_NAME'
   then parvalue:=self.stringgrid_main.Cells[2,self.row_counter];
   if parname='EXPENSES_2'
   then parvalue:=self.stringgrid_main.Cells[3,self.row_counter];
   if parname='EXPENSES_6'
   then parvalue:=self.stringgrid_main.Cells[4,self.row_counter];
   if parname='EXPENSES_1'
   then parvalue:=self.stringgrid_main.Cells[5,self.row_counter];
   if parname='EXPENSES_4'
   then parvalue:=self.stringgrid_main.Cells[6,self.row_counter];
   if parname='EXPENSES_5'
   then parvalue:=self.stringgrid_main.Cells[7,self.row_counter];
   if parname='EXPENSES_10'
   then parvalue:=self.stringgrid_main.Cells[8,self.row_counter];
   if parname='EXPENSES_8'
   then parvalue:=self.stringgrid_main.Cells[9,self.row_counter];
   if parname='EXPENSES_12'
   then parvalue:=self.stringgrid_main.Cells[10,self.row_counter];
   if parname='SUMA'
   then parvalue:=self.stringgrid_main.Cells[11,self.row_counter];

   if parname='EXPENSES_2_ALL'
   then parvalue:=self.stringgrid_main.Cells[3,self.row_counter];
   if parname='EXPENSES_6_ALL'
   then parvalue:=self.stringgrid_main.Cells[4,self.row_counter];
   if parname='EXPENSES_1_ALL'
   then parvalue:=self.stringgrid_main.Cells[5,self.row_counter];
   if parname='EXPENSES_4_ALL'
   then parvalue:=self.stringgrid_main.Cells[6,self.row_counter];
   if parname='EXPENSES_5_ALL'
   then parvalue:=self.stringgrid_main.Cells[7,self.row_counter];
   if parname='EXPENSES_10_ALL'
   then parvalue:=self.stringgrid_main.Cells[8,self.row_counter];
   if parname='EXPENSES_8_ALL'
   then parvalue:=self.stringgrid_main.Cells[9,self.row_counter];
   if parname='EXPENSES_12_ALL'
   then parvalue:=self.stringgrid_main.Cells[10,self.row_counter];
   if parname='SUMA_ALL'
   then parvalue:=self.stringgrid_main.Cells[11,self.row_counter];

end;

function TfmDovidka_12.execute_query: boolean;
var
   point_kod:string;
begin
   point_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_points.text+chr(39),'KOD');
   if  (self.edit_date_begin.text<>'')
   and (self.edit_date_end.text<>'')
   and (point_kod<>'')
//   and (self.edit_date_begin.date<=self.edit_date_end.date)
   then begin
        fmDataModule.query_dovidka_1.SQL.clear;
        fmDataModule.query_dovidka_1.SQL.add('SELECT');
        fmDataModule.query_dovidka_1.SQL.add('      MONEY.DATE_IN_OUT,');
        fmDataModule.query_dovidka_1.SQL.add('      POINTS.NAME POINTS_NAME,');
        fmDataModule.query_dovidka_1.SQL.add('      EXPENSES.NAME EXPENSES_NAME,');
        fmDataModule.query_dovidka_1.SQL.add('      EXPENSES.KOD EXPENSES_KOD,');
        fmDataModule.query_dovidka_1.SQL.add('      SUM(MONEY.AMOUNT*EXPENSES.SIGN) AMOUNT');
        fmDataModule.query_dovidka_1.SQL.add('FROM MONEY');
        fmDataModule.query_dovidka_1.SQL.add('LEFT JOIN POINTS ON POINTS.KOD=MONEY.KOD_POINT');
        fmDataModule.query_dovidka_1.SQL.add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
        fmDataModule.query_dovidka_1.SQL.add('WHERE KOD_POINT='+point_kod);
        if self.checkbox_date_begin.Checked
        then begin
             fmDataModule.query_dovidka_1.SQL.add('AND MONEY.DATE_IN_OUT <='+chr(39)+self.edit_date_end.text+chr(39));
             end
        else begin
             fmDataModule.query_dovidka_1.SQL.add('AND MONEY.DATE_IN_OUT BETWEEN '+chr(39)+self.edit_date_begin.text+chr(39)+' AND '+chr(39)+self.edit_date_end.text+chr(39));
             end;
        fmDataModule.query_dovidka_1.SQL.add('AND MONEY.KOD_EXPENSES IN (1,2,4,5,6,8,10,12)');
        //fmDataModule.query_dovidka_1.SQL.add('AND MONEY.NOTE NOT LIKE ''REDISCOUNT''  ');
        fmDataModule.query_dovidka_1.SQL.add('GROUP BY       MONEY.DATE_IN_OUT,');
        fmDataModule.query_dovidka_1.SQL.add('      POINTS.NAME ,');
        fmDataModule.query_dovidka_1.SQL.add('      --SELLER.FAMILIYA,');
        fmDataModule.query_dovidka_1.SQL.add('      EXPENSES.NAME,');
        fmDataModule.query_dovidka_1.SQL.add('      EXPENSES.KOD');

        fmDataModule.query_dovidka_1.SQL.add('ORDER BY MONEY.DATE_IN_OUT,');
        fmDataModule.query_dovidka_1.SQL.add('       POINTS.NAME');

        //clipboard.astext:=fmDataModule.query_dovidka_1.sql.text;
        fmDataModule.query_dovidka_1.open;
        if fmDataModule.query_dovidka_1.recordcount>0
        then result:=true
        else result:=false;
        end
   else begin
        result:=false;
        end;
end;

procedure TfmDovidka_12.query_to_grid(query: TIBQuery;
  Stringgrid: Tstringgrid);
var
   row_count,row_counter:integer;
   flag_data_output:boolean;
   DATE_IN_OUT:string;
   POINTS_NAME:string;
   expenses_1,
   expenses_2,
   expenses_4,
   expenses_5,
   expenses_6,
   expenses_8,
   expenses_10,
   expenses_12:real;
   expenses_1_all,
   expenses_2_all,
   expenses_4_all,
   expenses_5_all,
   expenses_6_all,
   expenses_8_all,
   expenses_10_all,
   expenses_12_all:real;

function check_date_into_visible_interval(temp_date:string):boolean;
var
    temp_value:TDateTime;
    return_value:boolean;
begin
    return_value:=false;
    try
        temp_value:=strtodate(temp_date);
        if  (temp_value>=self.edit_date_begin_display.date)
        and (temp_value<=self.edit_date_end_display.date)
        then begin
             return_value:=true;
             end;
    except
    end;
    result:=return_value;
end;

procedure add_string_to_float(s:string;var f:real);
var
   temp_float:real;
begin
   try
      temp_float:=strtofloat(s);
   except
      temp_float:=0;
   end;
   f:=f+temp_float;
end;

function string_to_format(s:string):string;
var
   temp_value:real;
begin
   try
      temp_value:=strtofloat(s);
   except
      temp_value:=0;
   end;
   result:=format('%.2f',[temp_value]);
end;

procedure out_people_header;
begin

end;

procedure out_data;
begin
   stringgrid.Cells[0,row_counter]:='DATA';
   if flag_data_output=true
   then begin
        stringgrid.Cells[1,row_counter]:=DATE_IN_OUT;
        end
   else begin
        stringgrid.Cells[1,row_counter]:='';
        end;
   if check_date_into_visible_interval(DATE_IN_OUT)
   then begin
        stringgrid.Cells[2,row_counter]:=POINTS_NAME;
        stringgrid.Cells[3,row_counter]:=format('%.2f',[expenses_2])+chr(13)+chr(10)+inttostr(row_counter)+',3';
        stringgrid.Cells[4,row_counter]:=format('%.2f',[expenses_6])+chr(13)+chr(10)+inttostr(row_counter)+',4';
        stringgrid.Cells[5,row_counter]:=format('%.2f',[expenses_1])+chr(13)+chr(10)+inttostr(row_counter)+',5';
        stringgrid.Cells[6,row_counter]:=format('%.2f',[expenses_4])+chr(13)+chr(10)+inttostr(row_counter)+',6';
        stringgrid.Cells[7,row_counter]:=format('%.2f',[expenses_5])+chr(13)+chr(10)+inttostr(row_counter)+',7';
        stringgrid.Cells[8,row_counter]:=format('%.2f',[expenses_10])+chr(13)+chr(10)+inttostr(row_counter)+',8';
        stringgrid.Cells[9,row_counter]:=format('%.2f',[expenses_8])+chr(13)+chr(10)+inttostr(row_counter)+',9';
        stringgrid.Cells[10,row_counter]:=format('%.2f',[expenses_12])+chr(13)+chr(10)+inttostr(row_counter)+',10';
        //stringgrid.Cells[11,row_counter]:=format('%.2f',[expenses_2+expenses_6+expenses_1+expenses_4+expenses_5+expenses_10+expenses_8+expenses_12]);
        stringgrid.Cells[11,row_counter]:=format('%.2f',[expenses_2+expenses_1+expenses_4+expenses_5+expenses_12]);
        if DATE_IN_OUT<>'����������� ���� �����'
        then inc(row_counter);
        end;

   expenses_2_all:=expenses_2_all+expenses_2;
   expenses_6_all:=expenses_6_all+expenses_6;
   expenses_1_all:=expenses_1_all+expenses_1;
   expenses_4_all:=expenses_4_all+expenses_4;
   expenses_5_all:=expenses_5_all+expenses_5;
   expenses_10_all:=expenses_10_all+expenses_10;
   expenses_8_all:=expenses_8_all+expenses_8;
   expenses_12_all:=expenses_12_all+expenses_12;
   expenses_2:=0;expenses_6:=0;expenses_1:=0;expenses_4:=0;expenses_5:=0;expenses_10:=0;expenses_8:=0;expenses_12:=0;
end;

procedure out_footer;
begin
   stringgrid.Cells[0,row_counter]:='FOOTER';
   //stringgrid.Cells[1,row_counter]:=query.fieldbyname('POINTS_NAME').asstring;
   stringgrid.Cells[3,row_counter]:=format('%.2f',[expenses_2_all]);
   stringgrid.Cells[4,row_counter]:=format('%.2f',[expenses_6_all]);
   stringgrid.Cells[5,row_counter]:=format('%.2f',[expenses_1_all]);
   stringgrid.Cells[6,row_counter]:=format('%.2f',[expenses_4_all]);
   stringgrid.Cells[7,row_counter]:=format('%.2f',[expenses_5_all]);
   stringgrid.Cells[8,row_counter]:=format('%.2f',[expenses_10_all]);
   stringgrid.Cells[9,row_counter]:=format('%.2f',[expenses_8_all]);
   stringgrid.Cells[10,row_counter]:=format('%.2f',[expenses_12_all]);
   //stringgrid.Cells[11,row_counter]:=format('%.2f',[expenses_2_all+expenses_6_all+expenses_1_all+expenses_4_all+expenses_5_all+expenses_10_all+expenses_8_all+expenses_12_all]);
   stringgrid.Cells[11,row_counter]:=format('%.2f',[expenses_2_all+expenses_1_all+expenses_4_all+expenses_5_all+expenses_12_all]);
   inc(row_counter);
end;


begin
   // ������ �����������
   fmdatamodule.clear_stringgrid(stringgrid);
   row_count:=fmDataModule.get_record_count(query);
   query.First;
   stringgrid.colcount:=12;
   stringgrid.rowcount:=row_count*2+20;
   // ��������� ������ � StringGrid � ������ �����������
   flag_data_output:=true;
   DATE_IN_OUT:='����������� ���� �����';
   POINTS_NAME:='';
   row_counter:=0;
   expenses_1:=0;
   expenses_2:=0;
   expenses_4:=0;
   expenses_5:=0;
   expenses_6:=0;
   expenses_8:=0;
   expenses_10:=0;
   expenses_12:=0;
   expenses_1_all:=0;
   expenses_2_all:=0;
   expenses_4_all:=0;
   expenses_5_all:=0;
   expenses_6_all:=0;
   expenses_8_all:=0;
   expenses_10_all:=0;
   expenses_12_all:=0;

   while not(query.Eof)
   do begin
      if DATE_IN_OUT<>query.fieldbyname('DATE_IN_OUT').asstring
      then begin
           out_data;
           DATE_IN_OUT:=query.fieldbyname('DATE_IN_OUT').asstring;
           POINTS_NAME:=query.fieldbyname('POINTS_NAME').asstring;
           flag_data_output:=true;
           end;
      if POINTS_NAME<>query.fieldbyname('POINTS_NAME').asstring
      then begin
           out_data;
           //DATE_IN_OUT:='';
           flag_data_output:=false;
           POINTS_NAME:=query.fieldbyname('POINTS_NAME').asstring;
           end;
      // ������������ ����������
      if query.FieldByName('EXPENSES_KOD').asinteger=1
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_1);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=2
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_2);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=4
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_4);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=5
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_5);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=6
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_6);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=8
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_8);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=10
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_10);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=12
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_12);
           end;
      query.next;
      end;
   out_data;
   out_footer;
   stringgrid.rowcount:=row_counter;
end;

procedure TfmDovidka_12.reportManualBuild(Page: TfrPage);
var
   i:integer;
begin
page.showbandbyname('HEADER_ALL');
for i:=0 to self.stringgrid_main.RowCount-1
do begin
   self.row_counter:=i;
   page.ShowBandByName(self.stringgrid_main.cells[0,row_counter]);
   end;
end;

procedure TfmDovidka_12.checkbox_date_beginClick(Sender: TObject);
begin
    if self.checkbox_date_begin.Checked
    then begin
         self.edit_date_begin.Visible:=false;
         self.set_display_interval(false);
         end
    else begin
         self.edit_date_begin.Visible:=true;
         self.set_display_interval;
         end;
end;

procedure TfmDovidka_12.reportObjectClick(View: TfrView);
var
   temp_string:string;
begin
    try
        temp_string:=TfrMemoView(view).Memo.text;
        self.report_main_click(temp_string);
        //showmessage(temp_string+chr(13)+chr(10)+chr(13)+chr(10)+string_row+'   '+string_column);
    except
    end;
end;

procedure TfmDovidka_12.reportMouseOverObject(View: TfrView;
  var Cursor: TCursor);
var
   temp_string:string;
   position:integer;
   length_string:integer;
begin
    try
        temp_string:=TfrMemoView(view).Memo.text;
        position:=pos(chr(10),temp_string);
        length_string:=length(temp_string);
        if ((position>0)
        and ((position)<>length_string))
        then begin
             cursor:=crHandPoint;
             end
        else begin
             cursor:=crDefault;
             end;
    except
        cursor:=crDefault;
    end;
end;

procedure TfmDovidka_12.report_main_click(string_value: string);
var
   temp_position:string;
   string_column,string_row:string;
   position:integer;
   column,row:integer;
begin
    try
        position:=pos(chr(10),string_value);
        if ((position>0)
        and ((position)<>length(string_value)))
        then begin
             temp_position:=copy(string_value,position+1,length(string_value));
             end;
        string_row:=copy(temp_position,1,pos(',',temp_position)-1);
        string_column:=copy(temp_position,length(string_row)+2,length(temp_position)-length(string_row)-3);
        row:=strtoint(string_row);
        column:=strtoint(string_column);
        //showmessage( self.get_points_name(self.stringgrid_main,column,row)+chr(13)+chr(10)
        //            +self.get_date(self.stringgrid_main,column,row));
        if self.execute_sub_query(fmDataModule.query_dovidka_1,
                                  fmDataModule.query_temp,
                                  self.get_date(self.stringgrid_main,column,row),
                                  self.get_points_name(self.stringgrid_main,column,row),
                                  self.get_expenses(column))
        then begin
             self.frDBDataSet_sub.dataset:=fmDataModule.query_dovidka_1;
             self.report_sub.title:='��������� �����';
             self.report_sub.ShowReport;
             end

    except

    end;
end;

function TfmDovidka_12.get_date(stringgrid: TstringGrid;
                                 position_column,
                                 position_row: integer): string;
var
    return_value:string;
    temp_string:string;
    temp_row:integer;
begin
    return_value:='';
    temp_row:=position_row;
    temp_string:=stringgrid.Cells[1,temp_row];
    while (trim(temp_string)='') and (temp_row>0)
    do begin
       dec(temp_row);
       temp_string:=stringgrid.Cells[1,temp_row];
       end;
    if temp_string<>''
    then return_value:=temp_string;
    result:=return_value;
end;

function TfmDovidka_12.get_points_name(stringgrid: TstringGrid;
                                        position_column,
                                        position_row: integer): string;

begin
    result:=stringgrid.Cells[2,position_row];

end;

function TfmDovidka_12.execute_sub_query(query,
                                          query_temp:TibQuery;
                                          string_date,
                                          string_point_name,
                                          string_expenses:string): boolean;
var
   temp_string:string;
   temp_points_kod:string;
begin
try
    query.sql.clear;
    query.sql.add('SELECT');
    query.sql.add('      MONEY.DATE_IN_OUT,');
    query.sql.add('      POINTS.NAME POINTS_NAME,');
    query.sql.add('      EXPENSES.NAME EXPENSES_NAME,');
    //query.sql.add('      EXPENSES.KOD EXPENSES_KOD,');
    query.sql.add('      MONEY.AMOUNT*EXPENSES.SIGN AMOUNT,');
    query.sql.add('      MONEY.KOD_MAN,');
    query.sql.add('      PEOPLE.FAMILIYA FAMILIYA,');
    query.sql.add('      PEOPLE.IMYA IMYA,');
    query.sql.add('      MONEY.DATE_WRITE DATE_WRITE,');
    query.sql.add('      MONEY.NOTE NOTE');
    query.sql.add('FROM MONEY');
    query.sql.add('LEFT JOIN POINTS ON POINTS.KOD=MONEY.KOD_POINT');
    query.sql.add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
    query.sql.add('    LEFT JOIN PEOPLE ON PEOPLE.KOD=MONEY.KOD_MAN');
    query.sql.add('');
    query.sql.add('WHERE MONEY.DATE_IN_OUT ='+chr(39)+string_date+chr(39));
    query.sql.add('AND MONEY.KOD_EXPENSES IN ('+string_expenses+')');
    if string_point_name<>''
    then begin
         temp_points_kod:=fmDataModule.get_name_by_id(query_temp,'POINTS','NAME',chr(39)+string_point_name+chr(39),'KOD');
         query.sql.add('AND POINTS.KOD='+temp_points_kod);
         end;
    query.sql.add('ORDER BY POINTS.KOD,PEOPLE.FAMILIYA,');
    query.sql.add('         PEOPLE.IMYA');
    query.Open;
    if query.recordcount>0
    then begin
         result:=true;
         end
    else begin
         result:=false;
         end;
except
    on e:exception
    do begin
       clipboard.astext:=query.sql.text;
       showmessage('������ ��� ���������� �������');
       end;
end;
end;

function TfmDovidka_12.get_expenses(position_column: integer): string;
var
   return_value:string;
   temp_value:integer;
begin
    return_value:='';
    try
//      1,2,4,5,6,8,10,12
        if position_column=3
        then return_value:='2';
        if position_column=4
        then return_value:='6';
        if position_column=5
        then return_value:='1';
        if position_column=6
        then return_value:='4';
        if position_column=7
        then return_value:='5';
        if position_column=8
        then return_value:='10';
        if position_column=9
        then return_value:='8';
        if position_column=10
        then return_value:='12';

    except
        on e:exception
        do begin
           return_value:='';
           end;
    end;
    result:=return_value;
end;

procedure TfmDovidka_12.set_display_interval(with_check:boolean=true);
begin
    self.edit_date_end_display.date:=self.edit_date_end.date;
    self.edit_date_begin_display.date:=self.edit_date_end.date-30;
    if with_check=true
    then begin
         self.check_display_interval;
         end
    else begin
         end;
end;

procedure TfmDovidka_12.check_display_interval;
begin
    // ��������� �� ���������� ���� �������
    if (self.edit_date_end.date<self.edit_date_begin.date)
    then begin
         {if self.edit_date_begin.visible=false
         then begin
              self.edit_date_end_display.date:=self.edit_date_end.date;
              self.edit_date_begin_display.date:=self.edit_date_end.date;
              end;}
         end
    else begin
         // ���������� �� ������ "� ������ ������"
         if self.edit_date_begin.visible=false
         then begin
              if (self.edit_date_end_display.date-self.edit_date_begin_display.date)>30
              then begin
                   //self.edit_date_begin_display.date:=self.edit_date_begin.date;
                   //self.edit_date_end_display.date:=self.edit_date_end.date;
                   end
              end
         else begin
              if  (self.edit_date_begin.date=self.edit_date_end.Date)
              then begin
                   self.set_display_interval(false);
                   end
              end;
         end;
end;

procedure TfmDovidka_12.edit_date_endChange(Sender: TObject);
begin
    self.set_display_interval(false);
end;

procedure TfmDovidka_12.edit_date_beginChange(Sender: TObject);
begin
     self.set_display_interval;
end;

procedure TfmDovidka_12.load_points_name;
begin
    try
       fmDataModule.query_temp.sql.text:='SELECT * FROM POINTS WHERE KOD>2';
       fmDataModule.query_temp.open;
       fmDataModule.load_from_query_field_to_combobox(fmDataModule.query_temp,'NAME',self.combobox_points);
       self.combobox_points.itemindex:=0;
    except
        on e:exception
        do begin
           showmessage('������ �������� ������');
           end;
    end;
end;

procedure TfmDovidka_12.FormShow(Sender: TObject);
begin
   load_data;
   fmDataModule.query_dovidka_1.sql.clear;

end;

end.
