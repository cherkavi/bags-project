unit Dovidka_10;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,DataModule,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, FR_DSet, FR_DBSet,
  FR_Class,clipbrd, CheckLst;

type
  TfmDovidka_10 = class(TForm)
    edit_date_begin: TdxDateEdit;
    button_show: TButton;
    Label2: TLabel;
    report: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    checkbox_detail: TCheckBox;
    CheckListBox_points: TCheckListBox;
    Label1: TLabel;
    edit_date_end: TdxDateEdit;
    button_invert: TButton;
    button_clear: TButton;
    GroupBox_1: TGroupBox;
    CheckBox_1: TCheckBox;
    RadioButton_1_1: TRadioButton;
    RadioButton_1_2: TRadioButton;
    RadioButton_1_3: TRadioButton;
    GroupBox1: TGroupBox;
    CheckBox_2: TCheckBox;
    RadioButton_2_1: TRadioButton;
    RadioButton_2_2: TRadioButton;
    RadioButton_2_3: TRadioButton;
    GroupBox2: TGroupBox;
    CheckBox_3: TCheckBox;
    RadioButton_3_1: TRadioButton;
    RadioButton_3_2: TRadioButton;
    RadioButton_3_3: TRadioButton;
    GroupBox3: TGroupBox;
    CheckBox_4: TCheckBox;
    RadioButton_4_1: TRadioButton;
    RadioButton_4_2: TRadioButton;
    RadioButton_4_3: TRadioButton;
    GroupBox4: TGroupBox;
    CheckBox_6: TCheckBox;
    RadioButton_6_1: TRadioButton;
    RadioButton_6_2: TRadioButton;
    RadioButton_6_3: TRadioButton;
    GroupBox5: TGroupBox;
    CheckBox_7: TCheckBox;
    RadioButton_7_1: TRadioButton;
    RadioButton_7_2: TRadioButton;
    RadioButton_7_3: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure button_showClick(Sender: TObject);
    procedure reportGetValue(const ParName: String; var ParValue: Variant);
    procedure button_clearClick(Sender: TObject);
    procedure button_invertClick(Sender: TObject);
    procedure CheckBox_1Click(Sender: TObject);
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
  fmDovidka_10: TfmDovidka_10;

implementation

{$R *.DFM}

procedure TfmDovidka_10.FormCreate(Sender: TObject);
begin
   self.points_all_name:='Все точки';
   load_data;
   fmDataModule.query_dovidka_1.sql.clear;
end;

procedure TfmDovidka_10.load_data;
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

procedure TfmDovidka_10.button_showClick(Sender: TObject);
function get_where_from_checkbox:string;
var
   where_string:string;
   counter,radiobutton_counter:integer;
   temp_object,temp_radiobutton:TObject;

begin
   where_string:='';
   for counter:=1 to 7
   do begin
      // find TCheckBox
      temp_object:=self.FindComponent('CheckBox_'+inttostr(counter));
      if (temp_object<>nil) and (temp_object is TCheckBox)
      then begin
           if TCheckBox(temp_object).checked=true
           then begin
                // учавствует в запросе
                if where_string<>''
                then where_string:=where_string+' OR ';

                // не учавствует в запросе
                for radiobutton_counter:=1 to 3
                do begin
                   temp_radiobutton:=self.FindComponent('RadioButton_'+inttostr(counter)+'_'+inttostr(radiobutton_counter));
                   if (temp_radiobutton<>nil) and (temp_radiobutton is TRadiobutton)
                   then begin
                        if TRadioButton(temp_radiobutton).checked
                        then begin
                             if radiobutton_counter=1
                             then begin
                                  where_string:=where_string+'(COMMODITY.QUANTITY>0 AND COMMODITY.OPERATION_KOD='+inttostr(counter)+')'+chr(13)+chr(10);
                                  end;
                             if radiobutton_counter=2
                             then begin
                                  where_string:=where_string+'(COMMODITY.QUANTITY<0 AND COMMODITY.OPERATION_KOD='+inttostr(counter)+')'+chr(13)+chr(10);
                                  end;
                             if radiobutton_counter=3
                             then begin
                                  where_string:=where_string+'(COMMODITY.QUANTITY<>0 AND COMMODITY.OPERATION_KOD='+inttostr(counter)+')'+chr(13)+chr(10);
                                  end;
                             end
                        else begin
                             // TRadioButton(temp_radiobutton).checked=false;
                             end;
                        end
                   else begin
                        // temp_radiobutton is nil or not found
                        end;
                   end;
                end
           else begin
                // checkbox.checked=false
                end;
           end
      else begin
           // object not found or not TCheckBox
           end;
      end;
   if where_string<>''
   then begin
        where_string:=where_string+' AND ('+chr(13)+chr(10)+where_string+chr(13)+chr(10)+')';
        end;
   result:=where_string;
end;

var
   temp_string:string;
begin
   fmDataModule.load_to_string_comma_determinate_do_from_table_from_field_where_in(fmDataModule.query_temp,temp_string,'POINTS','KOD','NAME',self.get_stringlist_from_checklistbox(self.CheckListBox_points,true,chr(39),chr(39)),'');
   if (self.edit_date_begin.text<>'') and (self.edit_date_end.text<>'')
   and (self.isCheckedCheckListBox(self.checklistbox_points))
   then begin
        if self.checkbox_detail.Checked
        then begin
             fmDataModule.query_dovidka_1.SQL.clear;
             fmDataModule.query_dovidka_1.SQL.add('SELECT');
             fmDataModule.query_dovidka_1.SQL.add('        POINTS.NAME POINTS_NAME,');
             fmDataModule.query_dovidka_1.SQL.add('        WRITER.FAMILIYA,');
             fmDataModule.query_dovidka_1.SQL.add('        COMMODITY.WRITE_DATE,');
             fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.NAME ASSORTMENT_NAME,');
             fmDataModule.query_dovidka_1.SQL.add('        COMMODITY.QUANTITY*(-1) QUANTITY,');
             fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE PRICE,');
             fmDataModule.query_dovidka_1.SQL.add('        COMMODITY.QUANTITY*ASSORTMENT.PRICE*(-1) SUMA,');
             fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE_BUYING PRICE_BUYING,');
             fmDataModule.query_dovidka_1.SQL.add('        COMMODITY.QUANTITY*ASSORTMENT.PRICE_BUYING*(-1) SUMA_BUYING');
             fmDataModule.query_dovidka_1.SQL.add('FROM COMMODITY');
             fmDataModule.query_dovidka_1.SQL.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
             fmDataModule.load_to_string_comma_determinate_do_from_table_from_field_where_in(fmDataModule.query_temp,temp_string,'POINTS','KOD','NAME',self.get_stringlist_from_checklistbox(self.CheckListBox_points,true,chr(39),chr(39)),'');
             fmDataModule.query_dovidka_1.SQL.add('INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD AND POINTS.KOD IN('+temp_string+')');
             fmDataModule.query_dovidka_1.SQL.add('LEFT JOIN PEOPLE WRITER ON WRITER.KOD=COMMODITY.WRITER');
             fmDataModule.query_dovidka_1.SQL.add('WHERE 1=1 ');
             // condition_find
             fmDataModule.query_dovidka_1.SQL.add(get_where_from_checkbox);
             fmDataModule.query_dovidka_1.SQL.add('AND COMMODITY.date_in_out BETWEEN '+chr(39)+self.edit_date_begin.text+chr(39)+' AND '+chr(39)+self.edit_date_end.text+chr(39));
             fmDataModule.query_dovidka_1.SQL.add('ORDER BY POINTS.NAME,COMMODITY.ASSORTMENT_KOD');
             end
        else begin
             fmDataModule.query_dovidka_1.SQL.clear;
             fmDataModule.query_dovidka_1.SQL.add('SELECT');
             fmDataModule.query_dovidka_1.SQL.add('        POINTS.NAME POINTS_NAME,');
             fmDataModule.query_dovidka_1.SQL.add('        WRITER.FAMILIYA,');
             fmDataModule.query_dovidka_1.SQL.add('        COMMODITY.WRITE_DATE,');
             fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.NAME ASSORTMENT_NAME,');
             fmDataModule.query_dovidka_1.SQL.add('        SUM(COMMODITY.QUANTITY) QUANTITY,');
             fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE PRICE,');
             fmDataModule.query_dovidka_1.SQL.add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA,');
             fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE_BUYING PRICE_BUYING,');
             fmDataModule.query_dovidka_1.SQL.add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE_BUYING SUMA_BUYING');
             fmDataModule.query_dovidka_1.SQL.add('FROM COMMODITY');
             fmDataModule.load_to_string_comma_determinate_do_from_table_from_field_where_in(fmDataModule.query_temp,temp_string,'POINTS','KOD','NAME',self.get_stringlist_from_checklistbox(self.CheckListBox_points,true,chr(39),chr(39)),'');
             fmDataModule.query_dovidka_1.SQL.add('INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD AND POINTS.KOD IN ('+temp_string+')');
             fmDataModule.query_dovidka_1.SQL.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
             fmDataModule.query_dovidka_1.SQL.add('LEFT JOIN PEOPLE WRITER ON WRITER.KOD=COMMODITY.WRITER');
             fmDataModule.query_dovidka_1.SQL.add('WHERE 1=1');
             // condition_find
             fmDataModule.query_dovidka_1.SQL.add(get_where_from_checkbox);
             fmDataModule.query_dovidka_1.SQL.add('AND COMMODITY.date_in_out BETWEEN '+chr(39)+self.edit_date_begin.text+chr(39)+' AND '+chr(39)+self.edit_date_end.text+chr(39));
             fmDataModule.query_dovidka_1.SQL.add('GROUP BY');
             fmDataModule.query_dovidka_1.SQL.add('        POINTS.NAME,');
             fmDataModule.query_dovidka_1.SQL.add('        WRITER.FAMILIYA,');
             fmDataModule.query_dovidka_1.SQL.add('        COMMODITY.WRITE_DATE,');
             fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.NAME,');
             fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE,');
             fmDataModule.query_dovidka_1.SQL.add('        ASSORTMENT.PRICE_BUYING');
             fmDataModule.query_dovidka_1.SQL.add('HAVING SUM(COMMODITY.QUANTITY)<>0');
             fmDataModule.query_dovidka_1.SQL.add('ORDER BY');
             fmDataModule.query_dovidka_1.SQL.add('        POINTS.NAME,');
             fmDataModule.query_dovidka_1.SQL.add('        WRITER.FAMILIYA');
             end;
        clipboard.astext:=fmDataModule.query_dovidka_1.sql.text;
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

procedure TfmDovidka_10.reportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='POINTS'
   then ParValue:=get_items_comma_delimeter_from_checklistbox(self.CheckListBox_points,true);
   if ParName='DATE_BEGIN'
   then ParValue:=self.edit_date_begin.text;
   if ParName='DATE_END'
   then ParValue:=self.edit_date_end.text;
end;

function TfmDovidka_10.get_items_comma_delimeter_from_checklistbox(
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

function TfmDovidka_10.get_stringlist_from_checklistbox(
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

function TfmDovidka_10.isCheckedCheckListBox(
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

procedure TfmDovidka_10.button_clearClick(Sender: TObject);
begin
   fmdatamodule.checklistbox_clear(self.CheckListBox_points);
end;

procedure TfmDovidka_10.button_invertClick(Sender: TObject);
begin
   fmdatamodule.checklistbox_invert(self.CheckListBox_points);
end;

procedure TfmDovidka_10.CheckBox_1Click(Sender: TObject);
var
   object_name:string;
   counter:integer;
   finded_object:TObject;
begin
   if (sender is TCheckBox)
   then begin
        object_name:=TCheckbox(sender).Name;
        object_name:='RadioButton_'+copy(object_name,10,length(object_name)-9)+'_3';
        if TCheckBox(sender).Checked=true
        then begin
             finded_object:=self.FindComponent(object_name);
             if (finded_object is TRadioButton)
             then TRadioButton(finded_object).checked:=true;
             end
        else begin
             if (finded_object is TRadioButton)
             then TRadioButton(finded_object).checked:=false;
             end;
        end
   else begin
        // объект не является TCheckBox
        end;
end;

end.
