unit Points_Sale_Skip;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Grids, DBGrids, StdCtrls, dxEdLib, dxCntner, dxEditor, dxExEdtr,
  ExtCtrls,clipbrd,dataModule,IBQuery;

type
  TfmPoints_Sale_Skip = class(TForm)
    Panel1: TPanel;
    combobox_points: TComboBox;
    Label1: TLabel;
    Edit_date: TdxDateEdit;
    Label2: TLabel;
    Edit_suma: TdxEdit;
    Label3: TLabel;
    Panel2: TPanel;
    button_skip: TButton;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure Edit_dateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure button_skipClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    procedure show_data(points_number:string;date_sells:string);
    procedure load_data_to_combobox;
    function sale_skip(point_kod,date_sale:string;query:TIBQuery):boolean;
  end;

var
  fmPoints_Sale_Skip: TfmPoints_Sale_Skip;

implementation

{$R *.DFM}

{ TfmPoints_Sale_Skip }

procedure TfmPoints_Sale_Skip.load_data_to_combobox;
begin
   fmDataModule.load_to_combobox_from_table_from_field(fmDAtaModule.query_temp,self.combobox_points,'POINTS','NAME','KOD>0','NAME');
   self.Edit_date.date:=date;
end;

procedure TfmPoints_Sale_Skip.show_data(points_number, date_sells: string);
begin
   fmDataModule.query_points_sale_skip.SQL.clear;
   fmDataModule.query_points_sale_skip.SQL.add('SELECT  COMMODITY.ASSORTMENT_KOD,');
   fmDataModule.query_points_sale_skip.SQL.add('        ASSORTMENT.NAME,');
   fmDataModule.query_points_sale_skip.SQL.add('        SUM(COMMODITY.QUANTITY)*(-1) QUANTITY,');
   fmDataModule.query_points_sale_skip.SQL.add('        ASSORTMENT.PRICE PRICE,');
   fmDataModule.query_points_sale_skip.SQL.add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE*(-1) SUMA');
   fmDataModule.query_points_sale_skip.SQL.add('FROM COMMODITY');
   fmDataModule.query_points_sale_skip.SQL.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
   fmDataModule.query_points_sale_skip.SQL.add('WHERE 1=1');
   fmDataModule.query_points_sale_skip.SQL.add('AND COMMODITY.operation_kod=1');
   fmDataModule.query_points_sale_skip.SQL.add('AND COMMODITY.POINT_KOD='+points_number);
   fmDataModule.query_points_sale_skip.SQL.add('AND COMMODITY.date_in_out ='+chr(39)+date_sells+chr(39));
   fmDataModule.query_points_sale_skip.SQL.add('GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRICE');
   fmDataModule.query_points_sale_skip.SQL.add('HAVING SUM(COMMODITY.QUANTITY)<>0');
   fmDataModule.query_points_sale_skip.SQL.add('ORDER BY COMMODITY.ASSORTMENT_KOD');
   //clipboard.astext:=fmDataModule.query_points_sale_skip.sql.text;
   fmDataModule.query_points_sale_skip.open;
   self.edit_suma.text:=format('%.2f',[fmDataModule.calculate_sum_from_query_from_field(fmDataModule.query_points_sale_skip,'SUMA')]);
end;

procedure TfmPoints_Sale_Skip.Edit_dateChange(Sender: TObject);
var
   point_kod:string;
begin
   if (self.combobox_points.text<>'') and (self.edit_date.text<>'')
   then begin
        point_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_points.text+chr(39),'KOD');
        self.show_data(point_kod,self.edit_date.text);
        end;
end;

procedure TfmPoints_Sale_Skip.FormShow(Sender: TObject);
begin
   self.load_data_to_combobox;
end;

procedure TfmPoints_Sale_Skip.button_skipClick(Sender: TObject);
var
   point_kod:string;
begin
   if (self.combobox_points.text<>'') and (self.edit_date.text<>'')
   then begin
        point_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_points.text+chr(39),'KOD');
        if sale_skip(point_kod,self.Edit_date.text,fmDataModule.query_temp)=true
        then begin
             showmessage('Продажи удалены');
             end
        else begin
             showmessage('Ошибка удаления продаж');
             end;
        self.show_data(point_kod,self.edit_date.text);
        end;
end;

function TfmPoints_Sale_Skip.sale_skip(point_kod, date_sale: string;
  query: TIBQuery): boolean;
var
   commodity:dataModule.TCommodity;
   delete_list:Tstringlist;
   counter:integer;
   return_result:boolean;
   temp_string:string;
begin
   return_result:=false;
   commodity:=dataModule.TCommodity.create;
   delete_list:=Tstringlist.create;
   // взять из базы все коды для удаления
   query.sql.clear;
   query.sql.add('SELECT  COMMODITY.KOD KOD');
   query.sql.add('FROM COMMODITY');
   query.sql.add('WHERE 1=1');
   query.sql.add('AND COMMODITY.OPERATION_KOD=1');
   query.sql.add('AND COMMODITY.POINT_KOD='+point_kod);
   query.sql.add('AND COMMODITY.DATE_IN_OUT ='+chr(39)+date_sale+chr(39));
   query.sql.add('ORDER BY COMMODITY.KOD');
   query.open;
   if query.Recordcount>0
   then begin
        query.first;
        while not(query.eof)
        do begin
           delete_list.Add(query.fieldbyname('KOD').asstring);
           query.next;
           end;
        // удалить коды из базы
        for counter:=0 to delete_list.Count-1
        do begin
           temp_string:=commodity.delete_by_kod(delete_list.Strings[counter],fmDataModule.query_temp);
           if temp_string<>''
           then return_result:=true;
           end;
        return_result:=not(return_result);
        end
   else begin
        return_result:=true;
        end;
   freeAndNil(commodity);
   freeAndNil(delete_list);
   result:=return_result;
end;

procedure TfmPoints_Sale_Skip.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
end;

end.
