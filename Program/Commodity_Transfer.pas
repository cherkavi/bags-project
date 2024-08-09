unit Commodity_Transfer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,DataModule, Db, Grids, DBGrids,IBQuery, ExtCtrls, dxCntner,
  dxEditor, dxEdLib;

type
  TfmCommodity_Transfer = class(TForm)
    DataSource_destination: TDataSource;
    panel_source: TPanel;
    DBGrid_source: TDBGrid;
    DataSource_source: TDataSource;
    Panel2: TPanel;
    Label1: TLabel;
    combobox_source: TComboBox;
    panel_destination: TPanel;
    DBGrid_destination: TDBGrid;
    Panel3: TPanel;
    button_transfer: TButton;
    ComboBox_destination: TComboBox;
    Label2: TLabel;
    Splitter1: TSplitter;
    edit_source_filter_name: TEdit;
    Edit_destination_filter_name: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox_in_step: TCheckBox;
    Panel1: TPanel;
    Panel4: TPanel;
    edit_source_quantity: TdxEdit;
    Edit_source_amount: TdxEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edit_destination_quantity: TdxEdit;
    Label8: TLabel;
    edit_destination_amount: TdxEdit;
    procedure FormShow(Sender: TObject);
    procedure combobox_sourceChange(Sender: TObject);
    procedure ComboBox_destinationChange(Sender: TObject);
    procedure button_transferClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edit_source_filter_nameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit_destination_filter_nameKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure CheckBox_in_stepClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    procedure points_get_data(grid:TDBGrid; points_number:string; query:TIBQuery; edit_quantity:TdxEdit; edit_amount:TdxEdit; condition_string:string='');
    procedure set_filter(edit_up,edit_down: TEdit; Sender: TObject; step_in: boolean);
    procedure locate_data(kod:string;query:TibQuery);
  end;

var
  fmCommodity_Transfer: TfmCommodity_Transfer;

implementation

uses Commodity_Transfer_Transaction;

{$R *.DFM}

{ TfmCommodity_Transfer }

procedure TfmCommodity_Transfer.points_get_data(grid:TDBGrid;
                                                points_number: string;
                                                query: TIBquery;
                                                edit_quantity:TdxEdit;
                                                edit_amount:TdxEdit;
                                                condition_string:string='');
var
   control_sql_values:datamodule.Tcontrol_sql_values;
   quantity:integer;
   amount:real;
   data_source:TDataSource;
begin
   query.SQL.clear;
   query.sql.Add('SELECT COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,SUM(COMMODITY.QUANTITY) QUANTITY,ASSORTMENT.PRICE PRICE,SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA');
   query.sql.Add('FROM COMMODITY');
   query.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
   query.sql.Add('WHERE COMMODITY.POINT_KOD='+points_number);
   if condition_string<>''
   then begin
        control_sql_values:=dataModule.TControl_SQL_Values.create;
        query.sql.add('AND ASSORTMENT.NAME LIKE '+control_sql_values.check(chr(39)+'%'+condition_string+'%'+chr(39)));
        end;
   query.sql.Add('GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRICE');
   query.sql.Add('   HAVING SUM(COMMODITY.QUANTITY)<>0');
   query.sql.Add('ORDER BY ASSORTMENT.PRICE,COMMODITY.ASSORTMENT_KOD');
   query.open;
   quantity:=0;
   amount:=0;
   data_source:=grid.DataSource;
   grid.DataSource:=nil;
   while not(query.eof)
   do begin
      try
         quantity:=quantity+query.fieldbyname('QUANTITY').asinteger;
      except
      end;
      try
         amount:=amount+query.fieldbyname('SUMA').asfloat;
      except
      end;
      query.next;
      end;
   edit_quantity.text:=inttostr(quantity);
   edit_amount.text:=format('%.2f',[amount]);
   query.first;
   grid.DataSource:=data_source;
end;

procedure TfmCommodity_Transfer.FormShow(Sender: TObject);
begin
   fmdataModule.load_to_combobox_from_table_from_field(fmdataModule.Query_temp,self.combobox_source,'POINTS','NAME','','NAME');
end;

procedure TfmCommodity_Transfer.combobox_sourceChange(Sender: TObject);
var
   points_number:string;
begin
   points_number:=fmdatamodule.get_name_by_id(fmdatamodule.Query_temp,'POINTS','NAME',chr(39)+self.combobox_source.text+chr(39),'KOD');
   fmdatamodule.load_to_combobox_from_table_from_field(fmDataModule.query_temp,self.combobox_destination,'POINTS','NAME',' KOD<>'+points_number,'NAME');
   self.points_get_data(self.DBGrid_source,
                        points_number,
                        fmDataModule.Query_transfer_source,
                        self.edit_source_quantity,
                        self.Edit_source_amount);
end;

procedure TfmCommodity_Transfer.ComboBox_destinationChange(
  Sender: TObject);
var
   points_number:string;
begin
   points_number:=fmdatamodule.get_name_by_id(fmdatamodule.Query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD');
   self.points_get_data(self.dbgrid_destination,
                        points_number,
                        fmDataModule.Query_transfer_destination,
                        self.edit_destination_quantity,
                        self.edit_destination_amount);
end;

procedure TfmCommodity_Transfer.button_transferClick(Sender: TObject);
var
   commodity_source,commodity_destination:DataModule.Tcommodity;
   point_source_kod,point_destination_kod,write_datetime:string;
   result_operation:string;
   kod:string;
   datasource_source,datasource_destination:TDataSource;
begin
kod:=fmdatamodule.Query_transfer_source.FieldByName('ASSORTMENT_KOD').asstring;
if (kod<>'')
and (Self.ComboBox_destination.text<>'')
then begin
     fmCommodity_Transfer_Transaction:=TfmCommodity_Transfer_Transaction.create(self);
     commodity_source:=DataModule.TCommodity.Create;
     commodity_destination:=DataModule.TCommodity.Create;

     fmCommodity_Transfer_Transaction.edit_source.text:=self.combobox_source.text;
     fmCommodity_Transfer_Transaction.edit_destination.text:=self.ComboBox_destination.text;
     fmCommodity_Transfer_Transaction.edit_assortment_kod.text:=fmDataModule.Query_transfer_source.fieldbyname('ASSORTMENT_KOD').asstring;
     fmCommodity_Transfer_Transaction.edit_name.text:=fmDataModule.Query_transfer_source.fieldbyname('NAME').asString;
     fmCommodity_Transfer_Transaction.Edit_quantity.MaxValue:=fmDataModule.Query_transfer_source.fieldbyname('QUANTITY').AsInteger;
     fmCommodity_Transfer_Transaction.Edit_quantity.minValue:=1;
     if fmCommodity_Transfer_Transaction.Edit_quantity.MaxValue>0
     then fmCommodity_Transfer_Transaction.Edit_quantity.IntValue:=1;
     if fmCommodity_Transfer_Transaction.Edit_quantity.MaxValue=1
     then fmCommodity_Transfer_Transaction.Edit_quantity.readonly:=true;
     fmCommodity_Transfer_Transaction.edit_price.text:=fmDataModule.Query_transfer_source.fieldbyname('PRICE').asString;
     fmCommodity_Transfer_Transaction.date_in_out.date:=date;
     if fmCommodity_Transfer_Transaction.ShowModal=mrOk
     then begin
          // перемещение товара - и +
          point_source_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_source.text+chr(39),'KOD');
          point_destination_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD');
          write_datetime:=datetimetostr(now);
          commodity_source.clear;
          commodity_source.field_assortment_kod:=fmDataModule.Query_transfer_source.fieldbyname('ASSORTMENT_KOD').asstring;
          commodity_source.field_date_in_out:=fmCommodity_Transfer_Transaction.date_in_out.text;
          commodity_source.field_man_kod:='';//
          commodity_source.field_note:='TO POINT=<'+point_destination_kod+'>';
          commodity_source.field_operation_kod:='4';
          commodity_source.field_point_kod:=point_source_kod;
          commodity_source.field_quantity:='-'+fmCommodity_Transfer_Transaction.Edit_quantity.text;
          commodity_source.field_writer:='1';// Ќомер пользовател€
          commodity_source.field_write_date:=write_datetime;

          commodity_destination.clear;
          commodity_destination.field_assortment_kod:=fmDataModule.Query_transfer_source.fieldbyname('ASSORTMENT_KOD').asstring;
          commodity_destination.field_date_in_out:=fmCommodity_Transfer_Transaction.date_in_out.text;
          commodity_destination.field_man_kod:='';
          commodity_destination.field_note:='FROM POINT=<'+point_source_kod+'>';
          commodity_destination.field_operation_kod:='4';
          commodity_destination.field_point_kod:=point_destination_kod;
          commodity_destination.field_quantity:=fmCommodity_Transfer_Transaction.Edit_quantity.text;
          commodity_destination.field_writer:='1';// Ќомер пользовател€
          commodity_destination.field_write_date:=write_datetime;

          result_operation:=commodity_source.save(fmDataModule.query_temp);
          if result_operation=''
          then begin
               result_operation:=commodity_destination.save(fmDataModule.query_temp);
               if result_operation<>''
               then begin
                    // откат изменений
                    if commodity_destination.field_kod<>''
                    then commodity_destination.delete_by_kod(commodity_destination.field_kod,fmDataModule.Query_temp);
                    if commodity_source.field_kod<>''
                    then commodity_source.delete_by_kod(commodity_source.field_kod,fmDataModule.Query_temp);
                    showmessage('ѕеремещение не произведено');
                    end
               else begin
                    // запись прошла успешно
                    datasource_source:=self.DBGrid_source.datasource;
                    datasource_destination:=self.DBGrid_destination.datasource;
                    self.DBGrid_source.datasource:=nil;
                    self.DBGrid_destination.datasource:=nil;
                    self.points_get_data(self.DBGrid_source
                                         point_source_kod,
                                         fmDataModule.Query_transfer_source,
                                         self.edit_source_quantity,
                                         self.Edit_source_amount);
                    self.points_get_data(self.DBGrid_destination,
                                         point_destination_kod,
                                         fmDataModule.Query_transfer_destination,
                                         self.edit_destination_quantity,
                                         self.edit_destination_amount);
                    // установка указател€ товара
                    self.locate_data(kod,fmDataModule.Query_transfer_source);
                    self.locate_data(kod,fmDataModule.Query_transfer_destination);
                    self.DBGrid_source.datasource:=datasource_source;
                    self.DBGrid_destination.datasource:=datasource_destination;
                    end;
               end
          else begin
               showmessage('перемещение не произведено');
               end;
          freeandnil(commodity_source);
          freeandnil(commodity_destination);
          end
     else begin
          // пользователь отказалс€ от перемещени€ товара
          end;
     freeandnil(fmCommodity_Transfer_Transaction);
     end;
end;

procedure TfmCommodity_Transfer.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
   fmDataModule.Query_transfer_source.sql.clear;
   fmDataModule.Query_transfer_destination.sql.clear;
end;

procedure TfmCommodity_Transfer.set_filter(edit_up,
  edit_down: TEdit; Sender: TObject; step_in: boolean);
var
   color_filter_set,color_filter_unset:TColor;
begin
   color_filter_set:=clRed;
   color_filter_unset:=clWindow;
   if Sender is TEdit
   then begin
        if trim(TEdit(Sender).text)<>''
        then begin
             // установить фильтр
             if TEdit(Sender)=edit_up
             then begin
                  // Set Filter UP
                  self.points_get_data(self.DBGrid_source,
                                       fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_source.text+chr(39),'KOD'),
                                       fmDataModule.Query_transfer_source,
                                       self.edit_source_quantity,
                                       self.Edit_source_amount,
                                       edit_up.text);
                  edit_up.color:=color_filter_set;
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_down.text:=edit_up.text;
                       edit_down.color:=color_filter_set;
                       // Set Filter Down
                       self.points_get_data(self.DBGrid_destination,
                                            fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD'),
                                            fmDataModule.Query_transfer_destination,
                                            self.edit_destination_quantity,
                                            self.edit_destination_amount,
                                            edit_down.text);
                       end;
                  end;
             if TEdit(Sender)=edit_down
             then begin
                  // Set Filter Down
                  self.points_get_data(self.DBGrid_destination,
                                       fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD'),
                                       fmDataModule.Query_transfer_destination,
                                       self.edit_destination_quantity,
                                       self.edit_destination_amount,
                                       edit_down.text);
                  edit_down.color:=color_filter_set;
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_up.text:=edit_down.text;
                       edit_up.color:=color_filter_set;
                       // Set Filter UP
                       self.points_get_data(self.DBGrid_source,
                                            fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_source.text+chr(39),'KOD'),
                                            fmDataModule.Query_transfer_source,
                                            self.edit_source_quantity,
                                            self.Edit_source_amount,
                                            edit_up.text);
                       end;
                  end;
             end
        else begin
             if TEdit(Sender)=edit_up
             then begin
                  edit_up.color:=color_filter_unset;
                  // Clear Filter UP
                  self.points_get_data(self.DBGrid_source,
                                       fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_source.text+chr(39),'KOD'),
                                       fmDataModule.Query_transfer_source,
                                       self.edit_source_quantity,
                                       self.Edit_source_amount);
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_down.color:=color_filter_unset;
                       edit_down.text:='';
                       // Clear Filter Down
                       self.points_get_data(self.DBGrid_destination,
                                            fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD'),
                                            fmDataModule.Query_transfer_destination,
                                            self.edit_destination_quantity,
                                            self.edit_destination_amount);
                       end;
                  end;
             if TEdit(Sender)=edit_down
             then begin
                  edit_down.color:=color_filter_unset;
                  // Clear Filter Down
                  self.points_get_data(self.DBGrid_destination,
                                       fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD'),
                                       fmDataModule.Query_transfer_destination,
                                       self.edit_destination_quantity,
                                       self.edit_destination_amount);
                  // проверка на синхронность
                  if step_in=true
                  then begin
                       edit_up.color:=color_filter_unset;
                       edit_up.text:='';
                       // Clear Filter UP
                       self.points_get_data(self.DBGrid_source,
                                            fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_source.text+chr(39),'KOD'),
                                            fmDataModule.Query_transfer_source,
                                            self.edit_source_quantity,
                                            self.Edit_source_amount);
                       end;
                  end;
             end;
        end;
   if Sender is TCheckBox
   then begin
        if TCheckBox(Sender).Checked=true
        then begin
             if trim(edit_up.text)=''
             then begin
                  edit_up.text:=edit_down.text;
                  if trim(edit_down.text)=''
                  then begin
                       edit_down.color:=color_filter_unset;
                       edit_up.color:=color_filter_unset;
                       // Clear Filter UP
                       self.points_get_data(self.DBGrid_source,
                                            fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_source.text+chr(39),'KOD'),
                                            fmDataModule.Query_transfer_source,
                                            self.edit_source_quantity,
                                            self.Edit_source_amount);
                       // Clear Filter Down
                       self.points_get_data(self.DBGrid_destination,
                                            fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD'),
                                            fmDataModule.Query_transfer_destination,
                                            self.edit_destination_quantity,
                                            self.edit_destination_amount);
                       end
                  else begin
                       edit_down.color:=color_filter_set;
                       edit_up.color:=color_filter_set;
                       // Set Filter UP
                       self.points_get_data(self.DBGrid_source,
                                            fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_source.text+chr(39),'KOD'),
                                            fmDataModule.Query_transfer_source,
                                            self.edit_source_quantity,
                                            self.Edit_source_amount,
                                            edit_up.text);
                       // Set Filter Down
                       self.points_get_data(self.DBGrid_destination,
                                            fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD'),
                                            fmDataModule.Query_transfer_destination,
                                            self.edit_destination_quantity,
                                            self.edit_destination_amount,
                                            edit_down.text);
                       end;
                  end
             else begin
                  edit_down.text:=edit_up.text;
                  edit_down.color:=color_filter_set;
                  edit_up.color:=color_filter_set;
                  // Set Filter UP
                  self.points_get_data(self.DBGrid_source,
                                       fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_source.text+chr(39),'KOD'),
                                       fmDataModule.Query_transfer_source,
                                       self.edit_source_quantity,
                                       self.Edit_source_amount,
                                       edit_up.text);
                  // Set Filter Down
                  self.points_get_data(self.DBGrid_destination,
                                       fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD'),
                                       fmDataModule.Query_transfer_destination,
                                       self.edit_destination_quantity,
                                       self.edit_destination_amount,
                                       edit_down.text);
                  end;
             end
        else begin
             // removing flag IN_STEP
             edit_down.text:='';
             edit_down.color:=color_filter_unset;
             // Clear Filter Down
             self.points_get_data(self.DBGrid_destination,
                                  fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_destination.text+chr(39),'KOD'),
                                  fmDataModule.Query_transfer_destination,
                                  self.edit_destination_quantity,
                                  self.edit_destination_amount);
             end;
        end;
end;

procedure TfmCommodity_Transfer.edit_source_filter_nameKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
if self.combobox_source.text<>''
then begin
     self.set_filter(self.edit_source_filter_name,self.Edit_destination_filter_name,sender,self.CheckBox_in_step.Checked);
     end;
end;

procedure TfmCommodity_Transfer.Edit_destination_filter_nameKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
if self.combobox_destination.text<>''
then begin
     self.set_filter(self.edit_source_filter_name,self.Edit_destination_filter_name,sender,self.CheckBox_in_step.Checked);
     end;
end;

procedure TfmCommodity_Transfer.CheckBox_in_stepClick(Sender: TObject);
begin
if (self.combobox_destination.text<>'') and (self.combobox_source.text<>'')
then begin
     self.set_filter(self.edit_source_filter_name,self.Edit_destination_filter_name,sender,self.CheckBox_in_step.Checked);
     end
else begin
     TCheckBox(Sender).checked:=false;
     end;

end;

procedure TfmCommodity_Transfer.locate_data(kod: string; query: TibQuery);
begin
   try
      query.locate('ASSORTMENT_KOD',kod,[]);
   except
      on e:exception
      do begin
         showmessage('Locate Error:'+kod);
         end;
   end;
end;

end.
