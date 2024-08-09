unit Commodity_to_main_transaction;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib;

type
  TfmCommodity_to_main_transaction = class(TForm)
    edit_kod: TEdit;
    edit_name: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edit_suma: TEdit;
    Edit_quantity: TdxSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    button_ok: TButton;
    button_cancel: TButton;
    Edit_date: TdxDateEdit;
    Label6: TLabel;
    Edit_price: TEdit;
    Label7: TLabel;
    procedure button_okClick(Sender: TObject);
    procedure button_cancelClick(Sender: TObject);
    procedure Edit_quantityChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCommodity_to_main_transaction: TfmCommodity_to_main_transaction;

implementation

{$R *.DFM}

procedure TfmCommodity_to_main_transaction.button_okClick(Sender: TObject);
begin
   modalresult:=mrOk;
end;

procedure TfmCommodity_to_main_transaction.button_cancelClick(
  Sender: TObject);
begin
   modalresult:=mrCancel;
end;

procedure TfmCommodity_to_main_transaction.Edit_quantityChange(
  Sender: TObject);
begin
try
   self.edit_suma.text:=format('%.2f',[strtofloat(self.Edit_quantity.text)*strtofloat(self.Edit_price.text)]);
except
   self.edit_suma.text:='';
end;
end;

procedure TfmCommodity_to_main_transaction.FormShow(Sender: TObject);
begin
try
   self.Edit_quantity.MaxValue:=1000000;
   self.Edit_quantity.MinValue:=1;
   self.edit_suma.text:=format('%.2f',[strtofloat(self.Edit_quantity.text)*strtofloat(self.Edit_price.text)]);
except
   self.edit_suma.text:='';
end;

end;

end.
