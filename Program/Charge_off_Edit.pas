unit Charge_off_Edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,dataModule,
  StdCtrls, dxEditor, dxExEdtr, dxEdLib, dxCntner;

type
  TfmCharge_Off_Edit = class(TForm)
    Edit_point: TdxEdit;
    Label1: TLabel;
    Edit_date: TdxEdit;
    Edit_assortment_kod: TdxEdit;
    Edit_name: TdxEdit;
    Edit_quantity: TdxSpinEdit;
    Edit_price: TdxEdit;
    Edit_suma: TdxEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    button_ok: TButton;
    button_cancel: TButton;
    procedure Edit_quantityChange(Sender: TObject);
    procedure button_cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure button_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    commodity_record:dataModule.Tcommodity;
    procedure commodity_to_form(commodity:dataModule.TCommodity);
    procedure form_to_commodity(var commodity:DataModule.TCommodity);
  end;

var
  fmCharge_Off_Edit: TfmCharge_Off_Edit;

implementation

{$R *.DFM}

procedure TfmCharge_Off_Edit.commodity_to_form(commodity: TCommodity);
begin
   self.Edit_assortment_kod.text:=commodity.field_assortment_kod;
   self.Edit_quantity.text:=commodity.field_quantity;
end;

procedure TfmCharge_Off_Edit.Edit_quantityChange(Sender: TObject);
begin
   try
      self.edit_suma.text:=format('%.2f',[strtofloat(self.Edit_price.text)*Edit_quantity.intvalue]);
   except
      self.Edit_suma.text:='';
   end;
end;

procedure TfmCharge_Off_Edit.form_to_commodity(var commodity: TCommodity);
begin
   commodity.field_assortment_kod:=self.Edit_assortment_kod.Text;
   commodity.field_quantity:=self.Edit_quantity.Text;
end;

procedure TfmCharge_Off_Edit.button_cancelClick(Sender: TObject);
begin
   modalResult:=mrCancel;
end;

procedure TfmCharge_Off_Edit.FormCreate(Sender: TObject);
begin
   self.commodity_record:=dataModule.TCommodity.create;
   self.access:=dataModule.TAccess.create;
end;

procedure TfmCharge_Off_Edit.FormShow(Sender: TObject);
begin
   self.commodity_to_form(self.commodity_record);
end;

procedure TfmCharge_Off_Edit.button_okClick(Sender: TObject);
begin
   if self.Edit_quantity.MaxValue>=Self.Edit_quantity.IntValue
   then begin
        self.form_to_commodity(self.commodity_record);
        modalResult:=mrOk;
        end
   else begin
        Self.Edit_quantity.IntValue:=trunc(self.Edit_quantity.MaxValue);
        showmessage('Вы превысили максимальное значение для данного товара');
        end;
end;

end.
