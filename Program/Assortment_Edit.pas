unit Assortment_Edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib,datamodule;

type
  TfmAssortment_Edit = class(TForm)
    edit_name: TEdit;
    Edit_note: TEdit;
    edit_price: TdxCalcEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    button_ok: TButton;
    Button_cancel: TButton;
    edit_price_buying: TdxCalcEdit;
    Label1: TLabel;
    button_generator: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure button_okClick(Sender: TObject);
    procedure Button_cancelClick(Sender: TObject);
    procedure button_generatorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    assortment_record:DataModule.Tassortment;
    flag_edit:boolean;
    procedure assortment_to_form(data:datamodule.Tassortment);
    procedure form_to_assortment(var data:datamodule.TAssortment);
  end;

var
  fmAssortment_Edit: TfmAssortment_Edit;

implementation

{$R *.DFM}

procedure TfmAssortment_Edit.assortment_to_form(data: datamodule.Tassortment);
begin
   self.edit_name.text:=data.field_name;
   self.edit_note.text:=data.field_note;
   self.edit_price.text:=data.field_price;
   self.edit_price_buying.text:=data.field_price_buying;
end;

procedure TfmAssortment_Edit.FormCreate(Sender: TObject);
begin
   self.assortment_record:=datamodule.TASSORTMENT.Create;
   self.access:=dataModule.TAccess.create;
   self.flag_edit:=false;
end;

procedure TfmAssortment_Edit.FormShow(Sender: TObject);
begin
   if self.assortment_record.field_kod<>''
   then begin
        self.assortment_to_form(self.assortment_record);
        end;
end;

procedure TfmAssortment_Edit.button_okClick(Sender: TObject);
begin
   if length(trim(self.edit_name.text))<3
   then begin
        showmessage('Введите корректное значение для поля Наименование');
        end
   else begin
        self.form_to_assortment(self.assortment_record);
        if (self.assortment_record.check_length<>'')
        then begin
             showmessage('Уменьшите пожалуйста длинну поля "'+self.assortment_record.check_length+'"')
             end
        else begin
             if self.flag_edit
             then begin
                  modalresult:=mrOk;
                  end
             else begin
                  if self.assortment_record.isUniqueName(fmDataModule.query_temp)
                  then begin
                       modalresult:=mrOk;
                       end
                  else begin
                       showmessage('Введите пожалуйста другое имя, данное имя уже существует');
                       end;
                  end;
             end;
        end;
end;

procedure TfmAssortment_Edit.form_to_assortment(var data: DataModule.TAssortment);
begin
   data.field_name:=self.edit_name.text;
   data.field_note:=self.edit_note.text;
   data.field_price:=self.edit_price.text;
   data.field_price_buying:=self.edit_price_buying.text;
end;

procedure TfmAssortment_Edit.Button_cancelClick(Sender: TObject);
begin
   modalresult:=mrCancel;
end;

procedure TfmAssortment_Edit.button_generatorClick(Sender: TObject);
var
   temp_value:integer;
begin
   temp_value:=0;
   fmdataModule.get_max_id(fmDataModule.query_temp,'ASSORTMENT','NAME',temp_value);
   if(temp_value>=0)
   then begin
        self.edit_name.text:=inttostr(temp_value+1);
        self.edit_price.SetFocus;
        end;
end;

end.
