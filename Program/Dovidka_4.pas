unit Dovidka_4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, FR_Class, FR_DSet,
  FR_DBSet,dataModule,IBQuery;

type
  TfmDovidka_4 = class(TForm)
    edit_date_begin: TdxDateEdit;
    Label1: TLabel;
    button_show: TButton;
    frDBDataSet1: TfrDBDataSet;
    Report: TfrReport;
    Edit_Date_end: TdxDateEdit;
    Label2: TLabel;
    checkbox_date_begin: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure ReportGetValue(const ParName: String;
      var ParValue: Variant);
    procedure button_showClick(Sender: TObject);
    procedure checkbox_date_beginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function show_data(query:TIBQuery;date_begin,date_end:string):boolean;overload;
    function show_data(query:TIBQuery;date_end:string):boolean;overload;
  end;

var
  fmDovidka_4: TfmDovidka_4;

implementation

{$R *.DFM}

procedure TfmDovidka_4.FormShow(Sender: TObject);
begin
   self.edit_date_begin.date:=date;
   self.edit_date_end.date:=date
end;

procedure TfmDovidka_4.ReportGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if parName='REPORT_DATE'
   then begin
        if self.checkbox_date_begin.Checked
        then begin
             parValue:=' на дату '+self.edit_date_end.text;
             end
        else begin
             parValue:=' за период c '+self.edit_date_begin.text+' по '+self.edit_date_end.text;
             end;
        end;
end;

procedure TfmDovidka_4.button_showClick(Sender: TObject);
begin
   if  (self.edit_date_begin.date<=self.edit_date_end.date)
   and (self.edit_date_begin.text<>'')
   and (self.edit_date_end.text<>'')
   then begin
        if self.checkbox_date_begin.Checked
        then begin
             if self.show_data(fmDataModule.query_dovidka_1,edit_date_end.text)
             then begin
                  report.ShowReport;
                  end
             else begin
                  showmessage('Нет данных для отображения ');
                  end;
             end
        else begin
             if self.show_data(fmDataModule.query_dovidka_1,edit_date_begin.text,edit_date_end.text)
             then begin
                  report.ShowReport;
                  end
             else begin
                  showmessage('Нет данных для отображения ');
                  end;
             end;
        end;
end;

function TfmDovidka_4.show_data(query:TIBQuery;date_begin,date_end: string): boolean;
begin
   query.SQL.clear;
   query.SQL.Add('SELECT MONEY.DATE_IN_OUT,');
   query.SQL.Add('       POINTS.NAME POINTS_NAME,');
   query.SQL.Add('       EXPENSES.NAME EXPENSES_NAME,');
   query.SQL.Add('       SELLER.FAMILIYA,');
   query.SQL.Add('       MONEY.AMOUNT*EXPENSES.SIGN AMOUNT,');
   query.SQL.Add('       MONEY.NOTE NOTE');
   query.SQL.Add('FROM MONEY');
   query.SQL.Add('LEFT JOIN POINTS ON POINTS.KOD=MONEY.KOD_POINT');
   query.SQL.Add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
   query.SQL.Add('LEFT JOIN PEOPLE SELLER ON SELLER.KOD=MONEY.KOD_MAN');
   query.SQL.Add('WHERE MONEY.DATE_IN_OUT BETWEEN '+chr(39)+date_begin+chr(39)+' AND '+chr(39)+date_end+chr(39));
   query.SQL.Add('AND MONEY.KOD_EXPENSES IN (1,2,4,5,6,8,10,12)');
   query.SQL.Add('ORDER BY DATE_IN_OUT,POINTS.NAME, EXPENSES.NAME,SELLER.FAMILIYA');
   query.Open;
   if query.recordcount>0
   then result:=true
   else result:=false;
end;

procedure TfmDovidka_4.checkbox_date_beginClick(Sender: TObject);
begin
    if self.checkbox_date_begin.Checked
    then begin
         self.edit_date_begin.Visible:=false;
         end
    else begin
         self.edit_date_begin.visible:=true;
         end;
end;

function TfmDovidka_4.show_data(query: TIBQuery;
                                date_end: string): boolean;
begin
   query.SQL.clear;
   query.SQL.Add('SELECT MONEY.DATE_IN_OUT,');
   query.SQL.Add('       POINTS.NAME POINTS_NAME,');
   query.SQL.Add('       EXPENSES.NAME EXPENSES_NAME,');
   query.SQL.Add('       SELLER.FAMILIYA,');
   query.SQL.Add('       MONEY.AMOUNT*EXPENSES.SIGN AMOUNT,');
   query.SQL.Add('       MONEY.NOTE NOTE');
   query.SQL.Add('FROM MONEY');
   query.SQL.Add('LEFT JOIN POINTS ON POINTS.KOD=MONEY.KOD_POINT');
   query.SQL.Add('INNER JOIN EXPENSES ON EXPENSES.KOD=MONEY.KOD_EXPENSES');
   query.SQL.Add('LEFT JOIN PEOPLE SELLER ON SELLER.KOD=MONEY.KOD_MAN');
   query.SQL.Add('WHERE MONEY.DATE_IN_OUT <='+chr(39)+date_end+chr(39));
   query.SQL.Add('AND MONEY.KOD_EXPENSES IN (1,2,4,5,6,8,10,12)');
   query.SQL.Add('ORDER BY DATE_IN_OUT,POINTS.NAME, EXPENSES.NAME,SELLER.FAMILIYA');
   query.Open;
   if query.recordcount>0
   then result:=true
   else result:=false;

end;

end.
