/*
 * main.java
 *
 * Created on 8 Октябрь 2007 г., 17:23
 */

package get_data_from_com;

import javax.microedition.midlet.*;
import javax.microedition.lcdui.*;

/**
 *
 * @author root
 */

public class main extends MIDlet implements CommandListener,ComListener,Delete_position {
    
    /**
     * Creates a new instance of main
     */
    public main() {
    }
    
    private Form Controller;//GEN-BEGIN:MVDFields
    private StringItem StringItem_data;
    private Command exitCommand;
    private List list_menu;
    private Command menuCommand;
    private Form form_delete_position;
    private TextField textfield_delete_position;
    private Command Command_delete;
    private Command Exit;
    private Form form_manual_enter;
    private Command Command_manual_add;
    private Command Command_exit;
    private TextField textField1;//GEN-END:MVDFields
//GEN-LINE:MVDMethods
    private ComController com_controller=null;
    private String string_from_port="";
    private int counter=0;
    /** This method initializes UI of the application.//GEN-BEGIN:MVDInitBegin
     */
    private void initialize() {//GEN-END:MVDInitBegin
        // Insert pre-init code here
        getDisplay().setCurrent(get_Controller());//GEN-LINE:MVDInitInit
        // Insert post-init code here
    }//GEN-LINE:MVDInitEnd
    
    /** Called by the system to indicate that a command has been invoked on a particular displayable.//GEN-BEGIN:MVDCABegin
     * @param command the Command that ws invoked
     * @param displayable the Displayable on which the command was invoked
     */
    public void commandAction(Command command, Displayable displayable) {//GEN-END:MVDCABegin
        // слушатель команд для формы
        if (displayable == Controller) {//GEN-BEGIN:MVDCABody
            if (command == exitCommand) {//GEN-END:MVDCABody
                // Остановка сканирования данных с порта
                this.com_controller.com_close();
                exitMIDlet();//GEN-LINE:MVDCAAction3
                // Insert post-action code here
            } else if (command == menuCommand) {//GEN-LINE:MVDCACase3
                // Показать меню
                getDisplay().setCurrent(get_list_menu());//GEN-LINE:MVDCAAction27
                // Insert post-action code here
            }//GEN-BEGIN:MVDCACase27
        } else if (displayable == list_menu) {
            if (command == list_menu.SELECT_COMMAND) {
                switch (get_list_menu().getSelectedIndex()) {
                    case 3://GEN-END:MVDCACase27
                        // Меню открытия порта
                        // Do nothing//GEN-LINE:MVDCAAction18
                        // Insert post-action code here
                        this.com_controller.com_open();
                        getDisplay().setCurrent(get_Controller());
                        break;//GEN-BEGIN:MVDCACase18
                    case 2://GEN-END:MVDCACase18
                        // Меню закрытия порта
                        // Do nothing//GEN-LINE:MVDCAAction20
                        // Insert post-action code here
                        this.com_controller.com_close();
                        getDisplay().setCurrent(get_Controller());
                        break;//GEN-BEGIN:MVDCACase20
                    case 4://GEN-END:MVDCACase20
                        // Меню передачи данных по E-mail
                        // Do nothing//GEN-LINE:MVDCAAction22
                        // Insert post-action code here
                        String temp_string=" ";
                        try{
                            temp_string=this.StringItem_data.getText();
                            if(temp_string==null){
                                temp_string=" ";
                            }
                        }
                        catch(Exception e){
                            temp_string=" ";
                        }
                        new mail(temp_string,this,this.Controller);
                        getDisplay().setCurrent(get_Controller());
                        break;//GEN-BEGIN:MVDCACase22
                    case 5://GEN-END:MVDCACase22
                        // Insert pre-action code here
                        // Do nothing//GEN-LINE:MVDCAAction29
                        // Insert post-action code here
                        getDisplay().setCurrent(get_Controller());
                        break;//GEN-BEGIN:MVDCACase29
                    case 1://GEN-END:MVDCACase29
                        // Insert pre-action code here
                        getDisplay().setCurrent(get_form_delete_position());//GEN-LINE:MVDCAAction31
                        // Insert post-action code here
                        
                        break;//GEN-BEGIN:MVDCACase31
                    case 0://GEN-END:MVDCACase31
                        // Insert pre-action code here
                        getDisplay().setCurrent(get_form_manual_enter());//GEN-LINE:MVDCAAction40
                        // Insert post-action code here
                        break;//GEN-BEGIN:MVDCACase40
                }
            }
        } else if (displayable == form_delete_position) {
            if (command == Exit) {//GEN-END:MVDCACase40
                // Insert pre-action code here
                getDisplay().setCurrent(get_list_menu());//GEN-LINE:MVDCAAction38
                // Insert post-action code here
            } else if (command == Command_delete) {//GEN-LINE:MVDCACase38
                // Insert pre-action code here
                // Do nothing//GEN-LINE:MVDCAAction36
                // Insert post-action code here
                int delete_index=-1;
                try{
                    String delete_position=((TextField)(form_delete_position.get(0))).getString();
                    if(delete_position!=null){
                        Integer temp_int=Integer.valueOf(delete_position);
                        delete_index=temp_int.intValue();
                    }
                }
                catch(Exception e){
                    // не удалось преобразовать число 
                }
                // если удалось преобразовать данные - удаляем число
                if(delete_index!=(-1)){
                    this.delete_postition_from_form(delete_index);
                }
                getDisplay().setCurrent(get_Controller());                        
            }//GEN-BEGIN:MVDCACase36
        } else if (displayable == form_manual_enter) {
            if (command == Command_manual_add) {//GEN-END:MVDCACase36
                // Insert pre-action code here
                this.add_position(((TextField)form_manual_enter.get(0)).getString());                
                ((TextField)form_manual_enter.get(0)).setString("");
                getDisplay().setCurrent(get_Controller());//GEN-LINE:MVDCAAction43
                // Insert post-action code here

            } else if (command == Command_exit) {//GEN-LINE:MVDCACase43
                // Insert pre-action code here
                getDisplay().setCurrent(get_list_menu());//GEN-LINE:MVDCAAction45
                // Insert post-action code here
            }//GEN-BEGIN:MVDCACase45
        }//GEN-END:MVDCACase45
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
    
    /** This method returns instance for Controller component and should be called instead of accessing Controller field directly.//GEN-BEGIN:MVDGetBegin2
     * @return Instance for Controller component
     */
    public Form get_Controller() {
        if (Controller == null) {//GEN-END:MVDGetBegin2
            // Insert pre-init code here
            Controller = new Form(null, new Item[] {get_StringItem_data()});//GEN-BEGIN:MVDGetInit2
            Controller.addCommand(get_exitCommand());
            Controller.addCommand(get_menuCommand());
            Controller.setCommandListener(this);//GEN-END:MVDGetInit2
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd2
        return Controller;
    }//GEN-END:MVDGetEnd2
    
    /** This method returns instance for StringItem_data component and should be called instead of accessing StringItem_data field directly.//GEN-BEGIN:MVDGetBegin4
     * @return Instance for StringItem_data component
     */
    public StringItem get_StringItem_data() {
        if (StringItem_data == null) {//GEN-END:MVDGetBegin4
            // Insert pre-init code here
            StringItem_data = new StringItem("DataFromPort", "\r\n");//GEN-LINE:MVDGetInit4
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd4
        return StringItem_data;
    }//GEN-END:MVDGetEnd4
    
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
  
  
    /** This method returns instance for list_menu component and should be called instead of accessing list_menu field directly.//GEN-BEGIN:MVDGetBegin15
     * @return Instance for list_menu component
     */
    public List get_list_menu() {
        if (list_menu == null) {//GEN-END:MVDGetBegin15
            // Insert pre-init code here
            list_menu = new List("Menu", Choice.IMPLICIT, new String[] {//GEN-BEGIN:MVDGetInit15
                "Manual Enter",
                "Delete position",
                "Close port",
                "Open port",
                "Send mail",
                "Close menu"
            }, new Image[] {
                null,
                null,
                null,
                null,
                null,
                null
            });
            list_menu.setCommandListener(this);
            list_menu.setSelectedFlags(new boolean[] {
                true,
                false,
                false,
                false,
                false,
                false
            });//GEN-END:MVDGetInit15
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd15
        return list_menu;
    }//GEN-END:MVDGetEnd15

    /** This method returns instance for menuCommand component and should be called instead of accessing menuCommand field directly.//GEN-BEGIN:MVDGetBegin26
     * @return Instance for menuCommand component
     */
    public Command get_menuCommand() {
        if (menuCommand == null) {//GEN-END:MVDGetBegin26
            // Insert pre-init code here
            menuCommand = new Command("Menu", Command.OK, 1);//GEN-LINE:MVDGetInit26
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd26
        return menuCommand;
    }//GEN-END:MVDGetEnd26
    /** This method returns instance for form_delete_position component and should be called instead of accessing form_delete_position field directly.//GEN-BEGIN:MVDGetBegin33
     * @return Instance for form_delete_position component
     */
    public Form get_form_delete_position() {
        if (form_delete_position == null) {//GEN-END:MVDGetBegin33
            // Insert pre-init code here
            form_delete_position = new Form("Delete position", new Item[] {get_textfield_delete_position()});//GEN-BEGIN:MVDGetInit33
            form_delete_position.addCommand(get_Command_delete());
            form_delete_position.addCommand(get_Exit());
            form_delete_position.setCommandListener(this);//GEN-END:MVDGetInit33
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd33
        return form_delete_position;
    }//GEN-END:MVDGetEnd33

    /** This method returns instance for textfield_delete_position component and should be called instead of accessing textfield_delete_position field directly.//GEN-BEGIN:MVDGetBegin34
     * @return Instance for textfield_delete_position component
     */
    public TextField get_textfield_delete_position() {
        if (textfield_delete_position == null) {//GEN-END:MVDGetBegin34
            // Insert pre-init code here
            textfield_delete_position = new TextField("Enter number for delete", null, 120, TextField.NUMERIC);//GEN-LINE:MVDGetInit34
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd34
        return textfield_delete_position;
    }//GEN-END:MVDGetEnd34

    /** This method returns instance for Command_delete component and should be called instead of accessing Command_delete field directly.//GEN-BEGIN:MVDGetBegin35
     * @return Instance for Command_delete component
     */
    public Command get_Command_delete() {
        if (Command_delete == null) {//GEN-END:MVDGetBegin35
            // Insert pre-init code here
            Command_delete = new Command("Delete", Command.OK, 1);//GEN-LINE:MVDGetInit35
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd35
        return Command_delete;
    }//GEN-END:MVDGetEnd35

    /** This method returns instance for Exit component and should be called instead of accessing Exit field directly.//GEN-BEGIN:MVDGetBegin37
     * @return Instance for Exit component
     */
    public Command get_Exit() {
        if (Exit == null) {//GEN-END:MVDGetBegin37
            // Insert pre-init code here
            Exit = new Command("Exit", Command.EXIT, 1);//GEN-LINE:MVDGetInit37
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd37
        return Exit;
    }//GEN-END:MVDGetEnd37

    /** This method returns instance for form_manual_enter component and should be called instead of accessing form_manual_enter field directly.//GEN-BEGIN:MVDGetBegin41
     * @return Instance for form_manual_enter component
     */
    public Form get_form_manual_enter() {
        if (form_manual_enter == null) {//GEN-END:MVDGetBegin41
            // Insert pre-init code here
            form_manual_enter = new Form("Enter BarCode", new Item[] {get_textField1()});//GEN-BEGIN:MVDGetInit41
            form_manual_enter.addCommand(get_Command_manual_add());
            form_manual_enter.addCommand(get_Command_exit());
            form_manual_enter.setCommandListener(this);//GEN-END:MVDGetInit41
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd41
        return form_manual_enter;
    }//GEN-END:MVDGetEnd41

    /** This method returns instance for Command_manual_add component and should be called instead of accessing Command_manual_add field directly.//GEN-BEGIN:MVDGetBegin42
     * @return Instance for Command_manual_add component
     */
    public Command get_Command_manual_add() {
        if (Command_manual_add == null) {//GEN-END:MVDGetBegin42
            // Insert pre-init code here
            Command_manual_add = new Command("Add", Command.OK, 1);//GEN-LINE:MVDGetInit42
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd42
        return Command_manual_add;
    }//GEN-END:MVDGetEnd42

    /** This method returns instance for Command_exit component and should be called instead of accessing Command_exit field directly.//GEN-BEGIN:MVDGetBegin44
     * @return Instance for Command_exit component
     */
    public Command get_Command_exit() {
        if (Command_exit == null) {//GEN-END:MVDGetBegin44
            // Insert pre-init code here
            Command_exit = new Command("Exit", Command.EXIT, 1);//GEN-LINE:MVDGetInit44
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd44
        return Command_exit;
    }//GEN-END:MVDGetEnd44

    /** This method returns instance for textField1 component and should be called instead of accessing textField1 field directly.//GEN-BEGIN:MVDGetBegin46
     * @return Instance for textField1 component
     */
    public TextField get_textField1() {
        if (textField1 == null) {//GEN-END:MVDGetBegin46
            // Insert pre-init code here
            textField1 = new TextField("Manual Enter", null, 120, TextField.NUMERIC);//GEN-LINE:MVDGetInit46
            // Insert post-init code here
        }//GEN-BEGIN:MVDGetEnd46
        return textField1;
    }//GEN-END:MVDGetEnd46
     
    public void startApp() {
        initialize();
        this.com_controller=new get_data_from_com.ComController(this,this.Controller,"com0",9600,this);
        //this.com_controller.com_open();
    }
    
    public void pauseApp() {
    }
    
    public void destroyApp(boolean unconditional) {
    }
    /*
     * Реализация интерфейса для получения данных из коммуникационного порта ComListener
     */
    public void data_from_port(String s) {
        this.string_from_port=this.string_from_port+s;
        if(this.string_from_port.indexOf(0x0d)>0){
            this.counter++;
            this.StringItem_data.setText("\n<"+this.counter+">:"+this.string_from_port.substring(0,this.string_from_port.indexOf(0x0d)-1)+"\n"+this.StringItem_data.getText());
            // проверка на последний символ в строке 0x0d
            if(this.string_from_port.length()==(this.string_from_port.indexOf(0x0d)+1)){
                // символ перевода каретки последний - очистка строки
                this.string_from_port="";
            }
            else {
                // символ перевода строки не последний - есть еще данные
                this.string_from_port=this.string_from_port.substring(this.string_from_port.indexOf(0x0d)+1,this.string_from_port.length()-1);
            }
        }
        
    }
    /*
     *функция удаления введенных данных с экрана - удаление позиции из StringItem по номеру
     */
    public void delete_postition_from_form(int delete_number) {
        // проверка на существование данного индекса
        System.out.println("delete position="+delete_number);
        int index_begin=this.StringItem_data.getText().indexOf("<"+delete_number+">:");
        if(index_begin>=0){
            // последовательность найдена - удаляем
            String header=this.StringItem_data.getText().substring(0,index_begin-1);
            String tail=this.StringItem_data.getText().substring(this.StringItem_data.getText().indexOf("\n",index_begin),this.StringItem_data.getText().length());
            this.StringItem_data.setText(header+tail);
            System.out.println("header:"+header+"\ntail:"+tail);
        }
        else {
            // последовательность не найдена
            System.out.println("Enumeration not assigned");
        }
    }

    public void add_position(String string) {
        this.counter++;
        this.StringItem_data.setText("\n<"+this.counter+">:"+string+this.StringItem_data.getText());
    }
    
}
