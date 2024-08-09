unit Dovidka_14;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,dataModule,ibQuery,comobj,clipbrd;

type
  TfmDovidka_14 = class(TForm)
    ComboBox_points: TComboBox;
    Label1: TLabel;
    button_absent_on_point: TButton;
    button_present_on_point: TButton;
    procedure button_absent_on_pointClick(Sender: TObject);
    procedure button_present_on_pointClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    // возвращает список артикулов по наличию товара на торговой точке
    function get_assortment_name(query:TibQuery;date_in_out:TDateTime;point_name:string):TStringList;
    // возвращает список артикулов, которые есть в source но отсутствуют в destination
    function get_source_not_in_destinatoion(source:Tstringlist;destination:TStringlist):TStringlist;
    // загрузка данных в combobox_points
    procedure load_points;
    // вывод в Excel TStringList
    procedure print_into_excel(title:string;list:TStringList);
  public
    { Public declarations }
    // первоначальная загрузка данных
    procedure load_data;
    procedure print_present_into_storehouse;
    procedure print_present_into_tradepoint;
  end;

var
  fmDovidka_14: TfmDovidka_14;

implementation


{$R *.DFM}

{ TfmDovidka_14 }

procedure TfmDovidka_14.load_points;
begin
    try
       fmDataModule.query_temp.sql.text:='SELECT * FROM POINTS WHERE KOD>2';
       fmDataModule.query_temp.open;
       fmDataModule.load_from_query_field_to_combobox(fmDataModule.query_temp,'NAME',self.combobox_points);
       self.combobox_points.itemindex:=0;
    except
        on e:exception
        do begin
           showmessage('Ошибка загрузки данных');
           end;
    end;
end;

procedure TfmDovidka_14.load_data;
begin
    // загрузка данных в Combobox_points
    load_points;
end;

function TfmDovidka_14.get_assortment_name(query:TibQuery;date_in_out:TDateTime;point_name: string): TStringList;
var
    return_value:TStringList;
    point_kod:string;
begin
    return_value:=TStringList.Create;
    point_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,
                                           'POINTS',
                                           'NAME',
                                           chr(39)+point_name+chr(39),
                                           'KOD');
    if(point_kod<>'')
    then begin
         query.sql.clear;
         query.sql.Add('SELECT  COMMODITY.ASSORTMENT_KOD,');
         query.sql.Add('        ASSORTMENT.NAME,');
         query.sql.Add('        ASSORTMENT.NOTE,');
         query.sql.Add('        SUM(COMMODITY.QUANTITY) QUANTITY,');
         query.sql.Add('        ASSORTMENT.PRICE PRICE,');
         query.sql.Add('        SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA');
         query.sql.Add('FROM COMMODITY');
         query.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
         query.sql.Add('INNER JOIN POINTS ON POINTS.KOD=COMMODITY.POINT_KOD AND POINTS.KOD IN ('+point_kod+')');
         query.sql.Add('WHERE 1=1');
         query.sql.Add('AND COMMODITY.date_in_out <='+chr(39)+datetostr(date_in_out)+chr(39));
         query.sql.Add('GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.NOTE,ASSORTMENT.PRICE');
         query.sql.Add('HAVING SUM(COMMODITY.QUANTITY)<>0');
         query.sql.Add('ORDER BY ASSORTMENT.NAME');
         //clipboard.astext:=query.sql.text;
         query.Open;
         if query.recordcount>0
         then begin
              // есть данные для наполнения
              while not(query.eof)
              do begin
                 return_value.add(query.FieldByName('NAME').asstring);
                 query.next;
                 end;
              end
         else begin
              // нет данных для отображения
              end;
         end;
    result:=return_value;
end;

function TfmDovidka_14.get_source_not_in_destinatoion(source,
                                                      destination: TStringlist): TStringlist;
var
    return_value:TStringList;
    counter:integer;
begin
    return_value:=TStringlist.create;
    for counter:=0 to source.count-1
    do begin
       if destination.IndexOf(source.Strings[counter])>=0
       then begin
            // source present into destination
            end
       else begin
            // source absent into destination
            return_value.add(source.strings[counter]);
            end;
       end;
    result:=return_value;
end;

procedure TfmDovidka_14.button_absent_on_pointClick(Sender: TObject);
begin
    self.print_present_into_storehouse;
end;

procedure TfmDovidka_14.print_present_into_storehouse;
var
    storehouse:Tstringlist;
    tradepoint:TStringlist;
    sub:TStringlist;
begin
    // создание объектов
    storehouse:=tstringlist.create;
    tradepoint:=Tstringlist.create;
    sub:=tstringlist.create;
    // загрузка данных в объекты
    storehouse.Assign(self.get_assortment_name(fmDataModule.query_temp,now,'Склад'));
    tradepoint.Assign(self.get_assortment_name(fmDataModule.query_temp,now,self.ComboBox_points.text));
    // разница в объектах
    sub.assign(self.get_source_not_in_destinatoion(storehouse,tradepoint));
    // печать разницы
    self.print_into_excel('Есть на складе, но нет на точке('+self.combobox_points.text+')',sub);
    // уничтожение объектов
    storehouse.destroy;
    tradepoint.destroy;
    sub.destroy;
end;

procedure TfmDovidka_14.print_present_into_tradepoint;
var
    storehouse:Tstringlist;
    tradepoint:TStringlist;
    sub:TStringlist;
begin
    screen.Cursor:=crHourGlass;
    // создание объектов
    storehouse:=tstringlist.create;
    tradepoint:=Tstringlist.create;
    sub:=tstringlist.create;
    // загрузка данных в объекты
    storehouse.Assign(self.get_assortment_name(fmDataModule.query_temp,now,'Склад'));
    tradepoint.Assign(self.get_assortment_name(fmDataModule.query_temp,now,self.ComboBox_points.text));
    // разница в объектах
    sub.assign(self.get_source_not_in_destinatoion(tradepoint,storehouse));
    // печать разницы
    self.print_into_excel('Есть на точке('+self.combobox_points.text+'), но нет на складе',sub);
    // уничтожение объектов
    storehouse.destroy;
    tradepoint.destroy;
    sub.destroy;
    screen.Cursor:=crDefault;
end;

procedure TfmDovidka_14.button_present_on_pointClick(Sender: TObject);
begin
    self.print_present_into_tradepoint;
end;

procedure TfmDovidka_14.print_into_excel(title: string; list: TStringList);
var
    excel:variant;
    counter:integer;
begin
    try
       excel:=CreateOleObject('Excel.Application');
       excel.Application.EnableEvents:=true;
       excel.workbooks.add;
       excel.visible:=false;
       //excel.worksheets[1].Cells.item[row_counter,col_counter+1].value:=
       excel.worksheets[1].Cells.item[1,1].value:=title;
       excel.worksheets[1].Cells.item[1,1].font.bold:=true;
       excel.worksheets[1].Cells.item[2,1].value:='Код';
       excel.worksheets[1].Cells.item[2,2].value:='Цена';
       excel.worksheets[1].Cells.item[2,1].font.bold:=true;
       excel.worksheets[1].Cells.item[2,2].font.bold:=true;
       for counter:=0 to list.count-1
       do begin
          excel.worksheets[1].Cells.item[3+counter,1].value:=list.Strings[counter];
          excel.worksheets[1].Cells.item[3+counter,2].value:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'ASSORTMENT','NAME',chr(39)+list.Strings[counter]+chr(39),'PRICE');
          end;
       excel.visible:=true;
    except
        on e:exception
        do begin
           showmessage('Ошибка при попытке вывода в Excel'+chr(13)+chr(10)+e.message);
           end;
    end;

end;

procedure TfmDovidka_14.FormShow(Sender: TObject);
begin
    self.load_data;
end;

end.
