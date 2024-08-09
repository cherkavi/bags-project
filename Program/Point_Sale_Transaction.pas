unit Point_Sale_Transaction;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxEditor, dxExEdtr, dxEdLib, dxCntner;

type
  TfmPoint_Sale_Transaction = class(TForm)
    edit_seller: TdxEdit;
    edit_points: TdxEdit;
    edit_date: TdxEdit;
    Edit_kod: TdxEdit;
    Edit_name: TdxEdit;
    Edit_price: TdxEdit;
    Edit_suma: TdxEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit_quantity: TdxSpinEdit;
    button_ok: TButton;
    button_cancel: TButton;
    procedure button_cancelClick(Sender: TObject);
    procedure button_okClick(Sender: TObject);
    procedure Edit_quantityKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_quantityChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPoint_Sale_Transaction: TfmPoint_Sale_Transaction;

implementation

{$R *.DFM}

procedure TfmPoint_Sale_Transaction.button_cancelClick(Sender: TObject);
begin
   modalResult:=mrCancel;
end;

procedure TfmPoint_Sale_Transaction.button_okClick(Sender: TObject);
begin
   if self.Edit_quantity.MaxValue>=self.Edit_quantity.IntValue
   then begin
        modalResult:=mrOk;
        end
   else begin
        showmessage('Уменьшите кол-во товара');
        end;
end;

procedure TfmPoint_Sale_Transaction.Edit_quantityKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if self.Edit_quantity.IntValue>self.Edit_quantity.MaxValue
   then self.Edit_quantity.intValue:=trunc(self.edit_quantity.MaxValue);
   try
      self.Edit_suma.text:=format('%.2f',[strtofloat(self.Edit_price.text)*self.Edit_quantity.intValue]);
   except
      self.Edit_suma.text:='';
   end;

end;

procedure TfmPoint_Sale_Transaction.Edit_quantityChange(Sender: TObject);
begin
   if self.Edit_quantity.IntValue>self.Edit_quantity.MaxValue
   then self.Edit_quantity.intValue:=trunc(self.edit_quantity.MaxValue);
   try
      self.Edit_suma.text:=format('%.2f',[strtofloat(self.Edit_price.text)*self.Edit_quantity.intValue]);
   except
      self.Edit_suma.text:='';
   end;

end;

end.
