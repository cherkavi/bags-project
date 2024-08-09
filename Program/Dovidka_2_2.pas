unit Dovidka_2_2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DataModule,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, FR_DSet, FR_DBSet,
  FR_Class,clipbrd, Grids,IBQuery;

type
  TfmDovidka_2_2 = class(TForm)
    edit_date_begin: TdxDateEdit;
    button_show: TButton;
    Label2: TLabel;
    report: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    CheckBox_detail: TCheckBox;
    stringgrid_main: TStringGrid;
    Label1: TLabel;
    edit_date_end: TdxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure button_showClick(Sender: TObject);
    procedure reportGetValue(const ParName: String; var ParValue: Variant);
    procedure reportManualBuild(Page: TfrPage);
  private
    { Private declarations }
  public
    { Public declarations }
    row_counter:integer;
    points_all_name:string;
    procedure load_data;
    function execute_query:boolean;
    procedure query_to_grid(query:TIBQuery;Stringgrid:Tstringgrid);
  end;

var
  fmDovidka_2_2: TfmDovidka_2_2;

implementation

{$R *.DFM}

procedure TfmDovidka_2_2.FormCreate(Sender: TObject);
begin
   self.points_all_name:='¬се точки';
   load_data;
   fmDataModule.query_dovidka_1.sql.clear;
end;

procedure TfmDovidka_2_2.load_data;
begin
   self.edit_date_begin.date:=Date;
   self.edit_date_end.date:=date;
end;


procedure TfmDovidka_2_2.button_showClick(Sender: TObject);
begin
   if self.execute_query=true
   then begin
        query_to_grid(fmDataModule.query_dovidka_1,self.StringGrid_main);
        report.ShowReport;
        end
   else begin
        showmessage(' ѕо данному запросу ничего не найдено ');
        end;
end;

procedure TfmDovidka_2_2.reportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='DATE_BEGIN'
   then ParValue:=self.edit_date_begin.text;
   if ParName='DATE_END'
   then ParValue:=self.edit_date_end.text;
   if parname='POINTS_NAME'
   then parvalue:=self.stringgrid_main.Cells[1,self.row_counter];
   if parname='ASSORTMENT_NAME'
   then parvalue:=self.stringgrid_main.Cells[2,self.row_counter];
   if parname='QUANTITY'
   then parvalue:=self.stringgrid_main.Cells[3,self.row_counter];
   if parname='PRICE'
   then parvalue:=self.stringgrid_main.Cells[4,self.row_counter];
   if parname='SUMA'
   then parvalue:=self.stringgrid_main.Cells[5,self.row_counter];
   if parname='PRICE_BUYING'
   then parvalue:=self.stringgrid_main.Cells[6,self.row_counter];
   if parname='SUMA_BUYING'
   then parvalue:=self.stringgrid_main.Cells[7,self.row_counter];

   if parname='QUANTITY_POINTS'
   then parvalue:=self.stringgrid_main.Cells[3,self.row_counter];
   if parname='SUMA_POINTS'
   then parvalue:=self.stringgrid_main.Cells[5,self.row_counter];
   if parname='SUMA_BUYING_POINTS'
   then parvalue:=self.stringgrid_main.Cells[7,self.row_counter];

   if parname='QUANTITY_ALL'
   then parvalue:=self.stringgrid_main.Cells[3,self.row_counter];
   if parname='SUMA_ALL'
   then parvalue:=self.stringgrid_main.Cells[5,self.row_counter];
   if parname='SUMA_BUYING_ALL'
   then parvalue:=self.stringgrid_main.Cells[7,self.row_counter];

end;

function TfmDovidka_2_2.execute_query: boolean;
begin
   if (self.edit_date_begin.text<>'') and (self.edit_date_end.text<>'')
   then begin
        fmDataModule.query_dovidka_1.SQL.clear;
        fmDataModule.query_dovidka_1.SQL.add('SELECT');
        fmDataModule.query_dovidka_1.SQL.add('        POINTS.NAME POINTS_NAME,');
        fmDataModule.query_dovidka_1.SQL.add('        COMMODITY.ASSORTMENT_KOD,');
        fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.NAME ASSORTMENT_NAME,');
        fmDataModule.query_dovidka_1.SQL.add('        SUM(COMMODITY.QUANTITY)*(-1) QUANTITY,');
        fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE PRICE,');
        fmDataModule.query_dovidka_1.SQL.add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE*(-1) SUMA,');
        fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE_BUYING PRICE_BUYING,');
        fmDataModule.query_dovidka_1.SQL.add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE_BUYING*(-1) SUMA_BUYING');
        fmDataModule.query_dovidka_1.SQL.add('FROM COMMODITY');
        fmDataModule.query_dovidka_1.SQL.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
        fmDataModule.query_dovidka_1.SQL.add('INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD');
        fmDataModule.query_dovidka_1.SQL.add('WHERE 1=1');
        fmDataModule.query_dovidka_1.SQL.add('AND COMMODITY.OPERATION_KOD=1');
        fmDataModule.query_dovidka_1.SQL.add('AND COMMODITY.date_in_out BETWEEN '+chr(39)+self.edit_date_begin.text+chr(39)+' AND '+chr(39)+self.edit_date_end.text+chr(39));
        fmDataModule.query_dovidka_1.SQL.add('GROUP BY');
        fmDataModule.query_dovidka_1.SQL.add('        POINTS.NAME,');
        fmDataModule.query_dovidka_1.SQL.add('        COMMODITY.ASSORTMENT_KOD,');
        fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.NAME,');
        fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE,');
        fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE_BUYING');
        fmDataModule.query_dovidka_1.SQL.add('ORDER BY POINTS.NAME, COMMODITY.ASSORTMENT_KOD');

        //clipboard.astext:=fmDataModule.query_dovidka.sql.text;
        fmDataModule.query_dovidka_1.open;
        if fmDataModule.query_dovidka_1.recordcount>0
        then result:=true
        else result:=false;
        end
   else begin
        result:=false;
        end;
end;

procedure TfmDovidka_2_2.query_to_grid(query: TIBQuery;
  Stringgrid: Tstringgrid);
var
   row_count,row_counter:integer;
   POINTS_NAME:string;
   points_sum_quantity,
   points_sum_suma,
   points_sum_suma_buying:real;
   points_sum_quantity_all,
   points_sum_suma_all,
   points_sum_suma_buying_all:real;


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

procedure out_header_points_name;
begin
   stringgrid.Cells[0,row_counter]:='HEADER_POINTS_NAME';
   stringgrid.Cells[1,row_counter]:=query.fieldbyname('POINTS_NAME').asstring;
   POINTS_NAME:=query.fieldbyname('POINTS_NAME').asstring;
   inc(row_counter);
end;

procedure out_data;
begin
   stringgrid.Cells[0,row_counter]:='DATA';
   //stringgrid.Cells[1,row_counter]:=query.fieldbyname('POINTS_NAME').asstring;
   stringgrid.Cells[2,row_counter]:=query.fieldbyname('ASSORTMENT_NAME').asstring;
   stringgrid.Cells[3,row_counter]:=query.fieldbyname('QUANTITY').asstring;
   stringgrid.Cells[4,row_counter]:=string_to_format(query.fieldbyname('PRICE').asstring);
   stringgrid.Cells[5,row_counter]:=string_to_format(query.fieldbyname('SUMA').asstring);
   stringgrid.Cells[6,row_counter]:=string_to_format(query.fieldbyname('PRICE_BUYING').asstring);
   stringgrid.Cells[7,row_counter]:=string_to_format(query.fieldbyname('SUMA_BUYING').asstring);
   inc(row_counter);
end;

procedure out_footer_points_name;
var
   back_counter:integer;
begin
   back_counter:=row_counter;
   while back_counter>=0
   do begin
      if stringgrid.cells[0,back_counter]='HEADER_POINTS_NAME'
      then break;
      dec(back_counter);
      end;
   if back_counter>=0
   then begin
        //stringgrid.Cells[0,back_counter]:='FOOTER_POINTS_NAME';
        //stringgrid.Cells[1,row_counter]:=query.fieldbyname('POINTS_NAME').asstring;
        stringgrid.Cells[3,back_counter]:=format('%.0f',[points_sum_quantity]);
        stringgrid.Cells[5,back_counter]:=format('%.2f',[points_sum_suma]);
        stringgrid.Cells[7,back_counter]:=format('%.2f',[points_sum_suma_buying]);
        points_sum_quantity_all:=points_sum_quantity_all+points_sum_quantity;
        points_sum_suma_all:=points_sum_suma_all+points_sum_suma;
        points_sum_suma_buying_all:=points_sum_suma_buying_all+points_sum_suma_buying;
        points_sum_quantity:=0;
        points_sum_suma:=0;
        points_sum_suma_buying:=0;
        end;
   //inc(row_counter);
end;

procedure out_footer;
begin
   stringgrid.Cells[0,row_counter]:='FOOTER';
   //stringgrid.Cells[1,row_counter]:=query.fieldbyname('POINTS_NAME').asstring;
   stringgrid.Cells[3,row_counter]:=format('%.0f',[points_sum_quantity_all]);
   stringgrid.Cells[5,row_counter]:=format('%.2f',[points_sum_suma_all]);
   stringgrid.Cells[7,row_counter]:=format('%.2f',[points_sum_suma_buying_all]);
   inc(row_counter);
end;

begin
   // задать размерность
   fmdatamodule.clear_stringgrid(stringgrid);
   row_count:=fmDataModule.get_record_count(query);query.First;
   stringgrid.colcount:=8;
   stringgrid.rowcount:=row_count*2+20;
   // сохранить данные в StringGrid с учетом детализации
   POINTS_NAME:='';
   row_counter:=0;
   points_sum_quantity:=0;
   points_sum_suma:=0;
   points_sum_suma_buying:=0;
   points_sum_quantity_all:=0;
   points_sum_suma_all:=0;
   points_sum_suma_buying_all:=0;

   while not(query.Eof)
   do begin
      if POINTS_NAME<>query.fieldbyname('POINTS_NAME').asstring
      then begin
           if POINTS_NAME<>''
           then out_footer_points_name;
           out_header_points_name;
           end;
      // суммирование переменных
      add_string_to_float(query.fieldbyname('QUANTITY').asstring,points_sum_quantity);
      add_string_to_float(query.fieldbyname('SUMA').asstring,points_sum_suma);
      add_string_to_float(query.fieldbyname('SUMA_BUYING').asstring,points_sum_suma_buying);

      if self.CheckBox_detail.checked=true
      then out_data;
      query.next;
      end;
   out_footer_points_name;
   out_footer;
   stringgrid.rowcount:=row_counter;
end;

procedure TfmDovidka_2_2.reportManualBuild(Page: TfrPage);
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
