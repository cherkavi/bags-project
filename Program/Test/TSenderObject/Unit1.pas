unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,SenderObject;

type
  TForm1 = class(TForm)
    edit_path: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    senderobject:TSenderObject;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
   text_file:textfile;
   file_content:string;
   temp_string:string;
begin
  if fileexists(self.edit_path.text)
  then begin
       assignfile(text_file,self.edit_path.text);
       reset(text_file);
       file_content:='';
       while not(eof(text_file))
       do begin
          readln(text_file,temp_string);
          file_content:=file_content+temp_string+chr(13)+chr(10);
          end;
       closefile(text_file);
       self.senderobject:=Tsenderobject.create(file_content);
       self.senderobject.decode;
       freeAndNil(self.senderobject);
       end;

end;

end.
 