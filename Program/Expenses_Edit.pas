unit Expenses_Edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,dataModule;

type
  TfmExpenses_Edit = class(TForm)
    edit_kod: TEdit;
    Label1: TLabel;
    Edit_name: TEdit;
    Label2: TLabel;
    button_ok: TButton;
    button_cancel: TButton;
    radiobutton_positive: TRadioButton;
    RadioButton_negative: TRadioButton;
    procedure button_okClick(Sender: TObject);
    procedure button_cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    expenses_record:dataModule.TExpenses;
    procedure expenses_to_form(expenses:dataModule.TExpenses);
    procedure form_to_expenses(var expenses:dataModule.TExpenses);
  end;

var
  fmExpenses_Edit: TfmExpenses_Edit;

implementation

{$R *.DFM}

procedure TfmExpenses_Edit.button_okClick(Sender: TObject);
begin
if trim(edit_name.text)<>''
then begin
     self.form_to_expenses(self.expenses_record);
     if self.expenses_record.check_length<>''
     then showmessage('Необходимо уменьшить размер поля '+self.expenses_record.check_length)
     else modalresult:=mrOk;
     end
else begin
     showmessage('Введите название статьи расхода-дохода');
     end;
end;

procedure TfmExpenses_Edit.button_cancelClick(Sender: TObject);
begin
   modalResult:=mrCancel;
end;

procedure TfmExpenses_Edit.expenses_to_form(expenses: TExpenses);
begin
   self.edit_kod.text:=expenses.field_kod;
   self.Edit_name.text:=expenses.field_name;
   if expenses.field_sign='-1'
   then self.RadioButton_negative.Checked:=true
   else self.RadioButton_positive.Checked:=true;
end;

procedure TfmExpenses_Edit.form_to_expenses(var expenses: TExpenses);
begin
   expenses.field_name:=self.Edit_name.Text;
   if self.radiobutton_positive.checked
   then expenses.field_sign:='1'
   else expenses.field_sign:='-1';
end;

procedure TfmExpenses_Edit.FormCreate(Sender: TObject);
begin
   self.expenses_record:=datamodule.TExpenses.create;
end;

procedure TfmExpenses_Edit.FormShow(Sender: TObject);
begin
   self.expenses_to_form(self.expenses_record);
end;

end.
