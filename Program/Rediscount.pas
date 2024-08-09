unit Rediscount;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, Grids,DataModule,IBQuery,IniFiles,
  Menus,COMObj;

type
  TfmRediscount = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    combobox_points: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit_data_rediscount: TdxDateEdit;
    combobox_seller: TComboBox;
    Label3: TLabel;
    Edit_path_to_file: TEdit;
    Button_load_file: TButton;
    button_open_file: TButton;
    Label4: TLabel;
    Panel11: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    dxEdit5: TdxEdit;
    dxEdit6: TdxEdit;
    dxEdit7: TdxEdit;
    dxEdit8: TdxEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    StringGrid_point: TStringGrid;
    StringGrid_real: TStringGrid;
    StringGrid_match: TStringGrid;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    dxEdit3: TdxEdit;
    Label12: TLabel;
    dxEdit4: TdxEdit;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    dxEdit1: TdxEdit;
    Label6: TLabel;
    dxEdit2: TdxEdit;
    Label13: TLabel;
    dxEdit9: TdxEdit;
    button_commit: TButton;
    button_preview: TButton;
    PopupMenu_point: TPopupMenu;
    PopupMenu_real: TPopupMenu;
    PopupMenu_match: TPopupMenu;
    Excel1: TMenuItem;
    Excel2: TMenuItem;
    Excel3: TMenuItem;
    button_edit_file: TButton;
    procedure button_open_fileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure combobox_pointsChange(Sender: TObject);
    procedure Button_load_fileClick(Sender: TObject);
    procedure button_previewClick(Sender: TObject);
    procedure button_commitClick(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure Excel2Click(Sender: TObject);
    procedure Excel3Click(Sender: TObject);
    procedure button_edit_fileClick(Sender: TObject);
  private
    { Private declarations }
    // загрузить данные из файла 'CSV'
    function load_from_csv_file_to_stringlist(path_to_file:String;var assortment_name:Tstringlist;var assortment_quantity:Tstringlist):integer;
    // загрузить данные из файла 'DAT'
    function load_from_dat_file_to_stringlist(path_to_file:String;var assortment_name:Tstringlist;var assortment_quantity:Tstringlist):integer;

    // удалить двойники
    procedure delete_doublbe(var assortment_name:tstringlist;var assortment_quantity:tstringlist);
    // упорядочить данные как в ассортименте, получить цены по ассортименту
    function order_as_assortment( var assortment_kod:tstringlist;
                                  var assortment_name:tstringlist;
                                  var assortment_price:tstringlist;
                                  var assortment_quantity:tstringlist;query:TIBQuery):boolean;
    // загрузить данные в StringGrid
    procedure load_to_StringGrid(assortment_kod,assortment_name,assortment_price,assortment_quantity:tstringlist;stringgrid:TStringGrid);
    // сопоставить StrigGrid_source и StringGrid_destination
    procedure match_stringgrids(stringgrid_source,stringgrid_destination:TstringGrid;var assortment_name:tstringlist;var assortment_quantity:tstringlist;kod_exists:boolean);
    // очистить StringGrid
    procedure clear_StringGrid(var stringgrid:TStringGrid);
    // StringGrid_to_Excel
    procedure StringGrid_to_Excel(caption:string;stringgrid:TStringgrid);
 public
    column_kod,
    column_name,
    column_quantity,
    column_price,
    column_amount:integer;
    field_path_to_rediscount:string;
    //field_name_rediscount:string;
    { Public declarations }
    procedure load_startup_data;
    // загрузка товара, который должен быть по бумагам
    procedure load_commodity_of_point;
    // подсчитать кол-во товара и его сумму для торговой точки
    procedure calculate_commodity_of_point;
    // подсчитать кол-во товара и сумму на реальной торговой точке
    procedure calculate_commodity_real;
    // подсчитать цифры для переучета
    procedure calculate_matching;
  end;

var
  fmRediscount: TfmRediscount;

implementation

uses Rediscount_list, Rediscount_edit_file;

{$R *.DFM}

procedure TfmRediscount.button_open_fileClick(Sender: TObject);
begin
   self.clear_StringGrid(self.stringGrid_real);
   // очистка StringGrid
   self.StringGrid_real.rowcount:=2;
   fmrediscount_list:=tfmrediscount_list.create(self);
   fmrediscount_list.field_path_to_rediscount:=self.field_path_to_rediscount;
   fmrediscount_list.ShowModal;
   self.Edit_path_to_file.text:=fmrediscount_list.field_path_to_file;
   freeandnil(fmrediscount_list);
end;

// загрузка начальных параметров
procedure TfmRediscount.load_startup_data;
begin
   column_kod:=0;
   column_name:=1;
   column_quantity:=2;
   column_price:=3;
   column_amount:=4;

   fmDataModule.load_to_combobox_from_table_from_field(fmDataModule.query_temp,self.combobox_points,'POINTS','NAME','KOD>=0');
   try
      self.Edit_data_rediscount.text:=Datetostr(date);
   except
   end;
   fmDataModule.load_to_combobox_from_table_from_fields(fmDataModule.query_temp,self.combobox_seller,'PEOPLE',['KOD','FAMILIYA','IMYA','OTCHESTVO'],'  ','','KOD');
end;

procedure TfmRediscount.FormShow(Sender: TObject);
begin
   self.load_startup_data;
end;

procedure TfmRediscount.load_commodity_of_point;
var
   point_kod:string;
begin
   try
      point_kod:=fmDataModule.get_name_by_id(fmDataModule.query_temp,'POINTS','NAME',chr(39)+self.combobox_points.text+chr(39),'KOD');
      fmDataModule.query_temp.sql.clear;
      fmDataModule.query_temp.sql.Add('SELECT COMMODITY.ASSORTMENT_KOD,');
      fmDataModule.query_temp.sql.Add('ASSORTMENT.NAME,');
      fmDataModule.query_temp.sql.Add('SUM(COMMODITY.QUANTITY) QUANTITY,');
      fmDataModule.query_temp.sql.Add('ASSORTMENT.PRICE PRICE,');
      fmDataModule.query_temp.sql.Add('SUM(COMMODITY.QUANTITY)*ASSORTMENT.PRICE SUMA');
      fmDataModule.query_temp.sql.Add('FROM COMMODITY');
      fmDataModule.query_temp.sql.Add('INNER JOIN ASSORTMENT ON ASSORTMENT.KOD=COMMODITY.ASSORTMENT_KOD AND ASSORTMENT.VALID=1');
      fmDataModule.query_temp.sql.Add('WHERE COMMODITY.POINT_KOD='+point_kod);
      fmDataModule.query_temp.sql.Add('  AND COMMODITY.DATE_IN_OUT<='+chr(39)+self.Edit_data_rediscount.text+chr(39));
      fmDataModule.query_temp.sql.Add('   GROUP BY COMMODITY.ASSORTMENT_KOD,ASSORTMENT.NAME,ASSORTMENT.PRICE');
      fmDataModule.query_temp.sql.Add('   HAVING SUM(COMMODITY.QUANTITY)<>0');
      fmDataModule.query_temp.sql.Add('ORDER BY ASSORTMENT.PRICE,ASSORTMENT.NAME');
      fmDataModule.query_temp.open;
      fmDataModule.load_from_query_field_to_stringgrid(fmDataModule.query_temp,self.StringGrid_point,true);
      if self.StringGrid_point.rowcount>1
      then begin
           self.StringGrid_point.fixedrows:=1;
           self.StringGrid_point.Cells[column_kod,0]:='Код';
           self.StringGrid_point.Cells[column_name,0]:='Наименование';
           self.StringGrid_point.Cells[column_quantity,0]:='Кол-во';
           self.StringGrid_point.Cells[column_price,0]:='Цена';
           self.StringGrid_point.Cells[column_amount,0]:='Сумма';
           end;                                                              
   except
      on e:exception
      do begin
         //showmessage('Error in load data of commodity for point:'+e.message);
         end;
   end;
end;

procedure TfmRediscount.combobox_pointsChange(Sender: TObject);
begin
   self.load_commodity_of_point;
   self.calculate_commodity_of_point;
   self.clear_StringGrid(self.stringgrid_match);
   button_commit.enabled:=false;
end;

procedure TfmRediscount.calculate_commodity_of_point;
var
   counter:integer;
   quantity:integer;
   amount:real;
begin
   if self.StringGrid_point.rowcount>1
   then begin
        quantity:=0;
        amount:=0;
        for counter:=1 to self.StringGrid_point.RowCount
        do begin
           try
              quantity:=quantity+strtoint(self.StringGrid_point.Cells[column_quantity,counter]);
           except
              on e:exception
              do begin
                 end;
           end;
           try
              amount:=amount+strtofloat(self.StringGrid_point.Cells[column_amount,counter]);
           except
              on e:exception
              do begin
                 end;
           end;
           end;
        self.dxEdit1.text:=inttostr(quantity);
        self.dxEdit2.text:=format('%.2f',[amount]);
        end
   else begin
        self.dxEdit1.text:='0';
        self.dxEdit2.text:='0';
        end;
end;

// загрузка в массивы <ассортиментного имени><кол-ва>
// проверка строки - строка длинной до 30 символов, в которой только цифры, пробел и знак ';'
function TfmRediscount.load_from_csv_file_to_stringlist(path_to_file: String;
  var assortment_name: Tstringlist;
  var assortment_quantity: Tstringlist): integer;
function check_string(s:string):boolean;
var
   set_of_char:set of char;
   value:boolean;
   counter:integer;
begin
   set_of_char:=['1','2','3','4','5','6','7','8','9','0',' ',';'];
   value:=false;
   if (length(s)<=30)
   then begin
        for counter:=1 to length(s)
        do begin
           if not(s[counter] in set_of_char)
           then begin
                value:=true;
                break;
                end;
           end;
        value:=not(value);
        end
   else begin
        value:=false;
        end;
   result:=value;
end;

function get_name_from_line(s:string):string;
var
   position:integer;
begin
   position:=pos(';',s);
   if position>0
   then begin
        result:=copy(s,1,position-1);
        end
   else begin
        result:=s;
        end;
end;

function get_quantity_from_line(s:string):string;
var
   quantity_string:string;
   return_value:string;
   position:integer;
begin
   position:=pos(';',s);
   if position>0
   then begin
        quantity_string:=copy(s,position+1,length(s)-position);
        try
           quantity_string:=trim(quantity_string);
           position:=pos(';',quantity_string);
           if position>0
           then begin
                quantity_string:=trim(copy(quantity_string,1,position-1));
                end;
           if trim(quantity_string)=''
           then begin
                quantity_string:='1'
                end;
           return_value:=quantity_string;
        except
           on e:exception
           do begin
              return_value:='0';
              end;
        end;
        end
   else begin
        return_value:='1';
        end;
   result:=return_value;
end;

var
   return_value:integer;
   csv_file:textfile;
   line_counter:integer;
   temp_string:string;
   position:integer;
begin
   return_value:=0;
   // предварительный подсчет элементов.
   if(fileexists(path_to_file))
   then begin
        try
           assignfile(csv_file,path_to_file);
           reset(csv_file);
           line_counter:=0;
           while not(eof(csv_file))
           do begin
              readln(csv_file,temp_string);
              if check_string(temp_string)
              then begin
                   line_counter:=line_counter+1;
                   end
              else begin
                   // String not Valid
                   end;
              end;
           closefile(csv_file);
        except
           on e:exception
           do begin
              try
                 closefile(csv_file)
              except
                 on e:exception
                 do begin
                    line_counter:=0;
                    end;
              end;
              end;
        end;
        // read valid line
        if (line_counter>0)
        then begin
             try
                assortment_name.clear;
                assortment_quantity.clear;
                assignfile(csv_file,path_to_file);
                reset(csv_file);
                line_counter:=0;
                while not(eof(csv_file))
                do begin
                   readln(csv_file,temp_string);
                   if check_string(temp_string)
                   then begin
                        assortment_name.Add(get_name_from_line(temp_string));
                        assortment_quantity.add(get_quantity_from_line(temp_string));
                        line_counter:=line_counter+1;
                        end
                   else begin
                        // String not Valid
                        end;
                   end;
                closefile(csv_file);
             except
                on e:exception
                do begin
                   try
                      closefile(csv_file)
                   except
                      on e:exception
                      do begin
                         line_counter:=0;
                         end;
                   end;
                end;
             end;
             end;
        end
   else begin
        // file not exists
        return_value:=0;
        end;
   result:=return_value;
end;

procedure TfmRediscount.Button_load_fileClick(Sender: TObject);
var
   list_name:tstringlist;
   list_quantity:tstringlist;
   list_price:tstringlist;
   list_kod:tstringlist;

   //list_temp:tstringlist;
   i:integer;
begin
   list_name:=tstringlist.create();
   list_quantity:=tstringlist.create();
   list_price:=tstringlist.create();
   list_kod:=tstringlist.create();
   //list_temp:=tstringlist.create();

   self.load_from_dat_file_to_stringlist(self.Edit_path_to_file.text,list_name,list_quantity);
   self.delete_doublbe(list_name,list_quantity);
   self.order_as_assortment(list_kod,list_name,list_price,list_quantity,fmDataModule.query_temp);
   self.load_to_StringGrid(list_kod,list_name,list_price,list_quantity,self.StringGrid_real);
   self.calculate_commodity_real;

   {for i:=0 to list_name.count-1
   do begin
      list_temp.add('kod:'+list_kod.strings[i]+'name:'+list_name.strings[i]+' price:'+list_price.strings[i]+' quantity:'+list_quantity.strings[i]);
      end;
   list_temp.SaveToFile('d:\out.txt');}
   freeandnil(list_name);
   freeandnil(list_quantity);
   freeandnil(list_price);
   freeandnil(list_kod);
   self.clear_StringGrid(self.stringgrid_match);
   button_commit.enabled:=false;
   //freeandnil(list_temp);
end;

procedure TfmRediscount.delete_doublbe(var assortment_name,
  assortment_quantity: tstringlist);

function get_integer_from_string(s:string):integer;
begin
   try
      result:=strtoint(s);
   except
      result:=0;
   end;
end;

var
   clear_assortment_name,clear_assortment_quantity:tstringlist;
   counter,counter_inner,index:integer;
   control_name:string;
   control_quantity:integer;
begin
   for counter:=0 to assortment_name.count-2
   do begin
      control_name:=assortment_name.Strings[counter];
      control_quantity:=get_integer_from_string(assortment_quantity.strings[counter]);
      for counter_inner:=counter+1 to assortment_name.count-1
      do begin
         if assortment_name.strings[counter_inner]<>''
         then begin
              if(assortment_name.strings[counter_inner])=control_name
              then begin
                   control_quantity:=control_quantity+get_integer_from_string(assortment_quantity.strings[counter_inner]);
                   assortment_name.strings[counter_inner]:='';
                   end;
              end
         else begin
              // строка уже обработана
              end
         end;
      assortment_quantity[counter]:=inttostr(control_quantity);
      end;
   clear_assortment_name:=tstringlist.create;
   clear_assortment_quantity:=tstringlist.create;
   for counter:=0 to assortment_name.count-1
   do begin
      if (assortment_name.strings[counter]<>'')
      then begin
           clear_assortment_name.Add(assortment_name.strings[counter]);
           clear_assortment_quantity.add(assortment_quantity.strings[counter]);
           end;
      end;
   assortment_name.Assign(clear_assortment_name);
   assortment_quantity.assign(clear_assortment_quantity);
   freeandnil(clear_assortment_name);
   freeandnil(clear_assortment_quantity);
end;

// упорядочить так как ассортимент
function TfmRediscount.order_as_assortment(var assortment_kod:tstringlist;var assortment_name,assortment_price,
  assortment_quantity: tstringlist; query: TIBQuery):boolean;
var
   order_assortment_name:tstringlist;
   order_assortment_quantity:tstringlist;
   order_assortment_price:tstringlist;
   order_assortment_kod:tstringlist;
   index:integer;
   find_name:string;
   error_name:string;
begin
   try
      order_assortment_name:=tstringlist.create;
      order_assortment_quantity:=tstringlist.create;
      order_assortment_price:=tstringlist.create;
      order_assortment_kod:=tstringlist.create;
      // перебросить найденный ассортимент
      query.sql.clear;
      query.sql.add('SELECT KOD, NAME, PRICE FROM ASSORTMENT ORDER BY PRICE,NAME');
      query.open;
      while not(query.eof)
      do begin
         find_name:=trim(query.fieldbyname('NAME').asstring);
         if assortment_name.IndexOf(find_name)>=0
         then begin
              index:=assortment_name.IndexOf(find_name);
              order_assortment_name.add(find_name);
              order_assortment_quantity.add(assortment_quantity.strings[index]);
              order_assortment_price.add(query.fieldbyname('PRICE').asstring);
              order_assortment_kod.add(query.fieldbyname('KOD').asstring);
              assortment_name.strings[index]:='';
              assortment_quantity.strings[index]:='';
              end;
         query.next;
         end;
      // не найденные позиции по базе
      error_name:='';
      for index:=0 to assortment_name.count-1
      do begin
         if assortment_name.strings[index]<>''
         then begin
              error_name:=error_name+assortment_name.strings[index]+chr(13)+chr(10);
              end;
         end;
      if error_name<>''
      then begin
           showmessage(' Не найденные позиции по базе '+chr(13)+chr(10)+error_name);
           end;
      assortment_name.Assign(order_assortment_name);
      assortment_quantity.assign(order_assortment_quantity);
      assortment_price.assign(order_assortment_price);
      assortment_kod.assign(order_assortment_kod);
      result:=true;
   except
      on e:exception
      do begin
         showmessage('TfmRediscount.order_as_assortment  Error:'+e.Message);
         result:=false;
         end;
   end

end;

procedure TfmRediscount.load_to_StringGrid(assortment_kod, assortment_name,
  assortment_price, assortment_quantity: tstringlist;
  stringgrid: TStringGrid);
var
   column_counter,row_counter:integer;
begin
   // очистка StringGrid
   for column_counter:=0 to stringgrid.colcount-1
   do begin
      stringgrid.Cols[column_counter].clear;
      end;
   // задание размеров для StringGrid
   stringgrid.rowcount:=assortment_name.count+1;
   stringgrid.colcount:=5;
   // Заполнение StringGrid
     // header
   stringgrid.cells[column_kod,0]:='Код';
   stringgrid.cells[column_name,0]:='Наименование';
   stringgrid.cells[column_quantity,0]:='Кол-во';
   stringgrid.cells[column_price,0]:='Цена';
   stringgrid.cells[column_amount,0]:='Сумма';
   if stringgrid.rowcount>1
   then stringgrid.FixedRows:=1;
     // body
   for row_counter:=0 to assortment_name.count-1
   do begin
      stringgrid.Cells[column_kod,row_counter+1]:=assortment_kod.Strings[row_counter];
      stringgrid.Cells[column_name,row_counter+1]:=assortment_name.Strings[row_counter];
      stringgrid.Cells[column_quantity,row_counter+1]:=assortment_quantity.Strings[row_counter];
      stringgrid.Cells[column_price,row_counter+1]:=assortment_price.Strings[row_counter];
      try
         stringgrid.Cells[column_amount,row_counter+1]:=format('%.0f',[strtoint(assortment_quantity.strings[row_counter])*strtofloat(assortment_price.strings[row_counter])]);
      except
         stringgrid.Cells[column_amount,row_counter+1]:='0.00';
      end;
      end;
end;

procedure TfmRediscount.calculate_commodity_real;
var
   index:integer;
   quantity:integer;
   amount:real;
begin
   quantity:=0;
   amount:=0;
   for index:=1 to self.stringgrid_real.rowcount-1
   do begin
      try
         quantity:=quantity+strtoint(self.StringGrid_real.cells[column_quantity,index]);
      except
         on e:exception
         do begin
            end;
      end;
      try
         amount:=amount+strtofloat(self.stringgrid_real.cells[column_amount,index]);
      except
         on e:exception
         do begin
            end;
      end;
      end;
   self.dxEdit3.text:=inttostr(quantity);
   self.dxEdit4.text:=format('%.2f',[amount]);
end;


// сопоставление двух TStringGrid
// kod_exists=true - возвращаем все что есть в StringGrid_source (и может не быть в StringGrid_destination)
// kod_exists=false - возвращаем все что есть в StringGrid_destination, но нет в StringGrid_source
// добавляем к TStringList
procedure TfmRediscount.match_stringgrids(stringgrid_source,
  stringgrid_destination: TstringGrid; var assortment_name,
  assortment_quantity: tstringlist;kod_exists:boolean);
function get_integer_from_string(s:string):integer;
begin
   try
      result:=strtoint(s);
   except
      result:=0;
   end;
end;

var
   i:integer;
   find_kod:string;
   index_in_destination:integer;
   difference:integer;
begin
   if kod_exists=true
   then begin
        // возвращаем все что есть в StringGrid_source
        for i:=1 to stringgrid_source.rowcount-1
        do begin
           find_kod:=stringgrid_source.cells[column_kod,i];
           index_in_destination:=stringgrid_destination.Cols[column_kod].IndexOf(find_kod);
           if index_in_destination>0
           then begin
                // позиция найдена - вычисление разницы
                difference:=get_integer_from_string(stringgrid_destination.Cells[column_quantity,index_in_destination])-get_integer_from_string(stringgrid_source.cells[column_quantity,i]);
                if difference<>0
                then begin
                     assortment_name.add(stringgrid_source.cells[column_name,i]);
                     assortment_quantity.add(inttostr(difference));
                     end;
                end
           else begin
                // позиция не найдена - прибавление
                assortment_name.add(stringgrid_source.cells[column_name,i]);
                assortment_quantity.add(inttostr((-1)*get_integer_from_string(stringgrid_source.cells[column_quantity,i])));
                end;
           end;
        end
   else begin
        // возвращаем все чего нет в StringGrid_source
        for i:=1 to stringgrid_destination.rowcount-1
        do begin
           find_kod:=stringgrid_destination.Cells[column_kod,i];
           index_in_destination:=stringgrid_source.Cols[column_kod].IndexOf(find_kod);
           if index_in_destination<0
           then begin
                // позиция не найдена - прибавляем
                assortment_name.add(stringgrid_destination.cells[column_name,i]);
                assortment_quantity.add(stringgrid_destination.cells[column_quantity,i]);
                end
           else begin
                // позиция найдена - никаких действий
                end;
           end;
        end;
end;

procedure TfmRediscount.button_previewClick(Sender: TObject);
var
   list_name:tstringlist;
   list_quantity:tstringlist;
   list_price:tstringlist;
   list_kod:tstringlist;

   //list_temp:tstringlist;
   i:integer;
begin
   list_name:=tstringlist.create();
   list_quantity:=tstringlist.create();
   list_price:=tstringlist.create();
   list_kod:=tstringlist.create();
   //list_temp:=tstringlist.create();


   //self.delete_doublbe(list_name,list_quantity);
   self.match_stringgrids(self.StringGrid_point,
                          self.StringGrid_real,
                          list_name,
                          list_quantity,
                          true);
   self.match_stringgrids(self.StringGrid_point,
                          self.StringGrid_real,
                          list_name,
                          list_quantity,
                          false);

   self.order_as_assortment(list_kod,
                            list_name,
                            list_price,
                            list_quantity,
                            fmDataModule.query_temp);
   self.load_to_StringGrid(list_kod,
                           list_name,
                           list_price,
                           list_quantity,
                           self.StringGrid_match);
   self.calculate_matching;

   {for i:=0 to list_name.count-1
   do begin
      list_temp.add('kod:'+list_kod.strings[i]+'name:'+list_name.strings[i]+' price:'+list_price.strings[i]+' quantity:'+list_quantity.strings[i]);
      end;
   list_temp.SaveToFile('d:\out.txt');}
   freeandnil(list_name);
   freeandnil(list_quantity);
   freeandnil(list_price);
   freeandnil(list_kod);
   button_commit.enabled:=true;
   //freeandnil(list_temp);
end;

procedure TfmRediscount.calculate_matching;
function get_integer_from_string(s:string):integer;
begin
   try
      result:=strtoint(s);
   except
      result:=0;
   end;
end;
function get_float_from_string(s:string):real;
begin
   try
      result:=strtofloat(s);
   except
      result:=0;
   end;
end;

var
   quantity_positive,quantity_negative:integer;
   amount_positive,amount_negative:real;
   quantity:integer;
   amount:real;
   i:integer;
begin
   quantity_positive:=0;
   quantity_negative:=0;
   amount_positive:=0;
   amount_negative:=0;
   for i:=1 to self.StringGrid_match.rowcount-1
   do begin
      quantity:=get_integer_from_string(self.StringGrid_match.cells[column_quantity,i]);
      amount:=get_float_from_string(self.stringgrid_match.cells[column_amount,i]);
      if quantity>0
      then begin
           quantity_positive:=quantity_positive+quantity;
           amount_positive:=amount_positive+amount;
           end
      else begin
           quantity_negative:=quantity_negative+quantity;
           amount_negative:=amount_negative+amount;
           end;
      end;
   self.dxEdit5.text:=inttostr(quantity_negative);
   self.dxEdit6.text:=format('%.2f',[amount_negative]);

   self.dxEdit7.text:=inttostr(quantity_positive);
   self.dxEdit8.text:=format('%.2f',[amount_positive]);
   self.dxEdit9.text:=format('%.2f',[amount_positive+amount_negative]);
end;

procedure TfmRediscount.button_commitClick(Sender: TObject);
function get_integer_from_string(s:string):integer;
begin
   try
      result:=strtoint(s);
   except
      result:=0;
   end;
end;

function get_float_from_string(s:string):real;
begin
   try
      result:=strtofloat(s);
   except
      result:=0;
   end;
end;

function get_man_kod:string;
var
   position:integer;
begin
   if combobox_seller.text<>''
   then begin
        position:=pos(' ',combobox_seller.text);
        result:=copy(combobox_seller.text,1,position-1);
        end
   else begin
        result:='';
        end;
end;

function get_point_kod:string;
begin
   result:=fmDataModule.get_name_by_id(fmDataModule.Query_temp,
                                       'POINTS',
                                       'NAME',
                                       chr(39)+self.combobox_points.text+chr(39),
                                       'KOD');
end;
var
   commodity:DataModule.Tcommodity;
   money:DataModule.TMoney;
   index:integer;
   field_date_in_out:string;
   field_man_kod:string;
   field_writer:string;
   field_write_date:string;
   field_point_kod:string;
   temp_string:string;
   flag_money_add:boolean;
begin
   flag_money_add:=false;
   if MessageDlg('Начислить зарплату продавцу ?',mtConfirmation, [mbYes, mbNo], 0) = mrYes
   then begin
        flag_money_add:=true;
        end
   else begin
        flag_money_add:=false;
        end;

try
   temp_string:='';
   field_date_in_out:=self.Edit_data_rediscount.Text;
   field_man_kod:=get_man_kod();
   if field_man_kod=''
   then raise Exception.create('Выберите продавца');
   field_point_kod:=get_point_kod();
   if field_point_kod=''
   then raise Exception.create('Выберите торговую точку');

   field_writer:='1';
   field_write_date:=datetimetostr(now);

   commodity:=DataModule.TCommodity.create;
   money:=DataModule.TMoney.create;
// "выравнивание" товара
   if (stringgrid_match.rowcount>=2) and (stringgrid_match.Cells[column_kod,1]<>'')
   then begin
        for index:=1 to stringgrid_match.rowcount-1
        do begin
           commodity.clear;
           commodity.field_assortment_kod:=stringgrid_match.Cells[column_kod,index];
           commodity.field_date_in_out:=field_date_in_out;
           commodity.field_man_kod:=field_man_kod;
           commodity.field_note:='REDISCOUNT';
           commodity.field_operation_kod:='7';
           commodity.field_point_kod:=field_point_kod;
           commodity.field_quantity:=stringgrid_match.Cells[column_quantity,index];
           commodity.field_writer:=field_writer;
           commodity.field_write_date:=field_write_date;
           temp_string:=commodity.save(fmDataModule.query_temp);
           if temp_string<>''
           then begin
                raise Exception.Create('REDISCOUNT.COMMIT.COMMODITY Error Обратитесь к разработчику '+temp_string);
                end;
           end;
// выравнивание суммы по продавцу, на котором данная торговая точка
        temp_string:='';
        money.clear;
        money.field_kod_point:=field_point_kod;
        money.field_kod_man:=field_man_kod;
        money.field_kod_writer:=field_writer;
        money.field_date_writer:=field_write_date;
        money.field_date_in_out:=field_date_in_out;
        money.field_note:='REDISCOUNT';
        if (get_float_from_string(self.dxEdit9.text))>0
        then begin
             // положительная сумма после переучета
             money.field_kod_expenses:='11';// Переучет положительно сказался на балансе продавце
             money.field_amount:='-'+self.dxEdit9.text;
             temp_string:=money.save(fmDataModule.query_temp);
             // если установлен флаг начисления З/П - отменит начисление, т.к. сумма положительная
             if flag_money_add=true
             then begin
                  flag_money_add:=false;
                  end;
             end
        else begin
             if(get_float_from_string(self.dxEdit9.text)<0)
             then begin
                  // отрицательная сумма после переучета - значит были продажи, нужно начислить з/п
                  money.field_kod_expenses:='11';// Переучет отрицательно сказался на продавца
                  try
                     money.field_amount:=floattostr(abs(strtofloat(self.dxEdit9.text)));
                  except
                     showmessage('Обратитесь к разработчику');
                  end;
                  temp_string:=money.save(fmDataModule.query_temp);
                  end
             else begin
                  // сумма равна 0 - не вносим никаких данных в таблицу Money
                  end;
             end;
// попытка начисления зарплаты
        if temp_string<>''
        then begin
             raise Exception.Create('REDISCOUNT.COMMIT.MONEY Error Обратитесь к разработчику '+temp_string);
             end
        else begin
             // нужно ли начислить з/п
             if flag_money_add
             then begin
                  money.field_kod:='';
                  money.field_kod_point:=field_point_kod;
                  money.field_kod_man:=field_man_kod;
                  money.field_kod_writer:=field_writer;
                  money.field_date_writer:=field_write_date;
                  money.field_date_in_out:=field_date_in_out;
                  money.field_note:='REDISCOUNT';
                  money.field_kod_expenses:='9';// Начислние зарплаты
                  try
                     money.field_amount:=format('%.2f',[abs(strtofloat(money.field_amount)*(0.1))]);
                  except
                     money.field_amount:='0';
                  end;
                  temp_string:=money.save(fmDataModule.query_temp);
                  if temp_string<>''
                  then showmessage('REDISCOUNT.COMMIT.MONEY Ошибка при начислении З/П - Обратитесь к разработчику');
                  end;
             end;
        self.Close;
        end
   else begin
        raise Exception.Create(' Нет данных для фиксирования переучета');
        end;
   freeandnil(commodity);
   freeandnil(money);
except
   on e:exception
   do begin
      if commodity<>nil
      then freeandnil(commodity);
      if money<>nil
      then freeandnil(money);
      showmessage(e.message);
      end;
end;
self.button_commit.enabled:=false;
end;

procedure TfmRediscount.clear_StringGrid(var stringgrid: TStringGrid);
var
   index:integer;
begin
   for index:=0 to stringgrid.colcount-1
   do begin
      stringgrid.Cols[index].clear;
      end;
end;

function TfmRediscount.load_from_dat_file_to_stringlist(
  path_to_file: String; var assortment_name,
  assortment_quantity: Tstringlist): integer;
var
   temp_value:string;
   key_count:integer;
   inifile:tinifile;
   i:integer;
begin
   assortment_name.Clear;
   assortment_quantity.clear;
   if fileexists(path_to_file)
   then begin
        // файл найден - обработка файла
        inifile:=Tinifile.Create(path_to_file);
        key_count:=inifile.ReadInteger('DATA','max_length',0);
        if key_count>0
        then begin
             // данные есть - читаем данные из ini-файла
             for i:=1 to key_count
             do begin
                temp_value:=inifile.readstring('DATA','key'+inttostr(i),'');
                if temp_value<>''
                then begin
                     assortment_name.Add(temp_value);
                     assortment_quantity.Add('1');
                     end;
                end;
             end
        else begin
             // нет данных для чтения
             end;
        freeandnil(inifile);
        end
   else begin
        // файл не найден
        end;
end;

procedure TfmRediscount.StringGrid_to_Excel(caption: string;
  stringgrid: TStringgrid);
var
   Excel:variant;
   row_counter,column_counter:integer;
begin
     if stringgrid.rowcount>0
     then begin
          try
             // создать Variant
             Excel := CreateOleObject('Excel.Application');
             excel:=CreateOleObject('Excel.Application');
             excel.workbooks.add;
             excel.visible:=false;
             // установка текстового формата вывода данных
             for column_counter:=0 to stringgrid.colcount-1
             do begin
                excel.worksheets[1].cells.numberformat:='@';
                end;
             excel.worksheets[1].Cells.item[1,1].value:=caption;
             // вывод данных
             for row_counter:=0 to stringgrid.rowcount-1
             do begin
                for column_counter:=0 to stringgrid.colcount-1
                do begin
                   excel.worksheets[1].Cells.item[row_counter+2,column_counter+1].value:=stringgrid.Cells[column_counter,row_counter];
                   end;
                end;
             excel.visible:=true;

          except
             on e:exception
             do begin
                if excel<>null
                then begin
                     try
                        excel.visible:=true;
                     except
                        on e2:exception
                        do begin
                           end;
                     end;
                     end;
                showmessage('Произошла ошибка при попытке вывода в Excel-файл:'+chr(13)+chr(10)+e.message);
                end;
          end;

          end
     else begin
          // нечего выводить в Excel
          end;
end;

procedure TfmRediscount.Excel1Click(Sender: TObject);
begin
   self.StringGrid_to_Excel('Наличие товара на торговой точке:'+self.combobox_points.text+' на дату: '+self.Edit_data_rediscount.text,self.StringGrid_point);
end;

procedure TfmRediscount.Excel2Click(Sender: TObject);
begin
   self.StringGrid_to_Excel('Данные считанные при переучете товара:'+self.combobox_points.text+' из файла: '+self.Edit_path_to_file.text,self.StringGrid_real);
end;

procedure TfmRediscount.Excel3Click(Sender: TObject);
begin
   self.StringGrid_to_Excel('Различие в данных при переучете торговой точки:'+self.combobox_points.text+self.combobox_points.text+' на дату: '+self.Edit_data_rediscount.text+' из файла: '+self.Edit_path_to_file.text,self.StringGrid_match);
end;

procedure TfmRediscount.button_edit_fileClick(Sender: TObject);
begin
   if fileexists(Self.Edit_path_to_file.text)
   then begin
        self.clear_StringGrid(self.stringgrid_real);
        self.StringGrid_real.rowcount:=1;
        fmRediscount_edit_file:=TfmRediscount_edit_file.create(self);
        fmRediscount_edit_file.edit_path_to_file.text:=self.edit_path_to_file.text;
        if fmRediscount_edit_file.load_to_stringgrid_data_not_in_assortment=true
        then begin
             if fmRediscount_edit_file.showmodal=mrOk
             then begin
                  self.Button_load_file.click;
                  freeAndNil(fmRediscount_edit_file);
                  end
             else begin
                  freeAndNil(fmRediscount_edit_file);
                  end;
             end
        else begin
             freeAndNil(fmRediscount_edit_file);
             showmessage('Нет данных для редактирования');
             end;

        end;
end;

end.
