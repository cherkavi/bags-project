unit PayDesk_Edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxEditor, dxEdLib, StdCtrls, dxExEdtr,DataModule;

type
  TfmPayDesk_Edit = class(TForm)
    edit_point: TEdit;
    Edit_kod_man: TdxEdit;
    Edit_Date_in_out: TdxEdit;
    combobox_expenses: TComboBox;
    Edit_Amount: TdxCalcEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    button_ok: TButton;
    button_cancel: TButton;
    edit_note: TEdit;
    procedure button_okClick(Sender: TObject);
    procedure button_cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure combobox_expensesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPayDesk_Edit: TfmPayDesk_Edit;

implementation

{$R *.DFM}

procedure TfmPayDesk_Edit.button_okClick(Sender: TObject);
begin
   if (trim(ansiuppercase(self.combobox_expenses.text))<>'ПРОЧЕЕ') and (strtofloat(self.Edit_Amount.text)<0)
   then begin
        showmessage('Не может быть отрицательным');
        end
   else begin
        modalresult:=mrOk;
        end;
end;

procedure TfmPayDesk_Edit.button_cancelClick(Sender: TObject);
begin
   ModalResult:=mrCancel;
end;

procedure TfmPayDesk_Edit.FormCreate(Sender: TObject);
begin
   fmDataModule.load_to_combobox_from_table_from_field(fmDataModule.query_temp,self.combobox_expenses,'EXPENSES','NAME','','KOD');
   self.combobox_expenses.ItemIndex:=1;
end;

procedure TfmPayDesk_Edit.combobox_expensesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if key=13
   then self.Edit_Amount.SetFocus;
end;

end.
