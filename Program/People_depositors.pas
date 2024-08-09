unit People_depositors;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, DBGrids, Db,datamodule,ibQuery;

type
  TfmPeople_depositors = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    button_ok: TButton;
    button_cancel: TButton;
    procedure button_okClick(Sender: TObject);
    procedure button_cancelClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    field_people_kod:string;
    procedure fill_dbgrid(query:TibQuery);
  end;

var
  fmPeople_depositors: TfmPeople_depositors;

implementation

{$R *.DFM}

procedure TfmPeople_depositors.button_okClick(Sender: TObject);
begin
    self.field_people_kod:=self.DBGrid1.DataSource.DataSet.fieldbyname('KOD').asstring;
    if self.field_people_kod<>''
    then begin
         modalResult:=mrOk;
         end;
end;

procedure TfmPeople_depositors.button_cancelClick(Sender: TObject);
begin
    modalresult:=mrCancel;
end;

procedure TfmPeople_depositors.fill_dbgrid(query: TibQuery);
begin
    query.sql.clear;
    query.sql.Add('SELECT * FROM PEOPLE WHERE PEOPLE.POST_KOD=1');
    query.open;
end;

procedure TfmPeople_depositors.DBGrid1DblClick(Sender: TObject);
begin
    self.button_ok.Click;
end;

procedure TfmPeople_depositors.FormCreate(Sender: TObject);
begin
    self.fill_dbgrid(fmDataModule.query_people);
end;

procedure TfmPeople_depositors.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if key=13
    then self.button_ok.click;
end;

end.
