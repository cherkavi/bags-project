unit Commodity_Transfer_Transaction;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxExEdtr, dxEdLib, dxCntner, dxEditor,datamodule;

type
  TfmCommodity_Transfer_Transaction = class(TForm)
    Label1: TLabel;
    edit_assortment_kod: TEdit;
    edit_name: TEdit;
    Edit_quantity: TdxSpinEdit;
    edit_source: TEdit;
    Label2: TLabel;
    edit_destination: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edit_price: TdxEdit;
    Edit_suma: TdxEdit;
    date_in_out: TdxDateEdit;
    Label8: TLabel;
    button_ok: TButton;
    button_cancel: TButton;
    procedure button_okClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit_quantityChange(Sender: TObject);
    procedure button_cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    commodity_record:datamodule.Tcommodity;
    procedure commodity_record_to_form(commodity:datamodule.TCommodity);
    procedure form_to_commodity_record(var commodity:datamodule.TCommodity);
  end;

var
  fmCommodity_Transfer_Transaction: TfmCommodity_Transfer_Transaction;

implementation

{$R *.DFM}

procedure TfmCommodity_Transfer_Transaction.button_okClick(
  Sender: TObject);
begin
   if self.Edit_quantity.IntValue<=self.Edit_quantity.MaxValue
   then begin
        modalResult:=mrOk
        end
   else begin
        self.Edit_quantity.IntValue:=trunc(self.Edit_quantity.MaxValue);
        end;
end;

procedure TfmCommodity_Transfer_Transaction.commodity_record_to_form(
  commodity: TCommodity);
begin
   self.edit_assortment_kod.text:=commodity.field_assortment_kod;
   self.edit_name.text:=commodity.get_assortment_name(fmDataModule.query_temp);
   self.Edit_quantity.text:=commodity.field_quantity;
   self.edit_price.text:=commodity.get_assortment_price(fmDataModule.query_temp);
end;

procedure TfmCommodity_Transfer_Transaction.form_to_commodity_record(
  var commodity: TCommodity);
begin
   commodity.field_assortment_kod:=self.edit_assortment_kod.text;
   commodity.field_quantity:=self.Edit_quantity.text;
   commodity.field_date_in_out:=self.date_in_out.Text;
   commodity.field_point_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.edit_destination.text+chr(39),'KOD');
   commodity.field_operation_kod:='4';// Перемещение товара
   commodity.field_note:='from POINT=<'+fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.edit_source.text+chr(39),'KOD')+'>';
end;

procedure TfmCommodity_Transfer_Transaction.FormCreate(Sender: TObject);
begin
   self.commodity_record:=dataModule.TCommodity.create();
end;

procedure TfmCommodity_Transfer_Transaction.FormShow(Sender: TObject);
begin
   try
      self.edit_suma.text:=format('%.2f',[self.Edit_quantity.intvalue*strtofloat(self.edit_price.text)]);
   except
      self.edit_suma.text:='';
   end;
end;

procedure TfmCommodity_Transfer_Transaction.Edit_quantityChange(
  Sender: TObject);
begin
   try
      self.edit_suma.text:=format('%.2f',[self.Edit_quantity.intvalue*strtofloat(self.edit_price.text)]);
   except
      self.edit_suma.text:='';
   end;

end;

procedure TfmCommodity_Transfer_Transaction.button_cancelClick(
  Sender: TObject);
begin
   modalResult:=mrCancel;
end;

end.
