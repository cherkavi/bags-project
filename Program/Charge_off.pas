unit Charge_off;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxEditor, dxExEdtr, dxEdLib, StdCtrls, ExtCtrls, Grids, DBGrids,
  dataModule, Db,IBquery;

type
  TfmCharge_Off = class(TForm)
    GroupBox1: TGroupBox;
    combobox_points: TComboBox;
    Label1: TLabel;
    edit_date: TdxDateEdit;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    DBGrid_commodity: TDBGrid;
    Splitter1: TSplitter;
    GroupBox3: TGroupBox;
    Panel1: TPanel;
    DBGrid_charge_off: TDBGrid;
    DataSource_commodity: TDataSource;
    DataSource_charge_off: TDataSource;
    button_charge_off: TButton;
    Button_restore: TButton;
    edit_commodity_filter_name: TEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure combobox_pointsChange(Sender: TObject);
    procedure button_charge_offClick(Sender: TObject);
    procedure Button_restoreClick(Sender: TObject);
    procedure edit_commodity_filter_nameKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    point_kod:string;
    procedure load_startup_data;
    procedure show_commodity(query:TIBQuery;point_kod,date_commodity:string;condition_string:string='');
    procedure show_charge_off(query:TIBQuery;point_kod,date_commodity:string);
    procedure set_filter(Edit_commodity_filter:TEdit;condition_string:string);
  end;

var
  fmCharge_Off: TfmCharge_Off;

implementation

uses Charge_off_Edit;

{$R *.DFM}

{ TfmCharge_Off }

procedure TfmCharge_Off.load_startup_data;
begin
   fmDataModule.load_to_combobox_from_table_from_field(fmDataModule.query_temp,self.combobox_points,'POINTS','NAME','KOD>0','NAME');
   fmDataModule.Query_transfer_source.SQL.clear;
   fmDataModule.Query_transfer_destination.sql.clear;
   self.edit_date.date:=Date;
end;

procedure TfmCharge_Off.show_charge_off(query: TIBQuery; point_kod,
  date_commodity: string);
begin
   query.sql.clear;
   query.sql.add('SELECT  COMMODITY.ASSORTMENT_KOD,');
   query.sql.add('        ASSORTMENT.NAME,');
   query.sql.add('        COMMODITY.QUANTITY*(-1) QUANTITY,');
   query.sql.add('        ASSORTMENT.PRICE PRICE,');
   query.sql.add('        COMMODITY.QUANTITY*ASSORTMENT.PRICE*(-1) SUMA,');
   query.sql.add('        COMMODITY.KOD');
   query.sql.add('FROM COMMODITY');
   query.sql.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
   query.sql.add('WHERE  1=1');
   query.sql.add('AND COMMODITY.POINT_KOD='+point_kod);
   query.sql.add('AND COMMODITY.DATE_IN_OUT ='+chr(39)+date_commodity+chr(39));
   query.sql.add('AND COMMODITY.OPERATION_KOD=3');
   query.sql.add('ORDER BY COMMODITY.ASSORTMENT_KOD');
   query.open;
end;

procedure TfmCharge_Off.show_commodity(query: TIBQuery; point_kod,
  date_commodity: string;condition_string:string='');
var
   control_sql_values:dataModule.Tcontrol_sql_values;
begin
   query.sql.clear;
   query.sql.add('SELECT  COMMODITY.ASSORTMENT_KOD,');
   query.sql.add('        ASSORTMENT.NAME,');
   query.sql.add('        SUM(COMMODITY.QUANTITY) QUANTITY,');
   query.sql.add('        ASSORTMENT.PRICE PRICE,');
   query.sql.add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA');
   query.sql.add('FROM COMMODITY');
   query.sql.add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
   query.sql.add('WHERE  1=1');
   query.sql.add('AND COMMODITY.POINT_KOD='+point_kod);
   query.sql.add('AND COMMODITY.date_in_out <='+chr(39)+date_commodity+chr(39));
   if trim(condition_string)<>''
   then begin
        control_sql_values:=dataModule.Tcontrol_sql_values.create;
        query.sql.add('AND ASSORTMENT.NAME LIKE '+control_sql_values.check(chr(39)+'%'+condition_string+'%'+chr(39)));
        end;
   query.sql.add('GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRICE');
   query.sql.add('HAVING SUM(COMMODITY.QUANTITY)<>0');
   query.sql.add('ORDER BY COMMODITY.ASSORTMENT_KOD');
   query.open;
end;

procedure TfmCharge_Off.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
   self.load_startup_data;
end;

procedure TfmCharge_Off.combobox_pointsChange(Sender: TObject);
begin
   if (self.edit_date.text<>'') and (self.combobox_points.text<>'')
   then begin
        self.point_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_points.text+chr(39),'KOD');
        self.show_commodity(fmDataModule.Query_transfer_source,self.point_kod,self.edit_date.text);
        self.show_charge_off(fmDataModule.Query_transfer_destination,self.point_kod,self.edit_date.text);
        end;
end;

procedure TfmCharge_Off.button_charge_offClick(Sender: TObject);
var
   temp_string:string;
begin
   if dbGrid_commodity.DataSource.dataset.fieldbyname('ASSORTMENT_KOD').asstring<>''
   then begin
        fmCharge_off_Edit:=TfmCharge_off_Edit.create(self);
        fmCharge_off_Edit.Caption:='Списывание товара';
        fmCharge_off_Edit.button_ok.caption:='Списать';
        fmCharge_off_Edit.Edit_point.text:=self.combobox_points.text;
        fmCharge_off_Edit.Edit_date.text:=self.edit_date.text;
        fmCharge_off_Edit.Edit_name.text:=self.DBGrid_commodity.DataSource.DataSet.fieldbyname('NAME').asstring;
        fmCharge_off_Edit.Edit_price.text:=format('%.2f',[self.DBGrid_commodity.DataSource.DataSet.fieldbyname('PRICE').asfloat]);
        fmCharge_off_Edit.Edit_suma.text:=format('%.2f',[self.DBGrid_commodity.DataSource.DataSet.fieldbyname('PRICE').asfloat]);
        fmCharge_off_Edit.Edit_quantity.MaxValue:=strtoint(self.DBGrid_commodity.DataSource.DataSet.fieldbyname('QUANTITY').asstring);
        fmCharge_off_Edit.Edit_quantity.MinValue:=1;
        if fmCharge_off_Edit.Edit_quantity.MaxValue=1
        then fmCharge_off_Edit.Edit_quantity.ReadOnly:=true;
        fmCharge_off_edit.commodity_record.field_assortment_kod:=self.DBGrid_commodity.DataSource.DataSet.fieldbyname('ASSORTMENT_KOD').asstring;
        fmCharge_off_edit.commodity_record.field_date_in_out:=self.edit_date.text;
        fmCharge_off_edit.commodity_record.field_man_kod:='';
        fmCharge_off_edit.commodity_record.field_operation_kod:='3';
        fmCharge_off_edit.commodity_record.field_point_kod:=fmDataModule.get_name_by_id(fmDataModule.Query_temp,'POINTS','NAME',chr(39)+self.combobox_points.text+chr(39),'KOD');
        fmCharge_off_edit.commodity_record.field_note:='CHARGE OFF FROM<'+fmCharge_off_edit.commodity_record.field_operation_kod+'>';
        fmCharge_off_edit.commodity_record.field_quantity:='1';
        fmCharge_off_edit.commodity_record.field_writer:='1';// Номер пользователя
        fmCharge_off_edit.commodity_record.field_write_date:=datetimetostr(now);
        if fmCharge_off_Edit.showmodal=mrOk
        then begin
             fmCharge_off_edit.commodity_record.field_quantity:='-'+fmCharge_off_edit.commodity_record.field_quantity;
             fmCharge_off_edit.commodity_record.field_write_date:=datetimetostr(now);
             temp_string:=fmCharge_off_edit.commodity_record.save(fmDataModule.query_temp);
             if temp_string<>''
             then begin
                  showmessage('Ошибка списывания товара'+chr(13)+chr(10)+temp_string);
                  end
             else begin
                  self.show_commodity(fmDataModule.Query_transfer_source,self.point_kod,self.edit_date.Text);
                  self.show_charge_off(fmDataModule.Query_transfer_destination,self.point_kod,self.edit_date.Text);
                  end;
             end
        else begin
             // пользователь отказался от изменений
             end;
        freeandnil(fmCharge_off_Edit);
        end;
end;

procedure TfmCharge_Off.Button_restoreClick(Sender: TObject);
var
   commodity:dataModule.TCommodity;
begin
   if DBGrid_charge_off.DataSource.dataset.fieldbyname('KOD').asstring<>''
   then begin
        commodity:=dataModule.TCommodity.create;
        commodity.delete_by_kod(DBGrid_charge_off.DataSource.dataset.fieldbyname('KOD').asstring,fmDataModule.Query_temp);
        freeAndNil(commodity);
        self.show_commodity(fmDataModule.Query_transfer_source,self.point_kod,self.edit_date.Text);
        self.show_charge_off(fmDataModule.Query_transfer_destination,self.point_kod,self.edit_date.Text);
        end;
end;

procedure TfmCharge_Off.edit_commodity_filter_nameKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   set_filter(self.edit_commodity_filter_name,self.edit_commodity_filter_name.text);
end;

procedure TfmCharge_Off.set_filter(Edit_commodity_filter: TEdit;
  condition_string: string);
var
   color_set_filter,color_unset_filter:TColor;
begin
   color_set_filter:=clRed;
   color_unset_filter:=clWindow;
   if trim(condition_string)=''
   then begin
        // отмена фильтра
        self.show_commodity(fmDataModule.Query_transfer_source,self.point_kod,self.edit_date.Text);
        edit_commodity_filter.color:=color_unset_filter;
        end
   else begin
        // установка фильтра
        self.show_commodity(fmDataModule.Query_transfer_source,self.point_kod,self.edit_date.Text,condition_string);
        edit_commodity_filter.color:=color_set_filter;
        end;
end;

end.
