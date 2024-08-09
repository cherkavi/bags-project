unit Expenses;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,datamodule,
  Db, Grids, DBGrids, ExtCtrls, StdCtrls;

type
  TfmExpenses = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    dbGrid: TDBGrid;
    DataSource1: TDataSource;
    button_add: TButton;
    button_edit: TButton;
    procedure button_addClick(Sender: TObject);
    procedure button_editClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    procedure show_data;
  end;

var
  fmExpenses: TfmExpenses;

implementation

uses Expenses_Edit;

{$R *.DFM}

procedure TfmExpenses.button_addClick(Sender: TObject);
begin
   fmExpenses_edit:=TfmExpenses_edit.create(self);
   if fmExpenses_edit.showmodal=mrOk
   then begin
        // сохранение значения
        fmExpenses_edit.expenses_record.save(fmDataModule.query_temp);
        fmDataModule.Transaction_main.active:=false;
        fmDataModule.Transaction_main.active:=true;
        self.show_data;
        end
   else begin
        // пользователь отказался от сохранения
        end;
   freeandnil(fmExpenses_edit);
end;

procedure TfmExpenses.button_editClick(Sender: TObject);
begin
   if self.dbGrid.DataSource.dataset.FieldByName('KOD').asstring<>''
   then begin
        fmExpenses_edit:=TfmExpenses_edit.create(self);
        fmExpenses_edit.expenses_record.load_by_kod(self.dbGrid.DataSource.dataset.FieldByName('KOD').asstring,fmDataModule.query_temp);
        if fmExpenses_edit.showmodal=mrOk
        then begin
             // сохранение значения
             fmExpenses_edit.expenses_record.save(fmDataModule.query_temp);
             fmDataModule.Transaction_main.active:=false;
             fmDataModule.Transaction_main.active:=true;
             self.show_data;
             end
        else begin
             // пользователь отказался от сохранения
             end;
        freeandnil(fmExpenses_edit);
        end
   else begin
        showmessage(' Выберите запись для редактирования');
        end;
end;

procedure TfmExpenses.show_data;
begin
   fmDataModule.query_expenses.SQL.clear;
   fmDataModule.query_expenses.SQL.text:='SELECT * FROM EXPENSES';
   fmDataModule.query_expenses.open;
end;

procedure TfmExpenses.FormShow(Sender: TObject);
begin
   show_data;
end;

procedure TfmExpenses.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
end;

end.
