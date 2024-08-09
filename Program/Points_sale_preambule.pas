unit Points_sale_preambule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxExEdtr, dxEdLib, dxCntner, dxEditor, StdCtrls,datamodule,IBQuery, Db,
  Grids, DBGrids, ExtCtrls;

type
  TfmPoints_sale_preambule = class(TForm)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    combobox_points: TComboBox;
    GroupBox1: TGroupBox;
    dbgrid_seller: TDBGrid;
    GroupBox2: TGroupBox;
    dbGrid_sells: TDBGrid;
    Panel2: TPanel;
    Label2: TLabel;
    Edit_Date: TdxDateEdit;
    Button_ok: TButton;
    button_cancel: TButton;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure button_cancelClick(Sender: TObject);
    procedure Button_okClick(Sender: TObject);
    procedure combobox_pointsChange(Sender: TObject);
    procedure Edit_DateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgrid_sellerDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    procedure load_data_to_combobox;
    procedure get_commodity_from_point(points_number:string;query:TIBQuery);
    procedure get_commodity_sell_by_point_by_date(points_number:string;Date_sells:string;query:TIBQuery);
    procedure show_sellers(query:TIBQuery);
    function calculate_sum_from_query_from_field(query:TIBQuery;field_name:string):real;
  end;

var
  fmPoints_sale_preambule: TfmPoints_sale_preambule;

implementation

uses Points_Sale;

{$R *.DFM}

procedure TfmPoints_sale_preambule.FormShow(Sender: TObject);
begin
   load_data_to_combobox;
   self.show_sellers(fmDataModule.query_people);
end;

procedure TfmPoints_sale_preambule.load_data_to_combobox;
begin
     fmDataModule.load_to_combobox_from_table_from_field(fmDataModule.query_temp,self.combobox_points,'POINTS','NAME','KOD>0','NAME');
     self.Edit_Date.date:=date;
end;

procedure TfmPoints_sale_preambule.button_cancelClick(Sender: TObject);
begin
   modalresult:=mrOk;
end;

procedure TfmPoints_sale_preambule.Button_okClick(Sender: TObject);
var
   points_number:string;
   seller_number:string;
   operator_number:string;
   temp_real:real;
   people:dataModule.TPeople;
begin

   if (self.combobox_points.text<>'') and (self.Edit_Date.text<>'') and (self.dbgrid_seller.DataSource.DataSet.FieldByName('KOD').asstring<>'')
   then begin
        // торгова€ точка и дата выбраны
           // загрузка начальных данных
        fmPoints_Sale:=TfmPoints_sale.create(self);
        fmPoints_Sale.edit_point_name.text:=self.combobox_points.text;
        fmPoints_sale.edit_date_in_out.text:=self.Edit_Date.text;
        fmPoints_sale.edit_seller.text:=self.dbgrid_seller.DataSource.DataSet.fieldbyname('KOD').asstring+':  '+self.dbgrid_seller.DataSource.DataSet.fieldbyname('FAMILIYA').asstring+'   '+self.dbgrid_seller.DataSource.DataSet.fieldbyname('IMYA').asstring;

        points_number:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_points.text+chr(39),'KOD');// номер точки
        seller_number:=self.dbgrid_seller.DataSource.DataSet.fieldbyname('KOD').asstring;// продавец
        operator_number:='1';// оператор
        self.get_commodity_from_point(points_number,fmDataModule.Query_transfer_source);
           // загрзука данных в переменные формы fmPoints_sale
        fmPoints_sale.point_kod:=points_number;
        fmPoints_sale.seller_kod:=seller_number;
        fmPoints_sale.operator_kod:=operator_number;
        fmPoints_sale.date_in_out:=self.Edit_Date.text;
        self.access.copy_to(fmPoints_sale.access);
        // подсчет баланса продавца
        people:=dataModule.TPeople.create;
        fmPoints_sale.seller_balance:=people.get_balance(seller_number,self.Edit_date.text,fmDataModule.query_temp);
        freeandnil(people);
        fmPoints_sale.ShowModal;
        // перечитать данные дл€ Grid
        fmDataModule.Transaction_main.active:=false;
        fmDataModule.transaction_main.active:=true;
        self.show_sellers(fmDataModule.query_people);
        self.get_commodity_sell_by_point_by_date(points_number,self.Edit_Date.text,fmDataModule.query_assortment_view);
        freeandnil(fmPoints_sale);
        end
   else begin
        showmessage(' ¬ведите пожалуйста дату и/или ¬ыберите торговую точку и/или ¬ыберите продавца');
        end;
   try
      self.dbgrid_seller.DataSource.DataSet.Locate('KOD',seller_number,[]);
   except
   end;
end;

procedure TfmPoints_sale_preambule.get_commodity_from_point(
  points_number: string; query: TIBQuery);
begin
   query.SQL.clear;
   query.sql.Add('SELECT COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,SUM(COMMODITY.QUANTITY) QUANTITY,ASSORTMENT.PRICE PRICE,SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA');
   query.sql.Add('FROM COMMODITY');
   query.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
   query.sql.Add('WHERE COMMODITY.POINT_KOD='+points_number);
   query.sql.Add('GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRICE');
   query.sql.Add('   HAVING SUM(COMMODITY.QUANTITY)<>0');
   query.open;
end;

procedure TfmPoints_sale_preambule.show_sellers(query: TIBQuery);
begin
   query.sql.clear;
   query.sql.add('SELECT *');
   query.sql.add('FROM PEOPLE');
   query.sql.add('WHERE PEOPLE.POST_KOD=3');
   query.open;
end;

procedure TfmPoints_sale_preambule.get_commodity_sell_by_point_by_date(
  points_number, Date_sells: string; query: TIBQuery);
begin
   query.sql.clear;
   query.sql.add('SELECT ASSORTMENT.KOD,ASSORTMENT.NAME,COMMODITY.QUANTITY*(-1) QUANTITY,ASSORTMENT.PRICE,ASSORTMENT.PRICE*COMMODITY.QUANTITY*(-1) SUMA,PEOPLE.FAMILIYA');
   query.sql.add('FROM COMMODITY');
   query.sql.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD');
   query.sql.add('LEFT JOIN PEOPLE ON PEOPLE.KOD=COMMODITY.MAN_KOD');
   query.sql.add('WHERE COMMODITY.OPERATION_KOD=1');
   query.sql.add('AND COMMODITY.POINT_KOD='+points_number);
   query.sql.add('AND COMMODITY.DATE_IN_OUT='+chr(39)+date_sells+chr(39));
   query.open;
end;

procedure TfmPoints_sale_preambule.combobox_pointsChange(Sender: TObject);
var
   points_number:string;
begin
   if self.Edit_Date.text<>''
   then begin
        points_number:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_points.Text+chr(39),'KOD');
        self.get_commodity_sell_by_point_by_date(points_number,self.Edit_Date.text,fmDataModule.query_assortment_view);
        end;
end;

procedure TfmPoints_sale_preambule.Edit_DateChange(Sender: TObject);
var
   points_number:string;
begin
   if (self.Edit_Date.text<>'') and (self.combobox_points.text<>'')
   then begin
        points_number:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_points.Text+chr(39),'KOD');
        self.get_commodity_sell_by_point_by_date(points_number,self.Edit_Date.text,fmDataModule.query_assortment_view);
        end;
end;

function TfmPoints_sale_preambule.calculate_sum_from_query_from_field(
  query: TIBQuery; field_name: string): real;
var
   return_result:real;
begin
   query.first;return_result:=0;
   while not(query.eof)
   do begin
      try
         return_result:=return_result+query.FieldByName(field_name).AsFloat;
      except
      end;
      query.next;
      end;
   result:=return_result;
end;

procedure TfmPoints_sale_preambule.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
   fmDataModule.query_assortment_view.SQL.clear;
end;

procedure TfmPoints_sale_preambule.dbgrid_sellerDblClick(Sender: TObject);
begin
   self.Button_ok.click;
end;

end.
