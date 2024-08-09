unit GetCom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,inifiles, VaClasses, VaComm, ExtCtrls,senderobject,clipbrd;

type
  TfmGetCom = class(TForm)
    memo_history: TMemo;
    ComPort: TVaComm;
    Timer_indicator: TTimer;
    Panel1: TPanel;
    label_indicator: TLabel;
    Panel2: TPanel;
    button_close: TButton;
    button_clear_buffer: TButton;
    procedure FormShow(Sender: TObject);
    procedure ComPortRxChar(Sender: TObject; Count: Integer);
    procedure button_clear_bufferClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer_indicatorTimer(Sender: TObject);
    procedure button_closeClick(Sender: TObject);
  private
    { Private declarations }
    field_string_from_comport:string;
  public
    { Public declarations }
    field_ini_file_name:string;
    field_rediscount_path:string;
    field_rediscount_max:integer;
    field_rediscount_name:string;
    // возвращает позицию начального маркера
    function get_position_begin_data(value:string):integer;
    // возвращает позицию конечного маркера
    function get_position_end_data(value:string):integer;
    // возвращает положительный результат если есть маркер начала и маркер конца
    function is_marker_begin_and_end(value:string):boolean;
    procedure processing_data;
  end;

var
  fmGetCom: TfmGetCom;

implementation

{$R *.DFM}

procedure TfmGetCom.FormShow(Sender: TObject);
var
    ini_file:Tinifile;
    port_num:integer;
begin
    port_num:=1;
    try
        comport.PortNum:=port_num;
        if(self.field_ini_file_name<>'')
        then begin
             if SysUtils.FileExists(field_ini_file_name)
             then begin
                  ini_file:=TiniFile.create(field_ini_file_name);
                  if (ini_file.ValueExists('COM_PORT','NUMBER'))
                  then begin
                       port_num:=ini_file.ReadInteger('COM_PORT','NUMBER',1);
                       end
                  else begin
                       ini_file.WriteInteger('COM_PORT','NUMBER',1);
                       ini_file.UpdateFile;
                       end;
                  ini_file.free;
                  end;
             end
        else begin
             end;
        //comPort.ResetPortParameters;
        comport.portnum:=port_num;
        comport.ResetPortParameters;
        comport.close;
        ComPort.Open;
        self.field_string_from_comport:='';
    except
        on e:exception
        do begin
           showmessage('ќшибка во врем€ попытки инициализации порта '+inttostr(port_num));
           end;
    end;
end;

{
function save_value_from_port()
var
 content_mail:string;
 i:integer;
 sender_object:TSenderObject;
 filename:string;
begin
   try
      memo.lines.add(datetimetostr(now)+' : Ќачало приема почты');
      pop3.port:=self.field_pop3_port;
      pop3.host:=self.field_pop3_host;
      pop3.UserID:=self.field_pop3_login;
      pop3.Password:=self.field_pop3_password;
      pop3.DeleteOnRead:=true;
      pop3.Connect;
      if pop3.mailcount=0
      then begin
           memo.lines.add(datetimetostr(now)+' : ѕисем нет');
           end;
      for i:=1 to pop3.MailCount
      do begin
         content_mail:=self.read_from_pop3_to_string_control_address(pop3,i,self.field_source_mail_address);
         if content_mail<>''
         then begin
              memo.lines.add(datetimetostr(now)+' : ѕолучено письмо с данными');
              sender_object:=TSenderObject.create(content_mail);
              sender_object.decode;
              postfix_start_counter:=postfix_start_counter+1;
              //filename:=path_to_file+prefix_filename+inttostr(postfix_start_counter)+extended_filename;
              filename:=path_to_file+'rediscount'+inttostr(postfix_start_counter)+extended_filename;
              sender_object.save_to_file(filename);
              freeandnil(sender_object);
              end
         else begin
              memo.lines.add(datetimetostr(now)+' : ѕолучено чужое письмо');
              end;
         end;
      pop3.disconnect;
   except
      on e:exception
      do begin
         memo.lines.add(datetimetostr(now)+' : ќшибка при попытке чтени€ писем с сервера'+chr(13)+chr(10)+e.Message);
         end;
   end;
   memo.lines.add(datetimetostr(now)+' : «акончено чтение писем ');
   memo.lines.add('');
   result:=postfix_start_counter;
end;
}
function TfmGetCom.get_position_begin_data(value:string):integer;
begin
    result:=(pos('[BEGIN]',value));
end;

function TfmGetCom.get_position_end_data(value:string):integer;
var
    temp_position:integer;
    temp_position_end:integer;
begin
    temp_position:=get_position_begin_data(value);
    if temp_position>0
    then begin
         temp_position_end:=(pos('[',copy(value,temp_position+1,length(value)-temp_position-1)));
         if temp_position_end>0
         then result:=temp_position+temp_position_end
         else result:=temp_position_end;
         end
    else begin
         result:=(pos('[',value));
         end;

end;

function TfmGetCom.is_marker_begin_and_end(value:string):boolean;
begin
    if  (get_position_begin_data(value)<get_position_end_data(value))
    and (get_position_begin_data(value)>0)
    then begin
         result:=true;
         end
    else begin
         result:=false;
         end;
end;

// данные начала и конца строки наход€тс€ в self.field_string_from_comport
procedure TfmGetCom.processing_data;
var
   temp_position:integer;
   temp_string:string;
   marker_begin:string;
   marker_end:string;
   sender_object:TSenderObject;
   filename:string;
begin
    marker_begin:='[BEGIN]';
    marker_end:='[';
    temp_string:=self.field_string_from_comport;
    // находим последнее вхождение [BEGIN]
    temp_position:=pos(marker_begin,temp_string);
    //clipboard.astext:=temp_string;
    while(temp_position>0)
    do begin

       if pos(marker_begin,temp_string)>0
       then begin
            // отрезаем чтобы испортить [BEGIN] и оставить EGIN] и оп€ть искать [BEGIN]
            temp_string:=copy(temp_string,temp_position+2,length(temp_string)-temp_position-1);
            temp_position:=pos(marker_begin,temp_string)
            end
       else begin
            temp_string:=copy(temp_string,temp_position,length(temp_string)-temp_position-1);
            break;
            end;
       end;
    // temp_position - позици€ [BEGIN] в строке temp_string
//    clipboard.astext:=temp_string;
    temp_string:=copy(temp_string,temp_position+length(marker_begin)-1,length(temp_string)-temp_position-length(marker_begin)-1);
//    clipboard.astext:=temp_string;
    temp_string:='U'+temp_string;// первый символ, который мы отрезаем в приложении дл€ мобильного телефона
    self.memo_history.lines.add('получены данные ');
    // находим позицию END
    self.field_string_from_comport:='';
    sender_object:=TSenderObject.create(temp_string,chr(10));
    sender_object.decode;
    field_rediscount_max:=field_rediscount_max+1;
    //filename:=path_to_file+prefix_filename+inttostr(postfix_start_counter)+extended_filename;
    filename:=self.field_rediscount_path+'rediscount'+inttostr(field_rediscount_max)+'.dat';
    sender_object.save_to_file(filename);
    freeandnil(sender_object);
    // получено
end;

procedure TfmGetCom.ComPortRxChar(Sender: TObject; Count: Integer);
begin

    if(memo_history.lines.count=0)
    then begin
         memo_history.Lines.add('.');
         end
    else begin
         if(length(memo_history.lines.strings[memo_history.lines.count-1])>50)
         then memo_history.lines.strings[memo_history.lines.count-1]:='';
         memo_history.Lines.Strings[memo_history.lines.count-1]:=memo_history.Lines.Strings[memo_history.lines.count-1]+'.';
         //Insert(memo_history.Lines.count-1,'.');
         end;
    self.field_string_from_comport:=self.field_string_from_comport+comport.ReadText;
    if(self.label_indicator.visible=false)
    then begin
         self.label_indicator.visible:=true;
         self.Timer_indicator.Enabled:=true;
         end;
    if (is_marker_begin_and_end(self.field_string_from_comport))
    then begin
         self.processing_data;
         end;
end;

procedure TfmGetCom.button_clear_bufferClick(Sender: TObject);
begin
    //self.memo_history.lines.add(self.field_string_from_comport);
    clipboard.astext:=self.field_string_from_comport;
    self.field_string_from_comport:='';
end;

procedure TfmGetCom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if(self.comport.Active)
    then self.comport.close;
end;

procedure TfmGetCom.Timer_indicatorTimer(Sender: TObject);
begin
    self.label_indicator.visible:=false;
    self.Timer_indicator.Enabled:=false;
end;

procedure TfmGetCom.button_closeClick(Sender: TObject);
begin
    modalresult:=mrCancel;
end;

end.
