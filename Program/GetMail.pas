unit GetMail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Psock, NMpop3, StdCtrls, ExtCtrls,SenderObject;

type
  TfmGetMail = class(TForm)
    NMpop3: TNMPOP3;
    memo_history: TMemo;
    Panel1: TPanel;
    button_get_mail: TButton;
    procedure FormCreate(Sender: TObject);
    procedure button_get_mailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    field_source_mail_address:string;
    field_pop3_host:string;
    field_pop3_port:integer;
    field_pop3_login:string;
    field_pop3_password:string;
    field_rediscount_path:string;
    field_rediscount_max:integer;
    field_rediscount_name:string;
    procedure load_startup_data;
    // чтение адреса отправителя письма
    function read_from_pop3_to_string_control_address(pop3:TNMPop3;mail_index:integer;control_address:string):string;
    // возвращает максимальное значение файла переучета, который хранится
    function read_from_pop3_to_hdd(pop3:TNMPOP3;
                                    path_to_file:string;
                                    prefix_filename:string;
                                    extended_filename:string;
                                    postfix_start_counter:integer;
                                    memo:TMemo):integer;
  end;

var
  fmGetMail: TfmGetMail;

implementation

{$R *.DFM}


procedure TfmGetMail.FormCreate(Sender: TObject);
begin
   self.load_startup_data;
end;

procedure TfmGetMail.button_get_mailClick(Sender: TObject);
begin
   self.field_rediscount_max:=self.read_from_pop3_to_hdd(self.NMpop3,self.field_rediscount_path,self.field_rediscount_name,'.dat',self.field_rediscount_max,self.memo_history);
end;

procedure TfmGetMail.load_startup_data;
begin
   self.field_source_mail_address:='technik7job@rambler.ru';
   self.field_pop3_host:='pop3.rambler.ru';
   self.field_pop3_port:=110;
   self.field_pop3_login:='bagsmainserver';
   self.field_pop3_password:='xxxxx';
   self.memo_history.clear;
end;


function TfmGetMail.read_from_pop3_to_hdd(pop3: TNMPOP3; path_to_file,
  prefix_filename: string; extended_filename:string; postfix_start_counter: integer; memo: TMemo):integer;
var
 content_mail:string;
 i:integer;
 sender_object:TSenderObject;
 filename:string;
begin
   try
      memo.lines.add(datetimetostr(now)+' : Начало приема почты');
      pop3.port:=self.field_pop3_port;
      pop3.host:=self.field_pop3_host;
      pop3.UserID:=self.field_pop3_login;
      pop3.Password:=self.field_pop3_password;
      pop3.DeleteOnRead:=true;
      pop3.Connect;
      if pop3.mailcount=0
      then begin
           memo.lines.add(datetimetostr(now)+' : Писем нет');
           end;
      for i:=1 to pop3.MailCount
      do begin
         content_mail:=self.read_from_pop3_to_string_control_address(pop3,i,self.field_source_mail_address);
         if content_mail<>''
         then begin
              memo.lines.add(datetimetostr(now)+' : Получено письмо с данными');
              sender_object:=TSenderObject.create(content_mail);
              sender_object.decode;
              postfix_start_counter:=postfix_start_counter+1;
              //filename:=path_to_file+prefix_filename+inttostr(postfix_start_counter)+extended_filename;
              filename:=path_to_file+'rediscount'+inttostr(postfix_start_counter)+extended_filename;
              sender_object.save_to_file(filename);
              freeandnil(sender_object);
              end
         else begin
              memo.lines.add(datetimetostr(now)+' : Получено чужое письмо');
              end;
         end;
      pop3.disconnect;
   except
      on e:exception
      do begin
         memo.lines.add(datetimetostr(now)+' : Ошибка при попытке чтения писем с сервера'+chr(13)+chr(10)+e.Message);
         end;
   end;
   memo.lines.add(datetimetostr(now)+' : Закончено чтение писем ');
   memo.lines.add('');
   result:=postfix_start_counter;
end;

function TfmGetMail.read_from_pop3_to_string_control_address(pop3: TNMPop3;
  mail_index: integer; control_address: string): string;
   function get_address_inner_treangle(s:string):string;
   var
      position_begin,position_end:integer;
      temp_value:string;
   begin
      if (pos('<',s)>0) and (pos('>',s)>0)
      then begin
           position_begin:=pos('<',s);
           position_end:=pos('>',s);
           temp_value:=copy(s,position_begin+1,position_end-position_begin-1);
           result:=temp_value;
           end
      else result:=s;
   end;
var
   return_value:string;
   temp_string:string;
begin
   try
      return_value:='';
      if pop3.Connected
      then begin
           pop3.GetMailMessage(mail_index);
           temp_string:=get_address_inner_treangle(pop3.MailMessage.from);

           if ansiuppercase(trim(get_address_inner_treangle(pop3.MailMessage.from)))=
              ansiuppercase(trim(control_address))
           then begin
                return_value:=pop3.MailMessage.RawBody.text
                end
           else begin
                return_value:='';
                end;
           end;
   except
      on e:exception
      do return_value:='';
   end;
   result:=return_value;
end;

end.
