unit Browser_dovidka;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfmBrowser_dovidka = class(TForm)
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Button_Dovidka_3: TButton;
    Button_Dovidka_4: TButton;
    button_dovidka_3_2: TButton;
    button_dovidka_4_2: TButton;
    GroupBox4: TGroupBox;
    button_dovidka_7: TButton;
    button_dovidka_8: TButton;
    button_dovidka_7_2: TButton;
    button_dovidka_8_2: TButton;
    Button_dovidka_7_3: TButton;
    Button_dovidka_8_3: TButton;
    button_dovidka_6: TButton;
    button_dovidka_1: TButton;
    button_dovidka_2: TButton;
    button_dovidka_1_2: TButton;
    button_dovidka_2_2: TButton;
    button_dovidka_1_3: TButton;
    button_dovidka_2_3: TButton;
    GroupBox1: TGroupBox;
    button_dovidka_10: TButton;
    GroupBox5: TGroupBox;
    button_dovidka_11: TButton;
    button_dovidka_12: TButton;
    button_dovidka_9_2: TButton;
    button_dovidka_9_3: TButton;
    button_dovidka_9: TButton;
    button_dovidka_13: TButton;
    button_dovidka_14: TButton;
    procedure button_dovidka_1Click(Sender: TObject);
    procedure button_dovidka_1_2Click(Sender: TObject);
    procedure button_dovidka_1_3Click(Sender: TObject);
    procedure button_dovidka_2Click(Sender: TObject);
    procedure button_dovidka_2_2Click(Sender: TObject);
    procedure button_dovidka_2_3Click(Sender: TObject);
    procedure Button_Dovidka_4Click(Sender: TObject);
    procedure button_dovidka_4_2Click(Sender: TObject);
    procedure Button_Dovidka_3Click(Sender: TObject);
    procedure button_dovidka_3_2Click(Sender: TObject);
    procedure button_dovidka_6Click(Sender: TObject);
    procedure button_dovidka_7Click(Sender: TObject);
    procedure button_dovidka_7_2Click(Sender: TObject);
    procedure Button_dovidka_7_3Click(Sender: TObject);
    procedure button_dovidka_8Click(Sender: TObject);
    procedure button_dovidka_8_2Click(Sender: TObject);
    procedure Button_dovidka_8_3Click(Sender: TObject);
    procedure button_dovidka_9Click(Sender: TObject);
    procedure button_dovidka_9_2Click(Sender: TObject);
    procedure button_dovidka_9_3Click(Sender: TObject);
    procedure button_dovidka_10Click(Sender: TObject);
    procedure button_dovidka_11Click(Sender: TObject);
    procedure button_dovidka_12Click(Sender: TObject);
    procedure button_dovidka_13Click(Sender: TObject);
    procedure button_dovidka_14Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBrowser_dovidka: TfmBrowser_dovidka;

implementation

uses Dovidka_1, Dovidka_1_2, Dovidka_1_3, Dovidka_2, Dovidka_2_2,
  Dovidka_2_3, Dovidka_4, Dovidka_4_2, Dovidka_3, Dovidka_3_2, Dovidka_6,
  Dovidka_7, Dovidka_7_2, Dovidka_7_3, Dovidka_8, Dovidka_8_2, dovidka_8_3,
  Dovidka_9, dovidka_9_2, dovidka_9_3,dovidka_10, dovidka_10_2, dovidka_11,
  Dovidka_12, Dovidka_13, Dovidka_14;

{$R *.DFM}

procedure TfmBrowser_dovidka.button_dovidka_1Click(Sender: TObject);
begin
   fmDovidka_1:=TfmDovidka_1.create(self);
   fmDovidka_1.showmodal;
   freeandnil(fmDovidka_1);
end;

procedure TfmBrowser_dovidka.button_dovidka_1_2Click(Sender: TObject);
begin
   fmDovidka_1_2:=TfmDovidka_1_2.create(self);
   fmDovidka_1_2.showmodal;
   freeandnil(fmDovidka_1_2);
end;

procedure TfmBrowser_dovidka.button_dovidka_1_3Click(Sender: TObject);
begin
   fmDovidka_1_3:=TfmDovidka_1_3.create(self);
   fmDovidka_1_3.showmodal;
   freeandnil(fmDovidka_1_3);
end;

procedure TfmBrowser_dovidka.button_dovidka_2Click(Sender: TObject);
begin
   fmDovidka_2:=TfmDovidka_2.create(self);
   fmDovidka_2.showmodal;
   freeandnil(fmDovidka_2);
end;

procedure TfmBrowser_dovidka.button_dovidka_2_2Click(Sender: TObject);
begin
   fmDovidka_2_2:=TfmDovidka_2_2.create(self);
   fmDovidka_2_2.showmodal;
   freeandnil(fmDovidka_2_2);
end;

procedure TfmBrowser_dovidka.button_dovidka_2_3Click(Sender: TObject);
begin
   fmDovidka_2_3:=TfmDovidka_2_3.create(self);
   fmDovidka_2_3.showmodal;
   freeandnil(fmDovidka_2_3);
end;

procedure TfmBrowser_dovidka.Button_Dovidka_4Click(Sender: TObject);
begin
   fmDovidka_4:=TfmDovidka_4.create(self);
   fmDovidka_4.showmodal;
   freeandnil(fmDovidka_4);
end;

procedure TfmBrowser_dovidka.button_dovidka_4_2Click(Sender: TObject);
begin
   fmDovidka_4_2:=TfmDovidka_4_2.create(self);
   fmDovidka_4_2.showmodal;
   freeandnil(fmDovidka_4_2);
end;

procedure TfmBrowser_dovidka.Button_Dovidka_3Click(Sender: TObject);
begin
   fmDovidka_3:=TfmDovidka_3.create(self);
   fmDovidka_3.showmodal;
   freeandnil(fmDovidka_3);
end;

procedure TfmBrowser_dovidka.button_dovidka_3_2Click(Sender: TObject);
begin
   fmDovidka_3_2:=TfmDovidka_3_2.create(self);
   fmDovidka_3_2.showmodal;
   freeandnil(fmDovidka_3_2);
end;

procedure TfmBrowser_dovidka.button_dovidka_6Click(Sender: TObject);
begin
   fmDovidka_6:=TfmDovidka_6.create(self);
   fmDovidka_6.showmodal;
   freeandnil(fmDovidka_6);
end;

procedure TfmBrowser_dovidka.button_dovidka_7Click(Sender: TObject);
begin
   fmDovidka_7:=TfmDovidka_7.create(self);
   fmDovidka_7.showmodal;
   freeandnil(fmDovidka_7);
end;

procedure TfmBrowser_dovidka.button_dovidka_7_2Click(Sender: TObject);
begin
   fmDovidka_7_2:=TfmDovidka_7_2.create(self);
   fmDovidka_7_2.showmodal;
   freeandnil(fmDovidka_7_2);

end;

procedure TfmBrowser_dovidka.Button_dovidka_7_3Click(Sender: TObject);
begin
   fmDovidka_7_3:=TfmDovidka_7_3.create(self);
   fmDovidka_7_3.showmodal;
   freeandnil(fmDovidka_7_3);
end;

procedure TfmBrowser_dovidka.button_dovidka_8Click(Sender: TObject);
begin
   fmDovidka_8:=TfmDovidka_8.create(self);
   fmDovidka_8.showmodal;
   freeandnil(fmDovidka_8);
end;

procedure TfmBrowser_dovidka.button_dovidka_8_2Click(Sender: TObject);
begin
   fmDovidka_8_2:=TfmDovidka_8_2.create(self);
   fmDovidka_8_2.showmodal;
   freeandnil(fmDovidka_8_2);
end;

procedure TfmBrowser_dovidka.Button_dovidka_8_3Click(Sender: TObject);
begin
   fmDovidka_8_3:=TfmDovidka_8_3.create(self);
   fmDovidka_8_3.showmodal;
   freeandnil(fmDovidka_8_3);
end;

procedure TfmBrowser_dovidka.button_dovidka_9Click(Sender: TObject);
begin
   fmDovidka_9:=TfmDovidka_9.create(self);
   fmDovidka_9.showmodal;
   freeandnil(fmDovidka_9);
end;

procedure TfmBrowser_dovidka.button_dovidka_9_2Click(Sender: TObject);
begin
   fmDovidka_9_2:=TfmDovidka_9_2.create(self);
   fmDovidka_9_2.showmodal;
   freeandnil(fmDovidka_9_2);
end;

procedure TfmBrowser_dovidka.button_dovidka_9_3Click(Sender: TObject);
begin
   fmDovidka_9_3:=TfmDovidka_9_3.create(self);
   fmDovidka_9_3.showmodal;
   freeandnil(fmDovidka_9_3);
end;

procedure TfmBrowser_dovidka.button_dovidka_10Click(Sender: TObject);
begin
   fmDovidka_10_2:=TfmDovidka_10_2.create(self);
   fmDovidka_10_2.showmodal;
   freeandnil(fmDovidka_10_2);
end;

procedure TfmBrowser_dovidka.button_dovidka_11Click(Sender: TObject);
begin
   fmdovidka_11:=TfmDovidka_11.create(self);
   fmDovidka_11.showmodal;
   freeAndNil(fmDovidka_11);
end;

procedure TfmBrowser_dovidka.button_dovidka_12Click(Sender: TObject);
begin
   fmdovidka_12:=TfmDovidka_12.create(self);
   fmDovidka_12.showmodal;
   freeAndNil(fmDovidka_11);
end;

procedure TfmBrowser_dovidka.button_dovidka_13Click(Sender: TObject);
begin
   fmdovidka_13:=TfmDovidka_13.create(self);
   fmDovidka_13.showmodal;
   freeandnil(fmDovidka_13);
end;

procedure TfmBrowser_dovidka.button_dovidka_14Click(Sender: TObject);
begin
    fmDovidka_14:=TfmDovidka_14.create(self);
    fmDovidka_14.showmodal;
    freeAndNil(fmDovidka_14);
end;

end.
