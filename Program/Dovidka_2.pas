unit Dovidka_2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DataModule,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, FR_DSet, FR_DBSet,
  FR_Class,clipbrd, CheckLst;

type
  TfmDovidka_2 = class(TForm)
    edit_date_begin: TdxDateEdit;
    button_show: TButton;
    Label2: TLabel;
    report: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    CheckListBox_points: TCheckListBox;
    edit_date_end: TdxDateEdit;
    Label1: TLabel;
    button_invert: TButton;
    button_clear: TButton;
    procedure FormCreate(Sender: TObject);
    procedure button_showClick(Sender: TObject);
    procedure reportGetValue(const ParName: String; var ParValue: Variant);
    procedure button_clearClick(Sender: TObject);
    procedure button_invertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    points_all_name:string;
    procedure load_data;
    function get_stringlist_from_checklistbox(checklistbox:TCheckListBox;value:boolean;preambule,postambule:string):TStringlist;
    function get_items_comma_delimeter_from_checklistbox(checklistbox:TCheckListBox;value:boolean):string;
    function isCheckedCheckListBox(checklistbox:TCheckListBox):boolean;
  end;

var
  fmDovidka_2: TfmDovidka_2;

implementation

{$R *.DFM}

procedure TfmDovidka_2.FormCreate(Sender: TObject);
begin
   self.points_all_name:='Все точки';
   load_data;
   fmDataModule.query_dovidka_1.sql.clear;
end;

procedure TfmDovidka_2.load_data;
var
   i:integer;
begin
   self.edit_date_begin.date:=Date;
   self.edit_date_end.date:=date;
   fmDataModule.load_to_strings_from_table_from_field(fmDataModule.query_temp,self.CheckListBox_points.items,'POINTS','NAME','','KOD');
   for i:=0 to self.CheckListBox_points.Items.count-1
   do begin
      self.CheckListBox_points.Checked[i]:=false;
      end;
end;

procedure TfmDovidka_2.button_showClick(Sender: TObject);
var
   temp_string:string;
begin
   if (self.edit_date_end.text<>'') and (self.edit_date_begin.text<>'')
   and self.isCheckedCheckListBox(self.CheckListBox_points)
   then begin
        fmDataModule.query_dovidka_1.SQL.clear;
        fmDataModule.query_dovidka_1.SQL.add('SELECT  COMMODITY.ASSORTMENT_KOD,');
        fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.NAME,');
        fmDataModule.query_dovidka_1.SQL.add('        SUM(COMMODITY.QUANTITY)*(-1) QUANTITY,');
        fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE PRICE,');
        fmDataModule.query_dovidka_1.SQL.add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE*(-1) SUMA');
        fmDataModule.query_dovidka_1.SQL.add('FROM COMMODITY');
        fmDataModule.query_dovidka_1.SQL.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
        fmDataModule.query_dovidka_1.SQL.add('WHERE 1=1 ');
        fmDataModule.query_dovidka_1.SQL.add('AND COMMODITY.OPERATION_KOD=1');
        fmDataModule.load_to_string_comma_determinate_do_from_table_from_field_where_in(fmDataModule.query_temp,temp_string,'POINTS','KOD','NAME',self.get_stringlist_from_checklistbox(self.CheckListBox_points,true,chr(39),chr(39)),'');
        fmDataModule.query_dovidka_1.SQL.add('AND COMMODITY.POINT_KOD IN ('+temp_string+')');
        fmDataModule.query_dovidka_1.SQL.add('AND COMMODITY.date_in_out BETWEEN '+chr(39)+self.edit_date_begin.text+chr(39)+' AND '+chr(39)+self.edit_date_end.text+chr(39));
        fmDataModule.query_dovidka_1.SQL.add('GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRICE');
        fmDataModule.query_dovidka_1.SQL.add('HAVING SUM(COMMODITY.QUANTITY)<>0');
        fmDataModule.query_dovidka_1.SQL.add('ORDER BY COMMODITY.ASSORTMENT_KOD');
        //clipboard.astext:=fmDataModule.query_dovidka.sql.text;
        fmDataModule.query_dovidka_1.open;
        if fmDataModule.query_dovidka_1.recordcount>0
        then begin
             report.ShowReport;
             end
        else begin
             showmessage(' По данному запросу ничего не найдено ');
             end;
        end
   else begin
        showmessage(' По данному запросу ничего не найдено ');
        end;
end;

procedure TfmDovidka_2.reportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='POINTS'
   then ParValue:=get_items_comma_delimeter_from_checklistbox(self.CheckListBox_points,true);
   if ParName='DATE_BEGIN'
   then parvalue:=self.edit_date_begin.text;
   if ParName='DATE_END'
   then ParValue:=self.edit_date_end.text;
end;


function TfmDovidka_2.get_stringlist_from_checklistbox(
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


function TfmDovidka_2.get_items_comma_delimeter_from_checklistbox(
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
function TfmDovidka_2.isCheckedCheckListBox(
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

procedure TfmDovidka_2.button_clearClick(Sender: TObject);
begin
   fmdatamodule.checklistbox_clear(self.CheckListBox_points);
end;

procedure TfmDovidka_2.button_invertClick(Sender: TObject);
begin
   fmdatamodule.checklistbox_invert(self.CheckListBox_points);
end;

end.
