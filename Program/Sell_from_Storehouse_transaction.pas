unit Sell_from_Storehouse_transaction;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxEdLib, dxCntner, dxEditor, dxExEdtr;

type
  TfmSell_from_Storehouse_transaction = class(TForm)
    edit_name: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    button_ok: TButton;
    button_cancel: TButton;
    Edit_quantity_current: TdxSpinEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit_price: TdxEdit;
    Edit_price_buying: TdxEdit;
    Edit_price_current: TdxEdit;
    Edit_summa_price: TdxEdit;
    Edit_summa_buying: TdxEdit;
    Edit_summa_current: TdxEdit;
    Edit_price_balance: TdxEdit;
    Edit_price_buying_balance: TdxEdit;
    procedure button_okClick(Sender: TObject);
    procedure button_cancelClick(Sender: TObject);
    procedure Edit_quantity_currentChange(Sender: TObject);
    procedure Edit_price_currentKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_summa_currentKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure set_values;
    function is_float(s:string):boolean;
  end;

var
  fmSell_from_Storehouse_transaction: TfmSell_from_Storehouse_transaction;

implementation

{$R *.DFM}

procedure TfmSell_from_Storehouse_transaction.button_okClick(
  Sender: TObject);
begin
   try
      if (self.Edit_quantity_current.Value>self.Edit_quantity_current.MaxValue)
      or (self.Edit_quantity_current.Value<self.Edit_quantity_current.MinValue)
      then begin
           self.Edit_quantity_current.setfocus;
           raise Exception.create('Введите корректное значение для поля Количество')
           end;
      modalresult:=mrOk;
   except
      on e:exception
      do begin
         showmessage(e.message);
         end;
   end;
end;

procedure TfmSell_from_Storehouse_transaction.button_cancelClick(
  Sender: TObject);
begin
   modalResult:=mrCancel;
end;

procedure TfmSell_from_Storehouse_transaction.set_values;
begin
   try
      if self.Edit_quantity_current.IntValue>0
      then begin
           self.edit_summa_price.text:=format('%.2f',[self.Edit_quantity_current.IntValue*strtofloat(self.Edit_price.text)]);
           self.Edit_summa_buying.text:=format('%.2f',[self.Edit_quantity_current.IntValue*strtofloat(self.Edit_price_buying.text)]);

           self.Edit_price_balance.text:=format('%.2f',[strtofloat(self.Edit_summa_current.text)-strtofloat(self.Edit_price.text)]);
           self.Edit_price_buying_balance.text:=format('%.2f',[strtofloat(self.Edit_summa_current.text)-strtofloat(self.Edit_price_buying.text)]);
           end
      else begin
           self.edit_summa_price.text:='';
           self.Edit_summa_buying.text:='';

           self.Edit_price_balance.text:='';
           self.Edit_price_buying_balance.text:='';
           end;
   except
      self.edit_summa_price.text:='';
      self.Edit_summa_buying.text:='';

      self.Edit_price_balance.text:='';
      self.Edit_price_buying_balance.text:='';
   end;
end;

procedure TfmSell_from_Storehouse_transaction.Edit_quantity_currentChange(
  Sender: TObject);
begin
   if  ((self.Edit_price_current.text='') or (not(self.is_float(self.Edit_price_current.text))))
   and ((self.Edit_summa_current.text='') or (not(self.is_float(self.Edit_summa_current.text))))
   then begin

        end
   else begin
        if (self.Edit_price_current.text<>'') and (is_float(self.Edit_price_current.text))
        then begin
             self.Edit_summa_current.text:=format('%.2f',[strtofloat(Self.edit_price_current.text)*self.edit_quantity_current.intValue]);
             end
        else begin
             self.Edit_price_current.text:=format('%.2f',[strtofloat(Self.edit_summa_current.text)/self.edit_quantity_current.intValue]);
             end;
        end;
end;

function TfmSell_from_Storehouse_transaction.is_float(s: string): boolean;
begin
   try
      strtofloat(s);
      result:=true;
   except
      result:=false;
   end;
end;

procedure TfmSell_from_Storehouse_transaction.Edit_price_currentKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   try
      if (self.Edit_quantity_current.IntValue<>0)
      then begin
           self.Edit_summa_current.text:=format('%.2f',[strtofloat(Self.edit_price_current.text)*self.edit_quantity_current.intValue]);
           end;
   except
      self.Edit_summa_current.text:='';
   end;

end;

procedure TfmSell_from_Storehouse_transaction.Edit_summa_currentKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   try
      if (self.Edit_quantity_current.IntValue<>0)
      then begin
           self.Edit_price_current.text:=format('%.2f',[strtofloat(Self.edit_summa_current.text)/self.edit_quantity_current.intValue]);
           end;
   except
      self.Edit_price_current.text:=format('%.2f',[strtofloat(Self.Edit_summa_price.text)/self.edit_quantity_current.intValue]);
   end;

end;

end.
