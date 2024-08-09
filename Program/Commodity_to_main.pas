unit Commodity_to_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, Grids, DBGrids,datamodule, ExtCtrls, dxCntner, dxEditor,
  dxEdLib;

type
  TfmCommodity_to_Main = class(TForm)
    Panel1: TPanel;
    DBGrid2: TDBGrid;
    DataSource1: TDataSource;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    Panel3: TPanel;
    Label1: TLabel;
    Panel4: TPanel;
    button_add_to_main: TButton;
    button_assortment_add: TButton;
    Panel5: TPanel;
    Label2: TLabel;
    edit_assortment_name_filter: TEdit;
    edit_point_0_name_filter: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox_in_step: TCheckBox;
    Splitter1: TSplitter;
    Panel6: TPanel;
    edit_quantity: TdxEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edit_price: TdxEdit;
    edit_price_buying: TdxEdit;
    edit_assortment_note_filter: TEdit;
    caption_4: TLabel;
    CheckBox_without_price_buying: TCheckBox;
    procedure button_assortment_addClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure button_add_to_mainClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edit_assortment_name_filterKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure edit_point_0_name_filterKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox_in_stepClick(Sender: TObject);
    procedure edit_assortment_note_filterKeyUp(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure edit_point_0_note_filterKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    access:dataModule.Taccess;
    procedure view_point_0(quantity,amount,amount_buying:TdxEdit;assortment_name:string);overload;
    procedure view_point_0(quantity,amount,amount_buying:TdxEdit);overload;
    procedure view_assortment(assortment_name,assortment_note:string);overload;
    procedure view_assortment;overload;
    procedure view_point_0_locate(kod:string);
    procedure view_assortment_locate(kod:string);
    procedure set_filter(edit_up,edit_up2,edit_down:TEdit;Sender:TObject;step_in:boolean);
  end;

var
  fmCommodity_to_Main: TfmCommodity_to_Main;

implementation

uses Assortment, Commodity_to_main_transaction;

{$R *.DFM}

procedure TfmCommodity_to_Main.view_assortment(assortment_name,assortment_note:string);
var
   control_sql_values:datamodule.TControl_SQL_Values;
begin
     control_sql_values:=datamodule.Tcontrol_sql_values.create;
     fmdatamodule.query_assortment_view.SQL.Clear;
     fmdatamodule.query_assortment_view.SQL.add('SELECT KOD,NAME,PRICE,PRICE_BUYING,NOTE');
     fmdatamodule.query_assortment_view.SQL.add('FROM ASSORTMENT');
     fmdatamodule.query_assortment_view.SQL.add('WHERE VALID=1');
     if trim(assortment_name)<>''
     then begin
          fmdatamodule.query_assortment_view.SQL.add('AND NAME LIKE '+control_sql_values.check(chr(39)+'%'+assortment_name+'%'+chr(39)));
          end;
     if trim(assortment_note)<>''
     then begin
          fmdatamodule.query_assortment_view.SQL.add('AND NOTE LIKE '+control_sql_values.check(chr(39)+'%'+assortment_note+'%'+chr(39)));
          end;
     fmdatamodule.query_assortment_view.SQL.add('ORDER BY PRICE');
     fmdatamodule.query_assortment_view.Open;
end;

procedure TfmCommodity_to_Main.view_point_0(quantity,amount,amount_buying:TdxEdit;assortment_name:string);
var
   control_sql_values:datamodule.TControl_SQL_Values;
   temp_quantity:integer;
   temp_amount,temp_amount_buying:real;
   data_source:TDataSource;
begin
     data_source:=self.DBGrid1.DataSource;
     self.dbgrid1.datasource:=nil;
     control_sql_values:=datamodule.Tcontrol_sql_values.create;
     fmdatamodule.query_point_0_view.SQL.Clear;
     fmdatamodule.query_point_0_view.SQL.Add('SELECT COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,');
     fmdatamodule.query_point_0_view.SQL.Add('SUM(COMMODITY.QUANTITY) QUANTITY,');
     fmdatamodule.query_point_0_view.SQL.Add('ASSORTMENT.PRICE ASSORTMENT_PRICE,');
     fmdatamodule.query_point_0_view.SQL.Add('SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE PRICE,');
     fmdatamodule.query_point_0_view.SQL.Add('ASSORTMENT.PRICE_BUYING ASSORTMENT_PRICE_BUYING,');
     fmdatamodule.query_point_0_view.SQL.Add('SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE_BUYING PRICE_BUYING');
     fmdatamodule.query_point_0_view.SQL.Add('FROM COMMODITY');
     fmdatamodule.query_point_0_view.SQL.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
     fmdatamodule.query_point_0_view.SQL.Add('WHERE COMMODITY.POINT_KOD=0');
     if trim(assortment_name)<>''
     then begin
          fmdatamodule.query_point_0_view.SQL.Add(' AND ASSORTMENT.NAME LIKE '+control_sql_values.check(chr(39)+'%'+assortment_name+'%'+chr(39)));
          end;
     fmdatamodule.query_point_0_view.SQL.Add('GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRICE,ASSORTMENT.PRICE_BUYING');
     fmdatamodule.query_point_0_view.SQL.Add('HAVING SUM(COMMODITY.QUANTITY)<>0');
     fmdatamodule.query_point_0_view.SQL.Add('ORDER BY ASSORTMENT.PRICE');
     fmdatamodule.query_point_0_view.Open;
     temp_quantity:=0;
     temp_amount:=0;
     temp_amount_buying:=0;

     while not(fmDataModule.query_point_0_view.eof)
     do begin
        try
           temp_quantity:=temp_quantity+fmDataModule.query_point_0_view.fieldbyname('QUANTITY').asinteger;
        except
        end;
        try
           temp_amount:=temp_amount+fmDataModule.query_point_0_view.fieldbyname('PRICE').asfloat;
        except
        end;
        try
           temp_amount_buying:=temp_amount_buying+fmDataModule.query_point_0_view.fieldbyname('PRICE_BUYING').asfloat;
        except
        end;
        fmDataModule.Query_point_0_view.Next;
        end;
     quantity.text:=inttostr(temp_quantity);
     amount.text:=format('%.2f',[temp_amount]);
     amount_buying.text:=format('%.2f',[temp_amount_buying]);
     self.dbgrid1.datasource:=data_source;
end;

procedure TfmCommodity_to_Main.button_assortment_addClick(Sender: TObject);
begin
   fmassortment:=tfmAssortment.create(self);
   fmassortment.startup_assortment_kod:=self.DBGrid2.DataSource.DataSet.fieldbyname('KOD').asstring;
   fmassortment.showmodal;
   self.view_assortment;
   if fmassortment.current_assortment_kod<>''
   then begin
        self.DBGrid2.DataSource.DataSet.Locate('KOD',fmassortment.current_assortment_kod,[]);
        end;
   freeandnil(fmassortment);
end;

procedure TfmCommodity_to_Main.FormShow(Sender: TObject);
begin
   self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying);
   self.view_assortment;
end;

procedure TfmCommodity_to_Main.button_add_to_mainClick(Sender: TObject);
var
   commodity:datamodule.TCommodity;
   assortment:datamodule.TAssortment;
   money:datamodule.TMoney;
   temp_string:string;
   datetime_now:TDateTime;
   kod:string;
begin
   kod:=fmdatamodule.query_assortment_view.fieldbyname('KOD').asstring;
   if kod<>''
   then begin
        fmcommodity_to_main_transaction:=TfmCommodity_to_main_transaction.create(self);
        fmcommodity_to_main_transaction.edit_kod.text:=fmdatamodule.query_assortment_view.fieldbyname('KOD').asstring;
        fmcommodity_to_main_transaction.edit_name.text:=fmdatamodule.query_assortment_view.fieldbyname('NAME').asstring;
        fmcommodity_to_main_transaction.Edit_quantity.text:='1';
        fmcommodity_to_main_transaction.Edit_price.text:=fmdatamodule.query_assortment_view.fieldbyname('PRICE').asstring;
        fmcommodity_to_main_transaction.edit_date.date:=now;
        if fmcommodity_to_main_transaction.ShowModal=mrOk
        then begin
             // перенести товар на склад
             commodity:=datamodule.TCommodity.create();
             commodity.field_assortment_kod:=fmdatamodule.query_assortment_view.fieldbyname('KOD').asstring;
             commodity.field_date_in_out:=Datetostr(fmcommodity_to_main_transaction.edit_date.date);
             commodity.field_man_kod:='';
             commodity.field_note:='';
             commodity.field_operation_kod:='4';// перемещение товара на торговую точку
             commodity.field_point_kod:='0';// номер торговой точки
             commodity.field_quantity:=fmcommodity_to_main_transaction.Edit_quantity.text;
             commodity.field_writer:='1';// номер пользователя
             datetime_now:=date;
             commodity.field_write_date:=datetimetostr(datetime_now);
             temp_string:=commodity.save(fmdatamodule.query_temp);
             if temp_string<>''
             then begin
                  showmessage('Товар не занесен на склад '+chr(13)+chr(10)+temp_string);
                  end;
             money:=datamodule.Tmoney.create();
             assortment:=datamodule.TAssortment.create();
             assortment.load_by_kod(commodity.field_assortment_kod,fmDataModule.query_temp);
             money.field_kod_point:='0';
             money.field_kod_expenses:='8'; // закупка товара
             if self.CheckBox_without_price_buying.Checked
             then begin
                  // если довоз без закупки
                  money.field_amount:='0';
                  end
             else begin
                  // если довоз с закупкой
                  try
                     money.field_amount:=floattostr(strtofloat(assortment.field_price_buying)*strtofloat(commodity.field_quantity));
                  except
                     money.field_amount:='0';
                  end;
                  end;
             money.field_kod_man:='';
             money.field_kod_writer:='1';// номер пользователя
             money.field_date_writer:=datetimetostr(datetime_now);
             money.field_date_in_out:=Datetostr(fmcommodity_to_main_transaction.edit_date.date);
             if self.checkbox_without_price_buying.checked
             then begin
                  // если довоз без закупки
                  money.field_note:='<>A:'+commodity.field_assortment_kod+' Q:'+commodity.field_quantity;
                  end
             else begin
                  // если довоз с закупкой
                  money.field_note:='A:'+commodity.field_assortment_kod+' Q:'+commodity.field_quantity;
                  end;
             temp_string:=money.save(fmDataModule.query_temp);
             if temp_string<>''
             then begin
                  showmessage('Стоимость закупки не добавлена в Расходы '+chr(13)+chr(10)+temp_string);
                  end;
             // отображение на экране
             self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying);
             self.view_assortment;
             self.view_point_0_locate(kod);
             self.view_assortment_locate(kod);
             // Garbage Collector
             freeandnil(assortment);
             freeandnil(commodity);
             freeandnil(money);
             end
        else begin
             // отмена переноса товара на склад
             end;
        freeandnil(fmcommodity_to_main_transaction);
        end;
end;

procedure TfmCommodity_to_Main.FormCreate(Sender: TObject);
begin
   self.access:=dataModule.TAccess.create;
end;


procedure TfmCommodity_to_Main.set_filter(edit_up,edit_up2,edit_down: TEdit;
Sender: TObject; step_in: boolean);
var
   color_filter_set,color_filter_unset:TColor;
begin
   color_filter_set:=clRed;
   color_filter_unset:=clWindow;
   if Sender is TEdit
   then begin
        if trim(TEdit(Sender).text)<>''
        then begin
             // edit UP ?
             if TEdit(Sender)=edit_up
             then begin
                  // set filter UP
                  self.view_assortment(edit_up.text,edit_up2.text);
                  edit_up.color:=color_filter_set;
                  // step in?
                  if step_in=true
                  then begin
                       edit_down.text:=edit_up.text;
                       edit_down.color:=color_filter_set;
                       // set filter DOWN
                       self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying,edit_down.text);
                       end;
                  end;
             // edit UP2 ?
             if TEdit(Sender)=edit_up2
             then begin
                  // set filter UP
                  self.view_assortment(edit_up.text,edit_up2.text);
                  edit_up2.color:=color_filter_set;
                  end;

             // Edit Down ?
             if TEdit(Sender)=edit_down
             then begin
                  // set filter DOWN
                  self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying,edit_down.text);
                  edit_down.color:=color_filter_set;
                  // step in?
                  if step_in=true
                  then begin
                       edit_up.text:=edit_down.text;
                       edit_up.color:=color_filter_set;
                       // set filter UP
                       self.view_assortment(edit_up.text,edit_up2.text);
                       end;
                  end;
             end
        else begin
             // skip filter UP ?
             if TEdit(Sender)=edit_up
             then begin
                  edit_up.color:=color_filter_unset;
                  // skip filter UP
                  self.view_assortment;
                  // step in ?
                  if step_in=true
                  then begin
                       edit_down.color:=color_filter_unset;
                       edit_down.text:='';
                       // skip filter DOWN
                       self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying);
                       end;
                  end;
             // skip filter UP2 ?
             if TEdit(Sender)=edit_up2
             then begin
                  edit_up2.color:=color_filter_unset;
                  // skip filter UP
                  self.view_assortment;
                  end;

             // skip filter DOWN ?
             if TEdit(Sender)=edit_down
             then begin
                  edit_down.color:=color_filter_unset;
                  // skip filter DOWN
                  self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying);
                  // step in ?
                  if step_in=true
                  then begin
                       edit_up.color:=color_filter_unset;
                       edit_up.text:='';
                       // skip filter UP
                       self.view_assortment;
                       end;
                  end;
             end;
             end;
   if Sender is TCheckBox
   then begin
        self.set_filter(edit_up,edit_up2,edit_down,edit_up2,self.CheckBox_in_step.checked);
        {
        if TCheckBox(Sender).Checked=true
        then begin
             if trim(edit_up.text)=''
             then begin
                  edit_up.text:=edit_down.text;
                  if trim(edit_down.text)=''
                  then begin
                       edit_down.color:=color_filter_unset;
                       edit_up.color:=color_filter_unset;
                       self.view_assortment;
                       self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying);
                       end
                  else begin
                       edit_down.color:=color_filter_set;
                       edit_up.color:=color_filter_set;
                       self.view_assortment(edit_up.text,edit_up2.text);
                       self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying,edit_down.text,edit_down2.text);
                       end;
                  end
             else begin
                  edit_down.text:=edit_up.text;
                  edit_down.color:=color_filter_set;
                  edit_up.color:=color_filter_set;

                  self.view_assortment(edit_up.text,edit_up2.text);
                  self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying,edit_down.text,edit_down2.text);
                  end;
             end
        else begin
             // removing flag IN_STEP
             edit_down.text:='';
             edit_down.color:=color_filter_unset;
             self.view_point_0(self.edit_quantity,self.edit_price,self.edit_price_buying);
             end;}
        end;
end;

procedure TfmCommodity_to_Main.edit_assortment_name_filterKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   self.set_filter(self.edit_assortment_name_filter,self.edit_assortment_note_filter,self.edit_point_0_name_filter,sender,self.CheckBox_in_step.Checked);
end;

procedure TfmCommodity_to_Main.edit_point_0_name_filterKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   self.set_filter(self.edit_assortment_name_filter,self.edit_assortment_note_filter,self.edit_point_0_name_filter,sender,self.CheckBox_in_step.Checked);
end;

procedure TfmCommodity_to_Main.CheckBox_in_stepClick(Sender: TObject);
begin
   self.set_filter(self.edit_assortment_name_filter,self.edit_assortment_note_filter,self.edit_point_0_name_filter,sender,self.CheckBox_in_step.Checked);
end;

procedure TfmCommodity_to_Main.view_assortment_locate(kod: string);
begin
   fmdatamodule.query_assortment_view.locate('KOD',kod,[]);
end;

procedure TfmCommodity_to_Main.view_point_0_locate(kod: string);
begin
   fmdatamodule.query_point_0_view.locate('ASSORTMENT_KOD',kod,[]);
end;

procedure TfmCommodity_to_Main.view_assortment;
begin
     fmdatamodule.query_assortment_view.SQL.Clear;
     fmdatamodule.query_assortment_view.SQL.add('SELECT KOD,NAME,PRICE,PRICE_BUYING,NOTE');
     fmdatamodule.query_assortment_view.SQL.add('FROM ASSORTMENT');
     fmdatamodule.query_assortment_view.SQL.add('WHERE VALID=1');
     fmdatamodule.query_assortment_view.SQL.add('ORDER BY PRICE');
     fmdatamodule.query_assortment_view.Open;
end;

procedure TfmCommodity_to_Main.view_point_0(quantity,
                                            amount,
                                            amount_buying: TdxEdit);
var
   control_sql_values:datamodule.TControl_SQL_Values;
   temp_quantity:integer;
   temp_amount,temp_amount_buying:real;
   temp_datasource:TDatasource;
begin
     temp_datasource:=self.dbGrid1.datasource;
     self.DBGrid1.datasource:=nil;
     fmdatamodule.query_point_0_view.SQL.Clear;
     fmdatamodule.query_point_0_view.SQL.Add('SELECT COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,');
     fmdatamodule.query_point_0_view.SQL.Add('SUM(COMMODITY.QUANTITY) QUANTITY,');
     fmdatamodule.query_point_0_view.SQL.Add('ASSORTMENT.PRICE ASSORTMENT_PRICE,');
     fmdatamodule.query_point_0_view.SQL.Add('SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE PRICE,');
     fmdatamodule.query_point_0_view.SQL.Add('ASSORTMENT.PRICE_BUYING ASSORTMENT_PRICE_BUYING,');
     fmdatamodule.query_point_0_view.SQL.Add('SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE_BUYING PRICE_BUYING');
     fmdatamodule.query_point_0_view.SQL.Add('FROM COMMODITY');
     fmdatamodule.query_point_0_view.SQL.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
     fmdatamodule.query_point_0_view.SQL.Add('WHERE COMMODITY.POINT_KOD=0');
     fmdatamodule.query_point_0_view.SQL.Add('GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRICE,ASSORTMENT.PRICE_BUYING');
     fmdatamodule.query_point_0_view.SQL.Add('HAVING SUM(COMMODITY.QUANTITY)<>0');
     fmdatamodule.query_point_0_view.SQL.Add('ORDER BY ASSORTMENT.PRICE');
     fmdatamodule.query_point_0_view.Open;
     temp_quantity:=0;
     temp_amount:=0;
     temp_amount_buying:=0;
     while not(fmDataModule.query_point_0_view.eof)
     do begin
        try
           temp_quantity:=temp_quantity+fmDataModule.query_point_0_view.fieldbyname('QUANTITY').asinteger;
        except
        end;
        try
           temp_amount:=temp_amount+fmDataModule.query_point_0_view.fieldbyname('PRICE').asfloat;
        except
        end;
        try
           temp_amount_buying:=temp_amount_buying+fmDataModule.query_point_0_view.fieldbyname('PRICE_BUYING').asfloat;
        except
        end;
        fmDataModule.Query_point_0_view.Next;
        end;
     quantity.text:=inttostr(temp_quantity);
     amount.text:=format('%.2f',[temp_amount]);
     amount_buying.text:=format('%.2f',[temp_amount_buying]);
     self.DBGrid1.datasource:=temp_datasource;

end;

procedure TfmCommodity_to_Main.edit_assortment_note_filterKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   self.set_filter(self.edit_assortment_name_filter,self.edit_assortment_note_filter,self.edit_point_0_name_filter,sender,self.CheckBox_in_step.Checked);
end;

procedure TfmCommodity_to_Main.edit_point_0_note_filterKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   self.set_filter(self.edit_assortment_name_filter,self.edit_assortment_note_filter,self.edit_point_0_name_filter,sender,self.CheckBox_in_step.Checked);
end;

end.
