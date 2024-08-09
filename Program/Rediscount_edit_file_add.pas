unit Rediscount_edit_file_add;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,datamodule,ibquery;

type
  TfmRediscount_edit_file_add = class(TForm)
    edit_source: TEdit;
    edit_destination: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    button_ok: TButton;
    button_cancel: TButton;
    procedure button_cancelClick(Sender: TObject);
    procedure button_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function is_data_in_assortment_name(value:string;query:TibQuery):boolean;
  end;

var
  fmRediscount_edit_file_add: TfmRediscount_edit_file_add;

implementation

{$R *.DFM}

procedure TfmRediscount_edit_file_add.button_cancelClick(Sender: TObject);
begin
   modalresult:=mrCancel;
end;

procedure TfmRediscount_edit_file_add.button_okClick(Sender: TObject);
begin
   if self.is_data_in_assortment_name(trim(self.edit_destination.text),fmDataModule.query_temp)
   then begin
        self.edit_destination.text:=trim(self.edit_destination.text);
        modalresult:=mrOk;
        end
   else begin
        showmessage('Ќе найдена данна€ позици€ в ассортименте');
        end;
end;

function TfmRediscount_edit_file_add.is_data_in_assortment_name(
  value: string; query: TibQuery): boolean;
var
   return_value:boolean;
begin
   return_value:=false;
   try
      query.sql.clear;
      query.sql.Add('SELECT NAME FROM ASSORTMENT WHERE ASSORTMENT.NAME LIKE '+chr(39)+value+chr(39));
      query.open;
      if query.recordcount>0
      then return_value:=true
      else return_value:=false;
   except
      on e:exception
      do begin
         return_value:=false;
         end;
   end;
   result:=return_value;
end;

end.
