unit StringGrid_Shell;

interface
uses grids,forms,Controls,Classes,SysUtils,windows;
//types,

type
   TStringGrid_Shell=class
   private
      function get_number_by_tail_determinated_dot(source:string):integer;
      function get_cursor_position_by_component(): TPoint;
   public
      field_stringgrid:TStringGrid;

      constructor create(stringGrid:TStringGrid);
      function get_click_column:integer;
      function get_click_row:integer;
      procedure sort_by_column(column_number:integer);
      procedure sort_by_column_without_header(column_number:integer);
   end;
implementation
{ TStringGrid_Shell }

constructor TStringGrid_Shell.create(stringGrid: TStringGrid);
begin
   self.field_stringgrid:=stringGrid;
end;

function TStringGrid_Shell.get_click_column: integer;
var
   x_position:integer;
   counter:integer;
   return_value:integer;
   inc_width:integer;
begin
   return_value:=(-1);
   // получить координаты по оси x
   x_position:=self.get_cursor_position_by_component.x;
   // вычислить на какую колонку выпадают данные координаты
   inc_width:=0;
   for counter:=0 to self.field_stringgrid.ColCount-1
   do begin
      if (inc_width<=x_position)
      and ((inc_width+self.field_stringgrid.ColWidths[counter])>x_position)
      then begin
           return_value:=counter;
           break;
           end;
      inc_width:=inc_width+self.field_stringgrid.ColWidths[counter];
      end;
   result:=return_value;
end;

function TStringGrid_Shell.get_click_row: integer;
var
   y_position:integer;
   counter:integer;
   return_value:integer;
   inc_height:integer;
begin
   return_value:=(-1);
   // получить координаты по оси x
   y_position:=self.get_cursor_position_by_component.y;
   // вычислить на какую колонку выпадают данные координаты
   inc_height:=0;
   for counter:=0 to self.field_stringgrid.RowCount-1
   do begin
      if (inc_height<=y_position)
      and ((inc_height+self.field_stringgrid.RowHeights[counter])>y_position)
      then begin
           return_value:=counter;
           break;
           end;
      inc_height:=inc_height+self.field_stringgrid.RowHeights[counter];
      end;
   result:=return_value;
end;

function TStringGrid_Shell.get_cursor_position_by_component: TPoint;
var
   temp_point:TPoint;
begin
   temp_point.X:=0;
   temp_point.Y:=0;
   if (self.field_stringgrid.Parent is TForm)
   then begin
        temp_point.X:=mouse.CursorPos.X-TForm(self.field_stringgrid.parent).Left-self.field_stringgrid.Left-6;
        temp_point.Y:=mouse.CursorPos.y-TForm(self.field_stringgrid.parent).top-self.field_stringgrid.top-25;
        end;
   result:=temp_point;
end;

function TStringGrid_Shell.get_number_by_tail_determinated_dot(
  source: string): integer;
var
   old_dot_position:integer;
   dot_position:integer;
   temp_string:string;
begin
   old_dot_position:=0;
   dot_position:=0;
   temp_string:=source;
   while dot_position<>(-1)
   do begin
      old_dot_position:=dot_position+old_dot_position;
      dot_position:=pos('.',temp_string);
      if dot_position>0
      then begin
           temp_string:=copy(temp_string,dot_position+1,length(temp_string)-dot_position);
           end
      else begin
           break;
           end;
      end;
   result:=old_dot_position;
end;

procedure TStringGrid_Shell.sort_by_column(column_number: integer);
var
   temp_stringlist:Tstringlist;
   temp_stringgrid:TStringGrid;
   column_counter,row_counter:integer;
   row_source:integer;
begin
   temp_stringlist:=Tstringlist.create;
   // создать дополнительный столбец для StringGrid
   self.field_stringgrid.ColCount:=self.field_stringgrid.ColCount+1;
     // шириной -1, в котором будут находится столбцы с номерами
   self.field_stringgrid.ColWidths[self.field_stringgrid.ColCount-1]:=(-1);
   for row_counter:=0 to self.field_stringgrid.RowCount-1
   do begin
      self.field_stringgrid.Cells[self.field_stringgrid.ColCount-1,row_counter]:=inttostr(row_counter);
      end;
   // скопировать искомый столбец в TStringlist и прибавить к каждой строке '.'+номер строки
   temp_stringlist.Clear;
   for row_counter:=0 to self.field_stringgrid.RowCount-1
   do begin
      temp_stringlist.Add(self.field_stringgrid.Cells[column_number,row_counter]+'.'+self.field_stringgrid.Cells[self.field_stringgrid.ColCount-1,row_counter]);
      end;
   // отсортировать TStringList
   temp_stringlist.Sort;
   // создать копию TStringGrid
   temp_stringgrid:=TStringGrid.Create(self.field_stringgrid.Parent);
   temp_stringgrid.RowCount:=self.field_stringgrid.RowCount;
   temp_stringgrid.ColCount:=self.field_stringgrid.ColCount;
   for column_counter:=0 to self.field_stringgrid.ColCount-1
   do begin
      for row_counter:=0 to self.field_stringgrid.RowCount-1
      do begin
         temp_stringgrid.Cells[column_counter,row_counter]:=self.field_stringgrid.Cells[column_counter,row_counter];
         end;
      end;
   // удалить дополнительный столбец
   self.field_stringgrid.ColCount:=self.field_stringgrid.ColCount-1;
   // очистить field_StringGrid
   for column_counter:=0 to self.field_stringgrid.Colcount-1
   do begin
      self.field_stringgrid.Cols[column_counter].Clear;
      end;
   // заполнить согласно номеру в TStringList
   for row_counter:=0 to temp_stringlist.count-1 //self.field_stringgrid.RowCount-1 
   do begin
      // получить номер строки, из которой нужно будет брать данные
      row_source:=strtoint(copy(temp_stringlist.Strings[row_counter],
                                get_number_by_tail_determinated_dot(temp_stringlist.Strings[row_counter])+1,
                                length(temp_stringlist.Strings[row_counter])-get_number_by_tail_determinated_dot(temp_stringlist.Strings[row_counter])
                                )
                           );
      for column_counter:=0 to self.field_stringgrid.ColCount-1
      do begin
         self.field_stringgrid.Cells[column_counter,row_counter]:=temp_stringgrid.Cells[column_counter,row_source]
         end;
      end;
   freeandnil(temp_stringlist);
   freeandnil(temp_StringGrid);
end;

procedure TStringGrid_Shell.sort_by_column_without_header(
  column_number: integer);
var
   temp_stringlist:Tstringlist;
   temp_stringgrid:TStringGrid;
   column_counter,row_counter:integer;
   row_source:integer;
begin
   temp_stringlist:=Tstringlist.create;
   // создать дополнительный столбец для StringGrid
   self.field_stringgrid.ColCount:=self.field_stringgrid.ColCount+1;
     // шириной -1, в котором будут находится столбцы с номерами
   self.field_stringgrid.ColWidths[self.field_stringgrid.ColCount-1]:=(-1);
   for row_counter:=0 to self.field_stringgrid.RowCount-1
   do begin
      self.field_stringgrid.Cells[self.field_stringgrid.ColCount-1,row_counter]:=inttostr(row_counter);
      end;
   // скопировать искомый столбец в TStringlist и прибавить к каждой строке '.'+номер строки
   temp_stringlist.Clear;
   for row_counter:=1 to self.field_stringgrid.RowCount-1
   do begin
      temp_stringlist.Add(self.field_stringgrid.Cells[column_number,row_counter]+'.'+self.field_stringgrid.Cells[self.field_stringgrid.ColCount-1,row_counter-1]);
      end;
   // отсортировать TStringList
   temp_stringlist.Sort;
   // создать копию TStringGrid
   temp_stringgrid:=TStringGrid.Create(self.field_stringgrid.Parent);
   temp_stringgrid.RowCount:=self.field_stringgrid.RowCount;
   temp_stringgrid.ColCount:=self.field_stringgrid.ColCount;
   for column_counter:=0 to self.field_stringgrid.ColCount-1
   do begin
      for row_counter:=0 to self.field_stringgrid.RowCount-1
      do begin
         temp_stringgrid.Cells[column_counter,row_counter]:=self.field_stringgrid.Cells[column_counter,row_counter];
         end;
      end;
   // удалить дополнительный столбец
   self.field_stringgrid.ColCount:=self.field_stringgrid.ColCount-1;
   // очистить field_StringGrid
   for column_counter:=0 to self.field_stringgrid.Colcount-1
   do begin
      self.field_stringgrid.Cols[column_counter].Clear;
      end;
      // заполнить шапку
   for column_counter:=0 to self.field_stringgrid.ColCount-1
   do begin
      self.field_stringgrid.Cells[column_counter,0]:=temp_stringgrid.Cells[column_counter,0];
      end;
   // заполнить согласно номеру в TStringList
   for row_counter:=0 to temp_stringlist.count-1 // temp_stringlist.count-1
   do begin
      // получить номер строки, из которой нужно будет брать данные
      row_source:=strtoint(copy(temp_stringlist.Strings[row_counter],
                                get_number_by_tail_determinated_dot(temp_stringlist.Strings[row_counter])+1,
                                length(temp_stringlist.Strings[row_counter])-get_number_by_tail_determinated_dot(temp_stringlist.Strings[row_counter])
                                )
                           );
      for column_counter:=0 to self.field_stringgrid.ColCount-1
      do begin
         self.field_stringgrid.Cells[column_counter,row_counter+1]:=temp_stringgrid.Cells[column_counter,row_source+1]
         end;
      end;
   freeandnil(temp_stringlist);
   freeandnil(temp_StringGrid);
end;

end.
