/*
 * Rediscount.java
 *
 * Created on 16 Октябрь 2007 г., 11:50
 */

package main_package;

import java.util.Date;
import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;

/**
 *
 * @author root
 */
public class Rediscount extends MIDlet implements CommandListener {
    
    /**
     * Creates a new instance of Rediscount
     */
    public Rediscount() {
    }
    
    private Command exitCommand;//GEN-BEGIN:MVDFields
    private List list_rediscount;
    private Command Command_main_menu;
    private List list_main_menu;
    private Command Command_main_menu_exit;
    private Command Commnad_main_menu_ok;
    private Form form_create_rediscount;
    private TextField textField_new_rediscount_name;
    private Command Command_new_rediscount_cancel;
    private Command Command_new_rediscount_ok;
    private Form form_delete_all_rediscount;
    private StringItem stringItem1;
    private Command Command_delete_all_cancel;
    private Command Command_delete_all_ok;
    private Form form_get_data;
    private List list_get_data_menu;
    private Command Command_get_data_menu;
    private Command Command_get_data_exit;
    private StringItem StringItem_data;
    private Form form_delete_position_by_number;
    private Command Command_delete_position_by_number;
    private Command Command_cancel_delete_position_by_number;
    private TextField textField1;
    private Form form_manual_enter_position;
    private Command Command_manual_enter_position_cancel;
    private Command Command_manual_enter_position_add;
    private TextField textField2;
    private TextField textField_new_rediscount_points;
    private TextField textField_new_rediscount_people;
    private DateField dateField_new_rediscount_date;
    private Command okCommand_exit;
    private Form form_com_sender;
    private Command okCommand1;//GEN-END:MVDFields
    private TStore_shell_List shell_list;
    private ComController_shell_StringItem shell_stringitem=null;
    private Alert alert_error_send_mail;    
    private Alert alert_send_mail;    
    private Alert alert_by_message;
    private ComController_sender com_outputer;
//GEN-LINE:MVDMethods

    /** This method initializes UI of the application.//GEN-BEGIN:MVDInitBegin
     */
    private void initialize() {//GEN-END:MVDInitBegin
        dateField_new_rediscount_date = new DateField("DATE:", DateField.DATE);//GEN-BEGIN:MVDInitInit
        getDisplay().setCurrent(get_list_rediscount());//GEN-END:MVDInitInit
        this.dateField_new_rediscount_date.setDate(new Date());
        /*try{
            javax.microedition.rms.RecordStore.deleteRecordStore("REDISCOUNT");
        }
        catch(Exception e){
        }*/
        this.shell_list=new TStore_shell_List(list_rediscount,"REDISCOUNT");
    }//GEN-LINE:MVDInitEnd
    
    /** Called by the system to indicate that a command has been invoked on a particular displayable.//GEN-BEGIN:MVDCABegin
     * @param command the Command that ws invoked
     * @param displayable the Displayable on which the command was invoked
     */
    public void commandAction(Command command, Displayable displayable) {//GEN-END:MVDCABegin
        // Insert global pre-action code here
        if (displayable == list_rediscount) {//GEN-BEGIN:MVDCABody
            if (command == exitCommand) {//GEN-END:MVDCABody
                // Insert pre-action code here
                exitMIDlet();//GEN-LINE:MVDCAAction8
                // Insert post-action code here
            } else if (command == Command_main_menu) {//GEN-LINE:MVDCACase8
                // Insert pre-action code here
                getDisplay().setCurrent(get_list_main_menu());//GEN-LINE:MVDCAAction10
                // Insert post-action code here
            }//GEN-BEGIN:MVDCACase10
        } else if (displayable == list_main_menu) {
            if (command == Command_main_menu_exit) {//GEN-END:MVDCACase10
                // Insert pre-action code here
                getDisplay().setCurrent(get_list_rediscount());//GEN-LINE:MVDCAAction24
                // Insert post-action code here
            } else if (command == list_main_menu.SELECT_COMMAND) {//GEN-BEGIN:MVDCACase24
                switch (get_list_main_menu().getSelectedIndex()) {
                    case 0://GEN-END:MVDCACase24
                        // Переход в экран сканирования данных
                        if(this.list_rediscount.getSelectedIndex()>=0){
                            //if(System.getProperty("com.siemens.IMEI").equals(" 353542000966501")){ // телефон Siement CX65
                            //if(System.getProperty("com.siemens.IMEI").equals(" 354765000042127")){ // телефон Siement C65
                            if(System.getProperty("com.siemens.IMEI").equals(" 353661006438297")){ // телефон Siement C65
                                getDisplay().setCurrent(get_form_get_data());//GEN-LINE:MVDCAAction14
                            String store_name=this.shell_list.get_store_name_by_display_name(this.list_rediscount.getString(this.list_rediscount.getSelectedIndex()));
                            //System.out.println("open store name="+store_name);
                            this.shell_stringitem=new ComController_shell_StringItem(Display.getDisplay(this),this.form_get_data,(StringItem)this.form_get_data.get(0),store_name);
                            this.shell_stringitem.open();
                            }
                        }
                        break;//GEN-BEGIN:MVDCACase14
                    case 1://GEN-END:MVDCACase14
                        // Insert pre-action code here
                        getDisplay().setCurrent(get_form_create_rediscount());//GEN-LINE:MVDCAAction16
                        // Insert post-action code here
                        break;//GEN-BEGIN:MVDCACase16
                    case 2://GEN-END:MVDCACase16
                        // Выбрано меню по отправке сообщения по электронной почте
                        // получить данные для чтения
                        String rediscount_name="";
                        String rediscount_message="";
                        try{
                            rediscount_name=this.list_rediscount.getString(this.list_rediscount.getSelectedIndex());
                            //System.out.println("Имя переучета: "+rediscount_name);
                        }
                        catch(Exception e){
                            //System.out.println("Ошибка получения индекса переучета для удаления");
                        }
                        // отправить данные
                        getDisplay().setCurrent(get_list_rediscount());//GEN-LINE:MVDCAAction18
                        // Insert post-action code here
                        if(rediscount_message!=null){
                            rediscount_message=this.shell_list.get_data_from_store(rediscount_name);
                            //System.out.println(" E-mail - <<<"+rediscount_name+">>>\n"+rediscount_message);
                            if((rediscount_message!=null)&&(rediscount_message!="")){
                                //System.out.println("Начинаем отправку по E-mail");
                                String user_name="User_name*";
                                try{
                                    user_name=user_name+this.getAppProperty("user_name")+"\n";
                                }
                                catch(Exception e){
                                    user_name=user_name+"\n";
                                }
                                java.util.Random random=new java.util.Random();
                                char char1=(char)(Math.abs(random.nextInt(26))+65);
                                char char2=(char)(Math.abs(random.nextInt(26))+65);
                                String random_string="";
                                random_string+=char1;
                                random_string+=char2;
                                // отправка письма
                                    string_package shell_string=new string_package("");
                                    mail temp_mail=new mail(user_name+"mail_caption*"+mail.convert_string_to_asc_string(rediscount_name)+"\ndata*\n"+rediscount_message+"\nrandom*"+random_string,
                                                            this,
                                                            this.list_rediscount,
                                                            shell_string);
                                    // проверка результата отправки письма
                                    if(temp_mail.flag_send_mail==true){
                                        //System.out.println("mail sended");
                                        getDisplay().setCurrent(this.get_alert_send_mail(), get_list_rediscount());
                                    }
                                    else {
                                        //System.out.println("mail not send");
                                       /* getDisplay().setCurrent(new Form(null, 
                                                                         new Item[] {new StringItem("ErrorValue", shell_string.getValue())}
                                                                         )
                                                                );*/
                                        getDisplay().setCurrent(this.get_alert_error_send_mail(shell_string.getValue()), get_list_rediscount());
                                    }
                            }
                            else{
                                //System.out.println("Нечего отправлять");
                            }
                        }
                        
                        break;//GEN-BEGIN:MVDCACase18
                    case 4://GEN-END:MVDCACase18
                        // Выбрано меню удаления данных - получаем индекс и удаляем данные
                        String delete_string="";
                        try{
                            delete_string=this.list_rediscount.getString(this.list_rediscount.getSelectedIndex());
                        }
                        catch(Exception e){
                            //System.out.println("Ошибка получения индекса переучета для удаления");
                        }
                        if(delete_string!=null){
                            this.shell_list.delete_record_by_display_name(delete_string);
                            this.shell_list.show_elements_on_list();
                            ////System.out.println("Удаление произведено "+delete_string);
                        }
                        getDisplay().setCurrent(get_list_rediscount());//GEN-LINE:MVDCAAction20
                        
                        break;//GEN-BEGIN:MVDCACase20
                    case 5://GEN-END:MVDCACase20
                        // Insert pre-action code here
                        getDisplay().setCurrent(get_form_delete_all_rediscount());//GEN-LINE:MVDCAAction34
                        // Insert post-action code here
                        break;//GEN-BEGIN:MVDCACase34
                    case 3://GEN-END:MVDCACase34
                        // Выбрано меню по отправке сообщения в COM порт
                        // получить данные для чтения
                        String rediscount_name_com="";
                        String rediscount_message_com="";
                        try{
                            rediscount_name_com=this.list_rediscount.getString(this.list_rediscount.getSelectedIndex());
                            System.out.println("Имя переучета: "+rediscount_name_com);
                        }
                        catch(Exception e){
                            System.out.println("Ошибка получения индекса переучета ");
                        }
                        // отправить данные
                        if((rediscount_name_com!=null)&&(!rediscount_name_com.equals(""))){
                            rediscount_message_com=this.shell_list.get_data_from_store(rediscount_name_com);
                                String user_name="User_name*";
                                try{
                                    user_name=user_name+this.getAppProperty("user_name")+"\n";
                                }
                                catch(Exception e){
                                    user_name=user_name+"\n";
                                }
                                System.out.println("объект для отправки в COM создан, начинаем отправку");
                                //this.getDisplay().setCurrent((Form)com_outputer);
                        // Insert pre-action code here
                                getDisplay().setCurrent(get_form_com_sender());//GEN-LINE:MVDCAAction81
                        // Insert post-action code here
                                System.out.println("создать объект для отправки в COM");
                                com_outputer=new ComController_sender(getDisplay(),
                                                                      this.list_rediscount,
                                                                      "com0",// com0
                                                                      9600,
                                                                      (String)(user_name+"mail_caption*"+mail.convert_string_to_asc_string(rediscount_name_com)+"\ndata*\n"+rediscount_message_com));
                                    
                                if(com_outputer.send()==true){
                                    System.out.println("Данные переданы");
                                    //getDisplay().setCurrent(get_alert_send_to_com("Data sended"), get_list_rediscount());
                                }
                                else {
                                    getDisplay().setCurrent(get_list_rediscount());
                                    System.out.println("Ошибка передачи данных");
                                    //getDisplay().setCurrent(get_alert_send_to_com("ERROR send data"), get_list_rediscount());
                                    //getDisplay().setCurrent(this.get_alert_error_send_mail(shell_string.getValue()), get_list_rediscount());
                                }
                            
                        }
                        
                        break;//GEN-BEGIN:MVDCACase81
                }
            }
        } else if (displayable == form_create_rediscount) {
            if (command == Command_new_rediscount_ok) {//GEN-END:MVDCACase81
                // нажата кнопка OK на форме ввода имени нового переучета
                /*String temp_name=((TextField)this.form_create_rediscount.get(0)).getString()+"("+
                                 ((DateField)this.form_create_rediscount.get(1)).getDate().toString()+
                                 ((TextField)this.form_create_rediscount.get(2)).getString()+
                                 ((TextField)this.form_create_rediscount.get(3)).getString()+")";
                ((TextField)this.form_create_rediscount.get(0)).setString("");
                 */
                String temp_name=this.get_data_for_new_rediscount();
                // Если имя введено в поле - тогда пытаемся его создать
                if(temp_name!=null){
                    this.shell_list.create_record(temp_name);
                    this.shell_list.show_elements_on_list();
                    this.set_startup_data_for_new_rediscount();
                }
                getDisplay().setCurrent(get_list_rediscount());//GEN-LINE:MVDCAAction32
                
            } else if (command == Command_new_rediscount_cancel) {//GEN-LINE:MVDCACase32
                // Insert pre-action code here
                getDisplay().setCurrent(get_list_main_menu());//GEN-LINE:MVDCAAction30
                // Insert post-action code here
            }//GEN-BEGIN:MVDCACase30
        } else if (displayable == form_delete_all_rediscount) {
            if (command == Command_delete_all_cancel) {//GEN-END:MVDCACase30
                // получили команду отмены удаления всех элементов из меню "удаления всех переучетов
                getDisplay().setCurrent(get_list_main_menu());//GEN-LINE:MVDCAAction40
                // Insert post-action code here
            } else if (command == Command_delete_all_ok) {//GEN-LINE:MVDCACase40
                // получили согласие на удаление всех переучетов
                  // удаляем все переучеты
                for(int i=0;i<this.list_rediscount.size();i++){
                    this.shell_list.delete_record_by_display_name(this.list_rediscount.getString(i));
                }
                this.shell_list.show_elements_on_list();
                getDisplay().setCurrent(get_list_rediscount());//GEN-LINE:MVDCAAction42
                // Insert post-action code here
            }//GEN-BEGIN:MVDCACase42
        } else if (displayable == list_get_data_menu) {
            if (command == list_get_data_menu.SELECT_COMMAND) {
                switch (get_list_get_data_menu().getSelectedIndex()) {
                    case 0://GEN-END:MVDCACase42
                        // Manual Enter - ручной ввод данных
                        getDisplay().setCurrent(get_form_manual_enter_position());//GEN-LINE:MVDCAAction51
                        
                        break;//GEN-BEGIN:MVDCACase51
                    case 1://GEN-END:MVDCACase51
                        // Delete last position - удалить последнюю введенную позицию
                        this.shell_stringitem.delete_last_position_from_data();
                        this.shell_stringitem.read_data_from_store_and_display_to_StringItem();
                        getDisplay().setCurrent(get_form_get_data());//GEN-LINE:MVDCAAction53
                        break;//GEN-BEGIN:MVDCACase53
                    case 2://GEN-END:MVDCACase53
                        // Delete by number - удалить позицию по заданному номеру
                        getDisplay().setCurrent(get_form_delete_position_by_number());//GEN-LINE:MVDCAAction55
                        break;//GEN-BEGIN:MVDCACase55
                    case 3://GEN-END:MVDCACase55
                        // Cancel - выйти из меню
                        getDisplay().setCurrent(get_form_get_data());//GEN-LINE:MVDCAAction57
                        
                        break;//GEN-BEGIN:MVDCACase57
                }
            }
        } else if (displayable == form_get_data) {
            if (command == Command_get_data_menu) {//GEN-END:MVDCACase57
                // Переход на меню для ввода/радктирования данных для переучета
                getDisplay().setCurrent(get_list_get_data_menu());//GEN-LINE:MVDCAAction47
                
            } else if (command == Command_get_data_exit) {//GEN-LINE:MVDCACase47
                // команда окончания ввода/просмотра данных
                if(this.shell_stringitem.isOpen()){
                    this.shell_stringitem.close();
                }
                getDisplay().setCurrent(get_list_main_menu());//GEN-LINE:MVDCAAction49
                
            }//GEN-BEGIN:MVDCACase49
        } else if (displayable == form_delete_position_by_number) {
            if (command == Command_cancel_delete_position_by_number) {//GEN-END:MVDCACase49
                // Команда отмены удаления поизции из порта по ее номеру 
                getDisplay().setCurrent(get_form_get_data());//GEN-LINE:MVDCAAction65
                
            } else if (command == Command_delete_position_by_number) {//GEN-LINE:MVDCACase65
                // Команда удаление позиции, прочитанной из порта по ее номеру
                String temp_string=((TextField)(this.form_delete_position_by_number.get(0))).getString();
                ((TextField)(this.form_delete_position_by_number.get(0))).setString("");
                if((temp_string!=null)&&(temp_string!="")){
                    this.shell_stringitem.delete_number_from_data(temp_string);
                    this.shell_stringitem.read_data_from_store_and_display_to_StringItem();
                }
                getDisplay().setCurrent(get_form_get_data());//GEN-LINE:MVDCAAction63
                
            }//GEN-BEGIN:MVDCACase63
        } else if (displayable == form_manual_enter_position) {
            if (command == Command_manual_enter_position_cancel) {//GEN-END:MVDCACase63
                // Команда отмены ручного добавления данных
                getDisplay().setCurrent(get_list_get_data_menu());//GEN-LINE:MVDCAAction69
                
            } else if (command == Command_manual_enter_position_add) {//GEN-LINE:MVDCACase69
                // Команда ввода ручного добавления данных
                String temp_string=((TextField)(this.form_manual_enter_position.get(0))).getString();
                ((TextField)(this.form_manual_enter_position.get(0))).setString("");
                this.shell_stringitem.counter++;
                try{
                    this.shell_stringitem.add_data_to_store(temp_string);
                }
                catch(Exception e){
                    //System.out.println(" Memory FULL");
                    Display.getDisplay(this).setCurrent(new Alert("Memory FULL"),form_manual_enter_position);
                }
                this.shell_stringitem.read_data_from_store_and_display_to_StringItem();
                getDisplay().setCurrent(get_form_get_data());//GEN-LINE:MVDCAAction71
            }//GEN-BEGIN:MVDCACase71
        } else if (displayable == form_com_sender) {
            if (command == okCommand1) {//GEN-END:MVDCACase71
                // Insert pre-action code here
                getDisplay().setCurrent(get_list_rediscount());//GEN-LINE:MVDCAAction88
                // Insert post-action code here
            }//GEN-BEGIN:MVDCACase88
        }//GEN-END:MVDCACase88
        // Insert global post-action code here
}//GEN-LINE:MVDCAEnd
    
    /**
     * This method should return an instance of the display.
     */
    public Display getDisplay() {//GEN-FIRST:MVDGetDisplay
        return Display.getDisplay(this);
    }//GEN-LAST:MVDGetDisplay
    
    /**
     * This method should exit the midlet.
     */
    public void exitMIDlet() {//GEN-FIRST:MVDExitMidlet
        getDisplay().setCurrent(null);
        destroyApp(true);
        notifyDestroyed();
    }//GEN-LAST:MVDExitMidlet
    
    
    
    /** This method returns instance for exitCommand component and should be called instead of accessing exitCommand field directly.//GEN-BEGIN:MVDGetBegin5
     * @return Instance for exitCommand component
     */
    public Command get_exitCommand() {
        if (exitCommand == null) {//GEN-END:MVDGetBegin5
            // Insert pre-init code here
            exitCommand = new Command("Exit", Command.EXIT, 1);//GEN-LINE:MVDGetInit5
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd5
        return exitCommand;
    }//GEN-END:MVDGetEnd5

    /** This method returns instance for list_rediscount component and should be called instead of accessing list_rediscount field directly.//GEN-BEGIN:MVDGetBegin6
     * @return Instance for list_rediscount component
     */
    public List get_list_rediscount() {
        if (list_rediscount == null) {//GEN-END:MVDGetBegin6
            // Insert pre-init code here
            list_rediscount = new List("Rediscount", Choice.IMPLICIT, new String[0], new Image[0]);//GEN-BEGIN:MVDGetInit6
            list_rediscount.addCommand(get_exitCommand());
            list_rediscount.addCommand(get_Command_main_menu());
            list_rediscount.setCommandListener(this);
            list_rediscount.setSelectedFlags(new boolean[0]);//GEN-END:MVDGetInit6
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd6
        return list_rediscount;
    }//GEN-END:MVDGetEnd6

    /** This method returns instance for Command_main_menu component and should be called instead of accessing Command_main_menu field directly.//GEN-BEGIN:MVDGetBegin9
     * @return Instance for Command_main_menu component
     */
    public Command get_Command_main_menu() {
        if (Command_main_menu == null) {//GEN-END:MVDGetBegin9
            // Insert pre-init code here
            Command_main_menu = new Command("Menu", Command.OK, 1);//GEN-LINE:MVDGetInit9
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd9
        return Command_main_menu;
    }//GEN-END:MVDGetEnd9

    /** This method returns instance for list_main_menu component and should be called instead of accessing list_main_menu field directly.//GEN-BEGIN:MVDGetBegin11
     * @return Instance for list_main_menu component
     */
    public List get_list_main_menu() {
        if (list_main_menu == null) {//GEN-END:MVDGetBegin11
            // Insert pre-init code here
            list_main_menu = new List(null, Choice.IMPLICIT, new String[] {//GEN-BEGIN:MVDGetInit11
                "View rediscount",
                "Create rediscount",
                "Send via E-mail",
                "Send via COM",
                "Delete rediscount",
                "Delete all Rediscount"
            }, new Image[] {
                null,
                null,
                null,
                null,
                null,
                null
            });
            list_main_menu.addCommand(get_Command_main_menu_exit());
            list_main_menu.setCommandListener(this);
            list_main_menu.setSelectedFlags(new boolean[] {
                false,
                false,
                false,
                false,
                false,
                false
            });//GEN-END:MVDGetInit11
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd11
        return list_main_menu;
    }//GEN-END:MVDGetEnd11

    /** This method returns instance for Command_main_menu_exit component and should be called instead of accessing Command_main_menu_exit field directly.//GEN-BEGIN:MVDGetBegin23
     * @return Instance for Command_main_menu_exit component
     */
    public Command get_Command_main_menu_exit() {
        if (Command_main_menu_exit == null) {//GEN-END:MVDGetBegin23
            // Insert pre-init code here
            Command_main_menu_exit = new Command("Cancel", Command.EXIT, 1);//GEN-LINE:MVDGetInit23
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd23
        return Command_main_menu_exit;
    }//GEN-END:MVDGetEnd23

    /** This method returns instance for Commnad_main_menu_ok component and should be called instead of accessing Commnad_main_menu_ok field directly.//GEN-BEGIN:MVDGetBegin25
     * @return Instance for Commnad_main_menu_ok component
     */
    public Command get_Commnad_main_menu_ok() {
        if (Commnad_main_menu_ok == null) {//GEN-END:MVDGetBegin25
            // Insert pre-init code here
            Commnad_main_menu_ok = new Command("OK", Command.OK, 1);//GEN-LINE:MVDGetInit25
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd25
        return Commnad_main_menu_ok;
    }//GEN-END:MVDGetEnd25

    /** This method returns instance for form_create_rediscount component and should be called instead of accessing form_create_rediscount field directly.//GEN-BEGIN:MVDGetBegin27
     * @return Instance for form_create_rediscount component
     */
    public Form get_form_create_rediscount() {
        if (form_create_rediscount == null) {//GEN-END:MVDGetBegin27
            // Insert pre-init code here
            form_create_rediscount = new Form("Enter name NEW Rediscount", new Item[] {//GEN-BEGIN:MVDGetInit27
                get_textField_new_rediscount_name(),
                dateField_new_rediscount_date,
                get_textField_new_rediscount_points(),
                get_textField_new_rediscount_people()
            });
            form_create_rediscount.addCommand(get_Command_new_rediscount_cancel());
            form_create_rediscount.addCommand(get_Command_new_rediscount_ok());
            form_create_rediscount.setCommandListener(this);//GEN-END:MVDGetInit27
            // Insert post-init code here
            
        }//GEN-BEGIN:MVDGetEnd27
        return form_create_rediscount;
    }//GEN-END:MVDGetEnd27

    /** This method returns instance for textField_new_rediscount_name component and should be called instead of accessing textField_new_rediscount_name field directly.//GEN-BEGIN:MVDGetBegin28
     * @return Instance for textField_new_rediscount_name component
     */
    public TextField get_textField_new_rediscount_name() {
        if (textField_new_rediscount_name == null) {//GEN-END:MVDGetBegin28
            // Insert pre-init code here
            textField_new_rediscount_name = new TextField("Advanced NAME:", null, 10, TextField.ANY);//GEN-LINE:MVDGetInit28
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd28
        return textField_new_rediscount_name;
    }//GEN-END:MVDGetEnd28

    /** This method returns instance for Command_new_rediscount_cancel component and should be called instead of accessing Command_new_rediscount_cancel field directly.//GEN-BEGIN:MVDGetBegin29
     * @return Instance for Command_new_rediscount_cancel component
     */
    public Command get_Command_new_rediscount_cancel() {
        if (Command_new_rediscount_cancel == null) {//GEN-END:MVDGetBegin29
            // Insert pre-init code here
            Command_new_rediscount_cancel = new Command("Cancel", Command.EXIT, 1);//GEN-LINE:MVDGetInit29
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd29
        return Command_new_rediscount_cancel;
    }//GEN-END:MVDGetEnd29

    /** This method returns instance for Command_new_rediscount_ok component and should be called instead of accessing Command_new_rediscount_ok field directly.//GEN-BEGIN:MVDGetBegin31
     * @return Instance for Command_new_rediscount_ok component
     */
    public Command get_Command_new_rediscount_ok() {
        if (Command_new_rediscount_ok == null) {//GEN-END:MVDGetBegin31
            // Insert pre-init code here
            Command_new_rediscount_ok = new Command("OK", Command.OK, 1);//GEN-LINE:MVDGetInit31
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd31
        return Command_new_rediscount_ok;
    }//GEN-END:MVDGetEnd31

    /** This method returns instance for form_delete_all_rediscount component and should be called instead of accessing form_delete_all_rediscount field directly.//GEN-BEGIN:MVDGetBegin37
     * @return Instance for form_delete_all_rediscount component
     */
    public Form get_form_delete_all_rediscount() {
        if (form_delete_all_rediscount == null) {//GEN-END:MVDGetBegin37
            // Insert pre-init code here
            form_delete_all_rediscount = new Form(null, new Item[] {get_stringItem1()});//GEN-BEGIN:MVDGetInit37
            form_delete_all_rediscount.addCommand(get_Command_delete_all_cancel());
            form_delete_all_rediscount.addCommand(get_Command_delete_all_ok());
            form_delete_all_rediscount.setCommandListener(this);//GEN-END:MVDGetInit37
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd37
        return form_delete_all_rediscount;
    }//GEN-END:MVDGetEnd37

    /** This method returns instance for stringItem1 component and should be called instead of accessing stringItem1 field directly.//GEN-BEGIN:MVDGetBegin38
     * @return Instance for stringItem1 component
     */
    public StringItem get_stringItem1() {
        if (stringItem1 == null) {//GEN-END:MVDGetBegin38
            // Insert pre-init code here
            stringItem1 = new StringItem("Attention:", "Delete ALL rediscount?");//GEN-LINE:MVDGetInit38
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd38
        return stringItem1;
    }//GEN-END:MVDGetEnd38

    /** This method returns instance for Command_delete_all_cancel component and should be called instead of accessing Command_delete_all_cancel field directly.//GEN-BEGIN:MVDGetBegin39
     * @return Instance for Command_delete_all_cancel component
     */
    public Command get_Command_delete_all_cancel() {
        if (Command_delete_all_cancel == null) {//GEN-END:MVDGetBegin39
            // Insert pre-init code here
            Command_delete_all_cancel = new Command("Cancel", Command.EXIT, 1);//GEN-LINE:MVDGetInit39
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd39
        return Command_delete_all_cancel;
    }//GEN-END:MVDGetEnd39

    /** This method returns instance for Command_delete_all_ok component and should be called instead of accessing Command_delete_all_ok field directly.//GEN-BEGIN:MVDGetBegin41
     * @return Instance for Command_delete_all_ok component
     */
    public Command get_Command_delete_all_ok() {
        if (Command_delete_all_ok == null) {//GEN-END:MVDGetBegin41
            // Insert pre-init code here
            Command_delete_all_ok = new Command("Delete all", Command.OK, 1);//GEN-LINE:MVDGetInit41
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd41
        return Command_delete_all_ok;
    }//GEN-END:MVDGetEnd41

    /** This method returns instance for form_get_data component and should be called instead of accessing form_get_data field directly.//GEN-BEGIN:MVDGetBegin43
     * @return Instance for form_get_data component
     */
    public Form get_form_get_data() {
        if (form_get_data == null) {//GEN-END:MVDGetBegin43
            // Insert pre-init code here
            form_get_data = new Form(null, new Item[] {get_StringItem_data()});//GEN-BEGIN:MVDGetInit43
            form_get_data.addCommand(get_Command_get_data_menu());
            form_get_data.addCommand(get_Command_get_data_exit());
            form_get_data.setCommandListener(this);//GEN-END:MVDGetInit43
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd43
        return form_get_data;
    }//GEN-END:MVDGetEnd43

    /** This method returns instance for list_get_data_menu component and should be called instead of accessing list_get_data_menu field directly.//GEN-BEGIN:MVDGetBegin44
     * @return Instance for list_get_data_menu component
     */
    public List get_list_get_data_menu() {
        if (list_get_data_menu == null) {//GEN-END:MVDGetBegin44
            // Insert pre-init code here
            list_get_data_menu = new List(null, Choice.IMPLICIT, new String[] {//GEN-BEGIN:MVDGetInit44
                "Manual Enter",
                "Delete last",
                "Delete by number",
                "Cancel"
            }, new Image[] {
                null,
                null,
                null,
                null
            });
            list_get_data_menu.setCommandListener(this);
            list_get_data_menu.setSelectedFlags(new boolean[] {
                true,
                false,
                false,
                false
            });//GEN-END:MVDGetInit44
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd44
        return list_get_data_menu;
    }//GEN-END:MVDGetEnd44

    /** This method returns instance for Command_get_data_menu component and should be called instead of accessing Command_get_data_menu field directly.//GEN-BEGIN:MVDGetBegin46
     * @return Instance for Command_get_data_menu component
     */
    public Command get_Command_get_data_menu() {
        if (Command_get_data_menu == null) {//GEN-END:MVDGetBegin46
            // Insert pre-init code here
            Command_get_data_menu = new Command("Menu", Command.OK, 1);//GEN-LINE:MVDGetInit46
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd46
        return Command_get_data_menu;
    }//GEN-END:MVDGetEnd46

    /** This method returns instance for Command_get_data_exit component and should be called instead of accessing Command_get_data_exit field directly.//GEN-BEGIN:MVDGetBegin48
     * @return Instance for Command_get_data_exit component
     */
    public Command get_Command_get_data_exit() {
        if (Command_get_data_exit == null) {//GEN-END:MVDGetBegin48
            // Insert pre-init code here
            Command_get_data_exit = new Command("Exit", Command.EXIT, 1);//GEN-LINE:MVDGetInit48
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd48
        return Command_get_data_exit;
    }//GEN-END:MVDGetEnd48

    /** This method returns instance for StringItem_data component and should be called instead of accessing StringItem_data field directly.//GEN-BEGIN:MVDGetBegin60
     * @return Instance for StringItem_data component
     */
    public StringItem get_StringItem_data() {
        if (StringItem_data == null) {//GEN-END:MVDGetBegin60
            // Insert pre-init code here
            StringItem_data = new StringItem("Data:", "");//GEN-LINE:MVDGetInit60
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd60
        return StringItem_data;
    }//GEN-END:MVDGetEnd60

    /** This method returns instance for form_delete_position_by_number component and should be called instead of accessing form_delete_position_by_number field directly.//GEN-BEGIN:MVDGetBegin61
     * @return Instance for form_delete_position_by_number component
     */
    public Form get_form_delete_position_by_number() {
        if (form_delete_position_by_number == null) {//GEN-END:MVDGetBegin61
            // Insert pre-init code here
            form_delete_position_by_number = new Form(null, new Item[] {get_textField1()});//GEN-BEGIN:MVDGetInit61
            form_delete_position_by_number.addCommand(get_Command_delete_position_by_number());
            form_delete_position_by_number.addCommand(get_Command_cancel_delete_position_by_number());
            form_delete_position_by_number.setCommandListener(this);//GEN-END:MVDGetInit61
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd61
        return form_delete_position_by_number;
    }//GEN-END:MVDGetEnd61

    /** This method returns instance for Command_delete_position_by_number component and should be called instead of accessing Command_delete_position_by_number field directly.//GEN-BEGIN:MVDGetBegin62
     * @return Instance for Command_delete_position_by_number component
     */
    public Command get_Command_delete_position_by_number() {
        if (Command_delete_position_by_number == null) {//GEN-END:MVDGetBegin62
            // Insert pre-init code here
            Command_delete_position_by_number = new Command("Delete", Command.OK, 1);//GEN-LINE:MVDGetInit62
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd62
        return Command_delete_position_by_number;
    }//GEN-END:MVDGetEnd62

    /** This method returns instance for Command_cancel_delete_position_by_number component and should be called instead of accessing Command_cancel_delete_position_by_number field directly.//GEN-BEGIN:MVDGetBegin64
     * @return Instance for Command_cancel_delete_position_by_number component
     */
    public Command get_Command_cancel_delete_position_by_number() {
        if (Command_cancel_delete_position_by_number == null) {//GEN-END:MVDGetBegin64
            // Insert pre-init code here
            Command_cancel_delete_position_by_number = new Command("Cancel", Command.EXIT, 1);//GEN-LINE:MVDGetInit64
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd64
        return Command_cancel_delete_position_by_number;
    }//GEN-END:MVDGetEnd64

    /** This method returns instance for textField1 component and should be called instead of accessing textField1 field directly.//GEN-BEGIN:MVDGetBegin66
     * @return Instance for textField1 component
     */
    public TextField get_textField1() {
        if (textField1 == null) {//GEN-END:MVDGetBegin66
            // Insert pre-init code here
            textField1 = new TextField("Number position for Delete", null, 120, TextField.NUMERIC);//GEN-LINE:MVDGetInit66
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd66
        return textField1;
    }//GEN-END:MVDGetEnd66

    /** This method returns instance for form_manual_enter_position component and should be called instead of accessing form_manual_enter_position field directly.//GEN-BEGIN:MVDGetBegin67
     * @return Instance for form_manual_enter_position component
     */
    public Form get_form_manual_enter_position() {
        if (form_manual_enter_position == null) {//GEN-END:MVDGetBegin67
            // Insert pre-init code here
            form_manual_enter_position = new Form(null, new Item[] {get_textField2()});//GEN-BEGIN:MVDGetInit67
            form_manual_enter_position.addCommand(get_Command_manual_enter_position_cancel());
            form_manual_enter_position.addCommand(get_Command_manual_enter_position_add());
            form_manual_enter_position.setCommandListener(this);//GEN-END:MVDGetInit67
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd67
        return form_manual_enter_position;
    }//GEN-END:MVDGetEnd67

    /** This method returns instance for Command_manual_enter_position_cancel component and should be called instead of accessing Command_manual_enter_position_cancel field directly.//GEN-BEGIN:MVDGetBegin68
     * @return Instance for Command_manual_enter_position_cancel component
     */
    public Command get_Command_manual_enter_position_cancel() {
        if (Command_manual_enter_position_cancel == null) {//GEN-END:MVDGetBegin68
            // Insert pre-init code here
            Command_manual_enter_position_cancel = new Command("Cancel", Command.EXIT, 1);//GEN-LINE:MVDGetInit68
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd68
        return Command_manual_enter_position_cancel;
    }//GEN-END:MVDGetEnd68

    /** This method returns instance for Command_manual_enter_position_add component and should be called instead of accessing Command_manual_enter_position_add field directly.//GEN-BEGIN:MVDGetBegin70
     * @return Instance for Command_manual_enter_position_add component
     */
    public Command get_Command_manual_enter_position_add() {
        if (Command_manual_enter_position_add == null) {//GEN-END:MVDGetBegin70
            // Insert pre-init code here
            Command_manual_enter_position_add = new Command("Add", Command.OK, 1);//GEN-LINE:MVDGetInit70
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd70
        return Command_manual_enter_position_add;
    }//GEN-END:MVDGetEnd70

    /** This method returns instance for textField2 component and should be called instead of accessing textField2 field directly.//GEN-BEGIN:MVDGetBegin72
     * @return Instance for textField2 component
     */
    public TextField get_textField2() {
        if (textField2 == null) {//GEN-END:MVDGetBegin72
            // Insert pre-init code here
            textField2 = new TextField("BarCode", null, 120, TextField.NUMERIC);//GEN-LINE:MVDGetInit72
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd72
        return textField2;
    }//GEN-END:MVDGetEnd72

    /** This method returns instance for textField_new_rediscount_points component and should be called instead of accessing textField_new_rediscount_points field directly.//GEN-BEGIN:MVDGetBegin75
     * @return Instance for textField_new_rediscount_points component
     */
    public TextField get_textField_new_rediscount_points() {
        if (textField_new_rediscount_points == null) {//GEN-END:MVDGetBegin75
            // Insert pre-init code here
            textField_new_rediscount_points = new TextField("POINTS:", "000", 3, TextField.NUMERIC);//GEN-LINE:MVDGetInit75
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd75
        return textField_new_rediscount_points;
    }//GEN-END:MVDGetEnd75

    /** This method returns instance for textField_new_rediscount_people component and should be called instead of accessing textField_new_rediscount_people field directly.//GEN-BEGIN:MVDGetBegin76
     * @return Instance for textField_new_rediscount_people component
     */
    public TextField get_textField_new_rediscount_people() {
        if (textField_new_rediscount_people == null) {//GEN-END:MVDGetBegin76
            // Insert pre-init code here
            textField_new_rediscount_people = new TextField("MAN CODE:", "000", 3, TextField.NUMERIC);//GEN-LINE:MVDGetInit76
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd76
        return textField_new_rediscount_people;
    }//GEN-END:MVDGetEnd76
  
    /** This method returns instance for okCommand_exit component and should be called instead of accessing okCommand_exit field directly.//GEN-BEGIN:MVDGetBegin84
     * @return Instance for okCommand_exit component
     */
    public Command get_okCommand_exit() {
        if (okCommand_exit == null) {//GEN-END:MVDGetBegin84
            // Insert pre-init code here
            okCommand_exit = new Command("Close", Command.OK, 1);//GEN-LINE:MVDGetInit84
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd84
        return okCommand_exit;
    }//GEN-END:MVDGetEnd84

    /** This method returns instance for form_com_sender component and should be called instead of accessing form_com_sender field directly.//GEN-BEGIN:MVDGetBegin86
     * @return Instance for form_com_sender component
     */
    public Form get_form_com_sender() {
        if (form_com_sender == null) {//GEN-END:MVDGetBegin86
            // Insert pre-init code here
            form_com_sender = new Form("Data Transfer", new Item[0]);//GEN-BEGIN:MVDGetInit86
            form_com_sender.addCommand(get_okCommand1());
            form_com_sender.setCommandListener(this);//GEN-END:MVDGetInit86
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd86
        return form_com_sender;
    }//GEN-END:MVDGetEnd86

    /** This method returns instance for okCommand1 component and should be called instead of accessing okCommand1 field directly.//GEN-BEGIN:MVDGetBegin87
     * @return Instance for okCommand1 component
     */
    public Command get_okCommand1() {
        if (okCommand1 == null) {//GEN-END:MVDGetBegin87
            // Insert pre-init code here
            okCommand1 = new Command("Close", Command.OK, 1);//GEN-LINE:MVDGetInit87
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd87
        return okCommand1;
    }//GEN-END:MVDGetEnd87
 

     
    public Alert get_alert_error_send_mail(){
        if(alert_error_send_mail==null){
            alert_error_send_mail=new Alert("E-Mail","NOT SEND",null,AlertType.ERROR);
            alert_error_send_mail.setTimeout(-2);
        }
        return alert_error_send_mail;
    }
    public Alert get_alert_error_send_mail(String text_message){
        if(alert_error_send_mail==null){
            alert_error_send_mail=new Alert("E-Mail",text_message,null,AlertType.ERROR);
            alert_error_send_mail.setTimeout(-2);
        }
        return alert_error_send_mail;
    }
    
    public Alert get_alert_send_mail(){
        if(alert_send_mail==null){
            alert_send_mail=new Alert("E-Mail","sended",null,AlertType.INFO);
            alert_send_mail.setTimeout(-2);
        }
        return alert_send_mail;
    }
    public Alert get_alert_send_mail(String text_message){
        if(alert_send_mail==null){
            alert_send_mail=new Alert("E-Mail",text_message,null,AlertType.INFO);
            alert_send_mail.setTimeout(-2);
        }
        return alert_send_mail;
    }
    
    private Alert alert_send_com;    
    public Alert get_alert_send_to_com(String text_message){
        if(alert_send_com==null){
            alert_send_com=new Alert("COM",text_message,null,AlertType.INFO);
            alert_send_com.setTimeout(1000);
        }
        return alert_send_com;
    }
    
    public Alert get_alert_by_messsage(String message){
        this.alert_by_message=new Alert("message:",message,null,AlertType.INFO);
        alert_send_mail.setTimeout(-2);
        return this.alert_by_message;
    }
    /**
     * Получение данных из формы New_Rediscount, и преобразование их к виду, который готов быть именем хранлища
     */
    public String get_data_for_new_rediscount(){
        String return_value="";
        return_value=this.textField_new_rediscount_name.getString()+"{D:"+
                     this.get_date_short_from_date_long(this.dateField_new_rediscount_date.getDate().toString())+
                     " P:"+this.textField_new_rediscount_points.getString()+
                     " M:"+this.textField_new_rediscount_people.getString()+
                     "}";
        return return_value;
    }
    /**
     * установка начальных значений для форы New_Rediscount - после успешного создание переучета, его обнуление
     */
    public void set_startup_data_for_new_rediscount(){
        this.textField_new_rediscount_name.setString("");
        this.textField_new_rediscount_people.setString("");
        this.textField_new_rediscount_points.setString("");
    }
    /**
     * получение строки вида Nov11 из строки вида: Sun Nov 11 06:40:38 UTC 2007
     */
    public String get_date_short_from_date_long(String date_long){
        String return_value="";
        TStringTokenizer tokenizer=new TStringTokenizer(date_long," ");
        if(tokenizer.countTokens()>3){
            return_value=tokenizer.get_element(1)+tokenizer.get_element(2);
        }
        else {
            // return_value="
        }
        return return_value;
    }
    public void startApp() {
        initialize();
    }
    
    public void pauseApp() {
    }
    
    public void destroyApp(boolean unconditional) {
    }
    
}
