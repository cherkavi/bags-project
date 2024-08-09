unit Dovidka_3_2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DataModule,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, FR_DSet, FR_DBSet,
  FR_Class,clipbrd, Grids,IBQuery;

type
  TfmDovidka_3_2 = class(TForm)
    edit_date: TdxDateEdit;
    button_show: TButton;
    Label2: TLabel;
    report: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    stringgrid_main: TStringGrid;
    ComboBox_post: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure button_showClick(Sender: TObject);
    procedure reportGetValue(const ParName: String; var ParValue: Variant);
    procedure reportManualBuild(Page: TfrPage);
  private
    { Private declarations }
  public
    { Public declarations }
    row_counter:integer;
    all_people_post:string;
    procedure load_data;
    function execute_query:boolean;
    procedure query_to_grid(query:TIBQuery;Stringgrid:Tstringgrid);
  end;

var
  fmDovidka_3_2: TfmDovidka_3_2;

implementation

{$R *.DFM}

procedure TfmDovidka_3_2.FormCreate(Sender: TObject);
begin
   load_data;
   fmDataModule.query_dovidka_1.sql.clear;
end;

procedure TfmDovidka_3_2.load_data;
begin
   self.all_people_post:='Все должности';
   fmDataModule.load_to_combobox_from_table_from_field(fmDataModule.query_temp,self.ComboBox_post,'POSTS','NAME');
   self.ComboBox_post.Items.Insert(0,self.all_people_post);
   self.combobox_post.ItemIndex:=0;
   self.edit_date.date:=Date;
end;


procedure TfmDovidka_3_2.button_showClick(Sender: TObject);
begin
   if self.execute_query=true
   then begin
        query_to_grid(fmDataModule.query_dovidka_1,self.StringGrid_main);
        report.ShowReport;
        end
   else begin
        showmessage(' По данному запросу ничего не найдено ');
        end;
end;

procedure TfmDovidka_3_2.reportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='DATE_END'
   then ParValue:=self.edit_date.text;
   if parname='FIO'
   then parvalue:=self.stringgrid_main.Cells[1,self.row_counter];
   if parname='POINTS_NAME'
   then parvalue:=self.stringgrid_main.Cells[2,self.row_counter];
   if parname='EXPENSES_2'
   then parvalue:=self.stringgrid_main.Cells[3,self.row_counter];
   if parname='EXPENSES_7'
   then parvalue:=self.stringgrid_main.Cells[4,self.row_counter];
   if parname='EXPENSES_6'
   then parvalue:=self.stringgrid_main.Cells[5,self.row_counter];
   if parname='EXPENSES_1'
   then parvalue:=self.stringgrid_main.Cells[6,self.row_counter];
   if parname='EXPENSES_11'
   then parvalue:=self.stringgrid_main.Cells[7,self.row_counter];
   if parname='EXPENSES_3'
   then parvalue:=self.stringgrid_main.Cells[8,self.row_counter];
   if parname='SUMA'
   then parvalue:=self.stringgrid_main.Cells[9,self.row_counter];

   if parname='EXPENSES_2_ALL'
   then parvalue:=self.stringgrid_main.Cells[3,self.row_counter];
   if parname='EXPENSES_7_ALL'
   then parvalue:=self.stringgrid_main.Cells[4,self.row_counter];
   if parname='EXPENSES_6_ALL'
   then parvalue:=self.stringgrid_main.Cells[5,self.row_counter];
   if parname='EXPENSES_1_ALL'
   then parvalue:=self.stringgrid_main.Cells[6,self.row_counter];
   if parname='EXPENSES_11_ALL'
   then parvalue:=self.stringgrid_main.Cells[7,self.row_counter];
   if parname='EXPENSES_3_ALL'
   then parvalue:=self.stringgrid_main.Cells[8,self.row_counter];
   if parname='SUMA_ALL'
   then parvalue:=self.stringgrid_main.Cells[9,self.row_counter];

end;

function TfmDovidka_3_2.execute_query: boolean;
begin
   if (self.edit_date.text<>'')
   then begin
        fmDataModule.query_dovidka_1.SQL.clear;
        fmDataModule.query_dovidka_1.SQL.add('SELECT');
        fmDataModule.query_dovidka_1.SQL.add('        PEOPLE.KOD PEOPLE_KOD,');
        fmDataModule.query_dovidka_1.SQL.add('        PEOPLE.FAMILIYA,');
        fmDataModule.query_dovidka_1.SQL.add('        PEOPLE.imya,');
        fmDataModule.query_dovidka_1.SQL.add('        PEOPLE.otchestvo,');
        fmDataModule.query_dovidka_1.SQL.add('        POINTS.NAME POINTS_NAME,');
        fmDataModule.query_dovidka_1.SQL.add('        EXPENSES.KOD EXPENSES_KOD,');
        fmDataModule.query_dovidka_1.SQL.add('        EXPENSES.NAME EXPENSES_NAME,');
        fmDataModule.query_dovidka_1.SQL.add('        sum(MONEY.AMOUNT*(EXPENSES.SIGN_SELLER)) AMOUNT');
        fmDataModule.query_dovidka_1.SQL.add('FROM MONEY');
        fmDataModule.query_dovidka_1.SQL.add('INNER JOIN PEOPLE on PEOPLE.KOD=MONEY.kod_man');
        if self.ComboBox_post.text=self.all_people_post
        then begin
             // отобразить все должности
             end
        else begin
             // отобразить только одну должность
             fmDataModule.query_dovidka_1.SQL.add('       AND PEOPLE.post_kod='+fmDatamodule.get_name_by_id(fmDataModule.query_temp,'POSTS','NAME',chr(39)+self.ComboBox_post.text+chr(39),'KOD'));
             end;
        fmDataModule.query_dovidka_1.SQL.add('LEFT JOIN POINTS ON POINTS.KOD=MONEY.KOD_POINT');
        fmDataModule.query_dovidka_1.SQL.add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES --AND EXPENSES.sign_seller<>0');
        fmDataModule.query_dovidka_1.SQL.add('WHERE');
        fmDataModule.query_dovidka_1.SQL.add('        MONEY.KOD_EXPENSES IN (1,2,3,6,7,9,11)');
        fmDataModule.query_dovidka_1.SQL.add('    AND MONEY.date_in_out<='+chr(39)+self.edit_date.text+chr(39));
        fmDataModule.query_dovidka_1.SQL.add('GROUP BY');
        fmDataModule.query_dovidka_1.SQL.add('        PEOPLE.KOD,');
        fmDataModule.query_dovidka_1.SQL.add('        PEOPLE.FAMILIYA,');
        fmDataModule.query_dovidka_1.SQL.add('        PEOPLE.imya,');
        fmDataModule.query_dovidka_1.SQL.add('        PEOPLE.otchestvo,');
        fmDataModule.query_dovidka_1.SQL.add('        POINTS.NAME,');
        fmDataModule.query_dovidka_1.SQL.add('        EXPENSES.KOD,');
        fmDataModule.query_dovidka_1.SQL.add('        EXPENSES.NAME');


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

procedure TfmDovidka_3_2.query_to_grid(query: TIBQuery;
  Stringgrid: Tstringgrid);
var
   row_count,row_counter:integer;
   PEOPLE_KOD:string;
   FIO:string;
   POINTS_NAME:string;
   expenses_1,
   expenses_2,
   expenses_3,
   expenses_6,
   expenses_7,
   expenses_11:real;
   expenses_1_all,
   expenses_2_all,
   expenses_3_all,
   expenses_6_all,
   expenses_7_all,
   expenses_11_all:real;

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
   stringgrid.Cells[1,row_counter]:=FIO;
   stringgrid.Cells[2,row_counter]:=POINTS_NAME;
   stringgrid.Cells[3,row_counter]:=format('%.2f',[expenses_2]);
   stringgrid.Cells[4,row_counter]:=format('%.2f',[expenses_7]);
   stringgrid.Cells[5,row_counter]:=format('%.2f',[expenses_6]);
   stringgrid.Cells[6,row_counter]:=format('%.2f',[expenses_1]);
   stringgrid.Cells[7,row_counter]:=format('%.2f',[expenses_11]);
   stringgrid.Cells[8,row_counter]:=format('%.2f',[expenses_3]);
   stringgrid.Cells[9,row_counter]:=format('%.2f',[expenses_1+expenses_3+expenses_6+expenses_7+expenses_11]);

   if POINTS_NAME<>'невероятная точка для ввода'
   then inc(row_counter);
   expenses_1_all:=expenses_1_all+expenses_1;
   expenses_2_all:=expenses_2_all+expenses_2;
   expenses_3_all:=expenses_3_all+expenses_3;
   expenses_6_all:=expenses_6_all+expenses_6;
   expenses_7_all:=expenses_7_all+expenses_7;
   expenses_11_all:=expenses_11_all+expenses_11;
   expenses_1:=0;expenses_2:=0;expenses_3:=0;expenses_6:=0;expenses_7:=0;expenses_11:=0;
end;

procedure out_footer;
begin
   stringgrid.Cells[0,row_counter]:='FOOTER';
   //stringgrid.Cells[1,row_counter]:=query.fieldbyname('POINTS_NAME').asstring;
   stringgrid.Cells[3,row_counter]:=format('%.2f',[expenses_2_all]);
   stringgrid.Cells[4,row_counter]:=format('%.2f',[expenses_7_all]);
   stringgrid.Cells[5,row_counter]:=format('%.2f',[expenses_6_all]);
   stringgrid.Cells[6,row_counter]:=format('%.2f',[expenses_1_all]);
   stringgrid.Cells[7,row_counter]:=format('%.2f',[expenses_11_all]);
   stringgrid.Cells[8,row_counter]:=format('%.2f',[expenses_3_all]);
   stringgrid.Cells[9,row_counter]:=format('%.2f',[expenses_1_all+expenses_3_all+expenses_6_all+expenses_7_all+expenses_11_all]);
   inc(row_counter);
end;

begin
   // задать размерность
   fmdatamodule.clear_stringgrid(stringgrid);
   row_count:=fmDataModule.get_record_count(query);
   query.First;
   stringgrid.colcount:=10;
   stringgrid.rowcount:=row_count*2+20;
   // сохранить данные в StringGrid с учетом детализации
   POINTS_NAME:='невероятная точка для ввода';
   PEOPLE_KOD:='jj';
   row_counter:=0;
   expenses_1:=0;
   expenses_2:=0;
   expenses_3:=0;
   expenses_6:=0;
   expenses_7:=0;
   expenses_11:=0;

   expenses_1_all:=0;
   expenses_2_all:=0;
   expenses_3_all:=0;
   expenses_6_all:=0;
   expenses_7_all:=0;
   expenses_11_all:=0;

   while not(query.Eof)
   do begin
      if PEOPLE_KOD<>query.fieldbyname('PEOPLE_KOD').asstring
      then begin
           if PEOPLE_KOD<>''
           then begin
                out_data;
                FIO:=query.fieldbyname('FAMILIYA').asstring+' '+query.fieldbyname('IMYA').asstring+' '+query.fieldbyname('OTCHESTVO').asstring;
                POINTS_NAME:=query.fieldbyname('POINTS_NAME').asstring;
                PEOPLE_KOD:=query.fieldbyname('PEOPLE_KOD').asstring;
                end;
           end;
      if POINTS_NAME<>query.fieldbyname('POINTS_NAME').asstring
      then begin
           if POINTS_NAME<>''
           then begin
                out_data;
                FIO:='';
                POINTS_NAME:=query.fieldbyname('POINTS_NAME').asstring;
                end;
           end;
      // суммирование переменных
      if query.FieldByName('EXPENSES_KOD').asinteger=1
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_1);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=2
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_2);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=3
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_3);
           end;
      if query.FieldByName('EXPENSES_KOD').asinteger=6
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_6);
           end;
      if (query.FieldByName('EXPENSES_KOD').asinteger=7) or (query.FieldByName('EXPENSES_KOD').asinteger=9)
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_7);
           end;
      if (query.FieldByName('EXPENSES_KOD').asinteger=11)
      then begin
           add_string_to_float(query.fieldbyname('AMOUNT').asstring,expenses_11);
           end;
      query.next;
      end;
   out_data;
   out_footer;
   stringgrid.rowcount:=row_counter;
end;

procedure TfmDovidka_3_2.reportManualBuild(Page: TfrPage);
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

end.
