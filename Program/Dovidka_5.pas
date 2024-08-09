unit Dovidka_5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib,dataModule, FR_DSet,
  FR_DBSet, FR_Class,clipbrd, CheckLst;

type
  TfmDovidka_5 = class(TForm)
    edit_date_begin: TdxDateEdit;
    button_show: TButton;
    Label1: TLabel;
    Report: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    CheckListBox_points: TCheckListBox;
    edit_date_end: TdxDateEdit;
    Label2: TLabel;
    button_invert: TButton;
    button_clear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ReportGetValue(const ParName: String;
      var ParValue: Variant);
    procedure button_showClick(Sender: TObject);
    procedure button_clearClick(Sender: TObject);
    procedure button_invertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    all_point_caption:string;
    function get_stringlist_from_checklistbox(checklistbox:TCheckListBox;value:boolean;preambule,postambule:string):TStringlist;
    function get_items_comma_delimeter_from_checklistbox(checklistbox:TCheckListBox;value:boolean):string;
    function isCheckedCheckListBox(checklistbox:TCheckListBox):boolean;
  end;

var
  fmDovidka_5: TfmDovidka_5;

implementation

{$R *.DFM}

procedure TfmDovidka_5.FormCreate(Sender: TObject);
var
   i:integer;
begin
   self.all_point_caption:='Все точки';
   self.edit_date_begin.date:=Date;
   self.edit_date_end.date:=date;
   fmDataModule.load_to_strings_from_table_from_field(fmDataModule.query_temp,self.CheckListBox_points.items,'POINTS','NAME','','KOD');
   for i:=0 to self.CheckListBox_points.Items.count-1
   do begin
      self.CheckListBox_points.Checked[i]:=false;
      end;

end;

procedure TfmDovidka_5.ReportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='DATE_BEGIN'
   then begin
        parValue:=self.edit_date_begin.text;
        end;
   if ParName='DATE_END'
   then begin
        parValue:=self.edit_date_end.text;
        end;
   if ParName='PLACE'
   then begin
        ParValue:='по торговым точкам:'+get_items_comma_delimeter_from_checklistbox(self.CheckListBox_points,true);
        end;
end;

procedure TfmDovidka_5.button_showClick(Sender: TObject);
var
   temp_string:string;
begin
   if (self.edit_date_begin.text<>'') and (self.edit_date_end.text<>'')
   and (self.isCheckedCheckListBox(self.CheckListBox_points))
   then begin
        fmdataModule.query_dovidka_1.SQL.clear;
        fmdataModule.query_dovidka_1.SQL.add('SELECT');
        fmdataModule.query_dovidka_1.SQL.add('        POINTS.NAME POINTS_NAME,');
        fmdataModule.query_dovidka_1.SQL.add('        WRITER_MAN.FAMILIYA,');
        fmdataModule.query_dovidka_1.SQL.add('        WRITER_MAN.IMYA,');
        fmdataModule.query_dovidka_1.SQL.add('        COMMODITY.WRITE_DATE,');
        fmdataModule.query_dovidka_1.SQL.add('        COMMODITY.ASSORTMENT_KOD,');
        fmdataModule.query_dovidka_1.SQL.add('        ASSORTMENT.NAME ASSORTMENT_NAME,');
        fmdataModule.query_dovidka_1.SQL.add('        COMMODITY.QUANTITY*(-1) QUANTITY,');
        fmdataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE PRICE,');
        fmdataModule.query_dovidka_1.SQL.add('        COMMODITY.QUANTITY*ASSORTMENT.PRICE*(-1) SUMA,');
        fmdataModule.query_dovidka_1.SQL.add('        COMMODITY.DATE_IN_OUT,');
        fmdataModule.query_dovidka_1.SQL.add('        COMMODITY.KOD COMMODITY_KOD');
        fmdataModule.query_dovidka_1.SQL.add('FROM COMMODITY');
        fmdataModule.query_dovidka_1.SQL.add('   INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
        fmdataModule.query_dovidka_1.SQL.add('   INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD');
        fmdataModule.query_dovidka_1.SQL.add('   LEFT JOIN PEOPLE WRITER_MAN ON WRITER_MAN.KOD=COMMODITY.WRITER');
        fmdataModule.query_dovidka_1.SQL.add('WHERE  1=1');
        fmDataModule.load_to_string_comma_determinate_do_from_table_from_field_where_in(fmDataModule.query_temp,temp_string,'POINTS','KOD','NAME',self.get_stringlist_from_checklistbox(self.CheckListBox_points,true,chr(39),chr(39)),'');
        fmdataModule.query_dovidka_1.SQL.add('AND COMMODITY.POINT_KOD IN ('+temp_string+')');
        fmdataModule.query_dovidka_1.SQL.add('AND COMMODITY.DATE_IN_OUT BETWEEN '+chr(39)+self.edit_date_begin.text+chr(39)+' AND '+chr(39)+self.edit_date_end.text+chr(39));
        fmdataModule.query_dovidka_1.SQL.add('AND COMMODITY.OPERATION_KOD=3');
        fmdataModule.query_dovidka_1.SQL.add('ORDER BY COMMODITY.date_in_out');
        //clipboard.astext:=fmdataModule.query_dovidka_1.sql.text;
        fmdataModule.query_dovidka_1.open;
        if fmDataModule.query_dovidka_1.recordcount>0
        then begin
             self.Report.showreport
             end
        else begin
             showmessage(' Нет данных для отображения');
             end;
        end
   else begin
        showmessage(' Нет данных для отображения');
        end;
end;

function TfmDovidka_5.get_items_comma_delimeter_from_checklistbox(
  checklistbox: TCheckListBox; value: boolean): string;
var
   temp_string:string;
   index:integer;
begin
   temp_string:='';
   for index:=0 to checklistbox.Items.count-1
   do begin
      if checklistbox.Checked[index]=value
      then temp_string:=temp_string+checklistbox.items.strings[index]+', ';
      end;
   if temp_string<>''
   then begin
        temp_string:=copy(temp_string,1,length(temp_string)-2);
        end;
   result:=temp_string;
end;

function TfmDovidka_5.get_stringlist_from_checklistbox(
  checklistbox: TCheckListBox; value: boolean; preambule,
  postambule: string): TStringlist;
var
  index:integer;
  stringlist:tstringlist;
begin
   stringlist:=tstringlist.create;
   for index:=0 to checklistbox.Items.count-1
   do begin
      if checklistbox.Checked[index]
      then stringlist.Add(preambule+checklistbox.Items.Strings[index]+postambule);
      end;
   result:=stringlist;
end;

function TfmDovidka_5.isCheckedCheckListBox(
  checklistbox: TCheckListBox): boolean;
var
   i:integer;
   return_value:boolean;
begin
   return_value:=false;
   for i:=0 to checklistbox.Items.count-1
   do begin
      if checklistbox.Checked[i]
      then begin
           return_value:=true;
           break;
           end;
      end;
   result:=return_value;
end;

procedure TfmDovidka_5.button_clearClick(Sender: TObject);
begin
   fmdatamodule.checklistbox_clear(self.CheckListBox_points);
end;

procedure TfmDovidka_5.button_invertClick(Sender: TObject);
begin
   fmdatamodule.checklistbox_invert(self.CheckListBox_points);
end;

end.
