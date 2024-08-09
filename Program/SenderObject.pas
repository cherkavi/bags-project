unit SenderObject;
interface
uses
  Classes,SysUtils,clipbrd;

type
   {Объект, который будет содержать все сведения о файле}
   TSenderObject=class
   private
      // расшифровка строки (mail_caption) у которой есть имя переучета, дата, номер точки, номер человека
      procedure decode_original_string;
      // получение максимального значения из строки
      function get_max_length_from_string(s:string):string;
      // преобразование из строки вида ":<11>:1000681" в строку вида "key11='1000681'"
      function get_decode_string_from_string(s:string):string;
      // получение номера строки данных
      function get_key_from_string(s:string):string;
      // получение данных из строки
      function get_value_from_string(s:string):string;
   public
      field_lines:tstringlist;
      field_user_name:string;
      field_original_string:string;
      field_name:string;
      field_date:string;
      field_points_number:string;
      field_man_number:string;
      field_data:tstringlist;
      field_data_max_length:string;
      constructor create(string_data:string);overload;
      constructor create();overload;
      constructor create(string_data: string;delimeter:string);overload;
      // загрузка из строки в StringList, который служит основой для декодирования данных
      procedure string_to_object(s:string);overload;
      procedure string_to_object(s:string;delimeter:string);overload;
      // расшифровка данных из объекта field_lines
      procedure decode;
      destructor destroy;
      procedure clear;
      function save_to_file(path_to_file:string):boolean;
   end;
implementation

{ TSenderObject }

constructor TSenderObject.create(string_data: string);
begin
   self.field_lines:=tstringlist.create;
   self.field_data:=tstringlist.create;
   self.clear;
   self.string_to_object(string_data);
end;

constructor TSenderObject.create(string_data: string;delimeter:string);
begin
   self.field_lines:=tstringlist.create;
   self.field_data:=tstringlist.create;
   self.clear;
   self.string_to_object(string_data,delimeter);
end;

procedure TSenderObject.clear;
begin
      field_lines.Clear;
      field_user_name:='';
      field_original_string:='';
      field_name:='';
      field_date:='';
      field_points_number:='';
      field_man_number:='';
      field_data.clear;
      field_data_max_length:='';
end;

constructor TSenderObject.create;
begin
  self.create('');
end;

// функция поиска и декодирования всех значений, которые есть в TStringList
procedure TSenderObject.decode;
var
   i:integer;
   flag_random:boolean;
   flag_data:boolean;
begin
   //self.clear;
   flag_random:=false;
   flag_data:=false;
   //self.field_lines.SaveToFile('c:\field_lines.txt');
   for i:=0 to self.field_lines.count-1
   do begin
      if self.field_user_name=''
      then begin
           // проверка на длинну
           if length(self.field_lines.Strings[i])>10
           then begin
                if copy(self.field_lines.strings[i],1,9)='USER_NAME'
                then begin
                     self.field_user_name:=copy(self.field_lines.strings[i],11,length(self.field_lines.strings[i])-10);
                     end;
                end;
           end;
      // основа для Даты, кода точки, Кода человека
      if self.field_original_string=''
      then begin
           // проверка на длинну
           if length(self.field_lines.strings[i])>14
           then begin
                if copy(self.field_lines.strings[i],1,12)='MAIL_CAPTION'
                then begin
                     self.field_original_string:=copy(self.field_lines.strings[i],14,length(self.field_lines.strings[i])-13);
                     self.decode_original_string;
                     end;
                end;
           end;
      if (flag_data=true) and (flag_random=false)
      then begin
           if length(self.field_lines.strings[i])>0
           then begin
                if length(self.field_lines.strings[i])>6
                then begin
                     if copy(self.field_lines.strings[i],1,6)='RANDOM'
                     then begin
                          flag_random:=true;
                          flag_data:=false;
                          end;
                     end;
                if flag_random=false
                then begin
                     // получение максимального числа
                     if self.field_data.count=0
                     then begin
                          self.field_data_max_length:=self.get_max_length_from_string(self.field_lines.strings[i]);
                          self.field_data.Add(self.get_decode_string_from_string(self.field_lines.strings[i]));
                          end
                     else begin
                          self.field_data.Add(self.get_decode_string_from_string(self.field_lines.strings[i]));
                          end;
                     end;
                end;
           end;
      // ожидание появления данных в строках
      if (flag_data=false) and (flag_random=false)
      then begin
           if length(self.field_lines.Strings[i])>4
           then begin
                if copy(self.field_lines.strings[i],1,4)='DATA'
                then flag_data:=true;
                end;
           end;
      if (flag_data=false) and (flag_random=true)
      then begin
           // последняя фаза данных
           end;
      end;
end;

destructor TSenderObject.destroy;
begin
   freeandnil(field_lines);
end;

function TSenderObject.save_to_file(path_to_file: string): boolean;
var
   text:textfile;
   i:integer;
begin
   try
      assignfile(text,path_to_file);
      rewrite(text);
      writeln(text,'[USER_NAME]');
      writeln(text,'value='+chr(39)+self.field_user_name+chr(39));
      writeln(text,'[ORIGINAL_STRING]');
      writeln(text,'value='+chr(39)+self.field_original_string+chr(39));
      writeln(text,'[NAME]');
      writeln(text,'value='+chr(39)+self.field_name+chr(39));
      writeln(text,'[DATE]');
      writeln(text,'value='+chr(39)+self.field_date+chr(39));
      writeln(text,'[POINTS_NUMBER]');
      writeln(text,'value='+self.field_points_number);
      writeln(text,'[MAN_NUMBER]');
      writeln(text,'value='+self.field_man_number);
      writeln(text,'[DATA]');
      writeln(text,'max_length='+self.field_data_max_length);
      for i:=0 to self.field_data.count-1
      do begin
         writeln(text,self.field_data.strings[i]);
         end;

      closefile(text);
      result:=true;
   except
      on e:exception
      do result:=false;
   end;
end;

procedure TSenderObject.string_to_object(s:string);
var
   position_cr:integer;
   temp_string:string;
begin
   self.field_lines:=tstringlist.Create;
   temp_string:=s;
   position_cr:=1;
   while position_cr>0
   do begin
      position_cr:=pos(chr(13)+chr(10),temp_string);
      if position_cr>0
      then begin
           // добавление данных в объект
           self.field_lines.add(ansiuppercase(trim(copy(temp_string,1,position_cr-1))));
           if length(temp_string)>position_cr+2
           then begin
                temp_string:=copy(temp_string,position_cr+2,length(temp_string)-position_cr-1);
                end
           else begin
                temp_string:='';
                end;
           end
      else begin
           field_lines.add(temp_string);
           end;
      end;
end;

procedure TSenderObject.string_to_object(s:string;delimeter:string);
var
   position_cr:integer;
   temp_string:string;
begin
   self.field_lines:=tstringlist.Create;
   temp_string:=s;
   //clipboard.astext:=temp_string;
   position_cr:=1;
   while position_cr>0
   do begin
      position_cr:=pos(delimeter,temp_string);
      if position_cr>0
      then begin
           //clipboard.astext:=temp_string;
           // добавление данных в объект
           //clipboard.astext:=ansiuppercase(trim(copy(temp_string,1,position_cr)));
           self.field_lines.add(ansiuppercase(trim(copy(temp_string,1,position_cr))));
           if length(temp_string)>position_cr+length(delimeter)
           then begin
                temp_string:=copy(temp_string,
                                  position_cr+length(delimeter),
                                  length(temp_string)-position_cr);
                end
           else begin
                temp_string:='';
                end;
           //clipboard.astext:=temp_string;
           end
      else begin
           field_lines.add(temp_string);
           end;
      end;
   //self.field_lines.SaveToFile('c:\temp_csv.txt');
end;

procedure TSenderObject.decode_original_string;
var
   position_begin,position_end:integer;
   temp_position_begin,temp_position_end:integer;
   temp_string:string;
begin
   position_begin:=pos('{',self.field_original_string);
   position_end:=pos('}',self.field_original_string);
   if position_begin>1
   then begin
        self.field_name:=copy(self.field_original_string,1,position_begin-1)
        end
   else begin
        self.field_name:='';
        end;
   if (position_begin<position_end) and (position_begin>0)
   then begin
        temp_string:=trim(copy(self.field_original_string,position_begin+1,position_end-position_begin-1));
        temp_position_begin:=pos('D*',temp_string);
        temp_position_end:=pos(' ',temp_string);
        if temp_position_begin>0
        then begin
             if temp_position_end<temp_position_begin
             then begin
                  self.field_date:=copy(temp_string,3,length(temp_string)-2)
                  end
             else begin
                  self.field_date:=copy(temp_string,temp_position_begin+2,temp_position_end-temp_position_begin-2);
                  temp_string:=trim(copy(temp_string,temp_position_end,length(temp_string)-temp_position_end+1));
                  end;
             end;
        temp_position_begin:=pos('P*',temp_string);
        temp_position_end:=pos(' ',temp_string);
        if temp_position_begin>0
        then begin
             if temp_position_end<temp_position_begin
             then self.field_points_number:=copy(temp_string,3,length(temp_string)-2)
             else begin
                  self.field_points_number:=copy(temp_string,temp_position_begin+2,temp_position_end-temp_position_begin-2);
                  temp_string:=trim(copy(temp_string,temp_position_end,length(temp_string)-temp_position_end+1));
                  end;
             end;
        temp_position_begin:=pos('M*',temp_string);
        temp_position_end:=pos(' ',temp_string);
        if temp_position_begin>0
        then begin
             if temp_position_end<temp_position_begin
             then self.field_man_number:=copy(temp_string,3,length(temp_string)-2)
             else begin
                  self.field_man_number:=copy(temp_string,temp_position_begin+2,temp_position_end-temp_position_begin-1);
                  temp_string:=trim(copy(temp_string,temp_position_end,length(temp_string)-temp_position_end));
                  end;
             end;

        end
   else begin
        self.field_name:='';
        self.field_date:='';
        self.field_points_number:='';
        self.field_man_number:='';
        end;
end;

function TSenderObject.get_decode_string_from_string(s: string): string;
var
   temp_key,temp_value:string;
begin
   temp_key:=self.get_key_from_string(s);
   temp_value:=self.get_value_from_string(s);
   if (length(temp_key)>0) and (length(temp_value)>0)
   then begin
        result:='key'+temp_key+'='+chr(39)+temp_value+chr(39)
        end
   else begin
        result:='';
        end;
end;

function TSenderObject.get_max_length_from_string(s: string): string;
begin
   result:=self.get_key_from_string(s);
end;

function TSenderObject.get_key_from_string(s: string): string;
var
   position_begin,position_end:integer;
begin
   position_begin:=pos(':<',s);
   position_end:=pos('>:',s);
   if (position_begin<position_end) and (position_begin>0)
   then begin
        result:=trim(copy(s,position_begin+2,position_end-position_begin-2));
        end
   else begin
        result:='';
        end;
end;

function TSenderObject.get_value_from_string(s: string): string;
var
   position_begin:integer;
begin
   position_begin:=pos('>:',s);
   if position_begin>0
   then begin
        result:=trim(copy(s,position_begin+2,length(s)-position_begin-1));
        end
   else begin
        result:='';
        end;
end;

end.
