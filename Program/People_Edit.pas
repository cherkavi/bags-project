unit People_Edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxEditor, dxExEdtr, dxEdLib, StdCtrls,datamodule;

type
  TfmPeople_edit = class(TForm)
    ComboBox_post: TComboBox;
    edit_familiya: TEdit;
    Edit_passport: TEdit;
    Edit_otchestvo: TEdit;
    Edit_imya: TEdit;
    Edit_ident_kod: TEdit;
    Date_begin: TdxDateEdit;
    button_ok: TButton;
    Button_cancel: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edit_kod: TEdit;
    edit_phone: TEdit;
    Label9: TLabel;
    edit_home: TEdit;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button_cancelClick(Sender: TObject);
    procedure button_okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    people_record:datamodule.tpeople;
    procedure people_record_to_form(people:datamodule.tpeople);
    procedure form_to_people_record(people:datamodule.tpeople);
  end;

var
  fmPeople_edit: TfmPeople_edit;

implementation

{$R *.DFM}

procedure TfmPeople_edit.FormCreate(Sender: TObject);
begin
   fmdatamodule.load_to_combobox_from_table_from_field(fmdatamodule.query_temp,self.ComboBox_post,'POSTS','NAME');
   people_record:=datamodule.TPeople.create;
end;

procedure TfmPeople_edit.form_to_people_record(people: tpeople);
var
   temp_string:string;
begin
   people.field_familiya:=self.edit_familiya.text;
   people.field_imya:=self.Edit_imya.text;
   people.field_otchestvo:=self.Edit_otchestvo.text;
   people.field_date_begin:=self.date_begin.Text;
   people.field_passport:=self.Edit_passport.text;
   people.field_ident_kod:=self.Edit_ident_kod.text;
   people.field_phone:=self.edit_phone.Text;
   people.field_home:=self.edit_home.text;
   if self.ComboBox_post.text<>''
   then begin
        people.field_post_kod:=fmdatamodule.get_name_by_id(fmdatamodule.query_temp,'POSTS','NAME',chr(39)+self.combobox_post.text+chr(39),'KOD');
        end;
end;

procedure TfmPeople_edit.people_record_to_form(people: tpeople);
var
   post_name:string;
begin
   self.edit_familiya.text:=people.field_familiya;
   self.Edit_imya.text:=people.field_imya;
   self.Edit_otchestvo.text:=people.field_otchestvo;
   self.date_begin.Text:=people.field_date_begin;
   self.Edit_passport.text:=people.field_passport;
   self.Edit_ident_kod.text:=people.field_ident_kod;
   self.edit_phone.text:=people.field_phone;
   post_name:=people.get_post_name(fmdatamodule.query_temp);
   if post_name<>''
   then self.ComboBox_post.ItemIndex:=self.ComboBox_post.Items.IndexOf(post_name)
   else self.ComboBox_post.ItemIndex:=0;
   self.edit_home.text:=people.field_home;
end;

procedure TfmPeople_edit.Button_cancelClick(Sender: TObject);
begin
   modalresult:=mrCancel;
end;

procedure TfmPeople_edit.button_okClick(Sender: TObject);
begin
   try
      if self.ComboBox_post.text=''
      then begin
           raise Exception.create('Выберите должность');
           end;
      if trim(self.edit_familiya.text)=''
      then begin
           raise Exception.create('Введите фамилию');
           end;
      {if trim(self.edit_imya.text)=''
      then begin
           raise Exception.create('Введите имя');
           end;}
      self.form_to_people_record(self.people_record);
      if self.people_record.check_length<>''
      then showmessage('Уменьшите пожалуйста длинну поля "'+self.people_record.check_length+'"')
      else modalresult:=mrOk;
   except
      on e:exception
      do begin
         showmessage(e.message);
         end;
   end;
end;

end.
