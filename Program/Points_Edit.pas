unit Points_Edit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,datamodule,
  StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib;

type
  TfmPoints_Edit = class(TForm)
    edit_kod: TEdit;
    edit_name: TEdit;
    edit_address: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    button_Ok: TButton;
    button_cancel: TButton;
    edit_rayon: TEdit;
    Edit_arenda: TdxCalcEdit;
    Label4: TLabel;
    Label5: TLabel;
    procedure button_OkClick(Sender: TObject);
    procedure button_cancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    points_record:datamodule.tpoints;
    procedure points_record_to_form(points:datamodule.TPoints);
    procedure form_to_points_record(var points:datamodule.TPoints);
  end;

var
  fmPoints_Edit: TfmPoints_Edit;

implementation

{$R *.DFM}

procedure TfmPoints_Edit.button_OkClick(Sender: TObject);
begin
   if trim(self.edit_name.text)<>''
   then begin
        self.form_to_points_record(self.points_record);
        if self.points_record.check_length<>''
        then showmessage('Необходимо уменьшить размер поля "'+self.points_record.check_length+'"')
        else modalresult:=mrOk;
        end
   else begin
        showmessage(' Введите название торговой точки ');
        end;
end;

procedure TfmPoints_Edit.button_cancelClick(Sender: TObject);
begin
   modalresult:=mrCancel;
end;

procedure TfmPoints_Edit.form_to_points_record(var points: TPoints);
begin
   points.field_name:=self.edit_name.text;
   points.field_address:=self.edit_address.text;
   points.field_rayon:=self.edit_rayon.text;
   points.field_arenda:=self.Edit_arenda.text;
end;

procedure TfmPoints_Edit.points_record_to_form(points: TPoints);
begin
   self.edit_kod.text:=points.field_kod;
   self.edit_name.text:=points.field_name;
   self.edit_address.text:=points.field_address;
   self.edit_rayon.text:=points.field_rayon;
   self.Edit_arenda.text:=points.field_arenda;
end;

procedure TfmPoints_Edit.FormCreate(Sender: TObject);
begin
   self.points_record:=datamodule.TPoints.create;
end;

procedure TfmPoints_Edit.FormShow(Sender: TObject);
begin
   self.points_record_to_form(self.points_record);
end;

end.
